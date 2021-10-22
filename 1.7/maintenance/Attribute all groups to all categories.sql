replace INTO `ps_category_group` (`id_category`, `id_group`) (SELECT `id_category`, id_group FROM `ps_group`, `ps_category`)
