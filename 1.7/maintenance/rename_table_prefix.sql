SET group_concat_max_len=5000;
SELECT group_concat(v.name separator '; ')
FROM (
    SELECT concat('RENAME TABLE ', t.table_name, ' TO ', replace(t.table_name, 'old_prefix', 'new_prefix')) name
    FROM information_schema.tables t
    WHERE table_name like 'old_prefix%'
) v;
