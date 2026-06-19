# Dashboard de Gestión Académica — Grafana (TPI · TUP)

Tablero de control interactivo construido en **Grafana** sobre los datos limpios del
análisis de cursos de Udemy. Permite a un usuario no técnico (coordinador / docente)
explorar el desempeño de los cursos filtrando en tiempo real.

## Arquitectura
- **PostgreSQL 16** — almacena el dataset limpio (`datos_limpios.csv`, 3.448 registros).
- **Grafana 11** — datasource PostgreSQL + dashboard, ambos *provisionados automáticamente*.
- Todo se levanta con un único comando vía **Docker Compose**.

## Cómo ejecutarlo (genera tus capturas reales)
```bash
cd grafana_stack
docker compose up -d
# Esperar ~20 s a que Postgres cargue el CSV y Grafana provisione el tablero
```
Luego abrir: **http://localhost:3000** → usuario `admin`, contraseña `admin`.
El tablero "Panel de Control – Análisis de Cursos Udemy (TUP)" ya aparece cargado.

Para detener: `docker compose down`

## Panels incluidos
| # | Panel | Tipo | Métrica |
|---|-------|------|---------|
| 1-4 | KPIs | Stat | Total cursos · Rating prom. · Estudiantes prom. · % Bestseller |
| 5 | Estudiantes por Nivel | Bar | AVG(students_count) GROUP BY nivel |
| 6 | Distribución de Calificaciones | Bar | COUNT por franja de rating |
| 7 | Cursos por Segmento de Precio | Donut | COUNT por segmento |
| 8 | Ratio Reseñas/Estudiante por Nivel | Bar | AVG(ratio_reviews) |
| 9 | Top 15 Cursos | Tabla | Orden por students_count |

## Interactividad (requisito del Hito 4)
Dos variables de plantilla en la barra superior actualizan **todos** los paneles:
- **Nivel** (multi-select): Beginner, Intermediate, Advanced, Expert, All Levels
- **Segmento de Precio** (multi-select): Bajo, Medio, Alto, Premium

Cada panel usa `WHERE nivel_label IN (${nivel}) AND segmento_precio IN (${segmento})`,
por lo que el filtrado ocurre en SQL (eficiente sobre el volumen completo).

## Importar el dashboard manualmente (sin Docker)
Si ya tenés Grafana + un datasource PostgreSQL con estos datos:
`Dashboards → New → Import → subir dashboards/dashboard_udemy.json`.
