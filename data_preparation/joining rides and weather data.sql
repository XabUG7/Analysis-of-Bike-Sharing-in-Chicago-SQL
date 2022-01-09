--Weather data is taken every hour and bike share data are taken every time.
    --In order to join them in the same table, the rides and the weather need to be related 
    --by date and the hour excludng the minutes and seconds where the ride started.
    
SELECT 
    * EXCEPT(date_time)
FROM (
    
    SELECT 
        * EXCEPT(time_string), 
        PARSE_DATETIME('%Y-%m-%d %H:%M:%S', CONCAT(EXTRACT(DATE FROM started_at)," " , time_string, ":00:00")) AS date_time_rides
    FROM (
        SELECT 
            *,
            CASE
            WHEN EXTRACT(HOUR FROM started_at) = 0 THEN "00"
            WHEN EXTRACT(HOUR FROM started_at) = 1 THEN "01"
            WHEN EXTRACT(HOUR FROM started_at) = 2 THEN "02"
            WHEN EXTRACT(HOUR FROM started_at) = 3 THEN "03"
            WHEN EXTRACT(HOUR FROM started_at) = 4 THEN "04"
            WHEN EXTRACT(HOUR FROM started_at) = 5 THEN "05"
            WHEN EXTRACT(HOUR FROM started_at) = 6 THEN "06"
            WHEN EXTRACT(HOUR FROM started_at) = 7 THEN "07"
            WHEN EXTRACT(HOUR FROM started_at) = 8 THEN "08"
            WHEN EXTRACT(HOUR FROM started_at) = 9 THEN "09"
            ELSE CAST(EXTRACT(HOUR FROM started_at) AS STRING)
            END AS time_string
        FROM 
            `lehenengoa.bikeshare_chicago_clean.bikeshare_chicago_full_table`) AS rides_table) AS rides_table_to_merge
    LEFT JOIN (
        SELECT 
            * EXCEPT(date,time,time_1), 
            PARSE_DATETIME('%Y-%m-%d %H:%M:%S', CONCAT(CAST(date AS STRING)," " , LEFT(time_1, 2), ":00:00")) AS date_time
        FROM (
            SELECT 
                *,
                CASE 
                WHEN time = 0 THEN "0000"
                WHEN time = 100 THEN "0100"
                WHEN time = 200 THEN "0200"
                WHEN time = 300 THEN "0300"
                WHEN time = 400 THEN "0400"
                WHEN time = 500 THEN "0500"
                WHEN time = 600 THEN "0600"
                WHEN time = 700 THEN "0700"
                WHEN time = 800 THEN "0800"
                WHEN time = 900 THEN "0900"
                ELSE CAST(time AS STRING)
                END AS time_1
            FROM 
                `lehenengoa.bikeshare_chicago_clean.weather_chicago_apr2020_aug2021` AS table_with_time_1)) AS weather_table
ON weather_table.date_time = rides_table_to_merge.date_time_rides