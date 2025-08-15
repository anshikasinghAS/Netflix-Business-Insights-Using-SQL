# Netflix Movies and TV shows Data Analysis Using SQL

![Netflix Logo](https://github.com/anshikasinghAS/Netflix-Business-Insights-Using-SQL/blob/main/logo.png)

## Overview 
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, findings, and conclusions.

## Objectives
* Analyze the distribution of content types (movies vs TV shows).
* Identify the most common ratings for movies and TV shows.
* List and analyze content based on release years, countries, and durations.
* Explore and categorize content based on specific criteria and keywords.


## Dataset

* **Source:** [Netflix Movies and TV Shows Dataset – Kaggle](https://www.kaggle.com/datasets/shivamb/netflix-shows)
* **Rows:** \~8,800
* **Columns:** 12 (including `title`, `director`, `cast`, `country`, `release_year`, `rating`, `duration`, `listed_in`, `description`)
* **Description:** Contains details of movies and TV shows available on Netflix, such as genre, release year, cast, director, duration, and description.

---

## **3. Questions & Key Insights**

| #  | Question                                                              | Key Insight                                             |
| -- | --------------------------------------------------------------------- | ------------------------------------------------------- |
| 1  | Count the number of Movies vs TV Shows                                | Shows that movies dominate Netflix’s library.           |
| 2  | Find the most common rating for Movies and TV Shows                   | Reveals the most frequent audience category per type.   |
| 3  | List all Movies released in 2020                                      | Understands Netflix’s release trend in a specific year. |
| 4  | Top 5 countries with most content (first listed country only)         | Identifies Netflix’s largest content-producing markets. |
| 5  | Identify the longest Movie                                            | Highlights Netflix’s maximum-length production.         |
| 6  | Content added in last 5 years                                         | Shows recent content growth rate.                       |
| 7  | Movies/TV Shows by director 'Jay Karas'                               | Profiles work of a specific creator.                    |
| 8  | TV Shows with more than 5 seasons                                     | Finds long-running series appealing to loyal viewers.   |
| 9  | Count content items in each genre                                     | Reveals Netflix’s most common genres.                   |
| 10 | Yearly percentage share of Indian content (top 5 years)               | Tracks India’s contribution over time.                  |
| 11 | All Movies that are Documentaries                                     | Segments non-fiction offerings.                         |
| 12 | Content without a director                                            | Identifies incomplete metadata.                         |
| 13 | Number of Movies with Salman Khan in last 10 years                    | Highlights one actor’s recent Netflix presence.         |
| 14 | Top 10 actors with most Movies produced in India                      | Recognizes dominant actors in Indian cinema on Netflix. |
| 15 | Categorize content with 'kill' or 'violence' in description and count | Flags potentially violent content for compliance.       |

---

## **4. Tools & Technologies**

* **Database:** MySQL
* **Dataset:** Kaggle Netflix dataset
* **SQL Concepts Used:**

  * Aggregation: `COUNT`, `GROUP BY`, `SUM`
  * Conditional logic: `CASE WHEN`
  * String operations: `LIKE`, `SUBSTRING_INDEX`
  * Date operations: `YEAR()`, `DATEDIFF`, `CURDATE()`
  * Filtering: `WHERE`, `IS NULL`
  * Sorting & limiting: `ORDER BY`, `LIMIT`
  * Subqueries

---

## Some Key Findings
- **Content Mix:** Movies dominate the catalog (6,131 titles) over TV shows (2,676 titles).  
- **Ratings:** The most common rating for both Movies and TV Shows is **TV-MA**.  
- **Geographic Distribution:**  
  - United States leads with **3,211** titles, followed by India (**1,008**) and the UK (**628**).  
- **Genre Popularity:** Top genres include *International Movies* (**2,752 titles**) and *Dramas* (**2,427 titles**).  
- **Indian Market Trends:** In 2018 alone, India released **349 titles**, accounting for **33.37%** of its total Netflix content.  
- **Top Actors in Indian Movies:** Anupam Kher (**40 movies**) and Shah Rukh Khan (**34 movies**) lead the list.  
- **Content Sentiment:** Based on description keywords, the majority of titles were labeled **Positive**.

## **5. How to Run the Project**

1. Download dataset from Kaggle and save as `netflix_titles.csv`.
2. Import the CSV into MySQL using Workbench or CLI.
3. Execute queries from the provided SQL file in order.
4. Review results and insights for each question.


