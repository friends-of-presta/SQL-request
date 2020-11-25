# get sales ( total and quantity ) by ipa
# total include tax

SET @date_from = "2020-10-01 00:00:00";
SET @date_to = "2020-11-30 00:00:00";
SET @need_invoice = 1;
SET @no_product_return = 1;

SELECT 
    od.product_id,
    od.product_name,
    od.product_reference,
    od.product_attribute_id,
    SUM(od.`product_quantity`)     as qty,
    SUM(od.`total_price_tax_incl`) as total,
    p.wholesale_price
FROM 
    `ps_order_detail` od
    INNER JOIN `ps_orders` o ON od.id_order = o.id_order
    INNER JOIN `ps_product` p ON p.id_product = od.product_id
WHERE 
    (CASE
    WHEN @need_invoice = 1 THEN o.invoice_date > @date_from AND o.invoice_date < @date_to
    ELSE o.date_add > @date_from AND o.date_add < @date_to
    END)
AND 
    (CASE
    WHEN @no_product_return = 1 THEN od.product_quantity_return = 0
    ELSE 1 = 1
    END)
GROUP BY CASE
    WHEN od.product_attribute_id > 0
    THEN od.product_attribute_id
    ELSE od.product_id
    END
ORDER BY od.product_id, od.product_attribute_id ASC
