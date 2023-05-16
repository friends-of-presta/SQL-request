# tables prefix without underscore
SET @prefix = 'ps';

# shop ID
SET @id_shop = '1';

# setting and execute of the mySQL request
# update quantity in stock stored for all combinations
# on product list in back office quantity will be up to date.

SET @sql_text = ('UPDATE ',@prefix,'_stock_available p,
    ( SELECT id_product, sum(quantity) as mysum
    FROM ',@prefix,'_stock_available 
    WHERE id_product_attribute > 0 
    AND id_shop = ',@id_shop,'
    GROUP BY id_product) as s
  SET p.quantity = s.mysum
  WHERE p.id_product = s.id_product
  AND p.id_product_attribute = 0
  AND id_shop = ',@id_shop,'');
 
PREPARE request FROM @sql_text;
EXECUTE request;
DEALLOCATE PREPARE request;
