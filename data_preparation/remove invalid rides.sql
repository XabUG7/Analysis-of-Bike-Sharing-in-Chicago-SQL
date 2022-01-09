-- Cleaning: 
-- the ones that ended earlier than started are out as we don't know the possible reason behind that.
-- if the starting station was same as the end station we assume the trip must be at least 10 minutes otherwise we consider it a failed ride.

WITH bike_share_table AS (SELECT * FROM `lehenengoa.bike_share_chicago.bikashare_chicago_apr2020_aug2021` WHERE DATETIME_DIFF(ended_at, started_at, SECOND) > 0)

SELECT
    start_station_name,end_station_name,
    ended_at,started_at,
    DATETIME_DIFF(ended_at, started_at, DAY) AS dif_dias,
    DATETIME_DIFF(ended_at, started_at, MINUTE) AS dif_mins,
    EXTRACT(SECOND FROM ended_at - started_at) AS segs
FROM 
    bike_share_table 
WHERE
   (start_station_name = end_station_name AND DATETIME_DIFF(ended_at, started_at, MINUTE) > 10) OR start_station_name <> end_station_name
ORDER BY dif_mins ASC