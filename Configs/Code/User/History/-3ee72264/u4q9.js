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
import rateLimit from 'express-rate-limit';  // Import rate limiting middleware

dotenv.config();

const app = new Hono();
const PORT = process.env.PORT || 4444;
const __filename = fileURLToPath(import.meta.url);
const publicDir = path.join(dirname(dirname(__filename)), "public");

// CORS configuration
app.use(
  cors({
    allowMethods: ["GET", "POST"], // Adjusted to handle more methods
    origin: "*",
  })
);

// Serve static files
app.use("/", serveStatic({ root: publicDir }));

// Lenient rate limiter for general API routes
const generalApiLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 5000, // Allow 5000 requests per 15 minutes for general API usage
  message: 'Too many requests from this IP, please try again later.',
  standardHeaders: true,
  legacyHeaders: false,
});

// Stricter rate limiter for resource-heavy routes (like search)
const heavyApiLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // Allow 100 requests per 15 minutes for expensive actions (e.g., searches)
  message: 'Too many search requests, please try again later.',
  standardHeaders: true,
  legacyHeaders: false,
});

// Apply general rate limiter to most API routes
app.use('/api', (c, next) => generalApiLimiter(c.req, c.res, next));

// Apply stricter rate limiting to specific routes like search (adjust accordingly)
app.use('/api/search', (c, next) => heavyApiLimiter(c.req, c.res, next));

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
