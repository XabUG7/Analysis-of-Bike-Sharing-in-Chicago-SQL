-- average rides per day for casual users and members

SELECT 
    rides_table.day,
    CAST(ROUND(rides_table.rides / days_table.total_days, 0) AS INT64) AS avg_rides_per_day,
    rides_table.member_casual
FROM (
    SELECT 
        CASE
        WHEN EXTRACT(DAYOFWEEK FROM started_at) = 1 
        THEN "sunday"
        WHEN EXTRACT(DAYOFWEEK FROM started_at) = 2 
        THEN "monday"
        WHEN EXTRACT(DAYOFWEEK FROM started_at) = 3 
        THEN "tuesday"
        WHEN EXTRACT(DAYOFWEEK FROM started_at) = 4 
        THEN "wednesday"
        WHEN EXTRACT(DAYOFWEEK FROM started_at) = 5 
        THEN "thursday"
        WHEN EXTRACT(DAYOFWEEK FROM started_at) = 6 
        THEN "friday"
        ELSE "saturday"
        END AS day,
        EXTRACT(DAYOFWEEK FROM started_at) AS day_number,
        COUNT(ride_id) AS rides, member_casual,
    FROM 
        `lehenengoa.bikeshare_chicago_clean.bikeshare_chicago_full_table` 
        GROUP BY day, day_number, member_casual
        ORDER BY day_number) AS rides_table
INNER JOIN 
    (SELECT 
    day_of_week AS day_of_week, COUNT(day_of_week) AS total_days
    FROM(
        SELECT 
        EXTRACT(DATE FROM started_at) AS date, EXTRACT(DAYOFWEEK FROM started_at) AS day_of_week
        FROM 
            `lehenengoa.bikeshare_chicago_clean.bikeshare_chicago_full_table`
        GROUP BY date, day_of_week)
    GROUP BY day_of_week) AS days_table
ON days_table.day_of_week = rides_table.day_number