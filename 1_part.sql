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
);

