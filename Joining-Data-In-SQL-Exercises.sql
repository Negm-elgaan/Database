SELECT 
    cities.name AS city,
    countries.name AS country,
    countries.region
FROM 
    cities
INNER JOIN 
    countries
ON 
    cities.country_code = countries.code;

#######################################
SELECT
    c.code AS country_code,
    name,
    year,
    inflation_rate
FROM countries AS c
-- Join to economies (alias e)
INNER JOIN
    economies AS e
-- Match on code field using table aliases
ON
    e.code = c.code
############################################
SELECT 
    c.name AS country, l.name AS language, official
FROM 
    countries AS c
INNER JOIN 
    languages AS l
-- Match using the code column
USING 
    (code)
#########################################
-- Select country and language names, aliased
SELECT
    c.name AS country,
    l.name AS language
-- From countries (aliased)
FROM
    countries AS c
-- Join to languages (aliased)
INNER JOIN
    languages AS l
-- Use code as the joining field with the USING keyword
USING 
    (code);
-- Rearrange SELECT statement, keeping aliases
SELECT l.name AS language,c.name AS country
FROM countries AS c
INNER JOIN languages AS l
USING(code)
-- Order the results by language
ORDER BY language
########################################
SELECT
    name,
    year,
    fertility_rate
FROM
    countries AS c
INNER JOIN
    populations p
ON
    c.code = p.country_code
###########################################
-- Select fields
SELECT 
    name, 
    e.year, 
    fertility_rate,
    unemployment_rate
FROM 
    countries AS c
INNER JOIN 
    populations AS p
ON 
    c.code = p.country_code
-- Join to economies (as e)
INNER JOIN
    economies e
-- Match on country code
ON
   p.country_code = e.code ;
#########################################
SELECT name, e.year, fertility_rate, unemployment_rate
FROM countries AS c
INNER JOIN populations AS p
ON c.code = p.country_code
INNER JOIN economies AS e
ON c.code = e.code
-- Add an additional joining condition such that you are also joining on year
AND 
	e.year = p.year;
########################################
SELECT 
    c1.name AS city,
    code,
    c2.name AS country,
    region,
    city_proper_pop
FROM cities AS c1
-- Perform an inner join with cities as c1 and countries as c2 on country code
INNER JOIN
    countries AS c2
ON
    c2.code = c1.country_code
ORDER BY code DESC;
#####################################
SELECT 
	c1.name AS city, 
    code, 
    c2.name AS country,
    region, 
    city_proper_pop
FROM cities AS c1
-- Join right table (with alias)
LEFT JOIN
    countries as c2
ON c1.country_code = c2.code
ORDER BY code DESC;
#######################################
SELECT 
    name, 
    region, 
    gdp_percapita
FROM 
    countries AS c
LEFT JOIN 
    economies AS e
-- Match on code fields
ON
    c.code = e.code
-- Filter for the year 2010
WHERE
    year = 2010;
########################################
-- Select region, and average gdp_percapita as avg_gdp
SELECT
    region,
    AVG(gdp_percapita) AS avg_gdp
FROM countries AS c
LEFT JOIN economies AS e
USING(code)
WHERE year = 2010
-- Group by region
GROUP BY
    region;
#######################################
SELECT 
    region, 
    AVG(gdp_percapita) AS avg_gdp
FROM 
    countries AS c
LEFT JOIN 
    economies AS e
USING(code)
WHERE 
    year = 2010
GROUP BY 
    region
-- Order by descending avg_gdp
ORDER BY
    avg_gdp DESC
-- Return only first 10 records
LIMIT 
    10;
#########################################
-- Modify this query to use RIGHT JOIN instead of LEFT JOIN
SELECT countries.name AS country, languages.name AS language, percent
FROM languages
RIGHT JOIN countries
USING(code)
ORDER BY language;
##############################################
SELECT 
    name AS country, 
    code, 
    region, 
    basic_unit
FROM countries
-- Join to currencies
LEFT JOIN
    currencies
USING (code)
-- Where region is North America or name is null
WHERE 
    region = 'North America'
    OR
    Name IS NULL
ORDER BY 
    region;
#########################################
SELECT 
	name AS country,
	code, 
	region, 
	basic_unit
FROM countries
-- Join to currencies
LEFT JOIN
	currencies
USING (code)
WHERE region = 'North America' 
	OR name IS NULL
ORDER BY region;
########################################
SELECT 
	name AS country,
	code, 
	region, 
	basic_unit
FROM countries
-- Join to currencies
LEFT JOIN
	currencies
USING (code)
WHERE region = 'North America' 
	OR name IS NULL
ORDER BY region;
######################################
SELECT 
	c.name AS country, 
	l.name AS language
-- Inner join countries as c with languages as l on code
FROM
	countries c
INNER JOIN
	languages l
ON
	c.code = l.code
WHERE 
	c.code IN ('PAK','IND')
	AND l.code in ('PAK','IND');
#######################################
SELECT 
	c.name AS country, 
	l.name AS language
FROM 
	countries AS c        
-- Perform a cross join to languages (alias as l)
CROSS JOIN
	languages l
WHERE 
	c.code in ('PAK','IND')
	AND l.code in ('PAK','IND');
#########################################
SELECT 
	c.name AS country,
    region,
    life_expectancy AS life_exp
FROM countries AS c
-- Join to populations (alias as p) using an appropriate join
INNER JOIN
    populations p
ON c.code = p.country_code
-- Filter for only results in the year 2010
WHERE
    year = 2010
-- Sort by life_exp
ORDER BY
    life_exp
-- Limit to five records
LIMIT
    5;
#######################################
-- Select aliased fields from populations as p1
SELECT
    p1.country_code,
    p1.size AS size2010,
    p2.size AS size2015
-- Join populations as p1 to itself, alias as p2, on country code
FROM
    populations p1
INNER JOIN
    populations p2
USING(country_code)
#######################################
SELECT 
	p1.country_code, 
    p1.size AS size2010, 
    p2.size AS size2015
FROM 
    populations AS p1
INNER JOIN 
    populations AS p2
ON 
    p1.country_code = p2.country_code
WHERE 
    p1.year = 2010
    AND
    p1.year = p2.year - 5 ;
-- Filter such that p1.year is always five years before p2.year
############################################################
-- Select all fields from economies2015
SELECT
    *
FROM
    economies2015
-- Set operation
UNION
-- Select all fields from economies2019
SELECT
    *
FROM
    economies2019
ORDER BY code, year;
##############################################################
-- Query that determines all pairs of code and year from economies and populations, without duplicates
SELECT
    code,
    year
FROM
    economies
UNION
SELECT
    country_code,
    year
FROM
    populations
##########################################################
SELECT 
    code, year
FROM 
    economies
-- Set theory clause
UNION ALL
SELECT 
    country_code, year
FROM 
    populations
ORDER BY 
    code, year;
#######################################################
-- Return all cities that do not have the same name as a country
SELECT
    name
FROM
    cities
EXCEPT
SELECT
    name
FROM
    countries
ORDER BY name;
#########################################################
SELECT
    name
FROM
    countries
INTERSECT
SELECT
    name
FROM
    cities
####################################################
-- Select country code for countries in the Middle East
SELECT
    code
FROM
    countries
WHERE
    region = 'Middle East'
#####################################################
-- Select unique language names
SELECT
    DISTINCT name
FROM 
    languages
-- Order by the name of the language
ORDER BY
    name;
##################################################
SELECT 
    DISTINCT name
FROM 
    languages
-- Add syntax to use bracketed subquery below as a filter
WHERE
    code IN 
    (
        SELECT 
            code
        FROM 
            countries
        WHERE 
            region = 'Middle East'
    )
ORDER BY 
    name;
##############################################
-- Select code and name of countries from Oceania
SELECT
    code,
    name
FROM
    countries
WHERE
    continent = 'Oceania';
##############################################
SELECT 
  code, name
FROM 
  countries
WHERE 
  continent = 'Oceania'
-- Filter for countries not included in the bracketed subquery
  AND code NOT IN 
  (
    SELECT 
      code
    FROM 
      currencies
  );
##############################################
-- Select average life_expectancy from the populations table
SELECT
    AVG(life_expectancy)
FROM
    populations
-- Filter for the year 2015
WHERE
    year = 2015
#############################################
SELECT 
  *
FROM 
  populations
-- Filter for only those populations where life expectancy is 1.15 times higher than average
WHERE 
  life_expectancy > 1.15 *
  (
    SELECT 
      AVG(life_expectancy)
    FROM 
      populations
    WHERE 
      year = 2015
  ) 
  AND 
    year = 2015;
#################################################
-- Select relevant fields from cities table
SELECT
    name,
    country_code,
    urbanarea_pop
FROM
    cities
-- Filter using a subquery on the countries table
WHERE
    name IN
    (
        SELECT
            capital
        FROM
            countries
    )
ORDER BY urbanarea_pop DESC;
#############################################
-- Find top nine countries with the most cities
SELECT
    c2.name AS country,
    COUNT(c1.*) AS cities_num
FROM
    countries c2
LEFT JOIN
    cities c1
ON
    c1.country_code = c2.code
-- Order by count of cities as cities_num
GROUP BY
    c2.name
ORDER BY 
    cities_num DESC
LIMIT 
    9;
############################################
SELECT countries.name AS country,
-- Subquery that provides the count of cities   
  (SELECT COUNT(*)
   FROM cities
   WHERE cities.country_code = countries.code) AS cities_num
FROM countries
ORDER BY cities_num DESC, country
LIMIT 9;
###########################################
-- Select code, and language count as lang_num
SELECT
    code,
    COUNT(*) AS lang_num
FROM
     languages
GROUP BY
    code;
#############################################
-- Select local_name and lang_num from appropriate tables
SELECT
  local_name,
  lang_num
FROM
  countries,
  (
    SELECT 
      code,
      COUNT(*) AS lang_num
  FROM 
    languages
  GROUP BY 
    code
  ) AS sub
-- Where codes match
WHERE
  countries.code = sub.code
ORDER BY lang_num DESC;
#########################################
-- Select relevant fields
SELECT
  code,
  inflation_rate,
  unemployment_rate
FROM
  economies
WHERE 
  year = 2015 
  AND 
  code NOT IN
-- Subquery returning country codes filtered on gov_form
	(
    SELECT
      code
    FROM
      countries
    WHERE
      gov_form  LIKE '%Republic%'
      OR
      gov_form  LIKE '%Monarchy%'
      
  )
ORDER BY inflation_rate;
#########################################
-- Select fields from cities
SELECT
    name,
    country_code,
    city_proper_pop,
    metroarea_pop,
    (city_proper_pop / metroarea_pop) * 100 AS city_perc
FROM
    cities
-- Use subquery to filter city name
WHERE
    name IN
    (
        SELECT
            capital
        FROM
            countries
        WHERE
            continent LIKE '%America%'
            OR
            continent = 'Europe'
    )
-- Add filter condition such that metroarea_pop does not have null values
    AND
        metroarea_pop IS NOT NULL
-- Sort and limit the result
ORDER BY
    city_perc DESC
LIMIT
    10;
