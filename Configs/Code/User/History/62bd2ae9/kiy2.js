import axios from 'axios';

const api = axios.create({
  baseURL: process.env.BASE_URL, // Use environment variable for base URL
  timeout: 5000, // Set a timeout of 5 seconds
});

export const fetchData = async (url) => {
  try {
    const response = await api.get(url);
    return response.data;
  } catch (error) {
    console.error('Error fetching data:', error);
    throw error;
  }
};

// Retry logic with exponential backoff
export const fetchWithRetry = async (url, retries = 3, delay = 1000) => {
  try {
    const response = await fetchData(url);
    return response;
  } catch (error) {
    if (retries > 0) {
      console.log(`Retrying... attempts left: ${retries}`);
      await new Promise(res => setTimeout(res, delay)); // Delay before retry
      return fetchWithRetry(url, retries - 1, delay * 2); // Exponential backoff
    } else {
      throw new Error('Max retries reached');
    }
  }
};
