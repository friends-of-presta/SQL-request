# In some cases, cache_is_pack can be wrong, this request fix it
UPDATE ps_product p
INNER JOIN ps_pack pa ON p.id_product = pa.id_product_pack
SET p.cache_is_pack = 1
