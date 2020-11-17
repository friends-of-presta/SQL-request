# Change values of table prefix, local domain and prod domain

UPDATE prefix_configuration SET value='monsite.local' WHERE name IN ('PS_SHOP_DOMAIN', 'PS_SHOP_DOMAIN_SSL');
UPDATE prefix_shop_url SET domain='monsite.local', domain_ssl='monsite.local';
UPDATE prefix_cms_lang SET content=REPLACE(content, 'url_site_en.prod', 'monsite.local');
UPDATE prefix_product_lang SET description=REPLACE(description, 'url_site_en.prod', 'monsite.local');
UPDATE prefix_homeslider_slides_lang SET description=REPLACE(description, 'url_site_en.prod', 'monsite.local'), url=REPLACE(url, 'url_site_en.prod', 'monsite.local');

UPDATE prefix_configuration SET value=0 WHERE name='PS_SSL_ENABLED';
UPDATE prefix_configuration SET value=0 WHERE name='PS_SSL_ENABLED_EVERYWHERE';
