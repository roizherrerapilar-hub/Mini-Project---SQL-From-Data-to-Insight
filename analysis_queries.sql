USE teen_mental_health;

#1. Uso mínimo y máximo diario y nocturno entre adolescentes. 
SELECT 
    MIN(cu.daily_social_media_hours) AS min_daily,
    MIN(cu.screen_time_before_sleep) AS min_night,
    MAX(cu.daily_social_media_hours) AS max_daily,
    MAX(cu.screen_time_before_sleep) AS max_night
FROM comportamiento_uso AS cu;

#El uso diario de redes sociales presenta una alta variabilidad, oscilando entre 1 y 8 horas, lo que indica la existencia de perfiles de uso muy distintos entre los adolescentes. En cambio, el uso antes de dormir es más limitado, con un rango entre 0.5 y 3 horas

#2. Plataforma más usada antes de dormir. 
SELECT cu.platform_usage,
ROUND(AVG(cu.screen_time_before_sleep),2) AS avg_night
FROM comportamiento_uso AS cu
GROUP BY cu.platform_usage 
ORDER BY avg_night DESC; 

#En los resultados, podemos ver que la plataforma más consumida por los adolescentes es el Tik Tok

#3. Plataforma con mayor uso medio diario. 
SELECT cu.platform_usage,
ROUND(AVG(cu.daily_social_media_hours),2) AS avg_daily
FROM comportamiento_uso AS cu
GROUP BY cu.platform_usage
ORDER BY avg_daily DESC; 

#En los resultados, podemos ver que la plataforma más utilizada durante el día es Instagram, con una media de 4.56 horas diarias. 

#4. Existe relación entre el uso de las redes sociales y el nivel de estrés en adolescentes?
SELECT 
    CASE 
        WHEN cu.daily_social_media_hours < 3 THEN 'Bajo'
        WHEN cu.daily_social_media_hours BETWEEN 3 AND 5 THEN 'Medio'
        ELSE 'Alto'
    END AS usage_level,
    ROUND(AVG(sr.stress_level), 2) AS avg_stress
FROM comportamiento_uso AS cu
INNER JOIN salud_rendimiento AS sr
    ON cu.adolescente_id = sr.adolescente_id
GROUP BY usage_level
ORDER BY 
    CASE 
        WHEN usage_level = 'Bajo' THEN 1
        WHEN usage_level = 'Medio' THEN 2
        ELSE 3
    END;

#Los niveles de estrés son ligeramente superiores en los adolescentes con mayor uso de redes sociales, aunque las diferencias son mínimas. Por lo que, no se observa una clara relación entre ambas variables. 

#5. Existe relación entre el uso de las redes sociales y el nivel de ansiedad en adolescentes?
SELECT 
    CASE 
        WHEN cu.daily_social_media_hours < 3 THEN 'Bajo'
        WHEN cu.daily_social_media_hours BETWEEN 3 AND 5 THEN 'Medio'
        ELSE 'Alto'
    END AS usage_level,
    ROUND(AVG(sr.anxiety_level), 2) AS avg_anxiety
FROM comportamiento_uso AS cu
INNER JOIN salud_rendimiento AS sr
    ON cu.adolescente_id = sr.adolescente_id
GROUP BY usage_level
ORDER BY 
    CASE 
        WHEN usage_level = 'Bajo' THEN 1
        WHEN usage_level = 'Medio' THEN 2
        ELSE 3
    END;

#6. Existe relación entre el uso de las redes sociales y el nivel de depresión en adolescentes?
SELECT 
    CASE 
        WHEN cu.daily_social_media_hours < 3 THEN 'Bajo'
        WHEN cu.daily_social_media_hours BETWEEN 3 AND 5 THEN 'Medio'
        ELSE 'Alto'
    END AS usage_level,
    ROUND(AVG(sr.depression_label), 2) AS avg_depre
FROM comportamiento_uso AS cu
INNER JOIN salud_rendimiento AS sr
    ON cu.adolescente_id = sr.adolescente_id
GROUP BY usage_level
ORDER BY 
    CASE 
        WHEN usage_level = 'Bajo' THEN 1
        WHEN usage_level = 'Medio' THEN 2
        ELSE 3
    END;

#Podemos decir que la depresión se observa en los adolescentes con mayor consumo de redes sociales, aunque es prácticamente cero; por lo que no vemos una relación entre variables.

#7. Existe relación entre el uso de las redes sociales y el rendimiento académico?
SELECT 
    CASE 
        WHEN cu.daily_social_media_hours < 3 THEN 'Bajo'
        WHEN cu.daily_social_media_hours BETWEEN 3 AND 5 THEN 'Medio'
        ELSE 'Alto'
    END AS usage_level,
    ROUND(AVG(sr.academic_performance), 2) AS avg_performance
FROM comportamiento_uso cu
INNER JOIN salud_rendimiento sr
    ON cu.adolescente_id = sr.adolescente_id
GROUP BY usage_level
ORDER BY
    CASE 
        WHEN usage_level = 'Bajo' THEN 1
        WHEN usage_level = 'Medio' THEN 2
        ELSE 3
    END;

#El rendimiento académico se mantiene bastante estable entre los distintos niveles de uso de redes sociales. Por tanto, en este dataset no se observa una relación significativa entre más horas de uso y peor rendimiento académico.

#8. ¿Existen diferencias en el uso de redes sociales según el género? 
SELECT 
    a.gender,
    ROUND(AVG(cu.daily_social_media_hours), 2) AS avg_usage,
    ROUND(STD(cu.daily_social_media_hours), 2) AS std_usage
FROM comportamiento_uso AS cu
INNER JOIN adolescentes AS a
    ON cu.adolescente_id = a.adolescente_id
GROUP BY a.gender;

#No se observan diferencias significativas en el uso medio de redes sociales entre géneros. Podemos ver que, el uso de redes sociales es heterogéneo independientemente del género.

#9. ¿Existen diferencias en el uso de redes sociales según la edad?
SELECT 
    CASE
        WHEN a.age BETWEEN 13 AND 15 THEN '13-15'
        WHEN a.age BETWEEN 16 AND 17 THEN '16-17'
        ELSE '18-19'
    END AS age_groups,
    ROUND(AVG(cu.daily_social_media_hours), 2) AS avg_usage,
    ROUND(STD(cu.daily_social_media_hours), 2) AS std_usage
FROM comportamiento_uso AS cu
INNER JOIN adolescentes AS a
    ON cu.adolescente_id = a.adolescente_id
GROUP BY age_groups
ORDER BY age_groups;

#No se observan diferencias significativas en el uso de redes sociales entre los distintos grupos de edad. Aunque el grupo de 16-17 años presenta un uso ligeramente superior, las diferencias son reducidas. Además, todos los grupos muestran una variabilidad similar, lo que indica comportamientos heterogéneos independientemente de la edad.

#10. ¿QUé plataformas tiene un uso nocturno superior a la media general?
SELECT 
    cu.platform_usage,
    ROUND(AVG(cu.screen_time_before_sleep), 2) AS avg_night
FROM comportamiento_uso cu
GROUP BY cu.platform_usage
HAVING AVG(cu.screen_time_before_sleep) > (SELECT AVG(screen_time_before_sleep) FROM comportamiento_uso)
ORDER BY avg_night DESC;

#Las plataformas con uso nocturno por encima de la media son TikTok y Both (Instagram y Tik Tok), aunque sus valores son muy similares. Esto sugiere que el uso antes de dormir no varía de forma muy significativa según la plataforma.