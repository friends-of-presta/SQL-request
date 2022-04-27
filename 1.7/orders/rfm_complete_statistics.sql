WITH rfm AS (
SELECT
  	c.id_customer,
    DATEDIFF(NOW(), MAX(o.date_add)) AS recency,
    COUNT(o.id_order) AS frequency,
	SUM(ROUND(od.total_price_tax_incl, 2)) AS monetary
FROM ps_customer c
	JOIN ps_orders o ON c.id_customer = o.id_customer
	JOIN ps_order_detail od ON od.id_order = o.id_order
WHERE c.active = 1
GROUP BY c.id_customer
HAVING monetary > 0 -- Ignore non customers
),
rfm_scoring AS (
	SELECT
  		id_customer,
		NTILE(5) OVER (ORDER BY recency DESC) AS recency_score,
		NTILE(5) OVER (ORDER BY frequency) AS frequency_score,
		NTILE(5) OVER (ORDER BY monetary) AS monetary_score,
  	    (
          NTILE(5) OVER (ORDER BY recency DESC) + NTILE(5) OVER (ORDER BY frequency) + NTILE(5) OVER (ORDER BY monetary)
        ) AS rfm_score,
  		(
          CONCAT(
            NTILE(5) OVER (ORDER BY recency DESC),
            NTILE(5) OVER (ORDER BY frequency),
            NTILE(5) OVER (ORDER BY monetary)
          )
        ) AS rfm_segment
  		
	FROM rfm
),
-- Adapt the segments and conditions according to your needs
customer_segmentation AS (
	SELECT
  		id_customer,
 		rfm_score,
  		rfm_segment,
  		(CASE
  			WHEN rfm_score = 3 THEN "Lost Customers"
         	WHEN rfm_score > 3 AND rfm_score <= 7 THEN "Bad Customers"
         	WHEN rfm_score > 7 AND rfm_score <= 11 THEN "Good Customers"
         	WHEN rfm_score > 11 AND rfm_score <= 14 THEN "Excellent Customers"
         	ELSE "Ambassadors"
         END) AS customer_segment
  	FROM rfm_scoring
),
customers_statistics AS (
	SELECT
		MIN(recency), AVG(recency), MAX(recency),
		MIN(frequency), AVG(frequency), MAX(frequency),
		MIN(monetary), AVG(monetary), MAX(monetary),
  		customer_segment
  	FROM rfm r
  	JOIN customer_segmentation cs ON cs.id_customer = r.id_customer
  	GROUP BY customer_segment
)

-- How to use it ?
SELECT * FROM customers_statistics
