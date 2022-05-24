-- If you want to increase your next order id, just use this query with something like phpmyadmin
-- On next line, set which is your next id. Be carefull, it must be a number!

SET @next_id = 150;

ALTER TABLE ps_orders AUTO_INCREMENT=@next_id;