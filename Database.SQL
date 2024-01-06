CREATE DATABASE United_Nations;
USE United_Nations;
CREATE TABLE Access_to_basic_services
(
Region VARCHAR(32),
Sub_Region VARCHAR(25),
Country_name VARCHAR(37) NOT NULL ,
Time_period INTEGER NOT NULL ,
Pct_managed_drinked_water_services NUMERIC(5,2) ,
Pct_managed_sanitation_services NUMERIC(5,2) ,
Est_population_in_millions NUMERIC(11,6) ,
Est_gdp_in_billions NUMERIC(8,2) , 
Land_area NUMERIC(10,2) ,
Pct_unemployment NUMERIC(5,2)
);
