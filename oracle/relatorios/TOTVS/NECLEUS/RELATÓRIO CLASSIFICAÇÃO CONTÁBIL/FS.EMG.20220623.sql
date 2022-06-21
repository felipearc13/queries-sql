SELECT
    tab2.descricao_1,
    ttb4.codtb4fat
    || ' - '
    || ttb4.descricao AS descricao_2,
    tab2.codigo,
    tab2.descricao
FROM
    (
        SELECT
            ttb4.codtb4fat
            || ' - '
            || ttb4.descricao AS descricao_1,
            tab1.codigo,
            tab1.codigo_2,
            tab1.descricao
        FROM
            (/* Classificação Contábil */
                SELECT
                    codtb4fat                    AS codigo,
                    substr(ttb4.codtb4fat, 1, 1) AS codigo_1,
                    substr(ttb4.codtb4fat, 1, 4) AS codigo_2,
                    descricao
                FROM
                    u_cfl8u4_rm.ttb4
            ) tab1
            LEFT JOIN u_cfl8u4_rm.ttb4 ON tab1.codigo_1 = ttb4.codtb4fat
        WHERE
                length(tab1.codigo) <> 1
            AND length(tab1.codigo) <> 4
    ) tab2
    LEFT JOIN u_cfl8u4_rm.ttb4 ON tab2.codigo_2 = ttb4.codtb4fat
ORDER BY
    tab2.codigo,
    tab2.descricao