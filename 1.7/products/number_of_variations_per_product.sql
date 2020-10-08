SELECT id_product, COUNT(*) AS nb_decli
FROM ps_product_attribute
GROUP BY id_product;
