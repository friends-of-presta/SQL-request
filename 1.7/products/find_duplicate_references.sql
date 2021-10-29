SELECT reference, count(*) AS c
FROM ps_product
WHERE reference != ""
GROUP BY reference
HAVING c > 1
ORDER BY c DESC