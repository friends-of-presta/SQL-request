SET @id_lang = 1;
SET @id_shop = 1;
SET @monsite = 'https://www.MONSITE.com/img/p/';

SELECT
IF(pa.id_product_attribute<>"", CONCAT(p.`id_product`,'-',pa.id_product_attribute),p.`id_product`) AS `ID`,
pl.name as `Nom`,
IF(pa.reference<>"", pa.reference, p.`reference`) as reference,
p.`id_category_default` AS `ID Cat defaut`,
cl2.`name` AS `Cat defaut`,
GROUP_CONCAT(DISTINCT(CONCAT(agl.name, ' ', al.name)) SEPARATOR ",") as declinaison,
GROUP_CONCAT(DISTINCT(cl.name) SEPARATOR ",") as categories,
GROUP_CONCAT(CONCAT(fl.name, ':', fvl.value) SEPARATOR ",") as caracteristiques,
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
IF(pa.price>0, sa.price+pa.price, sa.price) as price,
trg.name as tax,
ml.meta_title AS 'Marque',
ml.id_manufacturer AS 'Marque ID',
sa.active as active,
IF(pa.ean13<>'', pa.ean13, p.ean13) AS 'EAN13',
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
end as "ImgURL_1",
case
    when length(MIN(pai.`id_image`))=6 then
        concat(@monsite,insert(insert(insert(insert(insert(MIN(pai.`id_image`),2,0,'/'),4,0,'/'),6,0,'/'),8,0,'/'),10,0,'/'),'/',MIN(pai.`id_image`),'.jpg')
    when length(MIN(pai.`id_image`))=5 then
        concat(@monsite,insert(insert(insert(insert(MIN(pai.`id_image`),2,0,'/'),4,0,'/'),6,0,'/'),8,0,'/'),'/',MIN(pai.`id_image`),'.jpg')
    when length(MIN(pai.`id_image`))=4 then
        concat(@monsite,insert(insert(insert(MIN(pai.`id_image`),2,0,'/'),4,0,'/'),6,0,'/'),'/',MIN(pai.`id_image`),'.jpg')
    when length(MIN(pai.`id_image`))=3 then
        concat(@monsite,insert(insert(MIN(pai.`id_image`),2,0,'/'),4,0,'/'),'/',MIN(pai.`id_image`),'.jpg')
    when length(MIN(pai.`id_image`))=2 then
        concat(@monsite,insert(MIN(pai.`id_image`),2,0,'/'),'/',MIN(pai.`id_image`),'.jpg')
    when length(MIN(pai.`id_image`))=1 then
        concat(@monsite,insert(MIN(pai.`id_image`),2,0,'/'),MIN(pai.`id_image`),'.jpg')
    else ''
    end as "ImgURL_declinaison"

FROM `ps_product` p
LEFT JOIN `ps_category_product` cp ON (p.id_product = cp.id_product)
LEFT JOIN `ps_category_lang` cl ON (cp.id_category = cl.id_category  AND cl.id_lang = @id_lang)
LEFT JOIN `ps_category_lang` cl2 ON (p.id_category_default = cl2.id_category  AND cl2.id_lang = @id_lang)
LEFT JOIN `ps_product_lang` pl ON (pl.`id_product` = p.`id_product` AND pl.`id_lang` = @id_lang AND pl.`id_shop` = p.id_shop_default)
LEFT JOIN `ps_image` i ON (i.`id_product` = p.`id_product`)
LEFT JOIN `ps_manufacturer_lang` ml ON (p.id_manufacturer = ml.id_manufacturer AND ml.`id_lang` = @id_lang)
LEFT JOIN `ps_stock_available` sav ON (sav.`id_product` = p.`id_product` AND sav.`id_product_attribute` = 0 AND sav.id_shop_group = 0 AND sav.id_shop = @id_shop )
LEFT JOIN `ps_product_shop` sa ON (p.`id_product` = sa.`id_product` AND sa.id_shop = p.id_shop_default)
LEFT JOIN `ps_shop` shop ON (shop.id_shop = p.id_shop_default)
LEFT JOIN `ps_image_shop` image_shop ON (image_shop.`id_image` = i.`id_image` AND image_shop.`cover` = 1 AND image_shop.id_shop = p.id_shop_default)
LEFT JOIN `ps_product_download` pd ON (pd.`id_product` = p.`id_product`)
LEFT JOIN `ps_image` im on im.`id_product`= p.`id_product`
LEFT JOIN `ps_feature_product` fp ON fp.`id_product`= p.`id_product`
LEFT JOIN `ps_feature_lang` fl ON (fp.id_feature = fl.id_feature AND fl.id_lang=@id_lang)
LEFT JOIN `ps_feature_value_lang` fvl ON (fp.id_feature_value = fvl.id_feature_value AND fl.id_lang=@id_lang)
LEFT JOIN `ps_product_attribute` pa ON pa.id_product=p.id_product
LEFT JOIN `ps_product_attribute_image` pai ON (pa.id_product_attribute=pai.id_product_attribute)
LEFT JOIN `ps_product_attribute_combination` pac ON pa.id_product_attribute = pac.id_product_attribute
LEFT JOIN `ps_attribute` a ON pac.id_attribute = a.id_attribute
LEFT JOIN `ps_attribute_lang` al ON (a.id_attribute = al.id_attribute AND al.id_lang=@id_lang)
LEFT JOIN `ps_attribute_group_lang` agl ON (a.id_attribute_group=agl.id_attribute_group AND agl.id_lang=@id_lang)
LEFT JOIN `ps_tax_rules_group` trg ON trg.id_tax_rules_group= p.id_tax_rules_group
GROUP BY p.id_product, pa.id_product_attribute
ORDER BY p.`id_product` ASC
