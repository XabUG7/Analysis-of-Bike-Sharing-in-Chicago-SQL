--Adding a single geographical location to each station.
SELECT 
    locations_table_1.ride_id, locations_table_1.rideable_type, locations_table_1.started_at, locations_table_1.ended_at,
    locations_table_1.start_station_name, locations_table_1.start_lat, locations_table_1.start_lng,
    locations_table_1.end_station_name, stations_table_1.station_lat AS end_lat, stations_table_1.station_lng AS end_lng,
    locations_table_1.member_casual
FROM (
    SELECT 
        rides_table_1.ride_id, rides_table_1.rideable_type, rides_table_1.started_at, rides_table_1.ended_at,
        rides_table_1.start_station_name, stations_table_1.station_lat AS start_lat, stations_table_1.station_lng AS start_lng,
        rides_table_1.end_station_name, rides_table_1.member_casual, 
    FROM 
        `lehenengoa.bikeshare_chicago_clean.bikeshare_chicago_full_table`  AS rides_table_1
    JOIN `lehenengoa.bike_share_chicago.station_lat_lng` AS stations_table_1
        ON rides_table_1.start_station_name = stations_table_1.station_name
    WHERE rides_table_1.start_station_name IS NOT NULL) AS locations_table_1
JOIN `lehenengoa.bike_share_chicago.station_lat_lng` AS stations_table_1
    ON locations_table_1.end_station_name = stations_table_1.station_name
WHERE locations_table_1.end_station_name IS NOT NULL