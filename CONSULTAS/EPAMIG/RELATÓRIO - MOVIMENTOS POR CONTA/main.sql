SELECT
    tab_main.filial,
    tab_main.estoque,
    tab_main.codfilial,
    tab_main.nomefantasia,
    tab_main.codloc,
    tab_main.nomeloc,
    tab_main.descricao,
    tab_main.codconta,
    tab_main.descricao_1,
    tab_main.codconta_1,
    nvl(SUM(baixas_ant), 0)          AS baixas_ant,
    nvl(SUM(transf_saida_ant), 0)    AS transf_saida_ant,
    nvl(SUM(vendas_ant), 0)          AS vendas_ant,
    nvl(SUM(outras_saidas_ant), 0)   AS outras_saidas_ant,
    nvl(SUM(compras_ant), 0)         AS compras_ant,
    nvl(SUM(transf_entrada_ant), 0)  AS transf_entrada_ant,
    nvl(SUM(outras_entradas_ant), 0) AS outras_entradas_ant,
    nvl(SUM(baixas), 0)              AS baixas,
    nvl(SUM(transf_saida), 0)        AS transf_saida,
    nvl(SUM(vendas), 0)              AS vendas,
    nvl(SUM(outras_saidas), 0)       AS outras_saidas,
    nvl(SUM(compras), 0)             AS compras,
    nvl(SUM(transf_entrada), 0)      AS transf_entrada,
    nvl(SUM(outras_entradas), 0)     AS outras_entradas
FROM
    (
        SELECT
            tab6.filial,
            tab6.estoque,
            tab6.codfilial,
            tab6.nomefantasia,
            tab6.codloc,
            tab6.nomeloc,
            tab6.descricao,
            tab6.codconta,
            tab6.descricao_1,
            tab6.codconta_1,
            nvl(SUM(baixas), 0)          AS baixas_ant,
            nvl(SUM(transf_saida), 0)    AS transf_saida_ant,
            nvl(SUM(vendas), 0)          AS vendas_ant,
            nvl(SUM(outras_saidas), 0)   AS outras_saidas_ant,
            nvl(SUM(compras), 0)         AS compras_ant,
            nvl(SUM(transf_entrada), 0)  AS transf_entrada_ant,
            nvl(SUM(outras_entradas), 0) AS outras_entradas_ant,
    /* SALDO NO PERÍODO */
            0                            AS baixas,
            0                            AS transf_saida,
            0                            AS vendas,
            0                            AS outras_saidas,
            0                            AS compras,
            0                            AS transf_entrada,
            0                            AS outras_entradas
        FROM
            (
                WITH tab5 (
                    filial,
                    estoque,
                    codfilial,
                    nomefantasia,
                    codloc,
                    nomeloc,
                    descricao,
                    codconta,
                    descricao_1,
                    codconta_1,
                    baixas,
                    transf_saida,
                    vendas,
                    outras_saidas,
                    compras,
                    transf_entrada,
                    outras_entradas,
                    datamovimento
                ) AS (
                    SELECT
                        tab4.codfilial
                        || ' - '
                        || tab4.nomefantasia         AS filial,
                        tab4.codloc
                        || ' - '
                        || tab4.nomeloc              AS estoque,
                        tab4.codfilial,
                        tab4.nomefantasia,
                        tab4.codloc,
                        tab4.nomeloc,
                        tab4.descricao,
                        tab4.codconta,
                        tab4.descricao_1,
                        tab4.codconta_1,
                        nvl(SUM(baixa), 0)           AS baixas,
                        nvl(SUM(trasf_saida), 0)     AS transf_saida,
                        nvl(SUM(vendas), 0)          AS vendas,
                        nvl(SUM(outras_saidas), 0)   AS outras_saidas,
                        nvl(SUM(compras), 0)         AS compras,
                        nvl(SUM(transferencia), 0)   AS transf_entrada,
                        nvl(SUM(outras_entradas), 0) AS outras_entradas,
                        tab4.datamovimento
                    FROM
                        (
                            SELECT
                                tab3.codfilial,
                                tab3.nomefantasia,
                                tab3.codloc,
                                tab3.nomeloc,
                                tab3.descricao,
                                tab3.codconta,
                                tab3.descricao_1,
                                tab3.codconta_1,
                                tab3.datamovimento,
                                CASE
                                    WHEN codtmv IN ( '1.1.04', '1.1.20', '1.1.24', '1.1.41' ) THEN
                                        nvl(SUM(valortotal), 0)
                                END AS baixa,
                                CASE
                                    WHEN codtmv = '2.2.16' THEN
                                        nvl(SUM(valortotal), 0)
                                END AS trasf_saida,
                                CASE
                                    WHEN codtmv IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.21', '2.2.47',
                                                     '2.2.51', '2.2.54' ) THEN
                                        nvl(SUM(valortotal), 0)
                                END AS vendas,
                                CASE
                                    WHEN codtmv IN ( '2.2.09', '2.2.14', '4.1.02', '4.1.09', '4.1.14',
                                                     '4.1.16' ) THEN
                                        nvl(SUM(valortotal), 0)
                                END AS outras_saidas,
                                CASE
                                    WHEN codtmv IN ( '1.1.13', '1.1.21', '1.1.22', '1.1.40', '1.2.09',
                                                     '1.2.41', '1.2.48', '1.2.51', '1.2.61', '1.2.63',
                                                     '1.2.72', '1.2.75', '4.1.01', '4.1.08', '4.1.13',
                                                     '4.1.15' ) THEN
                                        nvl(SUM(valortotal), 0)
                                END AS outras_entradas,
                                CASE
                                    WHEN codtmv IN ( '1.2.02', '1.2.07', '1.2.23', '1.2.24', '1.2.28',
                                                     '1.2.29', '1.2.17' ) THEN
                                        nvl(SUM(valortotal), 0)
                                END AS compras,
                                CASE
                                    WHEN codtmv IN ( '1.2.17' ) THEN
                                        nvl(SUM(valortotal), 0)
                                END AS transferencia
                            FROM
                                (
                                    SELECT
                                        tab2.codtmv,
                                        tab2.codfilial,
                                        tab2.nomefantasia,
                                        tab2.codloc,
                                        tab2.nomeloc,
                                        tab2.descricao,
                                        tab2.codconta,
                                        tab2.descricao_1,
                                        tab2.codconta_1,
                                        tab2.datamovimento,
                                        trunc(SUM(valortotal_atual), 2) AS valortotal
                                    FROM
                                        (
                                            SELECT
                                                tab1.codtmv,
                                                tab1.codfilial,
                                                tab1.nomefantasia,
                                                tab1.codloc,
                                                tab1.nomeloc,
                                                tab1.descricao,
                                                tab1.codconta,
                                                cconta.descricao AS descricao_1,
                                                tab1.codconta_1,
                                                tab1.datamovimento,
                                                (
                                                    CASE
                                                        WHEN codtmv IN ( '1.2.02', '1.2.09', '1.2.61', '1.2.63', '1.2.23',
                                                                         '1.2.48' )
                                                             AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                            trunc(SUM(totalentrada), 2) * ( - 1 )
                                                        WHEN codtmv IN ( '1.2.02', '1.2.09', '1.2.61', '1.2.63', '1.2.23',
                                                                         '1.2.48' )
                                                             AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                            trunc(SUM(totalentrada), 2)
                                                        WHEN codtmv LIKE '1%'
                                                             AND codtmv NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61', '1.2.63',
                                                                                 '1.2.23', '1.2.48', '1.2.75' )
                                                             AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                            trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                                        WHEN codtmv LIKE '1%'
                                                             AND codtmv NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61', '1.2.63',
                                                                                 '1.2.23', '1.2.48', '1.2.75' )
                                                             AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                            trunc(SUM(valorbrutoitem), 2)
                                                        WHEN codtmv IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                                         '2.2.21', '2.2.22', '2.2.47' )
                                                             AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                            trunc(SUM(totalsaida), 2) * ( - 1 )
                                                        WHEN codtmv IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                                         '2.2.21', '2.2.22', '2.2.47' )
                                                             AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                            trunc(SUM(totalsaida), 2)
                                                        WHEN codtmv LIKE '2%'
                                                             AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                                                 '2.2.21', '2.2.22', '2.2.47' )
                                                             AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                            trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                                        WHEN codtmv LIKE '2%'
                                                             AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                                                 '2.2.21', '2.2.22', '2.2.47' )
                                                             AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                            trunc(SUM(valorbrutoitem), 2)
                                                        WHEN codtmv LIKE '3%'
                                                             AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                            trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                                        WHEN codtmv LIKE '3%'
                                                             AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                            trunc(SUM(valorbrutoitem), 2)
                                                        WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                                             AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                            trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                                        WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                                             AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                            trunc(SUM(valorbrutoitem), 2)
                                                        WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17' )
                                                             AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                            trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                                        WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17' )
                                                             AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                            trunc(SUM(valorbrutoitem), 2)
                                                        ELSE
                                                            SUM(valorbrutoitem)
                                                    END
                                                )                AS valortotal,
                                                (
                                                    CASE
                                                        WHEN codtmv IN ( '1.2.02', '1.2.09', '1.2.61', '1.2.63', '1.2.23',
                                                                         '1.2.48' )
                                                             AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                            trunc(SUM(totalentrada), 2) * ( - 1 )
                                                        WHEN codtmv IN ( '1.2.02', '1.2.09', '1.2.61', '1.2.63', '1.2.23',
                                                                         '1.2.48' )
                                                             AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                            trunc(SUM(totalentrada), 2)
                                                        WHEN codtmv LIKE '1%'
                                                             AND codtmv NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61', '1.2.63',
                                                                                 '1.2.23', '1.2.48', '1.1.04', '1.1.43', '1.2.75' )
                                                             AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                            trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                                        WHEN codtmv LIKE '1%'
                                                             AND codtmv NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61', '1.2.63',
                                                                                 '1.2.23', '1.2.48', '1.1.04', '1.1.43', '1.2.75' )
                                                             AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                            trunc(SUM(valorbrutoitem), 2)
                                                        WHEN codtmv IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                                         '2.2.21', '2.2.22', '1.1.04', '2.2.14', '2.2.47',
                                                                         '2.2.51', '2.2.16', '1.1.43', '1.2.75' )
                                                             AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                            trunc(SUM(totalsaida), 2) * ( - 1 )
                                                        WHEN codtmv IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                                         '2.2.21', '2.2.22', '1.1.04', '2.2.14', '2.2.47',
                                                                         '2.2.51', '2.2.16', '1.1.43', '1.2.75' )
                                                             AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                            trunc(SUM(totalsaida), 2)
                                                        WHEN codtmv LIKE '2%'
                                                             AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                                                 '2.2.21', '2.2.22', '2.2.14', '2.2.47', '2.2.51',
                                                                                 '2.2.16' )
                                                             AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                            trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                                        WHEN codtmv LIKE '2%'
                                                             AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                                                 '2.2.21', '2.2.22', '2.2.14', '2.2.47', '2.2.51',
                                                                                 '2.2.16' )
                                                             AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                            trunc(SUM(valorbrutoitem), 2)
                                                        WHEN codtmv LIKE '3%'
                                                             AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                            trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                                        WHEN codtmv LIKE '3%'
                                                             AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                            trunc(SUM(valorbrutoitem), 2)
                                                        WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                                             AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                            trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                                        WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                                             AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                            trunc(SUM(valorbrutoitem), 2)
                                                        WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17' )
                                                             AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                            trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                                        WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17' )
                                                             AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                            trunc(SUM(valorbrutoitem), 2)
                                                        ELSE
                                                            SUM(valorbrutoitem)
                                                    END
                                                )                AS valortotal_atual
                                            FROM
                                                (
                                                    SELECT
                                                        tmov.codtmv,
                                                        tmov.codfilial,
                                                        gfilial.nomefantasia,
                                                        trelsld.codloc,
                                                        tloc.nome                      AS nomeloc,
                                                        cconta.descricao,
                                                        cconta.codconta,
                                                        substr(cconta.codconta, 1, 8)  AS codconta_1,
                                                        SUM(trelsld.valorfincomsinal)  AS valorfincomsinal,
                                                        round(trelsld.totalsaida, 2)   AS totalsaida,
                                                        round(trelsld.totalentrada, 2) AS totalentrada,
                                                        titmmov.valorbrutoitem,
                                                        trelsld.datamovimento
                                                    FROM
                                                        u_cfl8u4_rm.trelsld
                                                        LEFT JOIN u_cfl8u4_rm.tmov ON trelsld.idmov = tmov.idmov
                                                        LEFT JOIN u_cfl8u4_rm.titmmov ON titmmov.idmov = trelsld.idmov
                                                                                         AND titmmov.idprd = trelsld.idprd
                                                                                         AND titmmov.nseqitmmov = trelsld.nseqitmmov
                                                        LEFT JOIN u_cfl8u4_rm.tprd ON trelsld.idprd = tprd.idprd
                                                        RIGHT JOIN u_cfl8u4_rm.ttb4 ON ttb4.codtb4fat = tprd.codtb4fat
                                                        RIGHT JOIN u_cfl8u4_rm.ttb4cont ON ttb4cont.codtb4fat = ttb4.codtb4fat
                                                        RIGHT JOIN u_cfl8u4_rm.cconta ON cconta.codconta = ttb4cont.codconta
                                                        RIGHT JOIN u_cfl8u4_rm.gfilial ON gfilial.codcoligada = tmov.codcoligada
                                                                                          AND gfilial.codfilial = tmov.codfilial
                                                        RIGHT JOIN u_cfl8u4_rm.tloc ON tloc.codcoligada = trelsld.codcoligada
                                                                                       AND tloc.codfilial = trelsld.codfilial
                                                                                       AND tloc.codloc = trelsld.codloc
                                                                                       AND trelsld.saldo = 2
                                                                                       AND tmov.codtmv IN ( '1.1.04', '1.1.13', '1.1.20',
                                                                                       '1.1.21', '1.1.22',
                                                                                                            '1.1.24', '1.1.40', '1.1.41',
                                                                                                            '1.2.02', '1.2.07',
                                                                                                            '1.2.09', '1.2.17', '1.2.23',
                                                                                                            '1.2.24', '1.2.28',
                                                                                                            '1.2.29', '1.2.41', '1.2.48',
                                                                                                            '1.2.51', '1.2.61',
                                                                                                            '1.2.63', '1.2.72', '1.2.75',
                                                                                                            '2.2.01', '2.2.07',
                                                                                                            '2.2.08', '2.2.09', '2.2.14',
                                                                                                            '2.2.16', '2.2.21',
                                                                                                            '2.2.47', '2.2.51', '2.2.54',
                                                                                                            '4.1.01', '4.1.02',
                                                                                                            '4.1.08', '4.1.09', '4.1.13',
                                                                                                            '4.1.14', '4.1.15',
                                                                                                            '4.1.16' )
                                                                                       AND ttb4cont.classconta = 'ESTOQUE'
                                                    GROUP BY
                                                        tmov.codtmv,
                                                        cconta.codconta,
                                                        cconta.descricao,
                                                        valorbrutoitem,
                                                        trelsld.totalsaida,
                                                        trelsld.totalentrada,
                                                        trelsld.idmov,
                                                        trelsld.codloc,
                                                        tloc.nome,
                                                        tmov.codfilial,
                                                        gfilial.nomefantasia,
                                                        trelsld.datamovimento
                                                ) tab1
                                                RIGHT JOIN u_cfl8u4_rm.cconta ON cconta.codconta = tab1.codconta_1
                                            WHERE
                                                tab1.codtmv IS NOT NULL
                                            GROUP BY
                                                tab1.codtmv,
                                                tab1.codfilial,
                                                tab1.nomefantasia,
                                                tab1.codloc,
                                                tab1.nomeloc,
                                                tab1.descricao,
                                                tab1.codconta,
                                                cconta.descricao,
                                                tab1.codconta_1,
                                                tab1.datamovimento
                                        ) tab2
                                    GROUP BY
                                        tab2.codtmv,
                                        tab2.codfilial,
                                        tab2.nomefantasia,
                                        tab2.codloc,
                                        tab2.nomeloc,
                                        tab2.descricao,
                                        tab2.codconta,
                                        tab2.descricao_1,
                                        tab2.codconta_1,
                                        tab2.datamovimento
                                ) tab3
                            GROUP BY
                                tab3.codtmv,
                                tab3.codfilial,
                                tab3.nomefantasia,
                                tab3.codloc,
                                tab3.nomeloc,
                                tab3.descricao,
                                tab3.codconta,
                                tab3.descricao_1,
                                tab3.codconta_1,
                                tab3.datamovimento
                        ) tab4
                    GROUP BY
                        tab4.codfilial,
                        tab4.nomefantasia,
                        tab4.codloc,
                        tab4.nomeloc,
                        tab4.descricao,
                        tab4.codconta,
                        tab4.descricao_1,
                        tab4.codconta_1,
                        tab4.datamovimento
                    ORDER BY
                        tab4.codfilial,
                        tab4.codloc,
                        tab4.descricao,
                        tab4.codconta,
                        tab4.descricao_1,
                        tab4.codconta_1
                )
/* SALDO FINAL DE DEZEMBRO DE 2019 */
                SELECT
                    tab5.filial,
                    tab5.estoque,
                    tab5.codfilial,
                    tab5.nomefantasia,
                    tab5.codloc,
                    tab5.nomeloc,
                    tab5.descricao,
                    tab5.codconta,
                    tab5.descricao_1,
                    tab5.codconta_1,
                    tab5.baixas,
                    tab5.transf_saida,
                    tab5.vendas,
                    tab5.outras_saidas,
                    tab5.compras,
                    tab5.transf_entrada,
                    tab5.outras_entradas,
                    datamovimento
                FROM
                    tab5
                WHERE
                        datamovimento < '01/01/2020'
                    AND codloc >= :codloc_inicial
                    AND codloc <= :codloc_final
                    AND codfilial >= :codfilial_inicial
                    AND codfilial <= :codfilial_final
                UNION
/* A PARTIR DE JANEIRO DE 2020 */
                SELECT
                    tab5.filial,
                    tab5.estoque,
                    tab5.codfilial,
                    tab5.nomefantasia,
                    tab5.codloc,
                    tab5.nomeloc,
                    tab5.descricao,
                    tab5.codconta,
                    tab5.descricao_1,
                    tab5.codconta_1,
                    tab5.baixas,
                    tab5.transf_saida,
                    tab5.vendas,
                    tab5.outras_saidas,
                    tab5.compras,
                    tab5.transf_entrada,
                    tab5.outras_entradas,
                    datamovimento
                FROM
                    tab5
                WHERE
                        datamovimento > '31/12/2019'
                    AND datamovimento <= :datainicio
                    AND codloc >= :codloc_inicial
                    AND codloc <= :codloc_final
                    AND codfilial >= :codfilial_inicial
                    AND codfilial <= :codfilial_final
            ) tab6
        GROUP BY
            tab6.filial,
            tab6.estoque,
            tab6.codfilial,
            tab6.nomefantasia,
            tab6.codloc,
            tab6.nomeloc,
            tab6.descricao,
            tab6.codconta,
            tab6.descricao_1,
            tab6.codconta_1
        UNION
        SELECT
            tab5.filial,
            tab5.estoque,
            tab5.codfilial,
            tab5.nomefantasia,
            tab5.codloc,
            tab5.nomeloc,
            tab5.descricao,
            tab5.codconta,
            tab5.descricao_1,
            tab5.codconta_1,
            0 AS baixas_ant,
            0 AS transf_saida_ant,
            0 AS vendas_ant,
            0 AS outras_saidas_ant,
            0 AS compras_ant,
            0 AS transf_entrada_ant,
            0 AS outras_entradas_ant,
            tab5.baixas,
            tab5.transf_saida,
            tab5.vendas,
            tab5.outras_saidas,
            tab5.compras,
            tab5.transf_entrada,
            tab5.outras_entradas
        FROM
            (
                SELECT
                    tab4.codfilial
                    || ' - '
                    || tab4.nomefantasia         AS filial,
                    tab4.codloc
                    || ' - '
                    || tab4.nomeloc              AS estoque,
                    tab4.codfilial,
                    tab4.nomefantasia,
                    tab4.codloc,
                    tab4.nomeloc,
                    tab4.descricao,
                    tab4.codconta,
                    tab4.descricao_1,
                    tab4.codconta_1,
                    nvl(SUM(baixa), 0)           AS baixas,
                    nvl(SUM(trasf_saida), 0)     AS transf_saida,
                    nvl(SUM(vendas), 0)          AS vendas,
                    nvl(SUM(outras_saidas), 0)   AS outras_saidas,
                    nvl(SUM(compras), 0)         AS compras,
                    nvl(SUM(transferencia), 0)   AS transf_entrada,
                    nvl(SUM(outras_entradas), 0) AS outras_entradas
                FROM
                    (
                        SELECT
                            tab3.codfilial,
                            tab3.nomefantasia,
                            tab3.codloc,
                            tab3.nomeloc,
                            tab3.descricao,
                            tab3.codconta,
                            tab3.descricao_1,
                            tab3.codconta_1,
                            CASE
                                WHEN codtmv IN ( '1.1.04', '1.1.20', '1.1.24', '1.1.41' ) THEN
                                    nvl(SUM(valortotal), 0)
                            END AS baixa,
                            CASE
                                WHEN codtmv = '2.2.16' THEN
                                    nvl(SUM(valortotal), 0)
                            END AS trasf_saida,
                            CASE
                                WHEN codtmv IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.21', '2.2.47',
                                                 '2.2.51', '2.2.54' ) THEN
                                    nvl(SUM(valortotal), 0)
                            END AS vendas,
                            CASE
                                WHEN codtmv IN ( '2.2.09', '2.2.14', '4.1.02', '4.1.09', '4.1.14',
                                                 '4.1.16' ) THEN
                                    nvl(SUM(valortotal), 0)
                            END AS outras_saidas,
                            CASE
                                WHEN codtmv IN ( '1.1.13', '1.1.21', '1.1.22', '1.1.40', '1.2.09',
                                                 '1.2.41', '1.2.48', '1.2.51', '1.2.61', '1.2.63',
                                                 '1.2.72', '1.2.75', '4.1.01', '4.1.08', '4.1.13',
                                                 '4.1.15' ) THEN
                                    nvl(SUM(valortotal), 0)
                            END AS outras_entradas,
                            CASE
                                WHEN codtmv IN ( '1.2.02', '1.2.07', '1.2.23', '1.2.24', '1.2.28',
                                                 '1.2.29', '1.2.17' ) THEN
                                    nvl(SUM(valortotal), 0)
                            END AS compras,
                            CASE
                                WHEN codtmv IN ( '1.2.17' ) THEN
                                    nvl(SUM(valortotal), 0)
                            END AS transferencia
                        FROM
                            (
                                SELECT
                                    tab2.codtmv,
                                    tab2.codfilial,
                                    tab2.nomefantasia,
                                    tab2.codloc,
                                    tab2.nomeloc,
                                    tab2.descricao,
                                    tab2.codconta,
                                    tab2.descricao_1,
                                    tab2.codconta_1,
                                    CASE
                         /*  WHEN '01/12/2021' >= '01/01/2017'*/
                                        WHEN :datainicio >= '01/01/2017' THEN
                                            trunc(SUM(valortotal_atual), 2)
                                        ELSE
                                            trunc(SUM(valortotal), 2)
                                    END AS valortotal
                                FROM
                                    (
                                        SELECT
                                            tab1.codtmv,
                                            tab1.codfilial,
                                            tab1.nomefantasia,
                                            tab1.codloc,
                                            tab1.nomeloc,
                                            tab1.descricao,
                                            tab1.codconta,
                                            cconta.descricao AS descricao_1,
                                            tab1.codconta_1,
                                            (
                                                CASE
                                                    WHEN codtmv IN ( '1.2.02', '1.2.09', '1.2.61', '1.2.63', '1.2.23',
                                                                     '1.2.48' )
                                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                        trunc(SUM(totalentrada), 2) * ( - 1 )
                                                    WHEN codtmv IN ( '1.2.02', '1.2.09', '1.2.61', '1.2.63', '1.2.23',
                                                                     '1.2.48' )
                                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                        trunc(SUM(totalentrada), 2)
                                                    WHEN codtmv LIKE '1%'
                                                         AND codtmv NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61', '1.2.63',
                                                                             '1.2.23', '1.2.48', '1.2.75' )
                                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                        trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                                    WHEN codtmv LIKE '1%'
                                                         AND codtmv NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61', '1.2.63',
                                                                             '1.2.23', '1.2.48', '1.2.75' )
                                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                        trunc(SUM(valorbrutoitem), 2)
                                                    WHEN codtmv IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                                     '2.2.21', '2.2.22', '2.2.47' )
                                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                        trunc(SUM(totalsaida), 2) * ( - 1 )
                                                    WHEN codtmv IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                                     '2.2.21', '2.2.22', '2.2.47' )
                                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                        trunc(SUM(totalsaida), 2)
                                                    WHEN codtmv LIKE '2%'
                                                         AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                                             '2.2.21', '2.2.22', '2.2.47' )
                                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                        trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                                    WHEN codtmv LIKE '2%'
                                                         AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                                             '2.2.21', '2.2.22', '2.2.47' )
                                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                        trunc(SUM(valorbrutoitem), 2)
                                                    WHEN codtmv LIKE '3%'
                                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                        trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                                    WHEN codtmv LIKE '3%'
                                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                        trunc(SUM(valorbrutoitem), 2)
                                                    WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                        trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                                    WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                        trunc(SUM(valorbrutoitem), 2)
                                                    WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17' )
                                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                        trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                                    WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17' )
                                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                        trunc(SUM(valorbrutoitem), 2)
                                                    ELSE
                                                        SUM(valorbrutoitem)
                                                END
                                            )                AS valortotal,
                                            (
                                                CASE
                                                    WHEN codtmv IN ( '1.2.02', '1.2.09', '1.2.61', '1.2.63', '1.2.23',
                                                                     '1.2.48' )
                                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                        trunc(SUM(totalentrada), 2) * ( - 1 )
                                                    WHEN codtmv IN ( '1.2.02', '1.2.09', '1.2.61', '1.2.63', '1.2.23',
                                                                     '1.2.48' )
                                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                        trunc(SUM(totalentrada), 2)
                                                    WHEN codtmv LIKE '1%'
                                                         AND codtmv NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61', '1.2.63',
                                                                             '1.2.23', '1.2.48', '1.1.04', '1.1.43', '1.2.75' )
                                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                        trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                                    WHEN codtmv LIKE '1%'
                                                         AND codtmv NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61', '1.2.63',
                                                                             '1.2.23', '1.2.48', '1.1.04', '1.1.43', '1.2.75' )
                                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                        trunc(SUM(valorbrutoitem), 2)
                                                    WHEN codtmv IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                                     '2.2.21', '2.2.22', '1.1.04', '2.2.14', '2.2.47',
                                                                     '2.2.51', '2.2.16', '1.1.43', '1.2.75' )
                                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                        trunc(SUM(totalsaida), 2) * ( - 1 )
                                                    WHEN codtmv IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                                     '2.2.21', '2.2.22', '1.1.04', '2.2.14', '2.2.47',
                                                                     '2.2.51', '2.2.16', '1.1.43', '1.2.75' )
                                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                        trunc(SUM(totalsaida), 2)
                                                    WHEN codtmv LIKE '2%'
                                                         AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                                             '2.2.21', '2.2.22', '2.2.14', '2.2.47', '2.2.51',
                                                                             '2.2.16' )
                                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                        trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                                    WHEN codtmv LIKE '2%'
                                                         AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                                             '2.2.21', '2.2.22', '2.2.14', '2.2.47', '2.2.51',
                                                                             '2.2.16' )
                                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                        trunc(SUM(valorbrutoitem), 2)
                                                    WHEN codtmv LIKE '3%'
                                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                        trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                                    WHEN codtmv LIKE '3%'
                                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                        trunc(SUM(valorbrutoitem), 2)
                                                    WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                        trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                                    WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                        trunc(SUM(valorbrutoitem), 2)
                                                    WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17' )
                                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                        trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                                    WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17' )
                                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                        trunc(SUM(valorbrutoitem), 2)
                                                    ELSE
                                                        SUM(valorbrutoitem)
                                                END
                                            )                AS valortotal_atual
                                        FROM
                                            (
                                                SELECT
                                                    tmov.codtmv,
                                                    tmov.codfilial,
                                                    gfilial.nomefantasia,
                                                    trelsld.codloc,
                                                    tloc.nome                      AS nomeloc,
                                                    cconta.descricao,
                                                    cconta.codconta,
                                                    substr(cconta.codconta, 1, 8)  AS codconta_1,
                                                    SUM(trelsld.valorfincomsinal)  AS valorfincomsinal,
                                                    round(trelsld.totalsaida, 2)   AS totalsaida,
                                                    round(trelsld.totalentrada, 2) AS totalentrada,
                                                    titmmov.valorbrutoitem
                                                FROM
                                                    u_cfl8u4_rm.trelsld
                                                    LEFT JOIN u_cfl8u4_rm.tmov ON trelsld.idmov = tmov.idmov
                                                    LEFT JOIN u_cfl8u4_rm.titmmov ON titmmov.idmov = trelsld.idmov
                                                                                     AND titmmov.idprd = trelsld.idprd
                                                                                     AND titmmov.nseqitmmov = trelsld.nseqitmmov
                                                    LEFT JOIN u_cfl8u4_rm.tprd ON trelsld.idprd = tprd.idprd
                                                    RIGHT JOIN u_cfl8u4_rm.ttb4 ON ttb4.codtb4fat = tprd.codtb4fat
                                                    RIGHT JOIN u_cfl8u4_rm.ttb4cont ON ttb4cont.codtb4fat = ttb4.codtb4fat
                                                    RIGHT JOIN u_cfl8u4_rm.cconta ON cconta.codconta = ttb4cont.codconta
                                                    RIGHT JOIN u_cfl8u4_rm.gfilial ON gfilial.codcoligada = tmov.codcoligada
                                                                                      AND gfilial.codfilial = tmov.codfilial
                                                    RIGHT JOIN u_cfl8u4_rm.tloc ON tloc.codcoligada = trelsld.codcoligada
                                                                                   AND tloc.codfilial = trelsld.codfilial
                                                                                   AND tloc.codloc = trelsld.codloc
                                                WHERE
                                                        trelsld.datamovimento >= :datainicio
                                                    AND trelsld.datamovimento <= :datafim
                                                    AND trelsld.codloc >= :codloc_inicial
                                                    AND trelsld.codloc <= :codloc_final
                                                    AND trelsld.codfilial >= :codfilial_inicial
                                                    AND trelsld.codfilial <= :codfilial_final
                                                    AND trelsld.saldo = 2
                                                    AND tmov.codtmv IN ( '1.1.04', '1.1.13', '1.1.20', '1.1.21', '1.1.22',
                                                                         '1.1.24', '1.1.40', '1.1.41', '1.2.02', '1.2.07',
                                                                         '1.2.09', '1.2.17', '1.2.23', '1.2.24', '1.2.28',
                                                                         '1.2.29', '1.2.41', '1.2.48', '1.2.51', '1.2.61',
                                                                         '1.2.63', '1.2.72', '1.2.75', '2.2.01', '2.2.07',
                                                                         '2.2.08', '2.2.09', '2.2.14', '2.2.16', '2.2.21',
                                                                         '2.2.47', '2.2.51', '2.2.54', '4.1.01', '4.1.02',
                                                                         '4.1.08', '4.1.09', '4.1.13', '4.1.14', '4.1.15',
                                                                         '4.1.16' )
                                                    AND ttb4cont.classconta = 'ESTOQUE'
                                                GROUP BY
                                                    tmov.codtmv,
                                                    cconta.codconta,
                                                    cconta.descricao,
                                                    valorbrutoitem,
                                                    trelsld.totalsaida,
                                                    trelsld.totalentrada,
                                                    trelsld.idmov,
                                                    trelsld.codloc,
                                                    tloc.nome,
                                                    tmov.codfilial,
                                                    gfilial.nomefantasia
                                            ) tab1
                                            RIGHT JOIN u_cfl8u4_rm.cconta ON cconta.codconta = tab1.codconta_1
                                        WHERE
                                            tab1.codtmv IS NOT NULL
                                        GROUP BY
                                            tab1.codtmv,
                                            tab1.codfilial,
                                            tab1.nomefantasia,
                                            tab1.codloc,
                                            tab1.nomeloc,
                                            tab1.descricao,
                                            tab1.codconta,
                                            cconta.descricao,
                                            tab1.codconta_1
                                    ) tab2
                                GROUP BY
                                    tab2.codtmv,
                                    tab2.codfilial,
                                    tab2.nomefantasia,
                                    tab2.codloc,
                                    tab2.nomeloc,
                                    tab2.descricao,
                                    tab2.codconta,
                                    tab2.descricao_1,
                                    tab2.codconta_1
                            ) tab3
                        GROUP BY
                            tab3.codtmv,
                            tab3.codfilial,
                            tab3.nomefantasia,
                            tab3.codloc,
                            tab3.nomeloc,
                            tab3.descricao,
                            tab3.codconta,
                            tab3.descricao_1,
                            tab3.codconta_1
                    ) tab4
                GROUP BY
                    tab4.codfilial,
                    tab4.nomefantasia,
                    tab4.codloc,
                    tab4.nomeloc,
                    tab4.descricao,
                    tab4.codconta,
                    tab4.descricao_1,
                    tab4.codconta_1
            ) tab5
    ) tab_main
GROUP BY
    tab_main.filial,
    tab_main.estoque,
    tab_main.codfilial,
    tab_main.nomefantasia,
    tab_main.codloc,
    tab_main.nomeloc,
    tab_main.descricao,
    tab_main.codconta,
    tab_main.descricao_1,
    tab_main.codconta_1
ORDER BY
    tab_main.codfilial,
    tab_main.codloc,
    tab_main.descricao,
    tab_main.descricao_1