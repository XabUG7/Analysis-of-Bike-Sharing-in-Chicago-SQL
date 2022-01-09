--merge databases with different data format
--and discard the rides that started or ended in the warehouse for being biased rides

SELECT 
    *
FROM (
    SELECT 
        ride_id,rideable_type,started_at,ended_at,start_station_name,CAST(start_station_id AS STRING) AS start_station_id,
        end_station_name,CAST(end_station_id AS STRING) AS end_station_id,start_lat,start_lng,end_lat,end_lng,member_casual 
    FROM `lehenengoa.bike_share_capstone.initial_integer`
    UNION ALL 
    SELECT 
        ride_id,rideable_type,started_at,ended_at,start_station_name,start_station_id,
        end_station_name,end_station_id,start_lat,start_lng,end_lat,end_lng,member_casual 
    FROM `lehenengoa.bike_share_capstone.second_string`)
WHERE LENGTH(start_station_id) < 30 AND LENGTH(end_station_id) < 30