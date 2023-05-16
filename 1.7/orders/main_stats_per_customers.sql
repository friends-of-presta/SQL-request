-- Total spent, Profits and Orders per Customer
-- WARNING : most of the time, the original wholesale price is not available
SELECT firstname,
	lastname,
	email,
	SUM(ROUND(od.total_price_tax_incl, 2)) AS total_spent,
	SUM(ROUND((od.unit_price_tax_excl - od.original_wholesale_price) * od.product_quantity, 2)) AS profits,
	COUNT(o.id_order) AS orders
FROM ps_customer c
	JOIN ps_orders o ON c.id_customer = o.id_customer
	JOIN ps_order_detail od ON od.id_order = o.id_order
GROUP BY c.id_customer
;
