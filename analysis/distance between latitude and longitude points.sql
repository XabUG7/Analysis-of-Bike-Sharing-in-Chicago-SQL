-- Distance between start station and end station in straight line in Km
-- using Haversine formula
with table as (SELECT*,
start_lat AS dovlat, start_lng AS dovlng, end_lat AS calat, end_lng AS calng,
(start_lat-end_lat)/57.29577951 AS dlat,((start_lng-end_lng)/57.29577951) AS dlng
FROM `lehenengoa.bike_share_chicago.bikeshare_chicago_clean`)

SELECT
    ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id,
    end_station_name, end_station_id, start_lat,start_lng, end_lat, end_lng, member_casual,
    6378*2*ATAN2(POWER(a,0.5),POWER((1-a),0.5)) AS straight_distance_km
FROM(
    SELECT
        *,
        havlat+havlng*coslat AS a
    FROM(
        SELECT *,
            SIN(dlat/2)*SIN(dlat/2) AS havlat,
            SIN(dlng/2)*SIN(dlng/2) AS havlng,
            COS(dovlat/57.29577951)*COS(calat/57.29577951) AS coslat,
        FROM 
            table))
    ORDER BY straight_distance_km ASC