SELECT `id_product`, SUM(`default_on`) AS default_on
FROM `ps_product_attribute_shop`
GROUP BY `id_product`
HAVING default_on IS NULL
