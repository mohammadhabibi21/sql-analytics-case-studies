# Bike Sales Inventory Analysis

SQL analysis of product inventory and sales velocity across stores, focused on estimating how many days current stock may last based on historical sales activity.

## Business Question

For each product at each store:

- How fast is the product selling?
- Based on the current inventory, how many days is the stock expected to last?
- How does the result change depending on how the sales period is defined?

The analysis uses sales data from `sales.orders` and `sales.order_items` together with inventory data from `production.stocks`.

## Approach

Two alternative methods are used to estimate the daily sales rate.

### 1. Active Sales Days Method

Calculates the sales rate using only the distinct days on which a product was actually sold.

**Daily Sales Rate = Total Units Sold / Active Sales Days**

This method focuses on actual selling days and ignores days with no recorded sales.

### 2. Elapsed Sales Period Method

Calculates the sales rate using the full period between the first and last recorded sale.

**Daily Sales Rate = Total Units Sold / Elapsed Days**

This approach accounts for inactive days occurring between the first and last sale.

## Inventory Days on Hand

For both methods:

**Inventory Days on Hand = Current Inventory / Daily Sales Rate**

The result is rounded down to the nearest whole day.

Products with current inventory but no recorded sales history are retained in the output. Their inventory days on hand remain `NULL` because a sales rate cannot be calculated from the available data.

## SQL Files

- `queries/01_active_sales_days_method.sql` — estimates inventory days using distinct active sales days.
- `queries/02_elapsed_sales_period_method.sql` — estimates inventory days using the elapsed period between first and last sale.

## SQL Concepts Demonstrated

- Common Table Expressions (CTEs)
- Aggregations
- `GROUP BY`
- `LEFT JOIN`
- Date calculations
- `COUNT(DISTINCT ...)`
- `NULLIF`
- `FLOOR`
- NULL-safe inventory analysis

## Tools

- Microsoft SQL Server
- T-SQL
- SQL Server Management Studio (SSMS)

## Note

The BikeSale database setup was provided as part of the course assignment. The analytical SQL queries in this folder represent the inventory analysis performed for the project.

## Author

**Mohammad Habibi**