TRUNCATE `ps_module_group`;

INSERT INTO `ps_module_group`
SELECT m.`id_module`, s.`id_shop`, g.`id_group`
FROM `ps_module` m, `ps_group` g, `ps_shop` s
ORDER BY m.`id_module`;
