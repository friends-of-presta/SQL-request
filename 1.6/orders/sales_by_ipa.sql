# get sales ( total and quantity ) by ipa
# total include tax

set @date_from="2020-01-01 00:00:00";
set @date_to="2020-01-30 00:00:00";
set @need_invoice = 1;

SELECT od.product_name, od.product_reference, od.product_attribute_id, SUM(od.`product_quantity`) as qty, SUM(od.`total_price_tax_incl`) as total, p.wholesale_price FROM `ps_order_detail` od 

INNER JOIN `ps_orders` o ON od.id_order = o.id_order 

INNER JOIN `ps_product` p ON p.id_product = od.product_id

WHERE 

( CASE 

	WHEN @need_invoice = 1 THEN o.invoice_date > @date_from AND o.invoice_date < @date_to

	ELSE o.date_add > @date_from AND o.date_add < @date_to

END )

GROUP BY od.product_attribute_id 

ORDER BY p.id_product
