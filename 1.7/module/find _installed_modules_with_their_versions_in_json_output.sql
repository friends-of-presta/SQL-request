SELECT CONCAT('[',GROUP_CONCAT(JSON_OBJECT('name',name,'version',version,'active',active)),']') FROM `ps_module`;
