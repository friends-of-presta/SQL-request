# clean guest table
DELETE g
FROM
    ps_guest g
    LEFT JOIN ps_cart c ON g.id_guest = c.id_guest
    LEFT JOIN ps_customer cu ON g.id_customer = cu.id_customer
WHERE
    (g.id_customer = 0 OR g.id_customer IS NULL)
    AND c.id_cart IS NULL;
