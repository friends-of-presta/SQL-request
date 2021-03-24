-- URL of the website front
SET @domain = "www.newurl.ext";
-- Put sslon = 1 to enable SSL, and 0 to disable SSL
SET @sslon = 1;

UPDATE `ps_configuration` SET `value` = @domain WHERE `name` = "PS_SHOP_DOMAIN";
UPDATE `ps_configuration` SET `value` = @domain WHERE `name` = "PS_SHOP_DOMAIN_SSL";
UPDATE `ps_shop_url` SET `domain` = @domain , `domain_ssl` = @domain WHERE `id_shop_url` = 1;
UPDATE `ps_configuration` SET `value` = @sslon WHERE `name` IN ("PS_SSL_ENABLED", "PS_SSL_ENABLED_EVERYWHERE");
