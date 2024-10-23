import dotenv from "dotenv";
import fs from "fs";
import path from "path";
import { cors } from "hono/cors";
import { serve } from "@hono/node-server";
import { Hono } from "hono";
import { serveStatic } from "@hono/node-server/serve-static";
import { fileURLToPath } from "url";
import { dirname } from "path";
import { createApiRoutes } from "../src/routes/apiRoutes.js";

dotenv.config();

const app = new Hono();
const PORT = process.env.PORT || 4444;
const __filename = fileURLToPath(import.meta.url);
const publicDir = path.join(dirname(dirname(__filename)), "public");

// Define the expected private key from environment variables
const EXPECTED_PRIVATE_KEY = process.env.PRIVATE_KEY || "your-secret-key";

// Middleware to check the 'privatekey' header
const checkPrivateKey = (c, next) => {
  const privateKey = c.req.header("privatekey");

  // If the 'privatekey' header is missing or does not match the expected value
  if (!privateKey || privateKey !== EXPECTED_PRIVATE_KEY) {
    return c.json(
      { success: false, message: "Unauthorized: Invalid or missing private key" },
      { status: 401 }
    );
  }

  // If the privatekey is valid, proceed to the next handler
  return next();
};

// Apply CORS policy
app.use(
  cors({
    allowMethods: ["GET"],
    origin: "*",
  })
);

// Apply static file serving middleware
app.use("/", serveStatic({ root: "public" }));

// Helper functions for JSON responses
const jsonResponse = (c, data, status = 200) =>
  c.json({ success: true, results: data }, { status });
const jsonError = (c, message = "Internal server error", status = 500) =>
  c.json({ success: false, message }, { status });

// Apply the private key check middleware globally to all routes
app.use("*", checkPrivateKey);

// Define API routes (with private key check middleware applied)
createApiRoutes(app, jsonResponse, jsonError);

// Catch-all route for 404 errors - returns JSON instead of serving HTML
app.get("*", (c) => {
  return c.json(
    { status: 404, message: "The requested resource was not found." },
    { status: 404 }
  );
});

// Start the server
serve({
  port: PORT,
  fetch: app.fetch,
}).addListener("listening", () =>
  console.info(`Listening at http://localhost:${PORT}`)
);
