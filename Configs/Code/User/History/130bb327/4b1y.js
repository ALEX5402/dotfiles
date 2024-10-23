import express from 'express';
import { fetchCategoryData } from '../controllers/category.controller.js';
import { body, validationResult } from 'express-validator';

export const routeTypes = [
  "genre/action",
  "genre/adventure",
  "genre/cars",
  "genre/comedy",
  "genre/dementia",
  "genre/demons",
  "genre/drama",
  "genre/ecchi",
  "genre/fantasy",
  "genre/game",
  "genre/harem",
  "genre/historical",
  "genre/horror",
  "genre/isekai",
  "genre/josei",
  "genre/kids",
  "genre/magic",
  "genre/martial-arts",
  "genre/mecha",
  "genre/military",
  "genre/music",
  "genre/mystery",
  "genre/parody",
  "genre/police",
  "genre/psychological",
  "genre/romance",
  "genre/samurai",
  "genre/school",
  "genre/sci-fi",
  "genre/seinen",
  "genre/shoujo",
  "genre/shoujo-ai",
  "genre/shounen",
  "genre/shounen-ai",
  "genre/slice-of-life",
  "genre/space",
  "genre/sports",
  "genre/super-power",
  "genre/supernatural",
  "genre/thriller",
  "genre/vampire",
  "top-airing",
  "most-popular",
  "most-favorite",
  "completed",
  "recently-updated",
  "recently-added",
  "top-upcoming",
  "subbed-anime",
  "dubbed-anime",
  "movie",
  "special",
  "ova",
  "ona",
  "tv",
  "az-list",
  "az-list/other",
  "az-list/0-9",
  "az-list/a",
  "az-list/b",
  "az-list/c",
  "az-list/d",
  "az-list/e",
  "az-list/f",
  "az-list/g",
  "az-list/h",
  "az-list/i",
  "az-list/j",
  "az-list/k",
  "az-list/l",
  "az-list/m",
  "az-list/n",
  "az-list/o",
  "az-list/p",
  "az-list/q",
  "az-list/r",
  "az-list/s",
  "az-list/t",
  "az-list/u",
  "az-list/v",
  "az-list/w",
  "az-list/x",
  "az-list/y",
  "az-list/z",
];



const router = express.Router();

router.post(
  '/category',
  // Input validation for security
  [body('category').isString().notEmpty().withMessage('Category is required')],
  async (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    
    try {
      const { category } = req.body;
      const data = await fetchCategoryData(category);
      res.json(data);
    } catch (error) {
      next(error); // Pass errors to the centralized error handler
    }
  }
);

export default router;
