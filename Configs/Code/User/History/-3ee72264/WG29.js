import express from 'express';
import cors from 'cors';
import morgan from 'morgan';
import dotenv from 'dotenv';
import NodeCache from 'node-cache';
import rateLimit from 'express-rate-limit';
import helmet from 'helmet';
import { createClient } from 'redis';
import { errorHandler } from './middlewares/errorHandler.js'; // Centralized error handler
import apiRoutes from './routes/apiRoutes.js'; // Updated routes

// Load environment variables
dotenv.config();

const app = express();
const port = process.env.PORT || 3000;

// Redis cache setup
const redisClient = createClient();
redisClient.on('error', (err) => console.error('Redis Client Error', err));
await redisClient.connect(); // Redis for distributed caching

// Set up Node-cache (in-memory caching with TTL)
const cache = new NodeCache({ stdTTL: 3600, checkperiod: 600 });

// Middleware
app.use(cors());
app.use(helmet()); // Security headers
app.use(morgan('combined')); // Enhanced logging
app.use(express.json());

// Rate limiter
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // limit each IP to 100 requests per windowMs
  message: 'Too many requests, please try again later.',
});
app.use(limiter);

// API routes
app.use('/api', apiRoutes);

// Centralized error handler
app.use(errorHandler);

// Start server
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
