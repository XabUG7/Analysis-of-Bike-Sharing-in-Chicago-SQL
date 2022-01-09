-- Get one latitude and one longitude per station in a table

WITH bike_share_table AS (SELECT * FROM `lehenengoa.bike_share_chicago.bikashare_chicago_apr2020_aug2021`)
 
SELECT 
    station_name,
    ROUND(AVG(lat), 3) AS station_lat,
    ROUND(AVG(lng), 3) AS station_lng
FROM 
    (SELECT start_station_name AS station_name, start_lat AS lat, start_lng AS lng FROM bike_share_table 
    UNION ALL
    SELECT end_station_name AS station_name, end_lat AS lat, end_lng AS lng FROM bike_share_table)

GROUP BY station_name
ORDER BY station_name DESC