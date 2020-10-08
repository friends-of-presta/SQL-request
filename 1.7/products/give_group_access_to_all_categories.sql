INSERT IGNORE INTO `ps_category_group` (id_category, id_group)
SELECT DISTINCT id_category, ###id_group_to_give_access### FROM `ps_category` WHERE id_parent != 0