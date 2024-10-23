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
import { RateLimiterMemory } from "rate-limiter-flexible"; // Rate limiter

dotenv.config();

const app = new Hono();
const PORT = process.env.PORT || 4444;
const __filename = fileURLToPath(import.meta.url);
const publicDir = path.join(dirname(dirname(__filename)), "public");

// Rate Limiting Setup: Allow 100 requests per 15 minutes per IP
const rateLimiter = new RateLimiterMemory({
  points: 100, // 100 requests
  duration: 15 * 60, // per 15 minutes
});

const rateLimitMiddleware = async (c, next) => {
  try {
    const ip = c.req.headers.get('x-forwarded-for') || c.req.headers.get('x-real-ip') || c.req.headers.get('host');
    await rateLimiter.consume(ip);
    await next(); // proceed to the next middleware if not rate-limited
  } catch (rateLimiterRes) {
    // If rate limited, return a 429 status code
    return c.json(
      { success: false, message: "Too many requests, please try again later." },
      { status: 429 }
    );
  }
};

// Apply rate limiting globally to all routes
app.use("*", rateLimitMiddleware);

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
