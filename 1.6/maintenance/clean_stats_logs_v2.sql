# Prefixe des tables
SET @prefix = 'ps';
# Nombre de jours dhistoriques à conserver
SET @nbjour = 100;
# Constitution et execution des requêtes
#
# Suppression des stats connections de plus de x jours
SET @sql_text1 = concat('DELETE FROM ',@prefix,'_connections',' WHERE date_add < now() - interval ',@nbjour,' DAY');
PREPARE stmt1 FROM @sql_text1;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;
#
# Suppression des stats sources de plus de x jours
SET @sql_text1 = concat('DELETE FROM ',@prefix,'_connections_page',' WHERE time_start < now() - interval ',@nbjour,' DAY');
PREPARE stmt1 FROM @sql_text1;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;
#
# Suppression des stats sources de plus de x jours
SET @sql_text1 = concat('DELETE FROM ',@prefix,'_connections_source',' WHERE date_add < now() - interval ',@nbjour,' DAY');
PREPARE stmt1 FROM @sql_text1;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;
#
# Suppression des stats pages 404 de plus de x jours
SET @sql_text1 = concat('DELETE FROM ',@prefix,'_pagenotfound',' WHERE date_add < now() - interval ',@nbjour,' DAY');
PREPARE stmt1 FROM @sql_text1;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;
#
# Suppression des stats pages vues 
SET @sql_text1 = concat('TRUNCATE TABLE ',@prefix,'_page_viewed');
PREPARE stmt1 FROM @sql_text1;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;
#
# Suppression des stats referers 
SET @sql_text1 = concat('TRUNCATE TABLE ',@prefix,'_referrer_cache');
PREPARE stmt1 FROM @sql_text1;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;
#
# Suppression des mails de plus de x jours 
SET @sql_text1 = concat('DELETE FROM ',@prefix,'_mail',' WHERE date_add < now() - interval ',@nbjour,' DAY');
PREPARE stmt1 FROM @sql_text1;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;
#
# Suppression des logs de plus de x jours 
SET @sql_text1 = concat('DELETE FROM ',@prefix,'_log',' WHERE date_add < now() - interval ',@nbjour,' DAY');
PREPARE stmt1 FROM @sql_text1;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;
#
# Suppression des stats de plus de x jours 
SET @sql_text1 = concat('DELETE FROM ',@prefix,'_statssearch',' WHERE date_add < now() - interval ',@nbjour,' DAY');
PREPARE stmt1 FROM @sql_text1;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;
#
# Suppression des paniers sans commandes vieux de plus de x jours 
SET @sql_text1 = concat('DELETE FROM ',@prefix,'_cart WHERE id_cart NOT IN (SELECT id_cart FROM ',@prefix,'_orders) AND date_add < now() - interval ',@nbjour,' DAY');
PREPARE stmt1 FROM @sql_text1;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;
#
# Suppression des invités sans commandes
SET @sql_text1 = concat('DELETE g FROM ',@prefix,'_guest',' as g LEFT JOIN ',@prefix,'_cart as c ON g.id_guest = c.id_guest WHERE id_cart IS NULL');
PREPARE stmt1 FROM @sql_text1;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;
