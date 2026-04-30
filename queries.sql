CREATE DATABASE teen_mental_health;
USE teen_mental_health;

CREATE TABLE adolescentes (
    adolescente_id INT PRIMARY KEY,
    age INT,
    gender VARCHAR(50)
);

DESCRIBE adolescentes;

CREATE TABLE comportamiento_uso (
    adolescente_id INT PRIMARY KEY,
    daily_social_media_hours DECIMAL(3,1),
    platform_usage VARCHAR(50),
    screen_time_before_sleep DECIMAL(3,1),
    FOREIGN KEY (adolescente_id) REFERENCES adolescentes(adolescente_id)
);

DESCRIBE comportamiento_uso;

CREATE TABLE salud_rendimiento (
    adolescente_id INT PRIMARY KEY,
    sleep_hours DECIMAL(3,1),
    academic_performance DECIMAL(4,2),
    physical_activity DECIMAL(3,1),
    social_interaction_level VARCHAR(50),
    stress_level INT,
    anxiety_level INT,
    addiction_level INT,
    depression_label BOOLEAN,
    FOREIGN KEY (adolescente_id) REFERENCES adolescentes(adolescente_id)
);

DESCRIBE salud_rendimiento;

SELECT * FROM adolescentes;
SELECT COUNT(*) FROM adolescentes;

SELECT * FROM comportamiento_uso;
SELECT COUNT(*) FROM comportamiento_uso;

SELECT * FROM salud_rendimiento;
SELECT COUNT(*) FROM salud_rendimiento;










