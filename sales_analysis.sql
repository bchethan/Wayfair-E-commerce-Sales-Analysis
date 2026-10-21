
-- Customer acquisition channel and their total purchase value.
SELECT acquisition_channel,
	   COUNT(DISTINCT c.customer_id) AS customers,
       COUNT(DISTINCT o.order_id) AS orders,
       ROUND(COUNT(DISTINCT o.order_id)/COUNT(DISTINCT c.customer_id), 2) AS orders_per_customer,
       ROUND(SUM(oi.quantity*(oi.unit_price - oi.discount_amount))) AS total_purchase_value
	FROM customers c 
			INNER JOIN 
         orders o
			ON o.customer_id = c.customer_id
		 INNER JOIN 
		`order-items` oi
			ON oi.order_id = o.order_id
GROUP BY acquisition_channel;

-- Break revenue down by product category and find the best-selling products.
-- Category performance: Calculated revenue by product category
SELECT category,
	   SUM(oi.quantity) AS units_sold,
	   ROUND(SUM(oi.quantity* (oi.unit_price - oi.discount_amount))) AS revenue
FROM products p
		INNER JOIN 
    `order-items` oi
		ON oi.product_id = p.product_id
        INNER JOIN 
	orders o
		ON o.order_id = oi.order_id
GROUP BY category
ORDER BY units_sold DESC;

-- Compare categories on how often their orders are returned or canceled.
SELECT category, 
       SUM(CASE WHEN status = 'canceled' THEN 1 ELSE 0 END) AS canceled,
       SUM(CASE WHEN status = 'returned' THEN 1 ELSE 0 END) AS returned,
       COUNT(DISTINCT oi.order_id) AS total_orders
FROM orders o 
		INNER JOIN 
    `order-items` oi
		ON oi.order_id = o.order_id
        INNER JOIN 
	products p
		ON p.product_id = oi.product_id
GROUP BY category;

-- Show how revenue changed month by month and compare 2025 with 2024.
-- 2025 vs. 2024: Compared monthly and annual revenue
WITH revenue AS (
	SELECT MONTH(order_date) AS month,
		   ROUND(SUM(CASE 
						WHEN YEAR(order_date) = 2024 
							THEN quantity * (unit_price - discount_amount) 
							ELSE 0 
						END)) AS `2024`,
			ROUND(SUM(CASE 
				WHEN YEAR(order_date) = 2025
					THEN quantity * (unit_price - discount_amount) 
					ELSE 0 
				END)) AS `2025`
				FROM `order-items` oi 
			INNER JOIN 
		orders o
			ON o.order_id = oi.order_id
	GROUP BY MONTH(order_date)
)
SELECT month, 
	   `2024`, 
       `2025`,
       ROUND((`2025`-`2024`)/`2024`*100, 2) AS yoy_growth 
FROM revenue;

-- Seasonal patterns: Identify months with recurring peaks or declines
-- Best-selling products: Rank products by units sold or eligible sales revenue, clearly stating which measure you use
WITH product_sales_ctc AS (
	SELECT product_name, 
		   SUM(oi.quantity) AS units_sold,
		   SUM(oi.quantity*
						(oi.unit_price-COALESCE(oi.discount_amount, 0))
					) AS revenue
	FROM products p 
			INNER JOIN 
		 `order-items` oi
			ON oi.product_id = p.product_id
			INNER JOIN 
		 orders o 
			ON o.order_id = oi.order_id
	GROUP BY product_name
)
SELECT product_name,
	   units_sold, 
       RANK() OVER(ORDER BY units_sold DESC) AS units_rank,
       ROUND(revenue) AS revenue,
       RANK() OVER(ORDER BY revenue DESC) AS revenue_rank
FROM product_sales_ctc
ORDER BY units_rank;

-- Return and cancellation rates: Calculate the percentage of orders returned or canceled in each category
SELECT p.category, 
	   COUNT(DISTINCT o.order_id) AS orders_count,
	   COUNT(DISTINCT CASE 
					WHEN o.status = 'returned' 
                    THEN o.order_id 
			END) AS return_count, 
	   COUNT(DISTINCT CASE 
					WHEN o.status = 'canceled'
					THEN o.order_id
			END) AS cancel_count,
	   ROUND(
			100* COUNT(DISTINCT CASE 
				WHEN status = 'returned' 
					THEN o.order_id 
				END)/NULLIF(COUNT(DISTINCT o.order_id), 0),
				2
            ) AS return_percentage,
	   ROUND(
			100* COUNT(DISTINCT CASE 
				WHEN status = 'canceled' 
					THEN o.order_id 
				END)/NULLIF(COUNT(DISTINCT o.order_id), 0),
                2
			) AS cancel_percentage
FROM `order-items` oi
		INNER JOIN 
	 orders o
		ON o.order_id = oi.order_id
        INNER JOIN
	 products p
		ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY return_percentage DESC;

-- Average order value (AOV): Eligible revenue divided by the number of eligible orders
WITH order_details AS (
	SELECT o.order_id,
		   SUM(oi.quantity*(
					oi.unit_price - COALESCE(oi.discount_amount, 0)
			)) AS order_value
	FROM orders o
			INNER JOIN 
		 `order-items` oi
			ON oi.order_id = o.order_id
    GROUP BY o.order_id
)

SELECT ROUND(AVG(order_value), 2) AS avg_order_value
FROM order_details;