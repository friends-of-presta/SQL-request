# RFM metrics
# Recency : nb of days since the last order
# Frequency : nb or orders/months since customer account creation
# Monetary : total profits for this customer
SELECT firstname,
	lastname,
	email,
    DATEDIFF(NOW(), MAX(o.date_add)) AS recency,
    COUNT(o.id_order)/PERIOD_DIFF(EXTRACT(YEAR_MONTH FROM NOW()), EXTRACT(YEAR_MONTH FROM c.date_add)) AS frequency,
	SUM(ROUND((od.unit_price_tax_excl - od.original_wholesale_price) * od.product_quantity, 2)) AS monetary
FROM ps_customer c
	JOIN ps_orders o ON c.id_customer = o.id_customer
	JOIN ps_order_detail od ON od.id_order = o.id_order
WHERE c.active = 1
GROUP BY c.id_customer
;
