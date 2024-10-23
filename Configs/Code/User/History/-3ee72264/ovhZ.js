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
import rateLimit from 'express-rate-limit';  // New rate limiter import

dotenv.config();

const app = new Hono();
const PORT = process.env.PORT || 4444;
const __filename = fileURLToPath(import.meta.url);
const publicDir = path.join(dirname(dirname(__filename)), "public");

// Rate Limiting Setup: Allow 100 requests per 15 minutes per IP
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // limit each IP to 100 requests per windowMs
  message: 'Too many requests, please try again later.'
});

// Apply rate limiting to all requests
app.use('*', (c, next) => limiter(c.req, c.res, next));

// CORS configuration
app.use(
  cors({
    allowMethods: ["GET"],
    origin: "*",
  })
);

// Serve static files
app.use("/", serveStatic({ root: publicDir }));

// JSON response helper functions
const jsonResponse = (c, data, status = 200) =>
  c.json({ success: true, results: data }, { status });
const jsonError = (c, message = "Internal server error", status = 500) =>
  c.json({ success: false, message }, { status });

// Create API routes
createApiRoutes(app, jsonResponse, jsonError);

// Catch-all route for 404 errors - returns JSON instead of serving HTML
app.get("*", (c) => {
  return c.json(
    { status: 404, message: "The requested resource was not found." },
    { status: 404 }
  );
});

// Start the server with optimized configuration
serve({
  port: PORT,
  fetch: app.fetch,
}).addListener("listening", () =>
  console.info(`Listening at http://localhost:${PORT}`)
);
