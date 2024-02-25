--Table Part 1
-- Add a new column for temperature delta between consecutive hourly records
ALTER TABLE weather_data
ADD COLUMN temperature_delta DECIMAL(5,2);

-- Update the temperature delta column with the temperature difference between consecutive records
UPDATE weather_data w
SET temperature_delta = w.temperature - (
    SELECT temperature
    FROM weather_data
    WHERE locality = w.locality
    AND country = w.country
    AND recorded_at = (w.recorded_at - INTERVAL '1 hour')
);

-- Back-fill temperature delta for all existing temperature occurrences
UPDATE weather_data
SET temperature_delta = 0 -- Set default value for the first record
WHERE temperature_delta IS NULL;


--Table Part 2
-- Add a new column for temperature delta between consecutive daily records
ALTER TABLE weather_data_fahrenheit_daily
ADD COLUMN temperature_delta DECIMAL(5,2);

-- Update the temperature delta column with the temperature difference between consecutive records
UPDATE weather_data_fahrenheit_daily w
SET temperature_delta = w.temperature_fahrenheit - (
    SELECT temperature_fahrenheit
    FROM weather_data_fahrenheit_daily
    WHERE locality = w.locality
    AND country = w.country
    AND recorded_date = (w.recorded_date - INTERVAL 1 DAY)
);

-- Back-fill temperature delta for all existing temperature occurrences
UPDATE weather_data_fahrenheit_daily
SET temperature_delta = 0 -- Set default value for the first record
WHERE temperature_delta IS NULL;
