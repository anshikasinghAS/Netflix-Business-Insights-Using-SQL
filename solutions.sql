-- Netflix (SQL) Data Analysis Project

drop table if exists netflix;
create table netflix (
	show_id	varchar(6),
	type varchar(10),
	title varchar(150),
	director varchar(250),	
	cast varchar (1000),
	country	varchar(150),
	date_added varchar (50),
	release_year int,
	rating varchar(10),
	duration varchar(15),
	listed_in varchar(100),
	description varchar(250)
);

SHOW VARIABLES LIKE 'secure_file_priv';


LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/netflix_titles.csv"
INTO TABLE netflix
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


select * from netflix;

select count(*) as total_data from netflix;

select distinct type from netflix;

-- 15 Business Problems 

-- 1. Count the number of Movies vs TV Shows

select type, count(*) as total_rows
from netflix
group by type;

-- 2. Find the most common rating for movies and TV shows

select type, rating
from
(
	select type, rating, count(*),
	rank() over(partition by type order by count(*) desc) as ranking
	from netflix
	group by 1,2 
) as t1
where ranking = 1;

-- 3. List all movies released in a specific year (e.g., 2020)

select * from netflix
where type = 'Movie' and release_year = 2020;

-- 4. Find the top 5 countries with the most content in the Netflix dataset.(If a title has multiple countries listed, only consider the first one.)

select 
    trim(SUBSTRING_INDEX(country, ',', 1)) as primary_country,
    count(*) as total_content
from netflix
where country <> ''
group by primary_country
order by total_content desc 
limit 5;

-- 5. Identify the longest movie

select * from netflix
where type = 'Movie' and duration = (select max(duration) from netflix);

-- 6. Find content added in the last 5 years

select *
from netflix
where STR_TO_DATE(date_added, '%M %e, %Y') >= CURDATE() - interval 5 YEAR;

-- 7. Find all the movies/TV shows by director 'Jay Karas'

select * from netflix
where director like '%Jay Karas%';

-- 8. List all TV shows with more than 5 seasons

select *
from netflix
where type = 'TV Show'and 
cast(SUBSTRING_INDEX(duration, ' ', 1) as unsigned) > 5;

-- 9. Count the number of content items in each genre

with recursive genre_split as (
    select 
        show_id,
        trim(SUBSTRING_INDEX(listed_in, ',', 1)) as genre,
        substring_index(listed_in, ',', - (char_length(listed_in) 
            - char_length(replace(listed_in, ',', '')))) as rest,
        listed_in
    from netflix

    union all

    select
        show_id,
        trim(SUBSTRING_INDEX(rest, ',', 1)) as genre,
        case 
            when rest like '%,%' 
            then SUBSTRING(rest, LOCATE(',', rest) + 1) 
            else null 
        end as rest,
        listed_in
    from genre_split
    where rest is not null
)
select 
    genre,
    count(*) as total_content
from genre_split
where genre is not null and genre != ''
group by genre
order by total_content desc;

-- 10.Find each year and the average number of content release in India on netflix. Return top 5 year with highest avg content released.

select 
    extract(year from STR_TO_DATE(date_added, '%M %e, %Y')) as year,
    count(*) as yearly_content,
    round(
        count(*) / (
            SELECT count(*) 
            from netflix 
            where country like '%India%'
        ) * 100, 2
    ) as percentage_share
from netflix
where country like '%India%'
group by year
order by percentage_share desc
limit 5;

-- 11. List all movies that are documentaries

select * from netflix
where listed_in like '%Documentaries%';

-- 12. Find all content without a director

select * from netflix
where director = '';

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years.

select * from netflix
where cast like '%Salman Khan%' and release_year > extract(year from current_date) - 10;

-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

with recursive actor_split as (
    select show_id,
           trim(SUBSTRING_INDEX(cast, ',', 1)) AS actor,
           substring(cast, length(SUBSTRING_INDEX(cast, ',', 1)) + 2) as rest
    from netflix
    where country like '%India%' and type = 'Movie' and cast <> ''

    union all

    select show_id,
           trim(SUBSTRING_INDEX(rest, ',', 1)),
           substring(rest, length(SUBSTRING_INDEX(rest, ',', 1)) + 2)
    from actor_split
    where rest <> ''
)
select actor, COUNT(show_id) as movie_count
from actor_split
group by actor
order by movie_count desc
limit 10;

-- 15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field. Label content containing these keywords as 'Negative' and all other content as 'Positive'. Count how many items fall into each category.

with new_table 
as
(
select *,
	case 
    when 
       description like '%kill%' or 
       description like '%violence%' then 'Negative'
	    else 'Positive'
	end category
from netflix
)
select category,
count(*) as total_content
from new_table
group by 1;

