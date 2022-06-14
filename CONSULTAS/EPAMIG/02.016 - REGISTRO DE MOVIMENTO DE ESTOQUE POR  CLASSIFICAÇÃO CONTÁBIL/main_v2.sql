SELECT
    tab_main.filial,
    tab_main.estoque,
    tab_main.codfilial,
    tab_main.codloc,
    tab_main.nomeloc,
    tab_main.nomefilial,
    tab_main.codconta_1,
    tab_main.descricao_1,
    tab_main.codconta,
    tab_main.descricao,
    nvl(SUM(tab_main.baixas), 0)              AS baixas,
    nvl(SUM(tab_main.transf_saida), 0)        AS transf_saida,
    nvl(SUM(tab_main.vendas), 0)              AS vendas,
    nvl(SUM(tab_main.outras_saidas), 0)       AS outras_saidas,
    nvl(SUM(tab_main.compras), 0)             AS compras,
    nvl(SUM(tab_main.transf_entrada), 0)      AS transf_entrada,
    nvl(SUM(tab_main.outras_entradas), 0)     AS outras_entradas,
    nvl(SUM(tab_main.baixas_ant), 0)          AS baixas_ant,
    nvl(SUM(tab_main.transf_saida_ant), 0)    AS transf_saida_ant,
    nvl(SUM(tab_main.vendas_ant), 0)          AS vendas_ant,
    nvl(SUM(tab_main.outras_saidas_ant), 0)   AS outras_saidas_ant,
    nvl(SUM(tab_main.compras_ant), 0)         AS compras_ant,
    nvl(SUM(tab_main.transf_entrada_ant), 0)  AS transf_entrada_ant,
    nvl(SUM(tab_main.outras_entradas_ant), 0) AS outras_entradas_ant
FROM
    (/*SALDO NO PERÍODO */
        SELECT
            tab6.filial,
            tab6.estoque,
            tab6.codfilial,
            tab6.codloc,
            tab6.nomeloc,
            tab6.nomefilial,
            tab6.codconta_1,
            tab6.descricao_1,
            tab6.codconta,
            tab6.descricao,
            tab6.baixas,
            tab6.transf_saida,
            tab6.vendas,
            tab6.outras_saidas,
            tab6.compras,
            tab6.transf_entrada,
            tab6.outras_entradas,
            0 AS baixas_ant,
            0 AS transf_saida_ant,
            0 AS vendas_ant,
            0 AS outras_saidas_ant,
            0 AS compras_ant,
            0 AS transf_entrada_ant,
            0 AS outras_entradas_ant
        FROM
            (
                SELECT
                    tab5.codfilial
                    || ' - '
                    || tab5.nomefilial                AS filial,
                    tab5.codloc
                    || ' - '
                    || tab5.nomeloc                   AS estoque,
                    tab5.codfilial,
                    tab5.codloc,
                    tab5.nomeloc,
                    tab5.nomefilial,
                    tab5.codconta_1,
                    tab5.descricao_1,
                    tab5.codconta,
                    tab5.descricao,
                    nvl(SUM(tab5.baixa), 0)           AS baixas,
                    nvl(SUM(tab5.trasf_saida), 0)     AS transf_saida,
                    nvl(SUM(tab5.vendas), 0)          AS vendas,
                    nvl(SUM(tab5.outras_saidas), 0)   AS outras_saidas,
                    nvl(SUM(tab5.compras), 0)         AS compras,
                    nvl(SUM(tab5.transferencia), 0)   AS transf_entrada,
                    nvl(SUM(tab5.outras_entradas), 0) AS outras_entradas
                FROM
                    (
                        SELECT
                            tab4.idmov,
                            tab4.codfilial,
                            tab4.codloc,
                            tab4.nomeloc,
                            tab4.nomefilial,
                            tab4.codconta_1,
                            tab4.descricao_1,
                            tab4.codconta,
                            tab4.descricao,
                            CASE
                                WHEN tab4.codtmv IN ( '1.1.04', '1.1.20', '1.1.24', '1.1.41' ) THEN
                                    nvl(SUM(tab4.total), 0)
                            END AS baixa,
                            CASE
                                WHEN tab4.codtmv = '2.2.16' THEN
                                    nvl(SUM(tab4.total), 0)
                            END AS trasf_saida,
                            CASE
                                WHEN tab4.codtmv IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.21', '2.2.47',
                                                      '2.2.51', '2.2.54' ) THEN
                                    nvl(SUM(tab4.total), 0)
                            END AS vendas,
                            CASE
                                WHEN tab4.codtmv IN ( '2.2.09', '2.2.14', '4.1.02', '4.1.09', '4.1.14',
                                                      '4.1.16' ) THEN
                                    nvl(SUM(tab4.total), 0)
                            END AS outras_saidas,
                            CASE
                                WHEN tab4.codtmv IN ( '1.1.13', '1.1.21', '1.1.22', '1.1.40', '1.2.09',
                                                      '1.2.41', '1.2.48', '1.2.51', '1.2.61', '1.2.63',
                                                      '1.2.72', '1.2.75', '4.1.01', '4.1.08', '4.1.13',
                                                      '4.1.15' ) THEN
                                    nvl(SUM(tab4.total), 0)
                            END AS outras_entradas,
                            CASE
                                WHEN tab4.codtmv IN ( '1.2.02', '1.2.07', '1.2.23', '1.2.24', '1.2.28',
                                                      '1.2.29', '1.2.17' ) THEN
                                    nvl(SUM(tab4.total), 0)
                            END AS compras,
                            CASE
                                WHEN tab4.codtmv IN ( '1.2.17' ) THEN
                                    nvl(SUM(tab4.total), 0)
                            END AS transferencia
                        FROM
                            (
                                SELECT
                                    tab3.codtmv,
                                    tab3.idmov,
                                    tab3.codfilial,
                                    tab3.codloc,
                                    tab3.nomeloc,
                                    nvl(SUM(valortotal), 0) AS total,
                                    tab3.nomefilial,
                                    tab3.codconta_1,
                                    cconta.descricao        AS descricao_1,
                                    tab3.codconta,
                                    tab3.descricao
                                FROM
                                    (
                                        SELECT
                                            tab2.codtmv,
                                            tab2.idmov,
                                            CASE
                                                WHEN :datainicio >= '01/01/2017' THEN
                                                    trunc(SUM(valortotal_atual), 2)
                                                ELSE
                                                    trunc(SUM(valortotal), 2)
                                            END AS valortotal,
                                            tab2.codfilial,
                                            tab2.codloc,
                                            tab2.nomeloc,
                                            tab2.nomefilial,
                                            tab2.codconta_1,
                                            tab2.codconta,
                                            tab2.descricao
                                        FROM
                                            (
                                                SELECT
                                                    tab1.codtmv,
                                                    tab1.idmov,
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
                                                    ) AS valortotal,
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
                                                    ) AS valortotal_atual,
                                                    tab1.codfilial,
                                                    tab1.codloc,
                                                    tab1.nomeloc,
                                                    tab1.nomefilial,
                                                    tab1.codconta_1,
                                                    tab1.codconta,
                                                    tab1.descricao
                                                FROM
                                                    (
                                                        SELECT
                                                            tmov.codtmv,
                                                            tprd.codigoprd,
                                                            trelsld.idmov,
                                                            SUM(trelsld.valorfincomsinal)  AS valorfincomsinal,
                                                            round(trelsld.totalsaida, 2)   AS totalsaida,
                                                            round(trelsld.totalentrada, 2) AS totalentrada,
                                                            titmmov.valorbrutoitem,
                                                            trelsld.qtdesaida,
                                                            trelsld.customeditem,
                                                            trelsld.idprd,
                                                            trelsld.nseqitmmov,
                                                            trelsld.codloc,
                                                            tloc.nome                      AS nomeloc,
                                                            tmov.codfilial,
                                                            tmov.idnat,
                                                            gfilial.nomefantasia           AS nomefilial,
                                                            substr(cconta.codconta, 1, 8)  AS codconta_1,
                                                            cconta.codconta,
                                                            cconta.descricao
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
                                           /* AND trelsld.saldo = 2
                                            AND tmov.idmov <> 595328
                                            AND tmov.idmov = 586243 */
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
                                                            AND length(tloc.codloc) = 9
                                                        GROUP BY
                                                            tmov.codtmv,
                                                            trelsld.idprd,
                                                            tmov.idmov,
                                                            trelsld.idprd,
                                                            titmmov.valorbrutoitem,
                                                            trelsld.qtdesaida,
                                                            trelsld.customeditem,
                                                            tprd.codigoprd,
                                                            trelsld.totalsaida,
                                                            trelsld.totalentrada,
                                                            trelsld.nseqitmmov,
                                                            trelsld.idmov,
                                                            trelsld.codloc,
                                                            tmov.codfilial,
                                                            tloc.nome,
                                                            tmov.idnat,
                                                            gfilial.nomefantasia,
                                                            cconta.codconta,
                                                            cconta.descricao
                                                        ORDER BY
                                                            tmov.codtmv,
                                                            tmov.idmov,
                                                            trelsld.idprd
                                                    ) tab1
                                                GROUP BY
                                                    tab1.codtmv,
                                                    tab1.idmov,
                                                    tab1.idprd,
                                                    tab1.codfilial,
                                                    tab1.codloc,
                                                    tab1.nomeloc,
                                                    tab1.nomefilial,
                                                    tab1.codconta_1,
                                                    tab1.codconta,
                                                    tab1.descricao
                                            ) tab2
                                        GROUP BY
                                            tab2.codtmv,
                                            tab2.idmov,
                                            tab2.codfilial,
                                            tab2.codloc,
                                            tab2.nomeloc,
                                            tab2.nomefilial,
                                            tab2.codconta_1,
                                            tab2.codconta,
                                            tab2.descricao
                                    ) tab3
                                    LEFT JOIN u_cfl8u4_rm.cconta ON tab3.codconta_1 = cconta.codconta
                                GROUP BY
                                    tab3.codtmv,
                                    tab3.idmov,
                                    tab3.codfilial,
                                    tab3.codloc,
                                    tab3.nomeloc,
                                    tab3.nomefilial,
                                    tab3.codconta_1,
                                    cconta.descricao,
                                    tab3.codconta,
                                    tab3.descricao
                            ) tab4
                        GROUP BY
                            tab4.codtmv,
                            tab4.idmov,
                            tab4.codfilial,
                            tab4.codloc,
                            tab4.nomeloc,
                            tab4.nomefilial,
                            tab4.codconta_1,
                            tab4.descricao_1,
                            tab4.codconta,
                            tab4.descricao
                    ) tab5
                GROUP BY
                    tab5.codfilial,
                    tab5.codloc,
                    tab5.nomeloc,
                    tab5.nomefilial,
                    tab5.codconta_1,
                    tab5.descricao_1,
                    tab5.codconta,
                    tab5.descricao
            ) tab6
        UNION

/* SALDO ANTERIOR */
        SELECT
            tab14.filial,
            tab14.estoque,
            tab14.codfilial,
            tab14.codloc,
            tab14.nomeloc,
            tab14.nomefilial,
            tab14.codconta_1,
            tab14.descricao_1,
            tab14.codconta,
            tab14.descricao,
            nvl(SUM(tab14.baixas), 0)              AS baixas,
            nvl(SUM(tab14.transf_saida), 0)        AS transf_saida,
            nvl(SUM(tab14.vendas), 0)              AS vendas,
            nvl(SUM(tab14.outras_saidas), 0)       AS outras_saidas,
            nvl(SUM(tab14.compras), 0)             AS compras,
            nvl(SUM(tab14.transf_entrada), 0)      AS transf_entrada,
            nvl(SUM(tab14.outras_entradas), 0)     AS outras_entradas,
            nvl(SUM(tab14.baixas_ant), 0)          AS baixas_ant,
            nvl(SUM(tab14.transf_saida_ant), 0)    AS transf_saida_ant,
            nvl(SUM(tab14.vendas_ant), 0)          AS vendas_ant,
            nvl(SUM(tab14.outras_saidas_ant), 0)   AS outras_saidas_ant,
            nvl(SUM(tab14.compras_ant), 0)         AS compras_ant,
            nvl(SUM(tab14.transf_entrada_ant), 0)  AS transf_entrada_ant,
            nvl(SUM(tab14.outras_entradas_ant), 0) AS outras_entradas_ant
        FROM
            (
                WITH tab13 (
                    filial,
                    estoque,
                    codfilial,
                    codloc,
                    nomeloc,
                    nomefilial,
                    codconta_1,
                    descricao_1,
                    codconta,
                    descricao,
                    baixas,
                    transf_saida,
                    vendas,
                    outras_saidas,
                    compras,
                    transf_entrada,
                    outras_entradas,
                    baixas_ant,
                    transf_saida_ant,
                    vendas_ant,
                    outras_saidas_ant,
                    compras_ant,
                    transf_entrada_ant,
                    outras_entradas_ant,
                    datamovimento
                ) AS (
                    SELECT
                        tab12.filial,
                        tab12.estoque,
                        tab12.codfilial,
                        tab12.codloc,
                        tab12.nomeloc,
                        tab12.nomefilial,
                        tab12.codconta_1,
                        tab12.descricao_1,
                        tab12.codconta,
                        tab12.descricao,
                        tab12.baixas,
                        tab12.transf_saida,
                        tab12.vendas,
                        tab12.outras_saidas,
                        tab12.compras,
                        tab12.transf_entrada,
                        tab12.outras_entradas,
                        tab12.baixas_ant,
                        tab12.transf_saida_ant,
                        tab12.vendas_ant,
                        tab12.outras_saidas_ant,
                        tab12.compras_ant,
                        tab12.transf_entrada_ant,
                        tab12.outras_entradas_ant,
                        tab12.datamovimento
                    FROM
                        (
                            SELECT
                                tab11.codfilial
                                || ' - '
                                || tab11.nomefilial                AS filial,
                                tab11.codloc
                                || ' - '
                                || tab11.nomeloc                   AS estoque,
                                tab11.codfilial,
                                tab11.codloc,
                                tab11.nomeloc,
                                tab11.nomefilial,
                                tab11.codconta_1,
                                tab11.descricao_1,
                                tab11.codconta,
                                tab11.descricao,
                                tab11.datamovimento,
                                nvl(SUM(tab11.baixa), 0)           AS baixas_ant,
                                nvl(SUM(tab11.trasf_saida), 0)     AS transf_saida_ant,
                                nvl(SUM(tab11.vendas), 0)          AS vendas_ant,
                                nvl(SUM(tab11.outras_saidas), 0)   AS outras_saidas_ant,
                                nvl(SUM(tab11.compras), 0)         AS compras_ant,
                                nvl(SUM(tab11.transferencia), 0)   AS transf_entrada_ant,
                                nvl(SUM(tab11.outras_entradas), 0) AS outras_entradas_ant,
                                nvl(SUM(0), 0)                     AS baixas,
                                nvl(SUM(0), 0)                     AS transf_saida,
                                nvl(SUM(0), 0)                     AS vendas,
                                nvl(SUM(0), 0)                     AS outras_saidas,
                                nvl(SUM(0), 0)                     AS compras,
                                nvl(SUM(0), 0)                     AS transf_entrada,
                                nvl(SUM(0), 0)                     AS outras_entradas
                            FROM
                                (
                                    SELECT
                                        tab10.idmov,
                                        tab10.codfilial,
                                        tab10.codloc,
                                        tab10.nomeloc,
                                        tab10.nomefilial,
                                        tab10.codconta_1,
                                        tab10.descricao_1,
                                        tab10.codconta,
                                        tab10.descricao,
                                        tab10.datamovimento,
                                        CASE
                                            WHEN tab10.codtmv IN ( '1.1.04', '1.1.20', '1.1.24', '1.1.41' ) THEN
                                                nvl(SUM(tab10.total), 0)
                                        END AS baixa,
                                        CASE
                                            WHEN tab10.codtmv = '2.2.16' THEN
                                                nvl(SUM(tab10.total), 0)
                                        END AS trasf_saida,
                                        CASE
                                            WHEN tab10.codtmv IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.21', '2.2.47',
                                                                   '2.2.51', '2.2.54' ) THEN
                                                nvl(SUM(tab10.total), 0)
                                        END AS vendas,
                                        CASE
                                            WHEN tab10.codtmv IN ( '2.2.09', '2.2.14', '4.1.02', '4.1.09', '4.1.14',
                                                                   '4.1.16' ) THEN
                                                nvl(SUM(tab10.total), 0)
                                        END AS outras_saidas,
                                        CASE
                                            WHEN tab10.codtmv IN ( '1.1.13', '1.1.21', '1.1.22', '1.1.40', '1.2.09',
                                                                   '1.2.41', '1.2.48', '1.2.51', '1.2.61', '1.2.63',
                                                                   '1.2.72', '1.2.75', '4.1.01', '4.1.08', '4.1.13',
                                                                   '4.1.15' ) THEN
                                                nvl(SUM(tab10.total), 0)
                                        END AS outras_entradas,
                                        CASE
                                            WHEN tab10.codtmv IN ( '1.2.02', '1.2.07', '1.2.23', '1.2.24', '1.2.28',
                                                                   '1.2.29', '1.2.17' )
                                                 AND tab10.idnat NOT IN ( 527, 159, 100, 101, 526,
                                                                          174, 272, 173, 586, 528,
                                                                          354, 176, 175, 370 ) THEN
                                                nvl(SUM(tab10.total), 0)
                                        END AS compras,
                                        CASE
                                            WHEN tab10.codtmv IN ( '1.2.17' )
                                                 AND tab10.idnat IN ( 527, 159, 100, 101, 526,
                                                                      174, 272, 173, 586, 528,
                                                                      354, 176, 175, 370 ) THEN
                                                nvl(SUM(tab10.total), 0)
                                        END AS transferencia
                                    FROM
                                        (
                                            SELECT
                                                tab9.codtmv,
                                                tab9.idmov,
                                                tab9.codfilial,
                                                tab9.codloc,
                                                tab9.nomeloc,
                                                nvl(SUM(valortotal), 0) AS total,
                                                tab9.nomefilial,
                                                tab9.codconta_1,
                                                cconta.descricao        AS descricao_1,
                                                tab9.codconta,
                                                tab9.descricao,
                                                tab9.idnat,
                                                tab9.datamovimento
                                            FROM
                                                (
                                                    SELECT
                                                        tab8.codtmv,
                                                        tab8.idmov,
                                                        trunc(SUM(valortotal_atual), 2) AS valortotal,
                                                        tab8.codfilial,
                                                        tab8.codloc,
                                                        tab8.nomeloc,
                                                        tab8.nomefilial,
                                                        tab8.codconta_1,
                                                        tab8.codconta,
                                                        tab8.descricao,
                                                        tab8.idnat,
                                                        tab8.datamovimento
                                                    FROM
                                                        (
                                                            SELECT
                                                                tab7.codtmv,
                                                                tab7.idmov,
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
                                                                             AND codtmv NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61',
                                                                             '1.2.63',
                                                                                                 '1.2.23', '1.2.48', '1.2.75' )
                                                                             AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                                            trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                                                        WHEN codtmv LIKE '1%'
                                                                             AND codtmv NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61',
                                                                             '1.2.63',
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
                                                                             AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                                             '2.2.09',
                                                                                                 '2.2.21', '2.2.22', '2.2.47' )
                                                                             AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                                            trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                                                        WHEN codtmv LIKE '2%'
                                                                             AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                                             '2.2.09',
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
                                                                ) AS valortotal,
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
                                                                             AND codtmv NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61',
                                                                             '1.2.63',
                                                                                                 '1.2.23', '1.2.48', '1.1.04', '1.1.43',
                                                                                                 '1.2.75' )
                                                                             AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                                            trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                                                        WHEN codtmv LIKE '1%'
                                                                             AND codtmv NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61',
                                                                             '1.2.63',
                                                                                                 '1.2.23', '1.2.48', '1.1.04', '1.1.43',
                                                                                                 '1.2.75' )
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
                                                                             AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                                             '2.2.09',
                                                                                                 '2.2.21', '2.2.22', '2.2.14', '2.2.47',
                                                                                                 '2.2.51',
                                                                                                 '2.2.16' )
                                                                             AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                                            trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                                                        WHEN codtmv LIKE '2%'
                                                                             AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                                             '2.2.09',
                                                                                                 '2.2.21', '2.2.22', '2.2.14', '2.2.47',
                                                                                                 '2.2.51',
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
                                                                ) AS valortotal_atual,
                                                                tab7.codfilial,
                                                                tab7.codloc,
                                                                tab7.nomeloc,
                                                                tab7.nomefilial,
                                                                tab7.codconta_1,
                                                                tab7.codconta,
                                                                tab7.descricao,
                                                                tab7.idnat,
                                                                tab7.datamovimento
                                                            FROM
                                                                (
                                                                    SELECT
                                                                        tmov.codtmv,
                                                                        tprd.codigoprd,
                                                                        trelsld.idmov,
                                                                        SUM(trelsld.valorfincomsinal)  AS valorfincomsinal,
                                                                        round(trelsld.totalsaida, 2)   AS totalsaida,
                                                                        round(trelsld.totalentrada, 2) AS totalentrada,
                                                                        titmmov.valorbrutoitem,
                                                                        trelsld.qtdesaida,
                                                                        trelsld.customeditem,
                                                                        trelsld.idprd,
                                                                        trelsld.nseqitmmov,
                                                                        trelsld.codloc,
                                                                        tloc.nome                      AS nomeloc,
                                                                        tmov.codfilial,
                                                                        tmov.idnat,
                                                                        gfilial.nomefantasia           AS nomefilial,
                                                                        substr(cconta.codconta, 1, 8)  AS codconta_1,
                                                                        cconta.codconta,
                                                                        cconta.descricao,
                                                                        trelsld.datamovimento
                                                                    FROM
                                                                        u_cfl8u4_rm.trelsld
                                                                        LEFT JOIN u_cfl8u4_rm.tmov ON trelsld.idmov = tmov.idmov
                                                                        LEFT JOIN u_cfl8u4_rm.titmmov ON titmmov.idmov = trelsld.idmov
                                                                                                         AND titmmov.idprd = trelsld.
                                                                                                         idprd
                                                                                                         AND titmmov.nseqitmmov = trelsld.
                                                                                                         nseqitmmov
                                                                        LEFT JOIN u_cfl8u4_rm.tprd ON trelsld.idprd = tprd.idprd
                                                                        RIGHT JOIN u_cfl8u4_rm.ttb4 ON ttb4.codtb4fat = tprd.codtb4fat
                                                                        RIGHT JOIN u_cfl8u4_rm.ttb4cont ON ttb4cont.codtb4fat = ttb4.
                                                                        codtb4fat
                                                                        RIGHT JOIN u_cfl8u4_rm.cconta ON cconta.codconta = ttb4cont.codconta
                                                                        RIGHT JOIN u_cfl8u4_rm.gfilial ON gfilial.codcoligada = tmov.
                                                                        codcoligada
                                                                                                          AND gfilial.codfilial = tmov.
                                                                                                          codfilial
                                                                        RIGHT JOIN u_cfl8u4_rm.tloc ON tloc.codcoligada = trelsld.codcoligada
                                                                                                       AND tloc.codfilial = trelsld.codfilial
                                                                                                       AND tloc.codloc = trelsld.codloc
                                                                    WHERE
                                                    /*    trelsld.datamovimento >= :datainicio
                                                    AND trelsld.datamovimento <= :datafim 
                                                    AND */
                                                                            trelsld.codloc >= :codloc_inicial
                                                                        AND trelsld.codloc <= :codloc_final
                                                                        AND trelsld.codfilial >= :codfilial_inicial
                                                                        AND trelsld.codfilial <= :codfilial_final
                                                                        AND trelsld.saldo = 2
                                          /*  AND tmov.idmov <> 595328
                                            AND tmov.idmov = 586243 */
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
                                                                        AND length(tloc.codloc) = 9
                                                                    GROUP BY
                                                                        tmov.codtmv,
                                                                        trelsld.idprd,
                                                                        tmov.idmov,
                                                                        trelsld.idprd,
                                                                        titmmov.valorbrutoitem,
                                                                        trelsld.qtdesaida,
                                                                        trelsld.customeditem,
                                                                        tprd.codigoprd,
                                                                        trelsld.totalsaida,
                                                                        trelsld.totalentrada,
                                                                        trelsld.nseqitmmov,
                                                                        trelsld.idmov,
                                                                        trelsld.codloc,
                                                                        tmov.codfilial,
                                                                        tloc.nome,
                                                                        tmov.idnat,
                                                                        gfilial.nomefantasia,
                                                                        cconta.codconta,
                                                                        cconta.descricao,
                                                                        trelsld.datamovimento
                                                                    ORDER BY
                                                                        tmov.codtmv,
                                                                        tmov.idmov,
                                                                        trelsld.idprd
                                                                ) tab7
                                                            GROUP BY
                                                                tab7.codtmv,
                                                                tab7.idmov,
                                                                tab7.idprd,
                                                                tab7.codfilial,
                                                                tab7.codloc,
                                                                tab7.nomeloc,
                                                                tab7.nomefilial,
                                                                tab7.codconta_1,
                                                                tab7.codconta,
                                                                tab7.descricao,
                                                                tab7.idnat,
                                                                tab7.datamovimento
                                                        ) tab8
                                                    GROUP BY
                                                        tab8.codtmv,
                                                        tab8.idmov,
                                                        tab8.codfilial,
                                                        tab8.codloc,
                                                        tab8.nomeloc,
                                                        tab8.nomefilial,
                                                        tab8.codconta_1,
                                                        tab8.codconta,
                                                        tab8.descricao,
                                                        tab8.idnat,
                                                        tab8.datamovimento
                                                ) tab9
                                                LEFT JOIN u_cfl8u4_rm.cconta ON tab9.codconta_1 = cconta.codconta
                                            GROUP BY
                                                tab9.codtmv,
                                                tab9.idmov,
                                                tab9.codfilial,
                                                tab9.codloc,
                                                tab9.nomeloc,
                                                tab9.nomefilial,
                                                tab9.codconta_1,
                                                cconta.descricao,
                                                tab9.codconta,
                                                tab9.descricao,
                                                tab9.idnat,
                                                tab9.datamovimento
                                        ) tab10
                                    GROUP BY
                                        tab10.codtmv,
                                        tab10.idmov,
                                        tab10.codfilial,
                                        tab10.codloc,
                                        tab10.nomeloc,
                                        tab10.nomefilial,
                                        tab10.codconta_1,
                                        tab10.descricao_1,
                                        tab10.codconta,
                                        tab10.descricao,
                                        tab10.idnat,
                                        tab10.datamovimento
                                ) tab11
                            GROUP BY
                                tab11.codfilial,
                                tab11.codloc,
                                tab11.nomeloc,
                                tab11.nomefilial,
                                tab11.codconta_1,
                                tab11.descricao_1,
                                tab11.codconta,
                                tab11.descricao,
                                tab11.datamovimento
                        ) tab12
                    GROUP BY
                        tab12.filial,
                        tab12.estoque,
                        tab12.codfilial,
                        tab12.codloc,
                        tab12.nomeloc,
                        tab12.nomefilial,
                        tab12.codconta_1,
                        tab12.descricao_1,
                        tab12.codconta,
                        tab12.descricao,
                        tab12.baixas,
                        tab12.transf_saida,
                        tab12.vendas,
                        tab12.outras_saidas,
                        tab12.compras,
                        tab12.transf_entrada,
                        tab12.outras_entradas,
                        tab12.baixas_ant,
                        tab12.transf_saida_ant,
                        tab12.vendas_ant,
                        tab12.outras_saidas_ant,
                        tab12.compras_ant,
                        tab12.transf_entrada_ant,
                        tab12.outras_entradas_ant,
                        tab12.datamovimento
                    ORDER BY
                        tab12.codfilial,
                        tab12.codloc,
                        tab12.descricao,
                        tab12.descricao_1
                )
/* SALDO FINAL DE DEZEMBRO DE 2019 */
                SELECT
                    tab13.filial,
                    tab13.estoque,
                    tab13.codfilial,
                    tab13.codloc,
                    tab13.nomeloc,
                    tab13.nomefilial,
                    tab13.codconta_1,
                    tab13.descricao_1,
                    tab13.codconta,
                    tab13.descricao,
                    tab13.baixas,
                    tab13.transf_saida,
                    tab13.vendas,
                    tab13.outras_saidas,
                    tab13.compras,
                    tab13.transf_entrada,
                    tab13.outras_entradas,
                    tab13.baixas_ant,
                    tab13.transf_saida_ant,
                    tab13.vendas_ant,
                    tab13.outras_saidas_ant,
                    tab13.compras_ant,
                    tab13.transf_entrada_ant,
                    tab13.outras_entradas_ant,
                    tab13.datamovimento
                FROM
                    tab13
                WHERE
                    datamovimento < '01/01/2020'
/* A PARTIR DE JANEIRO DE 2020 */
                UNION
                SELECT
                    tab13.filial,
                    tab13.estoque,
                    tab13.codfilial,
                    tab13.codloc,
                    tab13.nomeloc,
                    tab13.nomefilial,
                    tab13.codconta_1,
                    tab13.descricao_1,
                    tab13.codconta,
                    tab13.descricao,
                    tab13.baixas,
                    tab13.transf_saida,
                    tab13.vendas,
                    tab13.outras_saidas,
                    tab13.compras,
                    tab13.transf_entrada,
                    tab13.outras_entradas,
                    tab13.baixas_ant,
                    tab13.transf_saida_ant,
                    tab13.vendas_ant,
                    tab13.outras_saidas_ant,
                    tab13.compras_ant,
                    tab13.transf_entrada_ant,
                    tab13.outras_entradas_ant,
                    tab13.datamovimento
                FROM
                    tab13
                WHERE
                        datamovimento > '31/12/2019'
                    AND datamovimento <= :datainicio
            ) tab14
        GROUP BY
            tab14.filial,
            tab14.estoque,
            tab14.codfilial,
            tab14.codloc,
            tab14.nomeloc,
            tab14.nomefilial,
            tab14.codconta_1,
            tab14.descricao_1,
            tab14.codconta,
            tab14.descricao
    ) tab_main
GROUP BY
    tab_main.filial,
    tab_main.estoque,
    tab_main.codfilial,
    tab_main.codloc,
    tab_main.nomeloc,
    tab_main.nomefilial,
    tab_main.codconta_1,
    tab_main.descricao_1,
    tab_main.codconta,
    tab_main.descricao
ORDER BY
    tab_main.codfilial,
    tab_main.codloc,
    tab_main.descricao_1,
    tab_main.descricao