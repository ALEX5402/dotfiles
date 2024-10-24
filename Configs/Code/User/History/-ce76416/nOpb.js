import axios from "axios";
import dotenv from "dotenv";

dotenv.config();

const CACHE_SERVER_URL = process.env.CACHE_URL;

// export const getCachedData = async (key) => {
//   try {
//     const response = await axios.get(`${CACHE_SERVER_URL}/${key}`);
//     return response.data;
//   } catch (error) {
//     if (error.response && error.response.status === 404) {
//       return null;
//     }
//     throw error;
//   }
// };

// export const setCachedData = async (key, value) => {
//   try {
//     await axios.post(CACHE_SERVER_URL, { key, value });
//   } catch (error) {
//     console.error("Error setting cache data:", error);
//     throw error;
//   }
// };

// Redis-based caching for distributed systems
export const setCachedData = async (key, data, ttl = 3600) => {
  try {
    await redisClient.setEx(key, ttl, JSON.stringify(data));
  } catch (error) {
    console.error('Error setting cache:', error);
  }
};

export const getCachedData = async (key) => {
  try {
    const cachedData = await redisClient.get(key);
    return cachedData ? JSON.parse(cachedData) : null;
  } catch (error) {
    console.error('Error getting cache:', error);
    return null;
  }
};

