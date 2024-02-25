--partitioning by date range (monthly)
CREATE TABLE weather_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    locality VARCHAR(100),
    country VARCHAR(100),
    temperature DECIMAL(5,2),
    recorded_at DATETIME,
    cloud_coverage ENUM('Minimal', 'Partial', 'Full'),
    uv_index INT,
    atmospheric_pressure DECIMAL(7,2),
    wind_speed DECIMAL(6,2),
    PARTITION BY RANGE (YEAR(recorded_at)) (
        PARTITION p0 VALUES LESS THAN (2020),
        PARTITION p1 VALUES LESS THAN (2021),
        PARTITION p2 VALUES LESS THAN (2022),
        PARTITION p3 VALUES LESS THAN (2023),
        PARTITION p4 VALUES LESS THAN MAXVALUE
    )
);


--indexing on commonly used columns
CREATE INDEX idx_locality ON weather_data (locality);
CREATE INDEX idx_recorded_at ON weather_data (recorded_at);
CREATE INDEX idx_country ON weather_data (country);

--archiving older data and compressing the table
-- Assume archived data is moved to a separate table called weather_data_archive

-- Archive data older than a certain date (e.g., older than 2 years)
CREATE TABLE weather_data_archive AS
SELECT * FROM weather_data WHERE recorded_at < DATE_SUB(NOW(), INTERVAL 2 YEAR);

-- Drop archived data from the main table
DELETE FROM weather_data WHERE recorded_at < DATE_SUB(NOW(), INTERVAL 2 YEAR);

--compressing the table
ALTER TABLE weather_data ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=8;
