# List all modules hooked a the specified by @hookName

SET @hookName = "actionAdminProductsControllerSaveAfter";

select m.id_module, m.name, m.active
from ps_hook_module hm
left join ps_module m on hm.id_module = m.id_module
where id_hook = (select id_hook from ps_hook where name=@hookName);

