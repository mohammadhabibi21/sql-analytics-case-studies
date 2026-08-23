-- Step 1: Summarize sales and determine the elapsed sales period
;WITH sales_summary AS (
    SELECT
        o.store_id,
        oi.product_id,
        SUM(oi.quantity) AS total_units_sold,
        MIN(o.order_date) AS first_sale_date,
        MAX(o.order_date) AS last_sale_date
    FROM sales.orders AS o

    LEFT JOIN sales.order_items AS oi
        ON oi.order_id = o.order_id

    GROUP BY
        o.store_id,
        oi.product_id
),

-- Step 2: Calculate average daily sales over the elapsed sales period
daily_sales AS (
    SELECT
        store_id,
        product_id,

        total_units_sold * 1.0
        / NULLIF(
            DATEDIFF(DAY, first_sale_date, last_sale_date) + 1,
            0
        ) AS avg_daily_sales

    FROM sales_summary
)

-- Final step: Estimate inventory days on hand
SELECT
    ps.store_id,
    ps.product_id,

    FLOOR(
        ps.quantity / NULLIF(ds.avg_daily_sales, 0)
    ) AS inventory_days_on_hand

FROM production.stocks AS ps

LEFT JOIN daily_sales AS ds
    ON ds.store_id = ps.store_id
    AND ds.product_id = ps.product_id

ORDER BY
    ps.store_id,
    ps.product_id;