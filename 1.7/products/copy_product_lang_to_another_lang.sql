# copy product_lang to another lang
# Here example : 
# copy link rewrite, description, description_short and name 
# from id_lang 1 
# and id_shop 4
# exclude id_product 622, 766, 782, 783, 784, 1370
#
# to id_shop 4 
# and id_lang 2

UPDATE `ps_product_lang` l_to_up
    INNER JOIN (
        SELECT `link_rewrite`, `description`, `description_short`, `name`, `id_product`, `id_shop`
        FROM `ps_product_lang`
        WHERE id_shop = 4
          AND id_lang = 1
          AND id_product NOT IN (622, 766, 782, 783, 784, 1370)
    ) l_from
    ON l_to_up.`id_product` = l_from.`id_product` AND l_to_up.`id_shop` = 4
SET l_to_up.`description`       = l_from.`description`,
    l_to_up.`description_short` = l_from.`description_short`,
    l_to_up.`link_rewrite`      = l_from.`link_rewrite`,
    l_to_up.`name`              = l_from.`name`
WHERE l_to_up.`id_lang` = 2

# without exclude products

UPDATE `ps_product_lang` l_to_up
    INNER JOIN (
        SELECT `link_rewrite`, `description`, `description_short`, `name`, `id_product`, `id_shop`
        FROM `ps_product_lang`
        WHERE id_shop = 4
          AND id_lang = 1
    ) l_from
    ON l_to_up.`id_product` = l_from.`id_product` AND l_to_up.`id_shop` = 4
SET l_to_up.`description`       = l_from.`description`,
    l_to_up.`description_short` = l_from.`description_short`,
    l_to_up.`link_rewrite`      = l_from.`link_rewrite`,
    l_to_up.`name`              = l_from.`name`
WHERE l_to_up.`id_lang` = 2