-- Select all columns from the TABLES system database
 SELECT 
    * 
 FROM 
    INFORMATION_SCHEMA.TABLES
 -- Filter by schema
 WHERE 
    table_schema = 'public';
#########
-- Select all columns from the COLUMNS system database
 SELECT 
    * 
 FROM
    INFORMATION_SCHEMA.COLUMNS
 WHERE 
    table_name = 'actor';
#####################
-- Get the column name and data type
SELECT
 	column_name, 
    data_type
-- From the system database information schema
FROM 
    INFORMATION_SCHEMA.COLUMNS 
-- For the customer table
WHERE 
    table_name = 'customer';
#########################
SELECT
 	-- Select the rental and return dates
	rental_date,
	return_date,
 	-- Calculate the expected_return_date
	(rental_date + INTERVAL '3 DAY') AS expected_return_date
FROM 
	rental;
###################
-- Select the title and special features column 
SELECT 
  title, 
  special_features 
FROM 
  film;
##################
-- Select the title and special features column 
SELECT 
  title, 
  special_features 
FROM 
  film
-- Use the array index of the special_features column
WHERE 
  special_features[1] = 'Trailers';
############################
-- Select the title and special features column 
SELECT 
  title, 
  special_features 
FROM film
-- Use the array index of the special_features column
WHERE 
  special_features[2] = 'Deleted Scenes' ;
###############
SELECT
  title, 
  special_features 
FROM 
  film 
-- Modify the query to use the ANY function 
WHERE 
  'Trailers' = ANY(special_features);
#################################
SELECT 
    f.title, 
    f.rental_duration,
    -- Calculate the number of days rented
    r.return_date - r.rental_date AS days_rented
FROM 
    film AS f
INNER JOIN 
    inventory AS i 
ON 
    f.film_id = i.film_id
INNER JOIN 
    rental AS r 
ON 
    i.inventory_id = r.inventory_id
ORDER BY 
    f.title;
###########################
SELECT 
	f.title, f.rental_duration,
    -- Calculate the number of days rented
	AGE(r.return_date,r.rental_date) AS days_rented
FROM 
	film AS f
INNER JOIN 
	inventory AS i 
ON 
	f.film_id = i.film_id
INNER JOIN 
	rental AS r 
ON 
	i.inventory_id = r.inventory_id
ORDER BY 
	f.title;
##################################
SELECT
	f.title,
 	-- Convert the rental_duration to an interval
    INTERVAL '1' DAY * f.rental_duration,
 	-- Calculate the days rented as we did previously
    r.return_date - r.rental_date AS days_rented
FROM 
    film AS f
INNER JOIN 
    inventory AS i 
ON 
    f.film_id = i.film_id
INNER JOIN 
    rental AS r 
ON 
    i.inventory_id = r.inventory_id
-- Filter the query to exclude outstanding rentals
WHERE 
    r.return_date IS NOT NULL
ORDER BY 
    f.title;
##############################
-- Select the current timestamp
SELECT 
    NOW();
-- Select the current date
SELECT 
    CURRENT_DATE
--Select the current timestamp without a timezone
SELECT 
    CAST(NOW() AS CURRENT_TIMESTAMP)
SELECT 
	-- Select the current date
	CURRENT_DATE,
    -- CAST the result of the NOW() function to a date
    CAST( NOW() AS date )
##############################
--Select the current timestamp without timezone
SELECT 
    CURRENT_TIMESTAMP::TIMESTAMP AS right_now;
###################
SELECT
	CURRENT_TIMESTAMP::timestamp AS right_now,
    INTERVAL '5 DAYS' + CURRENT_TIMESTAMP AS five_days_from_now;
################
SELECT
	CURRENT_TIMESTAMP(2)::timestamp AS right_now,
    interval '5 days' + CURRENT_TIMESTAMP(2) AS five_days_from_now;
#############
SELECT 
  -- Extract day of week from rental_date
  EXTRACT(dow FROM rental_date) AS dayofweek 
FROM 
  rental 
LIMIT 
  100;
##############
-- Truncate rental_date by year
SELECT 
    DATE_TRUNC('year', rental_date) AS rental_year
FROM 
    rental;
#########
-- Truncate rental_date by month
SELECT 
    DATE_TRUNC('month', rental_date) AS rental_month
FROM 
    rental;
############
-- Truncate rental_date by day of the month 
SELECT 
    DATE_TRUNC('day', rental_date) AS rental_day
FROM 
    rental;
###############
SELECT 
  DATE_TRUNC('day', rental_date) AS rental_day,
  -- Count total number of rentals 
  COUNT(DATE_TRUNC('day', rental_date)) AS rentals
FROM 
  rental
GROUP BY 
  1;
############
SELECT 
  -- Extract the day of week date part from the rental_date
  EXTRACT(DOW FROM rental_date) AS dayofweek,
  AGE(return_date, rental_date) AS rental_days
FROM 
  rental AS r 
WHERE 
  -- Use an INTERVAL for the upper bound of the rental_date 
  rental_date BETWEEN CAST('2005-05-01' AS DATE)
  AND 
  CAST('2005-05-01' AS DATE) + INTERVAL '90 day';
######################
-- Concatenate the first_name and last_name and email 
SELECT 
    first_name || ' ' || last_name || ' <' || email || '>' AS full_email 
FROM 
    customer
#############
SELECT 
  c.first_name || ' ' || c.last_name AS customer_name,
  f.title,
  r.rental_date,
  -- Extract the day of week date part from the rental_date
  EXTRACT(dow FROM r.rental_date) AS dayofweek,
  AGE(r.return_date, r.rental_date) AS rental_days,
  -- Use DATE_TRUNC to get days from the AGE function
  CASE WHEN DATE_TRUNC('day', AGE(r.return_date, r.rental_date)) > 
  -- Calculate number of d
    f.rental_duration * INTERVAL '1' day 
  THEN TRUE 
  ELSE FALSE END AS past_due 
FROM 
  film AS f 
  INNER JOIN inventory AS i 
  	ON f.film_id = i.film_id 
  INNER JOIN rental AS r 
  	ON i.inventory_id = r.inventory_id 
  INNER JOIN customer AS c 
  	ON c.customer_id = r.customer_id 
WHERE 
  -- Use an INTERVAL for the upper bound of the rental_date 
  r.rental_date BETWEEN CAST('2005-05-01' AS DATE) 
  AND CAST('2005-05-01' AS DATE) + INTERVAL '90 day';
#########################SELECT 
  -- Concatenate the category name to coverted to uppercase
  -- to the film title converted to title case
  UPPER(c.name)  || ': ' || INITCAP(title) AS film_category, 
  -- Convert the description column to lowercase
  LOWER(description) AS description
FROM 
  film AS f 
INNER JOIN 
  film_category AS fc 
ON 
  f.film_id = fc.film_id 
INNER JOIN 
  category AS c 
ON fc.category_id = c.category_id;
#########################
SELECT 
  -- Replace whitespace in the film title with an underscore
  REPLACE(title, ' ', '_') AS title
FROM film; 
#########################
SELECT 
  -- Select the title and description columns
  title,
  description,
  -- Determine the length of the description column
  LENGTH(description) AS desc_len
FROM 
  film;
########################
SELECT 
  -- Select the first 50 characters of description
  LEFT(description,50) AS short_desc
FROM 
  film AS f; 
################
SELECT 
  -- Select only the street name from the address table
  SUBSTRING(address FROM POSITION(' ' IN address)+1 FOR LENGTH(address))
FROM 
  address;
#################
SELECT
  -- Extract the characters to the left of the '@'
  LEFT(email, POSITION('@' IN email)-1) AS username,
  -- Extract the characters to the right of the '@'
  SUBSTRING(email FROM POSITION('@' IN email)+1 FOR LENGTH(email)) AS domain
FROM 
  customer;
###############
-- Concatenate the padded first_name and last_name 
SELECT 
	RPAD(first_name, LENGTH(first_name)+1) || last_name  AS full_name
FROM 
	customer;
############
-- Concatenate the first_name and last_name 
SELECT 
	first_name || LPAD(last_name, LENGTH(last_name)+1) AS full_name
FROM 
	customer; 
##############
-- Concatenate the first_name and last_name 
SELECT 
	RPAD(first_name, LENGTH(first_name)+1) 
    || 
    RPAD(last_name, LENGTH(last_name)+2, ' <') 
    ||
    RPAD(email, LENGTH(email)+1, '>') AS full_email
FROM 
    customer; 
################
-- Concatenate the uppercase category name and film title
SELECT 
  CONCAT(UPPER(name), ': ', title) AS film_category, 
  -- Truncate the description remove trailing whitespace
  TRIM(LEFT(description, 50)) AS film_desc
FROM 
  film AS f 
INNER JOIN 
  film_category AS fc 
ON 
  f.film_id = fc.film_id 
INNER JOIN 
  category AS c 
ON 
  fc.category_id = c.category_id;
################
SELECT 
  UPPER(c.name) || ': ' || f.title AS film_category, 
  -- Truncate the description without cutting off a word
  LEFT(description, 50 - 
    -- Subtract the position of the first whitespace character
    POSITION
    (
      ' ' IN REVERSE(LEFT(description, 50))
    )
  ) 
FROM 
  film AS f 
  INNER JOIN film_category AS fc 
  	ON f.film_id = fc.film_id 
  INNER JOIN category AS c 
  	ON fc.category_id = c.category_id;
###############
-- Select all columns
SELECT 
    *
FROM 
    film
-- Select only records that begin with the word 'GOLD'
WHERE 
    title LIKE 'GOLD%';
#########
SELECT 
    *
FROM 
    film
-- Select only records that end with the word 'GOLD'
WHERE 
    title LIKE '%GOLD';
############
SELECT 
    *
FROM 
    film
-- Select only records that contain the word 'GOLD'
WHERE 
    title LIKE '%GOLD%';
###########
-- Select the film description as a tsvector
SELECT 
    to_tsvector(description)
FROM 
    film;
######################
-- Select the title and description
SELECT 
    title, description
FROM 
    film
-- Convert the title to a tsvector and match it against the tsquery 
WHERE 
    to_tsvector(title) @@ tsquery('elf');
##########################
-- Create an enumerated data type, compass_position
CREATE TYPE compass_position AS ENUM 
(
  	-- Use the four cardinal directions
  	'SOUTH', 
  	'WEST',
  	'EAST', 
  	'NORTH'
);
#######################
-- Create an enumerated data type, compass_position
CREATE TYPE compass_position AS ENUM 
(
  	-- Use the four cardinal directions
  	'North', 
  	'South',
  	'East', 
  	'West'
);
-- Confirm the new data type is in the pg_type system table
SELECT 
	*
FROM 
	pg_type
WHERE 
	typname = 'compass_position';
###########
SELECT 
    column_name, 
    data_type,
    udt_name
FROM 
    INFORMATION_SCHEMA.COLUMNS 
-- Filter by the rating column in the film table
WHERE 
    table_name = 'film'
    AND
    column_name = 'rating'
############
SELECT 
    *
FROM 
    pg_type
WHERE
    typname = 'mpaa_rating'
###########
-- Select the film title and inventory ids
SELECT 
	f.title, 
    i.inventory_id
FROM 
	film AS f 
	-- Join the film table to the inventory table
INNER JOIN 
	inventory AS i ON f.film_id = i.film_id
################
-- Select the film title, rental and inventory ids
SELECT 
	f.title, 
    i.inventory_id,
    -- Determine whether the inventory is held by a customer
    inventory_held_by_customer(i.inventory_id) AS held_by_cust
FROM film as f 
	-- Join the film table to the inventory table
	INNER JOIN inventory AS i ON f.film_id=i.film_id 
####################
-- Select the film title and inventory ids
SELECT 
	f.title, 
    i.inventory_id,
    -- Determine whether the inventory is held by a customer
    inventory_held_by_customer(i.inventory_id) as held_by_cust
FROM film as f 
	INNER JOIN inventory AS i ON f.film_id=i.film_id 
WHERE
	-- Only include results where the held_by_cust is not null
    inventory_held_by_customer(i.inventory_id) IS NOT NULL
#################
-- Enable the pg_trgm extension
CREATE EXTENSION IF NOT EXISTS pg_trgm;
################
-- Select all rows extensions
SELECT 
    *
FROM 
    pg_extension;
############
-- Select the title and description columns
SELECT 
  title, 
  description, 
  -- Calculate the similarity
  similarity(title, description)
FROM 
  film
############
-- Select the title and description columns
SELECT  
  title, 
  description, 
  -- Calculate the levenshtein distance
  levenshtein(title, 'JET NEIGHBOR') AS distance
FROM 
  film
ORDER BY 3
#############
-- Select the title and description columns
SELECT  
  title, 
  description 
FROM 
  film
WHERE 
  -- Match "Astounding Drama" in the description
  to_tsvector(description) @@ 
  to_tsquery('Astounding & Drama');
###########
SELECT 
  title, 
  description, 
  -- Calculate the similarity
  similarity(description, 'Astounding Drama')
FROM 
  film 
WHERE 
  to_tsvector(description) @@ 
  to_tsquery('Astounding & Drama') 
ORDER BY 
	similarity(description, 'Astounding Drama') DESC;
