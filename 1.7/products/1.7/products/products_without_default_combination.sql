SELECT `id_product`, `id_shop`, SUM(`default_on`) AS default_on
FROM `ps_product_attribute_shop`
GROUP BY `id_product`, `id_shop`
HAVING default_on IS NULL
