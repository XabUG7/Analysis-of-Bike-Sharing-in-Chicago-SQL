--This table shows average rides per hour in weekends and weekdays
--for members and casual users

SELECT 
    CONCAT(CAST(hour AS STRING), " h") AS hour,
    CAST(rides_table_hours.rides_at_hour / rided_hours.hours_with_rides AS INT64) AS avg_rides_at_given_hour,
    days, rides_table_hours.member_type AS member_type
FROM (
    SELECT 
        EXTRACT(HOUR FROM started_at) AS hour_1,
        CASE 
        WHEN EXTRACT(DAYOFWEEK FROM started_at) = 2 OR
            EXTRACT(DAYOFWEEK FROM started_at) = 3 OR
            EXTRACT(DAYOFWEEK FROM started_at) = 4 OR
            EXTRACT(DAYOFWEEK FROM started_at) = 5 OR
            EXTRACT(DAYOFWEEK FROM started_at) = 6
        THEN "weekdays"
        ELSE "weekend"
        END AS days,
        COUNT(ride_id) AS rides_at_hour,
        member_casual AS member_type
    FROM 
    `lehenengoa.bikeshare_chicago_clean.bikeshare_chicago_full_table`
    GROUP BY hour_1, days, member_type) AS rides_table_hours
INNER JOIN (
    SELECT 
        hour, COUNT(date_of_year) AS hours_with_rides
    FROM (
        SELECT 
            EXTRACT(DATE FROM started_at) AS date_of_year, EXTRACT(HOUR FROM started_at) AS hour
        FROM 
            `lehenengoa.bikeshare_chicago_clean.bikeshare_chicago_full_table`
        GROUP BY hour, date_of_year)
    GROUP BY hour) AS rided_hours
ON rides_table_hours.hour_1 = rided_hours.hour
ORDER BY hour