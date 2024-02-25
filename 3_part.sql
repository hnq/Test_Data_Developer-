-- Create a new table for weather data with temperature in Fahrenheit and distributed per day no more per hour
CREATE TABLE weather_data_fahrenheit_daily (
    id INT AUTO_INCREMENT PRIMARY KEY,
    locality VARCHAR(100),
    country VARCHAR(100),
    temperature_fahrenheit DECIMAL(5,2),
    recorded_date DATE,
    cloud_coverage ENUM('Minimal', 'Partial', 'Full'),
    uv_index INT,
    atmospheric_pressure DECIMAL(7,2),
    wind_speed DECIMAL(6,2)
);

-- Populate the new table with data converted from the existing table
INSERT INTO weather_data_fahrenheit_daily (locality, country, temperature_fahrenheit, recorded_date, cloud_coverage, uv_index, atmospheric_pressure, wind_speed)
SELECT locality,
       country,
       ROUND((temperature * 9/5) + 32, 2) AS temperature_fahrenheit, -- Convert Celsius to Fahrenheit
       DATE(recorded_at) AS recorded_date,
       cloud_coverage,
       uv_index,
       atmospheric_pressure,
       wind_speed
FROM weather_data;

-- Create an index on recorded_date for faster date-based queries
CREATE INDEX idx_recorded_date ON weather_data_fahrenheit_daily (recorded_date);
