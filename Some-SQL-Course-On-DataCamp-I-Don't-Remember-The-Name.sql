SELECT 
    *  -- Select all
FROM
    renting;        -- From table renting
#########
SELECT 
       rating,  -- Select all columns needed to compute the average rating per movie
       movie_id
FROM 
       renting;
########
SELECT
    *
FROM
    renting
WHERE
    rating IS NULL
#######
SELECT 
    *
FROM 
    renting
WHERE
    date_renting = '2018-10-09'; -- Movies rented on October 9th, 2018
########
SELECT 
    *
FROM 
    renting
WHERE
    date_renting BETWEEN '2018-04-01' AND '2018-08-31'; -- from beginning April 2018 to end August 2018
#########
SELECT 
    *
FROM 
    renting
WHERE 
    date_renting BETWEEN '2018-04-01' AND '2018-08-31'
ORDER BY
    date_renting DESC; -- Order by recency in decreasing order
#######
SELECT
    *
FROM 
    movies
WHERE
    genre != 'Drama'; -- All genres except drama
############
SELECT 
    *
FROM 
    movies
WHERE
    title IN 
    (
        'Showtime',
        'Love Actually',
        'The Fighter'
    ); -- Select all movies with the given titles
#########
SELECT 
    *
FROM 
    movies
ORDER BY
    renting_price; -- Order the movies by increasing renting price
###########
SELECT 
    *
FROM 
    renting
WHERE 
    date_renting BETWEEN '2018-01-01' AND '2018-12-31' -- Renting in 2018
    AND rating IS NOT NULL; -- Rating exists
##########
SELECT 
    COUNT(*) -- Count the total number of customers
FROM 
    customers
WHERE 
    date_of_birth BETWEEN '1980-01-01' AND '1989-12-31'; -- Select customers born between 1980-01-01 and 1989-12-31
########
SELECT 
    COUNT(*)   -- Count the total number of customers
FROM 
    customers
WHERE
    country = 'Germany'; -- Select all customers from Germany
########
SELECT 
    COUNT(DISTINCT country)   -- Count the number of countries
FROM 
    customers;
########
SELECT
	MIN(rating) min_rating, -- Calculate the minimum rating and use alias min_rating
	MAX(rating) max_rating, -- Calculate the maximum rating and use alias max_rating
	AVG(rating) avg_rating, -- Calculate the average rating and use alias avg_rating
	COUNT(rating) number_ratings -- Count the number of ratings and use alias number_ratings
FROM 
	renting
WHERE
	movie_id = 25; -- Select all records of the movie with ID 25
######
SELECT
    * -- Select all records of movie rentals since January 1st 2019
FROM
    renting
WHERE
    date_renting >= '2019-01-01'; 
#####
SELECT 
	COUNT(*), -- Count the total number of rented movies
	AVG(rating) -- Add the average rating
FROM 
	renting
WHERE 
	date_renting >= '2019-01-01';
##########
SELECT 
	COUNT(*) AS number_renting, -- Give it the column name number_renting
	AVG(rating) AS average_rating  -- Give it the column name average_rating
FROM 
	renting
WHERE 
	date_renting >= '2019-01-01';
###############
SELECT 
	COUNT(*) AS number_renting,
	AVG(rating) AS average_rating, 
    COUNT(rating) AS number_ratings -- Add the total number of ratings here.
FROM renting
WHERE date_renting >= '2019-01-01';
###########
SELECT 
	country, -- For each country report the earliest date when an account was created
	MIN(date_account_start) AS first_account
FROM 
	customers
GROUP BY 
	country
ORDER BY 
	MIN(date_account_start)
############
SELECT 
       movie_id, 
       AVG(rating)    -- Calculate average rating per movie
FROM 
       renting
GROUP BY
       movie_id;
#########
SELECT movie_id, 
       AVG(rating) AS avg_rating,
       COUNT(rating) AS number_ratings,
       COUNT(*) AS number_renting
FROM renting
GROUP BY movie_id
ORDER BY
     avg_rating DESC  ; -- Order by average rating in decreasing order
############
SELECT 
      customer_id, -- Report the customer_id
      AVG(rating),  -- Report the average rating per customer
      COUNT(rating),  -- Report the number of ratings per customer
      COUNT(*)  -- Report the number of movie rentals per customer
FROM renting
GROUP BY customer_id
HAVING 
      COUNT(*) > 7 -- Select only customers with more than 7 movie rentals
ORDER BY AVG(rating); -- Order by the average rating in ascending order
###########
SELECT * -- Join renting with customers
FROM renting r
LEFT JOIN customers c
ON c.customer_id = r.customer_id;
##########
SELECT *
FROM renting AS r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
WHERE
    country = 'Belgium'; -- Select only records from customers coming from Belgium
############
SELECT AVG(rating) -- Average ratings of customers from Belgium
FROM renting AS r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
WHERE c.country='Belgium';
###########
SELECT *
FROM renting AS r
LEFT JOIN movies AS m -- Choose the correct join statment
ON m.movie_id = r.movie_id;
###########
SELECT 
	SUM(m.renting_price), -- Get the revenue from movie rentals
	COUNT(*), -- Count the number of rentals
	COUNT(DISTINCT customer_id)  -- Count the number of customers
FROM renting AS r
LEFT JOIN movies AS m
ON r.movie_id = m.movie_id;
#########
SELECT 
	SUM(m.renting_price), 
	COUNT(*), 
	COUNT(DISTINCT r.customer_id)
FROM renting AS r
LEFT JOIN movies AS m
ON r.movie_id = m.movie_id
-- Only look at movie rentals in 2018
WHERE date_renting BETWEEN '2018-01-01' AND '2018-12-31';
##########
SELECT 
       name, -- Create a list of movie titles and actor names
       title
FROM
       actsIn
LEFT JOIN 
       movies AS m
ON 
       m.movie_id = actsIn.movie_id
LEFT JOIN 
       actors AS a
ON 
       a.actor_id = actsIn.actor_id;
#########
SELECT 
       title, -- Use a join to get the movie title and price for each movie rental
       renting_price
FROM 
       renting AS r
LEFT JOIN
       movies AS m
ON 
       m.movie_id = r.movie_id;
#######
SELECT 
       title, -- Report the income from movie rentals for each movie 
       SUM(renting_price) AS income_movie
FROM
       (SELECT m.title,  
               m.renting_price
       FROM renting AS r
       LEFT JOIN movies AS m
       ON r.movie_id=m.movie_id) AS rm
GROUP BY
       title
ORDER BY 
       income_movie DESC; -- Order the result by decreasing income
########
SELECT 
   gender, -- Report for male and female actors from the USA 
   MAX(year_of_birth), -- The year of birth of the oldest actor
   MIN(year_of_birth) -- The year of birth of the youngest actor
FROM
   (
      SELECT
         *
      FROM
         actors
      WHERE
         nationality = 'USA'
   ) -- Use a subsequen SELECT to get all information about actors from the USA
   AS
   a -- Give the table the name a
GROUP BY 
   gender;
#########
SELECT 
    *
FROM 
    renting AS r
LEFT JOIN 
    customers c   -- Add customer information
ON
    c.customer_id = r.customer_id	
LEFT JOIN
     movies m  -- Add movie information
ON
    m.movie_id = r.movie_id;
########
SELECT 
    *
FROM 
    renting AS r
LEFT JOIN 
    customers AS c
ON 
    c.customer_id = r.customer_id
LEFT JOIN 
    movies AS m
ON 
    m.movie_id = r.movie_id
WHERE
    date_of_birth BETWEEN '1970-01-01' AND '1979-12-31'; -- Select customers born in the 70s
##########
SELECT 
    m.title, 
    COUNT(r.*),-- Report number of views per movie
    AVG(rating) -- Report the average rating per movie
FROM 
    renting AS r
LEFT JOIN 
    customers AS c
ON 
    c.customer_id = r.customer_id
LEFT JOIN 
    movies AS m
ON 
    m.movie_id = r.movie_id
WHERE 
    c.date_of_birth BETWEEN '1970-01-01' AND '1979-12-31'
GROUP BY
    m.title;
#########
SELECT 
    m.title, 
    COUNT(*),
    AVG(r.rating)
FROM 
    renting AS r
LEFT JOIN 
    customers AS c
ON 
    c.customer_id = r.customer_id
LEFT JOIN 
    movies AS m
ON 
    m.movie_id = r.movie_id
WHERE 
    c.date_of_birth BETWEEN '1970-01-01' AND '1979-12-31'
GROUP BY 
    m.title
HAVING
    COUNT(*) > 1 -- Remove movies with only one rental
ORDER BY
    COUNT(*) DESC; -- Order with highest rating first
########
SELECT 
    *
FROM 
    renting as r 
LEFT JOIN   -- Augment table renting with information about customers 
    customers c
ON
    c.customer_id = r.customer_id
LEFT JOIN 
    actsin a  -- Augment the table renting with the table actsin
ON
    a.movie_id = r.movie_id
LEFT JOIN   -- Augment table renting with information about actors
    actors ass
ON
    a.actor_id = ass.actor_id
###########
SELECT 
    a.name,  
    c.gender,
    COUNT(*) AS number_views, 
    AVG(r.rating) AS avg_rating
FROM 
    renting as r
LEFT JOIN 
    customers AS c
ON 
    r.customer_id = c.customer_id
LEFT JOIN 
    actsin as ai
ON 
    r.movie_id = ai.movie_id
LEFT JOIN 
    actors as a
ON 
    ai.actor_id = a.actor_id
GROUP BY 
    a.name ,
    c.gender -- For each actor, separately for male and female customers
HAVING 
    AVG(r.rating) IS NOT NULL
    AND 
    COUNT(*) > 5 -- Report only actors with more than 5 movie rentals
ORDER BY 
    avg_rating DESC, 
    number_views DESC;
#############
SELECT 
  a.name,  
  c.gender,
  COUNT(*) AS number_views, 
  AVG(r.rating) AS avg_rating
FROM 
  renting as r
LEFT JOIN 
  customers AS c
ON 
  r.customer_id = c.customer_id
LEFT JOIN 
  actsin as ai
ON 
  r.movie_id = ai.movie_id
LEFT JOIN 
  actors as a
ON 
  ai.actor_id = a.actor_id
WHERE
  c.country = 'Spain' -- Select only customers from Spain
GROUP BY 
  a.name, 
  c.gender
HAVING 
  AVG(r.rating) IS NOT NULL 
  AND 
  COUNT(*) > 5 
ORDER BY 
  avg_rating DESC, 
  number_views DESC;
############
SELECT 
    *
FROM 
    renting r -- Augment the table renting with information about customers
LEFT JOIN 
    customers c
ON
    c.customer_id = r.customer_id
LEFT JOIN 
    movies m -- Augment the table renting with information about movies
ON
    m.movie_id = r.movie_id
WHERE
    date_renting > '2018-12-31'; -- Select only records about rentals since the beginning of 2019
##########
SELECT 
    movie_id, -- Select movie IDs with more than 5 views
    COUNT(*)
FROM
    renting
GROUP BY
    movie_id
HAVING
    COUNT(*) > 5
##########
SELECT *
FROM movies
WHERE  -- Select movie IDs from the inner query
	movie_id IN (SELECT movie_id
	FROM renting
	GROUP BY movie_id
	HAVING COUNT(*) > 5)
##########
SELECT 
	*
FROM 
	customers
WHERE 
	customer_id IN          -- Select all customers with more than 10 movie rentals
	(
		SELECT 
			customer_id
		FROM 
			renting
		GROUP BY 
			customer_id
		HAVING
			COUNT(*) > 10
	);
#########
SELECT  
	title-- Report the movie titles of all movies with average rating higher than the total average
FROM 
	movies
WHERE 
	movie_id IN
	(SELECT movie_id
	 FROM renting
     GROUP BY movie_id
     HAVING AVG(rating) > 
		(SELECT AVG(rating)
		 FROM renting));
########
-- Count movie rentals of customer 45
SELECT
    COUNT(*)
FROM
    renting
WHERE
    customer_id=45;
#########
-- Select customers with less than 5 movie rentals
SELECT 
	*
FROM 
	customers as c
WHERE
	5 >
	(
		SELECT 
			count(*)
		FROM 
			renting as r
		WHERE 
			r.customer_id = c.customer_id
	);
#########
-- Calculate the minimum rating of customer with ID 7
SELECT 
    MIN(rating)
FROM
    renting
WHERE
    customer_id = 7;
#######
SELECT 
	*
FROM 
	customers c
WHERE
	4 >  -- Select all customers with a minimum rating smaller than 4 
	(SELECT MIN(rating)
	FROM renting AS r
	WHERE r.customer_id = c.customer_id);
########
SELECT 
	*
FROM
	movies m
WHERE 
	5 < -- Select all movies with more than 5 ratings
	(
		SELECT 
			COUNT(rating)
		FROM 
			renting r
		WHERE
			r.movie_id = m.movie_id
	);
########
SELECT 
	*
FROM 
	movies AS m
WHERE
	8 
	< -- Select all movies with an average rating higher than 8
	(
		SELECT 
			AVG(rating)
		FROM 
			renting AS r
		WHERE 
			r.movie_id = m.movie_id
	);
#########
-- Select all records of movie rentals from customer with ID 115
SELECT
    *
FROM
    renting
WHERE
    customer_id = 115;
#######
SELECT 
    *
FROM 
    renting
WHERE 
    rating IS NOT NULL -- Exclude those with null ratings
    AND 
    customer_id = 115;
#########
SELECT 
    *
FROM 
    renting
WHERE
    rating IS NOT NULL -- Exclude null ratings
    AND
    customer_id = 1; -- Select all ratings from customer with ID 1
########
SELECT 
	*
FROM 
	customers c-- Select all customers with at least one rating
WHERE 
	EXISTS
	(
		SELECT 
			*
		FROM 
			renting AS r
		WHERE 
			rating IS NOT NULL 
		AND 
			r.customer_id = c.customer_id
	);
#########
SELECT 
    *  -- Select the records from the table `actsin` of all actors who play in a Comedy
FROM 
    actsin AS ai
LEFT JOIN 
    movies m
ON
    ai.movie_id=m.movie_id  
WHERE 
    m.genre = 'Comedy';
##########
SELECT 
    *
FROM 
    actsin AS ai
LEFT JOIN 
    movies AS m
ON 
    m.movie_id = ai.movie_id
WHERE 
    m.genre = 'Comedy'
    AND
    ai.actor_id = 1; -- Select only the actor with ID 1
########
SELECT 
	*
FROM
	actors a
WHERE 
	EXISTS
	(SELECT *
	 FROM actsin AS ai
	 LEFT JOIN movies AS m
	 ON m.movie_id = ai.movie_id
	 WHERE m.genre = 'Comedy'
	 AND ai.actor_id = a.actor_id);
#########
SELECT 
	a.nationality,
	COUNT(*) -- Report the nationality and the number of actors for each nationality
FROM 
	actors AS a
WHERE 
	EXISTS
	(
		SELECT 
			ai.actor_id
	 	FROM 
		 	actsin AS ai
	 	LEFT JOIN 
		 	movies AS m
	 	ON 
		 	m.movie_id = ai.movie_id
	 	WHERE 
		 	m.genre = 'Comedy'
	 	AND 
		 	ai.actor_id = a.actor_id
	)
GROUP BY
	a.nationality;
########
SELECT 
       name,  -- Report the name, nationality and the year of birth
       nationality, 
       year_of_birth
FROM 
       actors
WHERE
       nationality <> 'USA'; -- Of all actors who are not from the USA
##########
SELECT 
       name, 
       nationality, 
       year_of_birth
FROM 
       actors
WHERE
       year_of_birth > '1990'; -- Born after 1990
##########
SELECT 
       name, 
       nationality, 
       year_of_birth
FROM 
       actors
WHERE 
       nationality <> 'USA'
UNION
 -- Select all actors who are not from the USA and all actors who are born after 1990
SELECT 
       name, 
       nationality, 
       year_of_birth
FROM
       actors
WHERE 
       year_of_birth > 1990;
########
SELECT 
       name, 
       nationality, 
       year_of_birth
FROM 
       actors
WHERE 
       nationality <> 'USA'
INTERSECT -- Select all actors who are not from the USA and who are also born after 1990
SELECT name, 
       nationality, 
       year_of_birth
FROM actors
WHERE year_of_birth > 1990;
#########
SELECT movie_id -- Select the IDs of all dramas
FROM movies
WHERE genre = 'Drama';
##########
SELECT 
    movie_id,
    AVG(rating) -- Select the IDs of all movies with average rating higher than 9
FROM 
    renting
GROUP BY 
    movie_id
HAVING
    AVG(rating) > 9
##########
SELECT 
    movie_id
FROM 
    movies
WHERE 
    genre = 'Drama'
INTERSECT  -- Select the IDs of all dramas with average rating higher than 9
SELECT 
    movie_id
FROM 
    renting
GROUP BY
    movie_id
HAVING 
    AVG(rating)>9;
#############
SELECT 
   *
FROM 
   movies
WHERE
   movie_id IN -- Select all movies of genre drama with average rating higher than 9
   (
      SELECT 
         movie_id
      FROM 
         movies
      WHERE 
         genre = 'Drama'
      INTERSECT
      SELECT 
         movie_id
      FROM 
         renting
      GROUP BY 
         movie_id
      HAVING 
         AVG(rating) > 9
   );
########
SELECT 
	COUNT(*), -- Extract information of a pivot table of gender and country for the number of customers
	gender,
	country
FROM 
	customers
GROUP BY CUBE 
	(gender, country)
ORDER BY 
	country;
########
SELECT 
    genre,
    year_of_release,
    COUNT(*)
FROM 
    movies
GROUP BY CUBE (genre,
    year_of_release)
ORDER BY 
    year_of_release;
###########
-- Augment the records of movie rentals with information about movies and customers
SELECT 
    *
FROM 
    renting r
LEFT JOIN 
    movies m
ON
    m.movie_id = r.movie_id
LEFT JOIN
    customers c
ON
    c.customer_id = r.customer_id;
########
-- Calculate the average rating for each country
SELECT 
	country,
    AVG(rating)
FROM 
    renting AS r
LEFT JOIN 
    movies AS m
ON 
    m.movie_id = r.movie_id
LEFT JOIN 
    customers AS c
ON 
    r.customer_id = c.customer_id
GROUP BY
    country;
#######
SELECT 
	country, 
	genre, 
	AVG(r.rating) AS avg_rating -- Calculate the average rating 
FROM 
	renting AS r
LEFT JOIN 
	movies AS m
ON 
	m.movie_id = r.movie_id
LEFT JOIN 
	customers AS c
ON 
	r.customer_id = c.customer_id
GROUP BY 
	CUBE(country,genre); -- For all aggregation levels of country and genre
###########
-- Join the tables
SELECT 
    *
FROM 
    renting AS r
LEFT JOIN 
    movies AS m
ON
    r.movie_id = m.movie_id
LEFT JOIN 
    customers AS c
ON
    c.customer_id = r.customer_id;
##########
-- Count the total number of customers, the number of customers for each country, and the number of female and male customers for each country
SELECT 
    country,
    gender,
	COUNT(*)
FROM 
    customers
GROUP BY 
    ROLLUP(country, gender)
ORDER BY 
    country, gender; -- Order the result by country and gender
##########
SELECT 
	c.country, -- Select country
	m.genre, -- Select genre
	AVG(r.rating), -- Average ratings
	COUNT(*)  -- Count number of movie rentals
FROM 
	renting AS r
LEFT JOIN 
	movies AS m
ON 
	m.movie_id = r.movie_id
LEFT JOIN 
	customers AS c
ON 
	r.customer_id = c.customer_id
GROUP BY 
	country,genre -- Aggregate for each country and each genre
ORDER BY 
	country, genre;
##########
-- Group by each county and genre with OLAP extension
SELECT 
	c.country, 
	m.genre, 
	AVG(r.rating) AS avg_rating, 
	COUNT(*) AS num_rating
FROM renting AS r
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
GROUP BY ROLLUP(c.country,m.genre)
ORDER BY c.country, m.genre;
#########
SELECT 
	nationality, -- Select nationality of the actors
    gender, -- Select gender of the actors
    COUNT(*) -- Count the number of actors
FROM actors
GROUP BY GROUPING SETS ((nationality), (gender), ()); -- Use the correct GROUPING SETS operation
######
SELECT 
	country, -- Select country, gender and rating
    gender,
    rating
FROM 
    renting AS r
LEFT JOIN 
    customers AS c -- Use the correct join
ON
    r.customer_id = c.customer_id;
##########
SELECT 
	c.country, 
    c.gender,
	AVG(rating) -- Calculate average rating
FROM 
	renting AS r
LEFT JOIN 
	customers AS c
ON 
	r.customer_id = c.customer_id
GROUP BY
	c.country,c.gender -- Order and group by country and gender
ORDER BY 
	c.country,c.gender;
###########
SELECT 
	c.country, 
    c.gender,
	AVG(r.rating)
FROM renting AS r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
GROUP BY GROUPING SETS ((country, gender)); -- Group by country and gender with GROUPING SETS
############
SELECT 
	c.country, 
    c.gender,
	AVG(r.rating)
FROM renting AS r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
-- Report all info from a Pivot table for country and gender
GROUP BY GROUPING SETS ((country, gender), (country),(gender),());
###########
SELECT
    *
FROM 
    renting AS r
LEFT JOIN 
    movies m
ON
    m.movie_id = r.movie_id;-- Augment the table with information about movies
###############
SELECT 
	*
FROM 
	renting AS r
LEFT JOIN 
	movies AS m
ON 
	m.movie_id = r.movie_id
WHERE 
	r.movie_id IN
	( -- Select records of movies with at least 4 ratings
		SELECT 
			movie_id
		FROM 
			renting r
		GROUP BY 
			movie_id
		HAVING
			COUNT(rating) >= 4
	)
AND 
	date_renting >= '2018-04-01'; -- Select records of movie rentals since 2018-04-01
##########
SELECT 
	m.genre, -- For each genre, calculate:
	AVG(r.rating) AS avg_rating, -- The average rating and use the alias avg_rating
	COUNT(r.rating) AS n_rating, -- The number of ratings and use the alias n_rating
	COUNT(*) AS n_rentals,     -- The number of movie rentals and use the alias n_rentals
	COUNT(DISTINCT m.movie_id) AS n_movies -- The number of distinct movies and use the alias n_movies
FROM 
	renting AS r
LEFT JOIN 
	movies AS m
ON 
	m.movie_id = r.movie_id
WHERE 
	r.movie_id IN 
	( 
		SELECT 
			movie_id
		FROM 
			renting
		GROUP BY 
			movie_id
		HAVING 
			COUNT(rating) >= 3
	)
			AND 
			r.date_renting >= '2018-01-01'
GROUP BY
	m.genre
			;
##############
SELECT genre,
	   AVG(rating) AS avg_rating,
	   COUNT(rating) AS n_rating,
       COUNT(*) AS n_rentals,     
	   COUNT(DISTINCT m.movie_id) AS n_movies 
FROM renting AS r
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
WHERE r.movie_id IN ( 
	SELECT movie_id
	FROM renting
	GROUP BY movie_id
	HAVING COUNT(rating) >= 3 )
AND r.date_renting >= '2018-01-01'
GROUP BY genre
ORDER BY
	AVG(rating) DESC; -- Order the table by decreasing average rating
###########
-- Join the tables
SELECT *
FROM renting AS r
LEFT JOIN actsin AS ai
ON
    ai.movie_id = r.movie_id
LEFT JOIN actors AS a
ON
    ai.actor_id = a.actor_id;
##############
SELECT a.nationality,
       a.gender,
	   AVG(rating) AS avg_rating, -- The average rating
	   COUNT(rating) AS n_rating, -- The number of ratings
	   COUNT(r.*) AS n_rentals, -- The number of movie rentals
	   COUNT(DISTINCT a.name) AS n_actors -- The number of actors
FROM renting AS r
LEFT JOIN actsin AS ai
ON ai.movie_id = r.movie_id
LEFT JOIN actors AS a
ON ai.actor_id = a.actor_id
WHERE r.movie_id IN ( 
	SELECT movie_id
	FROM renting
	GROUP BY movie_id
	HAVING COUNT(rating) >=4 )
AND r.date_renting >= '2018-04-01'
GROUP BY a.nationality,a.gender; -- Report results for each combination of the actors' nationality and gender
