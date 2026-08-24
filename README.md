# SQL Analytics Case Studies

A collection of T-SQL case studies focused on solving practical analytical problems using relational databases, business metrics, and structured SQL analysis.

The repository currently includes two projects:

1. **Bike Sales Inventory Analysis** — inventory and sales-velocity analysis for estimating product days on hand across stores.
2. **Iran World Cup Analysis** — analysis of Iran's FIFA World Cup performance across six tournaments using match, goal, group, and team-level data.

## Case Studies

### 1. Bike Sales Inventory Analysis

Business-oriented inventory analysis using the BikeStores sample database.

The project estimates how long current inventory may last by calculating product sales velocity using two alternative definitions of the sales period:

- Distinct active sales days
- Elapsed period between first and last sale

The analysis also preserves products with inventory but no recorded sales history instead of excluding them from the results.

**Key SQL concepts:**

- CTEs
- Aggregations
- `LEFT JOIN`
- `GROUP BY`
- `COUNT(DISTINCT ...)`
- Date calculations
- `NULLIF`
- `FLOOR`
- NULL-safe analysis

➡️ [View Bike Sales Inventory Analysis](./bike-sales-inventory-analysis/)

---

### 2. Iran World Cup Analysis

Sports analytics case study examining Iran's 18 FIFA World Cup matches across six tournaments.

The project covers:

- Performance trends by tournament
- Relative group strength
- Goal timing and vulnerability
- Comparison with selected Asian teams
- Data-driven identification of key matches

The analysis uses the **Fjelstul World Cup Database** and includes CTEs, subqueries, window functions, relative performance metrics, and statistical thresholds.

**Key SQL concepts:**

- Multi-table joins
- CTEs
- Aggregations
- Conditional aggregation
- Subqueries
- Window functions
- `RANK()`
- `PERCENTILE_CONT()`
- `CASE`
- Relative metrics

➡️ [View Iran World Cup Analysis](./iran-world-cup-analysis/)

## Repository Structure

```text
sql-analytics-case-studies/
├── bike-sales-inventory-analysis/
│   ├── queries/
│   │   ├── 01_active_sales_days_method.sql
│   │   └── 02_elapsed_sales_period_method.sql
│   └── README.md
│
├── iran-world-cup-analysis/
│   ├── queries/
│   │   ├── 01_performance_trend.sql
│   │   ├── 02_group_strength_analysis.sql
│   │   ├── 03_goal_timing_analysis.sql
│   │   ├── 04_asian_team_comparison.sql
│   │   └── 05_key_matches.sql
│   └── README.md
│
└── README.md
```

## Tools & Technologies

- Microsoft SQL Server
- T-SQL
- SQL Server Management Studio (SSMS)
- Git & GitHub

## Author

**Mohammad Habibi**