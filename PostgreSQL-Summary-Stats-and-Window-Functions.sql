SELECT
  *,
  -- Assign numbers to each row
  ROW_NUMBER() OVER
  (

  ) AS Row_N
FROM 
  Summer_Medals
ORDER BY 
  Row_N ASC;

################################
SELECT
  Year,

  -- Assign numbers to each year
  ROW_NUMBER() OVER()AS Row_N
FROM 
(
  SELECT
    DISTINCT year
  FROM 
    Summer_Medals
  ORDER BY 
    Year ASC
) 
AS Years
ORDER BY 
  Year ASC;
################################
SELECT
  -- Count the number of medals each athlete has earned
  athlete,
  COUNT(medal) AS Medals
FROM 
  Summer_Medals
GROUP BY 
  Athlete
ORDER BY 
  Medals DESC;
###############################
WITH Athlete_Medals AS 
(
  SELECT
    -- Count the number of medals each athlete has earned
    Athlete,
    COUNT(*) AS Medals
  FROM 
    Summer_Medals
  GROUP BY 
    Athlete
)

SELECT
  -- Number each athlete by how many medals they've earned
  athlete,
  ROW_NUMBER() OVER 
  (
    ORDER BY medals DESC
  ) 
  AS Row_N
FROM 
  Athlete_Medals
ORDER BY 
  Medals DESC;
###########################################
SELECT
  -- Return each year's champions' countries
  year,
  country AS champion
FROM 
  Summer_Medals
WHERE
  Discipline = 'Weightlifting' 
  AND
  Event = '69KG' 
  AND
  Gender = 'Men' 
  AND
  Medal = 'Gold';
###########################################
WITH Weightlifting_Gold AS 
(
  SELECT
    -- Return each year's champions' countries
    Year,
    Country AS champion
  FROM 
    Summer_Medals
  WHERE
    Discipline = 'Weightlifting' 
    AND
    Event = '69KG' 
    AND
    Gender = 'Men' 
    AND
    Medal = 'Gold'
)

SELECT
  Year, Champion,
  -- Fetch the previous year's champion
  LAG(Champion) 
  OVER
  (
    ORDER BY
      Champion ASC
  ) 
  AS Last_Champion
FROM 
  Weightlifting_Gold
ORDER BY 
  Year ASC;
####################################
WITH Tennis_Gold AS 
(
  SELECT DISTINCT
    Gender, 
    Year, 
    Country
  FROM 
    Summer_Medals
  WHERE
    Year >= 2000 
    AND
    Event = 'Javelin Throw' 
    AND
    Medal = 'Gold'
)

SELECT
  Gender, 
  Year,
  Country AS Champion,
  -- Fetch the previous year's champion by gender
  LAG(country) OVER 
  (
    PARTITION BY 
      Gender
    ORDER BY 
      year ASC
  ) 
  AS Last_Champion
FROM 
  Tennis_Gold
ORDER BY 
  Gender ASC, 
  Year ASC;
##########################################
WITH Discus_Medalists AS 
(
  SELECT DISTINCT
    Year,
    Athlete
  FROM 
    Summer_Medals
  WHERE 
    Medal = 'Gold'
    AND 
    Event = 'Discus Throw'
    AND 
    Gender = 'Women'
    AND 
    Year >= 2000
)

SELECT
  -- For each year, fetch the current and future medalists
  year,
  Athlete,
  LEAD(Athlete,3) 
  OVER 
  (
    ORDER BY 
      year ASC
  ) 
  AS Future_Champion
FROM 
  Discus_Medalists
ORDER BY 
  Year ASC;
######################################
WITH All_Male_Medalists AS 
(
  SELECT DISTINCT
    Athlete
  FROM 
    Summer_Medals
  WHERE 
    Medal = 'Gold'
    AND 
    Gender = 'Men'
)

SELECT
  -- Fetch all athletes and the first athlete alphabetically
  athlete,
  FIRST_VALUE(Athlete) OVER 
  (
    ORDER BY 
       athlete ASC
  ) 
  AS First_Athlete
FROM 
  All_Male_Medalists;
#########################################
SELECT
  Year,
  City,
  -- Get the last city in which the Olympic games were held
  LAST_VALUE(city) OVER 
  (
   ORDER BY 
    year ASC
   RANGE BETWEEN
     UNBOUNDED PRECEDING AND
     UNBOUNDED FOLLOWING
  ) AS Last_City
FROM 
  Hosts
ORDER BY 
  Year ASC;
#####################################
WITH Athlete_Medals AS 
(
  SELECT
    Athlete,
    COUNT(*) AS Medals
  FROM 
    Summer_Medals
  GROUP BY 
    Athlete
)

SELECT
  Athlete,
  Medals,
  -- Rank athletes by the medals they've won
  RANK() 
  OVER 
  (
    ORDER BY 
      Medals DESC
  ) 
  AS Rank_N
FROM 
  Athlete_Medals
ORDER BY 
  Medals DESC;
######################################
WITH Events AS 
(
  SELECT 
    DISTINCT Event
  FROM 
    Summer_Medals
)
  
SELECT
  --- Split up the distinct events into 111 unique groups
  Event,
  NTILE(111) OVER 
  (
    ORDER BY 
      event ASC
  ) AS Page
FROM 
  Events
ORDER BY 
  Event ASC;
###############################
WITH 
  Athlete_Medals AS 
  (
    SELECT 
      Athlete, 
      COUNT(*) AS Medals
    FROM 
      Summer_Medals
    GROUP BY 
      Athlete
    HAVING 
      COUNT(*) > 1
  ),
  
  Thirds AS 
  (
    SELECT
      Athlete,
      Medals,
      NTILE(3) OVER 
      (
        ORDER BY Medals DESC
      ) 
      AS Third
    FROM 
      Athlete_Medals
  )
  
SELECT
  third,
  -- Get the average medals earned in each third
  AVG(medals) AS Avg_Medals
FROM 
  Thirds
GROUP BY 
  Third
ORDER BY 
  Third ASC;
################################
WITH Athlete_Medals AS 
(
  SELECT 
    Athlete, 
    COUNT(*) AS Medals
  FROM 
    Summer_Medals
  GROUP BY 
    Athlete
  HAVING 
    COUNT(*) > 1
)
  
SELECT
  Athlete,
  Medals,
  -- Split athletes into thirds by their earned medals
  NTILE(3) OVER 
  (
    ORDER BY
      medals DESC
  ) AS Third
FROM 
  Athlete_Medals
ORDER BY 
  Medals DESC, 
  Athlete ASC;
#######################################
WITH Country_Medals AS 
(
  SELECT
    Year, 
    Country, 
    COUNT(*) AS Medals
  FROM 
    Summer_Medals
  WHERE
    Country IN 
      ('CHN', 'KOR', 'JPN')
    AND 
    Medal = 'Gold' 
    AND 
    Year >= 2000
  GROUP BY 
    Year, 
    Country
)

SELECT
  -- Return the max medals earned so far per country
  country,
  year,
  medals,
  MAX(medals) OVER 
  (
    PARTITION BY 
      country
    ORDER BY 
      year ASC
  ) 
  AS Max_Medals
FROM 
  Country_Medals
ORDER BY 
  Country ASC, 
  Year ASC;
##############################
WITH Athlete_Medals AS 
(
  SELECT
    Athlete, 
    COUNT(*) AS Medals
  FROM 
    Summer_Medals
  WHERE
    Country = 'USA' 
    AND 
    Medal = 'Gold'
    AND 
    Year >= 2000
  GROUP BY 
    Athlete
)

SELECT
  -- Calculate the running total of athlete medals
  Athlete,
  medals,
  SUM(Medals) OVER 
  (
    ORDER BY
      athlete ASC
  ) 
  AS Max_Medals
FROM 
  Athlete_Medals
ORDER BY 
  Athlete ASC;
#####################################
WITH France_Medals AS 
(
  SELECT
    Year, 
    COUNT(*) AS Medals
  FROM 
    Summer_Medals
  WHERE
    Country = 'FRA'
    AND 
    Medal = 'Gold' 
    AND 
    Year >= 2000
  GROUP BY 
    Year
)

SELECT
  Year,
  Medals,
  MIN(Medals) 
  OVER 
  (
    ORDER BY 
      year ASC
  ) 
  AS Min_Medals
FROM 
  France_Medals
ORDER BY 
  Year ASC;
###################################
WITH Scandinavian_Medals AS 
(
  SELECT
    Year, COUNT(*) AS Medals
  FROM Summer_Medals
  WHERE
    Country IN ('DEN', 'NOR', 'FIN', 'SWE', 'ISL')
    AND Medal = 'Gold'
  GROUP BY Year
)

SELECT
  -- Select each year's medals
  year,
  medals,
  -- Get the max of the current and next years'  medals
  MAX(medals) OVER 
  (
    ORDER BY 
      year ASC
    ROWS BETWEEN 
      CURRENT ROW
      AND
      1 FOLLOWING
  ) 
  AS Max_Medals
FROM 
  Scandinavian_Medals
ORDER BY 
  Year ASC;
###################################
WITH Chinese_Medals AS 
(
  SELECT
    Athlete, 
    COUNT(*) AS Medals
  FROM 
    Summer_Medals
  WHERE
    Country = 'CHN' 
    AND 
    Medal = 'Gold'
    AND 
    Year >= 2000
  GROUP BY 
    Athlete
)

SELECT
  -- Select the athletes and the medals they've earned
  Athlete,
  medals,
  -- Get the max of the last two and current rows' medals 
  MAX(medals) 
  OVER 
  (
    ORDER BY 
      Athlete ASC
    ROWS BETWEEN 
        2 PRECEDING
        AND
        CURRENT ROW
  ) 
  AS Max_Medals
FROM 
  Chinese_Medals
ORDER BY 
  Athlete ASC;
################################
WITH Russian_Medals AS 
(
  SELECT
    Year, 
    COUNT(*) AS Medals
  FROM 
    Summer_Medals
  WHERE
    Country = 'RUS'
    AND 
    Medal = 'Gold'
    AND 
    Year >= 1980
  GROUP BY 
    Year
)

SELECT
  Year, 
  Medals,
  --- Calculate the 3-year moving average of medals earned
  AVG(medals) OVER
  (
    ORDER BY 
      Year ASC
    ROWS BETWEEN
      2 PRECEDING 
      AND
      CURRENT ROW
  ) 
  AS Medals_MA
FROM 
  Russian_Medals
ORDER BY 
  Year ASC;
##############################
-- Create the correct extension to enable CROSSTAB
CREATE 
  EXTENSION IF NOT EXISTS tablefunc;

SELECT 
  * 
FROM 
  CROSSTAB
  (
    $$
    SELECT
      Gender, 
      Year, 
      Country
    FROM 
      Summer_Medals
    WHERE
      Year IN 
      (
        2008
        ,
        2012
      )
      AND 
      Medal = 'Gold'
      AND 
      Event = 'Pole Vault'
    ORDER By 
      Gender ASC, 
      Year ASC;
-- Fill in the correct column names for the pivoted table
    $$
) 
AS ct 
(  
  Gender VARCHAR,
  "2008" VARCHAR,
  "2012" VARCHAR
)

ORDER BY 
  Gender ASC;
##############################################
WITH Country_Awards AS 
(
  SELECT
    Country,
    Year,
    COUNT(*) AS Awards
  FROM 
    Summer_Medals
  WHERE
    Country IN ('FRA', 'GBR', 'GER')
    AND Year IN (2004, 2008, 2012)
    AND Medal = 'Gold'
  GROUP BY 
    Country, Year
)

SELECT
  -- Select Country and Year
  Country,
  year,
  -- Rank by gold medals earned per year
  RANK() OVER (PARTITION BY Year ORDER BY Awards DESC) :: INTEGER AS rank
FROM 
  Country_Awards
ORDER BY 
  Country ASC, Year ASC;
#################################
-- Count the gold medals per country and year
SELECT
  Country,
  Year,
  COUNT(*) AS Awards
FROM 
  Summer_Medals
WHERE
  Country IN ('FRA', 'GBR', 'GER')
  AND Year IN (2004, 2008, 2012)
  AND Medal = 'Gold'
GROUP BY 
  Country,Year
ORDER BY 
  Country ASC, Year ASC
#####################################
CREATE
  EXTENSION IF NOT EXISTS tablefunc;

SELECT 
  * 
FROM 
  CROSSTAB
  (
    $$
    WITH Country_Awards AS 
    (
      SELECT
        Country,
        Year,
        COUNT(*) AS Awards
      FROM 
        Summer_Medals
      WHERE
        Country IN ('FRA', 'GBR', 'GER')
        AND 
        Year IN (2004, 2008, 2012)
        AND 
        Medal = 'Gold'
      GROUP BY 
        Country, 
        Year
    )

  SELECT
    Country,
    Year,
    RANK() OVER
    (
      PARTITION BY 
        Year
      ORDER BY 
        Awards DESC
    ) 
    :: INTEGER AS rank
  FROM 
    Country_Awards
  ORDER BY 
    Country ASC, 
    Year ASC;
-- Fill in the correct column names for the pivoted table
  $$
) 
AS ct 
(
  Country VARCHAR,
  "2004" INTEGER,
  "2008" INTEGER,
  "2012" INTEGER
)

Order by Country ASC;
########################
-- Count the gold medals per country and gender
SELECT
  country,
  gender,
  COUNT(*) AS Gold_Awards
FROM 
  Summer_Medals
WHERE
  Year = 2004
  AND 
  Medal = 'Gold'
  AND 
  Country IN ('DEN', 'NOR', 'SWE')
-- Generate Country-level subtotals
GROUP BY 
  country, ROLLUP(Gender)
ORDER BY 
  Country ASC, Gender ASC;
######################
-- Count the medals per gender and medal type
SELECT
  Gender,
  Medal,
  COUNT(*) AS Awards
FROM 
  Summer_Medals
WHERE
  Year = 2012
  AND 
  Country = 'RUS'
-- Get all possible group-level subtotals
GROUP BY 
  CUBE(Gender,Medal)
ORDER BY 
  Gender ASC, Medal ASC;
#####################################
SELECT
  -- Replace the nulls in the columns with meaningful text
  COALESCE(Country, 'All countries') AS Country,
  COALESCE(Gender, 'All genders') AS Gender,
  COUNT(*) AS Awards
FROM 
  Summer_Medals
WHERE
  Year = 2004
  AND 
  Medal = 'Gold'
  AND 
  Country IN ('DEN', 'NOR', 'SWE')
GROUP BY 
  ROLLUP(Country, Gender)
ORDER BY 
  Country ASC, 
  Gender ASC;
###############################
WITH Country_Medals AS (
  SELECT
    Country,
    COUNT(*) AS Medals
  FROM Summer_Medals
  WHERE Year = 2000
    AND Medal = 'Gold'
  GROUP BY Country)

  SELECT
    Country,
    -- Rank countries by the medals awarded
    RANK() OVER (ORDER BY Medals DESC) AS Rank
  FROM 
    Country_Medals
  ORDER BY 
    Rank ASC;
########################
WITH Country_Medals AS (
  SELECT
    Country,
    COUNT(*) AS Medals
  FROM Summer_Medals
  WHERE Year = 2000
    AND Medal = 'Gold'
  GROUP BY Country),

  Country_Ranks AS (
  SELECT
    Country,
    RANK() OVER (ORDER BY Medals DESC) AS Rank
  FROM Country_Medals
  ORDER BY Rank ASC)

-- Compress the countries column
SELECT STRING_AGG(Country,', ')
FROM Country_Ranks
-- Select only the top three ranks
WHERE Rank < 4;
