create database netflix_project ;

use netflix_project ;

CREATE TABLE netflix
(
	show_id	VARCHAR(5),
	type    VARCHAR(10),
	title	VARCHAR(250),
	director VARCHAR(550),
	casts	VARCHAR(1050),
	country	VARCHAR(550),
	date_added	VARCHAR(55),
	release_year	INT,
	rating	VARCHAR(15),
	duration	VARCHAR(15),
	listed_in	VARCHAR(250),
	description VARCHAR(550)
);



LOAD DATA LOCAL INFILE "C:\Users\chaud\OneDrive\Documents\sql_project\netflix_titles.csv"
INTO TABLE netflix_titles
FIELDS TERMINATED BY ','
ENCLOSED BY '\"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SET GLOBAL local_infile=1;

SELECT * FROM netflix;

select count(*) as total_data
from netflix ;



-- 1. Count the number of Movies vs TV Shows
SELECT 
      count(*) as total_no_of_movie_TVShow,
      type
FROM netflix
group by type ;

-- 2. Find the most common rating for movies and TV shows.
SELECT rating, COUNT(*) AS rating_count
FROM netflix
WHERE type IN ('Movie', 'TV Show')  
GROUP BY rating
ORDER BY rating_count DESC
LIMIT 1;


-- 3. List all movies released in a specific year (e.g., 2020)
SELECT 
	  type,
      release_year,
      title
FROM netflix
where release_year = 2020 and type ='movie';

-- 4. Find the top 5 countries with the most content on Netflix
SELECT 
      count(*),
      country
FROM netflix
group by country
order by 1 desc
limit 5 ;
;
-- 5. Identify the longest movie
SELECT 
       show_id,
       title,
       country,
       date_added,
       release_year,
       rating,
       duration
FROM netflix
where type = 'movie'
order by cast(substring_index(duration,' ',1) AS SIGNED) desc
limit 1;

-- 6. Find content added in the last 5 years
SELECT * 
FROM netflix
where release_year >= YEAR(CURDATE()) - 5
order by date_added desc ;

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
SELECT * 
FROM netflix
where director = 'Rajiv Chilaka' ;

-- 8. List all TV shows with more than 5 seasons
SELECT * 
FROM netflix
where duration > '5 Seasons' and type = 'TV Show';

-- 9. Count the number of content items in each genre
SELECT * 
FROM netflix;

-- 10.Find each year and the average numbers of content release in India on netflix. return top 5 year with highest avg content release!
 
      SELECT 
    release_year, 
    COUNT(*) AS content_release_count
FROM 
    netflix
WHERE 
    country = 'India'  -- Filter to include only content in India
GROUP BY 
    release_year
ORDER BY 
    content_release_count DESC
LIMIT 5;

-- 11. List all movies that are documentaries
SELECT title, release_year, listed_in
FROM netflix
WHERE type = 'Movie'
  AND listed_in LIKE '%Documentaries%';

-- 12. Find all content without a director
SELECT * 
FROM netflix
where director is null or director ='' ;

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
select * 
from netflix 
where casts ='%Salman Khan%'
	AND 
	release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10
;
 
 
-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
SELECT 
    release_year, 
    AVG(content_count) AS avg_content_release
FROM 
    (SELECT 
        release_year, 
        COUNT(*) AS content_count
     FROM 
        netflix
     WHERE 
        country = 'India'
     GROUP BY 
        release_year) AS yearly_counts
GROUP BY 
    release_year
ORDER BY 
    avg_content_release DESC
LIMIT 5;

-- 15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field. 
-- Label content containing these keywords as 'Bad' and all other content as 'Good'. Count how many items fall into each category.
SELECT
    CASE
        WHEN LOWER(description) LIKE '%kill%' OR LOWER(description) LIKE '%violence%' THEN 'Bad'
        ELSE 'Good'
    END AS content_category,
    COUNT(*) AS content_count
FROM
    netflix
GROUP BY
    content_category;

-- Findings and Conclusion
-- Content Distribution: The dataset contains a diverse range of movies and TV shows with varying ratings and genres.
-- Common Ratings: Insights into the most common ratings provide an understanding of the content's target audience.
-- Geographical Insights: The top countries and the average content releases by India highlight regional content distribution.
-- Content Categorization: Categorizing content based on specific keywords helps in understanding the nature of content available on Netflix.
-- This analysis provides a comprehensive view of Netflix's content and can help inform content strategy and decision-making.