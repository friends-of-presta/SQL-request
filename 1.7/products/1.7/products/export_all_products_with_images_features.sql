SET @id_lang = 1;
SET @id_shop = 1;
SET @monsite = 'https://www.MONSITE.com/img/p/';

SELECT
p.`id_product` AS `ID`,
b.name as `Nom`,`reference`,
cl.`id_category` AS `ID Cat defaut`,
cl.`name` AS `Cat defaut`,
GROUP_CONCAT(DISTINCT(c.id_category) SEPARATOR ",") as categories,
GROUP_CONCAT(CONCAT(fl.name, '=', fvl.value) SEPARATOR ",") as caracteristiques,
GROUP_CONCAT(DISTINCT(case
when length(im.`id_image`)=6 then
concat(@monsite,insert(insert(insert(insert(insert(im.`id_image`,2,0,'/'),4,0,'/'),6,0,'/'),8,0,'/'),10,0,'/'),'/',im.`id_image`,'.jpg')
when length(im.`id_image`)=5 then
concat(@monsite,insert(insert(insert(insert(im.`id_image`,2,0,'/'),4,0,'/'),6,0,'/'),8,0,'/'),'/',im.`id_image`,'.jpg')
when length(im.`id_image`)=4 then
concat(@monsite,insert(insert(insert(im.`id_image`,2,0,'/'),4,0,'/'),6,0,'/'),'/',im.`id_image`,'.jpg')
when length(im.`id_image`)=3 then
concat(@monsite,insert(insert(im.`id_image`,2,0,'/'),4,0,'/'),'/',im.`id_image`,'.jpg')
when length(im.`id_image`)=2 then
concat(@monsite,insert(im.`id_image`,2,0,'/'),'/',im.`id_image`,'.jpg')
when length(im.`id_image`)=1 then
concat(@monsite,insert(im.`id_image`,2,0,'/'),im.`id_image`,'.jpg')
else ''
end) SEPARATOR ",") as "Images",
sa.`price`,
ml.meta_title AS 'Marque',
ml.id_manufacturer AS 'Marque ID',
p.price as price,
sa.active as active,
p.ean13 AS 'EAN13',
p.upc AS 'UPC',
sav.`quantity` AS `quantite`,
p.visibility,
p.indexed,
pl.description_short,
pl.description,
pl.meta_title,
pl.meta_keywords,
pl.meta_description,
MAX(image_shop.id_image) id_image,
concat(pl.`link_rewrite`,'-',p.`id_product`,'.html') as "ProductURL google",
case
when length(im.`id_image`)=6 then
concat(@monsite,insert(insert(insert(insert(insert(im.`id_image`,2,0,'/'),4,0,'/'),6,0,'/'),8,0,'/'),10,0,'/'),'/',im.`id_image`,'.jpg')
when length(im.`id_image`)=5 then
concat(@monsite,insert(insert(insert(insert(im.`id_image`,2,0,'/'),4,0,'/'),6,0,'/'),8,0,'/'),'/',im.`id_image`,'.jpg')
when length(im.`id_image`)=4 then
concat(@monsite,insert(insert(insert(im.`id_image`,2,0,'/'),4,0,'/'),6,0,'/'),'/',im.`id_image`,'.jpg')
when length(im.`id_image`)=3 then
concat(@monsite,insert(insert(im.`id_image`,2,0,'/'),4,0,'/'),'/',im.`id_image`,'.jpg')
when length(im.`id_image`)=2 then
concat(@monsite,insert(im.`id_image`,2,0,'/'),'/',im.`id_image`,'.jpg')
when length(im.`id_image`)=1 then
concat(@monsite,insert(im.`id_image`,2,0,'/'),im.`id_image`,'.jpg')
else ''
end as "ImgURL_1"
FROM `ps_product` p
LEFT JOIN `ps_product_lang` pl ON (p.id_product = pl.id_product)
LEFT JOIN `ps_category_product` cp ON (p.id_product = cp.id_product)
LEFT JOIN `ps_category_lang` cl ON (cp.id_category = cl.id_category)
LEFT JOIN `ps_category` c ON (cp.id_category = c.id_category)
LEFT JOIN `ps_product_lang` b ON (b.`id_product` = p.`id_product` AND b.`id_lang` = @id_lang AND b.`id_shop` = p.id_shop_default)
LEFT JOIN `ps_image` i ON (i.`id_product` = p.`id_product`)
LEFT JOIN `ps_manufacturer_lang` ml ON (p.id_manufacturer = ml.id_manufacturer)
LEFT JOIN `ps_stock_available` sav ON (sav.`id_product` = p.`id_product` AND sav.`id_product_attribute` = 0 AND sav.id_shop_group = 0 AND sav.id_shop = @id_shop ) 
LEFT JOIN `ps_product_shop` sa ON (p.`id_product` = sa.`id_product` AND sa.id_shop = p.id_shop_default)
LEFT JOIN `ps_shop` shop ON (shop.id_shop = p.id_shop_default)
LEFT JOIN `ps_image_shop` image_shop ON (image_shop.`id_image` = i.`id_image` AND image_shop.`cover` = 1 AND image_shop.id_shop = p.id_shop_default)
LEFT JOIN `ps_product_download` pd ON (pd.`id_product` = p.`id_product`)
LEFT JOIN `ps_image` im on im.`id_product`= p.`id_product`
LEFT JOIN `ps_feature_product` fp ON fp.`id_product`= p.`id_product` 
LEFT JOIN `ps_feature_lang` fl ON (fp.id_feature = fl.id_feature AND fl.id_lang=@id_lang)
LEFT JOIN `ps_feature_value_lang` fvl ON (fp.id_feature_value = fvl.id_feature_value AND fl.id_lang=@id_lang)
WHERE pl.id_lang = @id_lang
GROUP BY sa.id_product
ORDER BY p.`id_product` ASC