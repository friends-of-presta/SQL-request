UPDATE `ps_configuration` SET `value` = "www.newurl.ext" WHERE `name` = "PS_SHOP_DOMAIN";
UPDATE `ps_configuration` SET `value` = "www.newurl.ext" WHERE `name` = "PS_SHOP_DOMAIN_SSL";
UPDATE `ps_shop_url` SET `domain` = "www.newurl.ext", `domain_ssl` = "www.newurl.ext" WHERE `id_shop_url` = 1;
-- To activate SSL put value = 1 if not value = 0
UPDATE `ps_configuration` SET `value` = "1" WHERE `name` IN ("PS_SSL_ENABLED", "PS_SSL_ENABLED_EVERYWHERE");
