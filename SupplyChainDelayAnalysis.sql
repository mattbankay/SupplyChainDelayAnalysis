--Executive KPI summary
SELECT
    COUNT(*) AS total_orders,
    ROUND(AVG(late_delivery_flag::numeric) * 100, 2) AS late_delivery_rate_pct,
    ROUND(AVG(delay_days::numeric), 2) AS avg_delay_days,
    ROUND(SUM(sales::numeric), 2) AS total_sales,
    ROUND(SUM(order_profit_per_order::numeric), 2) AS total_profit
FROM supply_chain_orders;

--Performance by Shipping Mode
SELECT
    shipping_mode,
    COUNT(*) AS orders,
    ROUND(AVG(late_delivery_flag::numeric) * 100, 2) AS late_delivery_rate_pct,
    ROUND(AVG(delay_days::numeric), 2) AS avg_delay_days,
    ROUND(AVG(scheduled_shipping_days::numeric), 2) AS avg_scheduled_days,
    ROUND(AVG(actual_shipping_days::numeric), 2) AS avg_actual_days
FROM supply_chain_orders
GROUP BY shipping_mode
ORDER BY late_delivery_rate_pct DESC;


--Regional Performance by Order Volume
SELECT
    order_region,
    COUNT(*) AS orders,
    SUM(late_delivery_flag) AS late_orders,
    ROUND(AVG(late_delivery_flag::numeric) * 100, 2) AS late_delivery_rate_pct,
    ROUND(AVG(delay_days::numeric), 2) AS avg_delay_days,
    ROUND(SUM(sales::numeric), 2) AS total_sales,
    ROUND(SUM(order_profit_per_order::numeric), 2) AS total_profit
FROM supply_chain_orders
GROUP BY order_region
ORDER BY orders DESC;

--Highest Risk Regions
SELECT
    order_region,
    COUNT(*) AS orders,
    SUM(late_delivery_flag) AS late_orders,
    ROUND(AVG(late_delivery_flag::numeric) * 100, 2) AS late_delivery_rate_pct,
    ROUND(AVG(delay_days::numeric), 2) AS avg_delay_days
FROM supply_chain_orders
GROUP BY order_region
HAVING COUNT(*) >= 3000
ORDER BY late_delivery_rate_pct DESC;

--Product Category Performance
SELECT
    category_name,
    COUNT(*) AS orders,
    SUM(late_delivery_flag) AS late_orders,
    ROUND(AVG(late_delivery_flag::numeric) * 100, 2) AS late_delivery_rate_pct,
    ROUND(AVG(delay_days::numeric), 2) AS avg_delay_days,
    ROUND(SUM(sales::numeric), 2) AS total_sales
FROM supply_chain_orders
GROUP BY category_name
HAVING COUNT(*) >= 500
ORDER BY orders DESC;

--Delay Impact by Order Value Segment
SELECT
    order_value_segment,
    COUNT(*) AS orders,
    SUM(late_delivery_flag) AS late_orders,
    ROUND(AVG(late_delivery_flag::numeric) * 100, 2) AS late_delivery_rate_pct,
    ROUND(AVG(delay_days::numeric), 2) AS avg_delay_days,
    ROUND(AVG(sales::numeric), 2) AS avg_sales
FROM supply_chain_orders
GROUP BY order_value_segment
ORDER BY
    CASE order_value_segment
        WHEN 'Low' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'High' THEN 3
        ELSE 4
    END;

--High Impact Operational Combinations
SELECT
    order_value_segment,
    COUNT(*) AS orders,
    SUM(late_delivery_flag) AS late_orders,
    ROUND(AVG(late_delivery_flag::numeric) * 100, 2) AS late_delivery_rate_pct,
    ROUND(AVG(delay_days::numeric), 2) AS avg_delay_days,
    ROUND(AVG(sales::numeric), 2) AS avg_sales
FROM supply_chain_orders
GROUP BY order_value_segment
ORDER BY
    CASE order_value_segment
        WHEN 'Low' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'High' THEN 3
        ELSE 4
    END;

--Delivery Status Breakdown
SELECT
    delivery_status,
    COUNT(*) AS orders,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS pct_of_orders
FROM supply_chain_orders
GROUP BY delivery_status
ORDER BY orders DESC;

--Revenue of Late Deliveries
SELECT
    late_delivery_flag,
    COUNT(*) AS orders,
    ROUND(SUM(sales)::numeric,2) AS total_sales,
    ROUND(SUM(order_profit_per_order)::numeric,2) AS total_profit,
    ROUND(AVG(delay_days)::numeric,2) AS avg_delay
FROM supply_chain_orders
GROUP BY late_delivery_flag;

--Revenue At Risk by Region
SELECT
    order_region,
    COUNT(*) AS total_orders,
    SUM(late_delivery_flag) AS late_orders,
    ROUND(SUM(CASE WHEN late_delivery_flag = 1 THEN sales ELSE 0 END)::numeric,2) AS late_sales,
    ROUND(SUM(sales)::numeric,2) AS total_sales
FROM supply_chain_orders
GROUP BY order_region
ORDER BY late_sales DESC;

--Revenue At Risk by Shipping Mode
SELECT
    shipping_mode,
    COUNT(*) AS orders,
    SUM(late_delivery_flag) AS late_orders,
    ROUND(AVG(late_delivery_flag::numeric) * 100,2) AS late_rate_pct,
    ROUND(SUM(CASE WHEN late_delivery_flag = 1 THEN sales ELSE 0 END::numeric),2) AS revenue_affected
FROM supply_chain_orders
GROUP BY shipping_mode
ORDER BY revenue_affected DESC;

--High Value Orders At Risk
SELECT
    order_value_segment,
    COUNT(*) AS orders,
    SUM(late_delivery_flag) AS late_orders,
    ROUND(SUM(CASE WHEN late_delivery_flag = 1 THEN sales ELSE 0 END)::numeric,2) AS revenue_at_risk
FROM supply_chain_orders
GROUP BY order_value_segment
ORDER BY revenue_at_risk DESC;
