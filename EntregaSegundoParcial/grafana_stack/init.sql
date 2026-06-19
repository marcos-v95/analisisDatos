-- Inicialización de la base de datos para el Dashboard de Grafana (TPI - TUP)
-- Se ejecuta automáticamente al levantar el contenedor de PostgreSQL.

CREATE TABLE IF NOT EXISTS cursos (
    course_name           TEXT,
    instructor            TEXT,
    reviews_avg           REAL,
    reviews_count         REAL,
    course_duration       REAL,
    lectures_count        REAL,
    level                 TEXT,
    price_after_discount  REAL,
    main_price            REAL,
    course_flag           TEXT,
    students_count        REAL,
    duracion_por_clase    REAL,
    ratio_reviews         REAL,
    franja_rating         TEXT,
    segmento_precio       TEXT,
    top_curso             TEXT,
    nivel_label           TEXT
);

-- Carga masiva desde el CSV limpio (montado en /data dentro del contenedor)
COPY cursos FROM '/data/datos_limpios.csv' WITH (FORMAT csv, HEADER true);

-- Índices para acelerar el filtrado en tiempo real desde Grafana
CREATE INDEX IF NOT EXISTS idx_nivel    ON cursos (nivel_label);
CREATE INDEX IF NOT EXISTS idx_segmento ON cursos (segmento_precio);
