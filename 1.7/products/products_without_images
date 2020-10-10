(
SELECT pa.`reference` AS "Référence", pl.name AS "Produit", cl.name AS "Catégorie défaut", "Oui" AS "Déclinaison"
FROM `ps_product_attribute` AS pa
INNER JOIN ps_product AS p ON p.id_product = pa.id_product
INNER JOIN ps_product_lang AS pl ON pl.id_product = p.`id_product` AND pl.id_lang = 2
INNER JOIN ps_category_lang AS cl ON cl.id_category = p.`id_category_default` AND cl.id_lang = 2
LEFT JOIN `ps_product_attribute_image` AS pai ON pai.id_product_attribute = pa.`id_product_attribute`
WHERE pai.id_image IS NULL
)
UNION
(
SELECT p.`reference` AS "Référence", pl.name AS "Produit", cl.name AS "Catégorie défaut", "Non" AS "Déclinaison"
FROM `ps_product` AS p
INNER JOIN ps_product_lang AS pl ON pl.id_product = p.`id_product` AND pl.id_lang = 2
INNER JOIN ps_category_lang AS cl ON cl.id_category = p.`id_category_default` AND cl.id_lang = 2
LEFT JOIN ps_image AS i ON i.id_product = p.`id_product`
WHERE p.`reference` <> ""
AND i.id_image IS NULL
)
