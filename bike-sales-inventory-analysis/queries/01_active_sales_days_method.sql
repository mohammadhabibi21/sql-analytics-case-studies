-- Step 1: Calculate total units sold for each product at each store
;WITH total_sales AS (
    SELECT
        o.store_id,
        oi.product_id,
        SUM(oi.quantity) AS total_units_sold
    FROM sales.order_items AS oi

    LEFT JOIN sales.orders AS o
        ON o.order_id = oi.order_id

    GROUP BY
        o.store_id,
        oi.product_id
),

-- Step 2: Count the distinct active sales days for each product at each store
active_sales_days AS (
    SELECT
        o.store_id,
        oi.product_id,
        COUNT(DISTINCT o.order_date) AS active_days
    FROM sales.order_items AS oi

    LEFT JOIN sales.orders AS o
        ON o.order_id = oi.order_id

    GROUP BY
        o.store_id,
        oi.product_id
),

-- Step 3: Calculate average sales rate per active sales day
daily_sales AS (
    SELECT
        ts.store_id,
        ts.product_id,

        CAST(ts.total_units_sold AS FLOAT)
        / NULLIF(ad.active_days, 0) AS daily_rate

    FROM total_sales AS ts

    LEFT JOIN active_sales_days AS ad
        ON ad.store_id = ts.store_id
        AND ad.product_id = ts.product_id
)

-- Final step: Estimate inventory days on hand
SELECT
    ps.store_id,
    ps.product_id,

    FLOOR(
        ps.quantity / NULLIF(ds.daily_rate, 0)
    ) AS inventory_days_on_hand

FROM production.stocks AS ps

LEFT JOIN daily_sales AS ds
    ON ds.store_id = ps.store_id
    AND ds.product_id = ps.product_id

ORDER BY
    ps.store_id,
    ps.product_id;