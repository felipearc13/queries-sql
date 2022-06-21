SELECT
    ttb2.codtb2fat
    || ' - '
    || ttb2.descricao n1,
    tab1.codigo,
    tab1.descricao
FROM
    (
        SELECT
            codtb2fat               AS codigo,
            substr(codtb2fat, 1, 2) AS codigo_1,
            descricao
        FROM
            u_cfl8u4_rm.ttb2 /*
WHERE 
 length (ttb2.codtb2fat) <> 2 */
    ) tab1
    LEFT JOIN u_cfl8u4_rm.ttb2 ON tab1.codigo_1 = ttb2.codtb2fat
WHERE
    length(tab1.codigo) <> 2
ORDER BY
    tab1.codigo_1,
    tab1.codigo