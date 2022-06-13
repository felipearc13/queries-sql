SELECT
    tab_main.codfilial,
    tab_main.nomefilial,
    tab_main.codconta_1,
    tab_main.descricao_1,
    tab_main.codconta,
    tab_main.descricao,
    tab_main.codloc_1,
    tab_main.nomeloc,
    nvl(SUM(tab_main.baixa), 0)                                                                                                                                                                                                  AS
    baixa,
    nvl(SUM(tab_main.trasf_saida), 0)                                                                                                                                                                                            AS
    trasf_saida,
    nvl(SUM(tab_main.vendas), 0)                                                                                                                                                                                                 AS
    vendas,
    nvl(SUM(tab_main.outras_saidas), 0)                                                                                                                                                                                          AS
    outras_saidas,
    nvl(SUM(tab_main.outras_entradas), 0)                                                                                                                                                                                        AS
    outras_entradas,
    nvl(SUM(tab_main.compras), 0)                                                                                                                                                                                                AS
    compras,
    nvl(SUM(tab_main.transferencia), 0)                                                                                                                                                                                          AS
    transferencia,
    nvl(SUM(tab_main.baixa_ant), 0)                                                                                                                                                                                              AS
    baixa_ant,
    nvl(SUM(tab_main.trasf_saida_ant), 0)                                                                                                                                                                                        AS
    trasf_saida_ant,
    nvl(SUM(tab_main.vendas_ant), 0)                                                                                                                                                                                             AS
    vendas_ant,
    nvl(SUM(tab_main.outras_saidas_ant), 0)                                                                                                                                                                                      AS
    outras_saidas_ant,
    nvl(SUM(tab_main.outras_entradas_ant), 0)                                                                                                                                                                                    AS
    outras_entradas_ant,
    nvl(SUM(tab_main.compras_ant), 0)                                                                                                                                                                                            AS
    compras_ant,
    nvl(SUM(tab_main.transferencia_ant), 0)                                                                                                                                                                                      AS
    transferencia_ant,
    nvl(SUM(baixa + trasf_saida + vendas + outras_saidas + outras_entradas + compras + transferencia), 0)                                                                                                                        AS
    saldo_per,
    nvl(SUM(baixa_ant + trasf_saida_ant + vendas_ant + outras_saidas_ant + outras_entradas_ant + compras_ant + transferencia_ant), 0)                                                                                            AS
    saldo_ant,
    nvl(SUM(baixa + trasf_saida + vendas + outras_saidas + outras_entradas + compras + transferencia + baixa_ant + trasf_saida_ant + vendas_ant +
    outras_saidas_ant + outras_entradas_ant + compras_ant + transferencia_ant), 0) AS total
FROM
    (
/* INICIO DO SALDO ANTERIOR */
        SELECT
            tab7.codfilial,
            tab7.nomefilial,
            tab7.codconta_1,
            tab7.descricao_1,
            tab7.codconta,
            tab7.descricao,
            tab7.codloc_1,
            tab7.nomeloc,
            nvl(SUM(tab7.baixa), 0)               AS baixa,
            nvl(SUM(tab7.trasf_saida), 0)         AS trasf_saida,
            nvl(SUM(tab7.vendas), 0)              AS vendas,
            nvl(SUM(tab7.outras_saidas), 0)       AS outras_saidas,
            nvl(SUM(tab7.outras_entradas), 0)     AS outras_entradas,
            nvl(SUM(tab7.compras), 0)             AS compras,
            nvl(SUM(tab7.transferencia), 0)       AS transferencia,
            nvl(SUM(tab7.baixa_ant), 0)           AS baixa_ant,
            nvl(SUM(tab7.trasf_saida_ant), 0)     AS trasf_saida_ant,
            nvl(SUM(tab7.vendas_ant), 0)          AS vendas_ant,
            nvl(SUM(tab7.outras_saidas_ant), 0)   AS outras_saidas_ant,
            nvl(SUM(tab7.outras_entradas_ant), 0) AS outras_entradas_ant,
            nvl(SUM(tab7.compras_ant), 0)         AS compras_ant,
            nvl(SUM(tab7.transferencia_ant), 0)   AS transferencia_ant
        FROM
            (
                WITH tab6 (
                    codfilial,
                    nomefilial,
                    codconta_1,
                    descricao_1,
                    codconta,
                    descricao,
                    codloc_1,
                    nomeloc,
                    datamovimento,
                    baixa,
                    trasf_saida,
                    vendas,
                    outras_saidas,
                    outras_entradas,
                    compras,
                    transferencia,
                    baixa_ant,
                    trasf_saida_ant,
                    vendas_ant,
                    outras_saidas_ant,
                    outras_entradas_ant,
                    compras_ant,
                    transferencia_ant
                ) AS (
                    SELECT
                        tab5.codfilial,
                        tab5.nomefilial,
                        tab5.codconta_1,
                        tab5.descricao_1,
                        tab5.codconta,
                        tab5.descricao,
                        tab5.codloc_1,
                        tab5.nomeloc,
                        tab5.datamovimento,
                        nvl(SUM(0), 0)                    AS baixa,
                        nvl(SUM(0), 0)                    AS trasf_saida,
                        nvl(SUM(0), 0)                    AS vendas,
                        nvl(SUM(0), 0)                    AS outras_saidas,
                        nvl(SUM(0), 0)                    AS outras_entradas,
                        nvl(SUM(0), 0)                    AS compras,
                        nvl(SUM(0), 0)                    AS transferencia,
                        nvl(SUM(tab5.baixa), 0)           AS baixa_ant,
                        nvl(SUM(tab5.trasf_saida), 0)     AS trasf_saida_ant,
                        nvl(SUM(tab5.vendas), 0)          AS vendas_ant,
                        nvl(SUM(tab5.outras_saidas), 0)   AS outras_saidas_ant,
                        nvl(SUM(tab5.outras_entradas), 0) AS outras_entradas_ant,
                        nvl(SUM(tab5.compras), 0)         AS compras_ant,
                        nvl(SUM(tab5.transferencia), 0)   AS transferencia_ant
                    FROM
                        (
                            SELECT
                                tab4.codfilial,
                                tab4.nomefilial,
                                tab4.codconta_1,
                                tab4.descricao_1,
                                tab4.codconta,
                                tab4.descricao,
                                tab4.codloc_1,
                                tab4.nomeloc,
                                tab4.datamovimento,
                                CASE
                                    WHEN tab4.codtmv IN ( '1.1.04', '1.1.20', '1.1.24', '1.1.41' ) THEN
                                        tab4.valortotal
                                END AS baixa,
                                CASE
                                    WHEN tab4.codtmv = '2.2.16' THEN
                                        tab4.valortotal
                                END AS trasf_saida,
                                CASE
                                    WHEN tab4.codtmv IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.21', '2.2.47',
                                                          '2.2.51', '2.2.54' ) THEN
                                        tab4.valortotal
                                END AS vendas,
                                CASE
                                    WHEN tab4.codtmv IN ( '2.2.09', '2.2.14', '4.1.02', '4.1.09', '4.1.14',
                                                          '4.1.16' ) THEN
                                        tab4.valortotal
                                END AS outras_saidas,
                                CASE
                                    WHEN tab4.codtmv IN ( '1.1.13', '1.1.21', '1.1.22', '1.1.40', '1.2.09',
                                                          '1.2.41', '1.2.48', '1.2.51', '1.2.61', '1.2.63',
                                                          '1.2.72', '1.2.75', '4.1.01', '4.1.08', '4.1.13',
                                                          '4.1.15' ) THEN
                                        tab4.valortotal
                                END AS outras_entradas,
                                CASE
                                    WHEN tab4.codtmv IN ( '1.2.02', '1.2.07', '1.2.23', '1.2.24', '1.2.28',
                                                          '1.2.29', '1.2.17' )
                                         AND tab4.idnat NOT IN ( 527, 159, 100, 101, 526,
                                                                 174, 272, 173, 586, 528,
                                                                 354, 176, 175, 370 ) THEN
                                        tab4.valortotal
                                END AS compras,
                                CASE
                                    WHEN tab4.codtmv = '1.2.17'
                                         AND tab4.idnat IN ( 527, 159, 100, 101, 526,
                                                             174, 272, 173, 586, 528,
                                                             354, 176, 175, 370 ) THEN
                                        tab4.valortotal
                                END AS transferencia
                            FROM
                                (
                                    SELECT
                                        tab3.codtmv,
                                        tab3.idnat,
                                        tab3.codfilial,
                                        tab3.nomefilial,
                                        tab3.codloc      AS codloc_1,
                                        tab3.codconta_1,
                                        cconta.descricao AS descricao_1,
                                        tab3.codconta,
                                        tab3.descricao,
                                        tab3.codloc,
                                        tab3.nomeloc,
                                        tab3.datamovimento,
                                        SUM(valortotal)  AS valortotal
                                    FROM /* OK */
                                        (
                                            SELECT
                                                tab2.codfilial,
                                                tab2.nomefilial,
                                                tab2.codconta_1,
                                                tab2.codconta,
                                                tab2.descricao,
                                                tab2.codtmv,
                                                tab2.idnat,
                                                tab2.codloc,
                                                tab2.nomeloc,
                                                tab2.datamovimento,
                                                trunc(SUM(valortotal_atual), 2) AS valortotal
                                            FROM /* ok */
                                                (
                                                    SELECT
                                                        tab1.codfilial,
                                                        tab1.nomefilial,
                                                        tab1.codconta_1,
                                                        tab1.codconta,
                                                        tab1.descricao,
                                                        tab1.codtmv,
                                                        tab1.idnat,
                                                        tab1.codloc,
                                                        tab1.nomeloc,
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
                                                        ) AS valortotal_atual
                                                    FROM /* OK */
                                                        (
                                                            SELECT
                                                                tmov.codfilial,
                                                                tmov.idnat,
                                                                gfilial.nomefantasia           AS nomefilial,
                                                                substr(cconta.codconta, 1, 8)  AS codconta_1,
                                                                cconta.codconta,
                                                                cconta.descricao,
                                                                tmov.codtmv,
                                                                trelsld.idmov,
                                                                titmmov.valorbrutoitem,
                                                                trelsld.nseqitmmov,
                                                                tloc.codloc,
                                                                tloc.nome                      AS nomeloc,
                                                                round(trelsld.totalsaida, 2)   AS totalsaida,
                                                                round(trelsld.totalentrada, 2) AS totalentrada,
                                                                SUM(trelsld.valorfincomsinal)  AS valorfincomsinal,
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
                                                            WHERE
                                                                    trelsld.codloc >= :codloc_inicial
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
                                                                AND length(tloc.codloc) = 9
                                                            GROUP BY
                                                                gfilial.nomefantasia,
                                                                cconta.codconta,
                                                                cconta.descricao,
                                                                tmov.codtmv,
                                                                trelsld.idprd,
                                                                tmov.idmov,
                                                                tmov.idnat,
                                                                titmmov.valorbrutoitem,
                                                                trelsld.totalsaida,
                                                                trelsld.totalentrada,
                                                                trelsld.nseqitmmov,
                                                                trelsld.idmov,
                                                                tloc.codloc,
                                                                tloc.nome,
                                                                tmov.codfilial,
                                                                trelsld.datamovimento
                                                            ORDER BY
                                                                tmov.codtmv,
                                                                tmov.idmov
                                                        ) tab1
                    /* OK */
                                                    GROUP BY
                                                        tab1.codfilial,
                                                        tab1.nomefilial,
                                                        tab1.codconta_1,
                                                        tab1.codconta,
                                                        tab1.descricao,
                                                        tab1.codtmv,
                                                        tab1.idnat,
                                                        tab1.codloc,
                                                        tab1.nomeloc,
                                                        tab1.datamovimento
                                                ) tab2
            /* OK */
                                            GROUP BY
                                                tab2.codfilial,
                                                tab2.nomefilial,
                                                tab2.codconta_1,
                                                tab2.codconta,
                                                tab2.descricao,
                                                tab2.codtmv,
                                                tab2.idnat,
                                                tab2.codloc,
                                                tab2.nomeloc,
                                                tab2.datamovimento
                                        ) tab3
    /* OK */
                                        RIGHT JOIN u_cfl8u4_rm.cconta ON cconta.codconta = tab3.codconta_1
                                    WHERE
                                        tab3.valortotal IS NOT NULL
                                    GROUP BY
                                        tab3.codtmv,
                                        tab3.idnat,
                                        tab3.codfilial,
                                        tab3.nomefilial,
                                        tab3.codloc,
                                        tab3.codconta_1,
                                        cconta.descricao,
                                        tab3.codconta,
                                        tab3.descricao,
                                        tab3.codloc,
                                        tab3.nomeloc,
                                        tab3.datamovimento
                                    ORDER BY
                                        tab3.codfilial,
                                        tab3.codloc,
                                        tab3.codtmv
                                ) tab4
    /* OK */
                        ) tab5
                    GROUP BY
                        tab5.codfilial,
                        tab5.codloc_1,
                        tab5.codconta_1,
                        tab5.descricao_1,
                        tab5.descricao,
                        tab5.nomefilial,
                        tab5.codconta,
                        tab5.nomeloc,
                        tab5.datamovimento
                    ORDER BY
                        tab5.codfilial,
                        tab5.codloc_1,
                        tab5.descricao_1,
                        tab5.descricao
                )
/* FIM DA CTE */

/* SALDO FINAL DE DEZEMBRO DE 2019 */
                SELECT
                    tab6.codfilial,
                    tab6.nomefilial,
                    tab6.codconta_1,
                    tab6.descricao_1,
                    tab6.codconta,
                    tab6.descricao,
                    tab6.codloc_1,
                    tab6.nomeloc,
                    tab6.baixa,
                    tab6.trasf_saida,
                    tab6.vendas,
                    tab6.outras_saidas,
                    tab6.outras_entradas,
                    tab6.compras,
                    tab6.transferencia,
                    tab6.baixa_ant,
                    tab6.trasf_saida_ant,
                    tab6.vendas_ant,
                    tab6.outras_saidas_ant,
                    tab6.outras_entradas_ant,
                    tab6.compras_ant,
                    tab6.transferencia_ant
                FROM
                    tab6
                WHERE
                    tab6.datamovimento < '01/01/2020'
                UNION
/* SALDO A PARTIR DE JANEIRO DE 2020 */
                SELECT
                    tab6.codfilial,
                    tab6.nomefilial,
                    tab6.codconta_1,
                    tab6.descricao_1,
                    tab6.codconta,
                    tab6.descricao,
                    tab6.codloc_1,
                    tab6.nomeloc,
                    tab6.baixa,
                    tab6.trasf_saida,
                    tab6.vendas,
                    tab6.outras_saidas,
                    tab6.outras_entradas,
                    tab6.compras,
                    tab6.transferencia,
                    tab6.baixa_ant,
                    tab6.trasf_saida_ant,
                    tab6.vendas_ant,
                    tab6.outras_saidas_ant,
                    tab6.outras_entradas_ant,
                    tab6.compras_ant,
                    tab6.transferencia_ant
                FROM
                    tab6
                WHERE
                        tab6.datamovimento > '31/12/2019'
                    AND tab6.datamovimento < :datainicio
            ) tab7
        GROUP BY
            tab7.codfilial,
            tab7.nomefilial,
            tab7.codconta_1,
            tab7.descricao_1,
            tab7.codconta,
            tab7.descricao,
            tab7.codloc_1,
            tab7.nomeloc
    
/* FIM DO SALDO ANTERIOR */

/* INICIO SALDO ATUAL */

        UNION
        SELECT
            tab5.codfilial,
            tab5.nomefilial,
            tab5.codconta_1,
            tab5.descricao_1,
            tab5.codconta,
            tab5.descricao,
            tab5.codloc_1,
            tab5.nomeloc,
            nvl(SUM(tab5.baixa), 0)           AS baixa,
            nvl(SUM(tab5.trasf_saida), 0)     AS trasf_saida,
            nvl(SUM(tab5.vendas), 0)          AS vendas,
            nvl(SUM(tab5.outras_saidas), 0)   AS outras_saidas,
            nvl(SUM(tab5.outras_entradas), 0) AS outras_entradas,
            nvl(SUM(tab5.compras), 0)         AS compras,
            nvl(SUM(tab5.transferencia), 0)   AS transferencia,
            nvl(SUM(0), 0)                    AS baixa_ant,
            nvl(SUM(0), 0)                    AS trasf_saida_ant,
            nvl(SUM(0), 0)                    AS vendas_ant,
            nvl(SUM(0), 0)                    AS outras_saidas_ant,
            nvl(SUM(0), 0)                    AS outras_entradas_ant,
            nvl(SUM(0), 0)                    AS compras_ant,
            nvl(SUM(0), 0)                    AS transferencia_ant
        FROM
            (
                SELECT
                    tab4.codfilial,
                    tab4.nomefilial,
                    tab4.codconta_1,
                    tab4.descricao_1,
                    tab4.codconta,
                    tab4.descricao,
                    tab4.codloc_1,
                    tab4.nomeloc,
                    CASE
                        WHEN tab4.codtmv IN ( '1.1.04', '1.1.20', '1.1.24', '1.1.41' ) THEN
                            tab4.valortotal
                    END AS baixa,
                    CASE
                        WHEN tab4.codtmv = '2.2.16' THEN
                            tab4.valortotal
                    END AS trasf_saida,
                    CASE
                        WHEN tab4.codtmv IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.21', '2.2.47',
                                              '2.2.51', '2.2.54' ) THEN
                            tab4.valortotal
                    END AS vendas,
                    CASE
                        WHEN tab4.codtmv IN ( '2.2.09', '2.2.14', '4.1.02', '4.1.09', '4.1.14',
                                              '4.1.16' ) THEN
                            tab4.valortotal
                    END AS outras_saidas,
                    CASE
                        WHEN tab4.codtmv IN ( '1.1.13', '1.1.21', '1.1.22', '1.1.40', '1.2.09',
                                              '1.2.41', '1.2.48', '1.2.51', '1.2.61', '1.2.63',
                                              '1.2.72', '1.2.75', '4.1.01', '4.1.08', '4.1.13',
                                              '4.1.15' ) THEN
                            tab4.valortotal
                    END AS outras_entradas,
                    CASE
                        WHEN tab4.codtmv IN ( '1.2.02', '1.2.07', '1.2.23', '1.2.24', '1.2.28',
                                              '1.2.29', '1.2.17' )
                             AND tab4.idnat NOT IN ( 527, 159, 100, 101, 526,
                                                     174, 272, 173, 586, 528,
                                                     354, 176, 175, 370 ) THEN
                            tab4.valortotal
                    END AS compras,
                    CASE
                        WHEN tab4.codtmv = '1.2.17'
                             AND tab4.idnat IN ( 527, 159, 100, 101, 526,
                                                 174, 272, 173, 586, 528,
                                                 354, 176, 175, 370 ) THEN
                            tab4.valortotal
                    END AS transferencia
                FROM
                    (
                        SELECT
                            tab3.codtmv,
                            tab3.idnat,
                            tab3.codfilial,
                            tab3.nomefilial,
                            tab3.codloc      AS codloc_1,
                            tab3.codconta_1,
                            cconta.descricao AS descricao_1,
                            tab3.codconta,
                            tab3.descricao,
                            tab3.codloc,
                            tab3.nomeloc,
                            SUM(valortotal)  AS valortotal
                        FROM /* OK */
                            (
                                SELECT
                                    tab2.codfilial,
                                    tab2.nomefilial,
                                    tab2.codconta_1,
                                    tab2.codconta,
                                    tab2.descricao,
                                    tab2.codtmv,
                                    tab2.idnat,
                                    tab2.codloc,
                                    tab2.nomeloc,
                                    CASE
                                        WHEN :datainicio >= '01/01/2017' THEN
                                            trunc(SUM(tab2.valortotal_atual), 2)
                                        ELSE
                                            trunc(SUM(tab2.valortotal), 2)
                                    END AS valortotal
                                FROM /* ok */
                                    (
                                        SELECT
                                            tab1.codfilial,
                                            tab1.nomefilial,
                                            tab1.codconta_1,
                                            tab1.codconta,
                                            tab1.descricao,
                                            tab1.codtmv,
                                            tab1.idnat,
                                            tab1.codloc,
                                            tab1.nomeloc,
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
                                            ) AS valortotal_atual
                                        FROM /* OK */
                                            (
                                                SELECT
                                                    tmov.codfilial,
                                                    tmov.idnat,
                                                    gfilial.nomefantasia           AS nomefilial,
                                                    substr(cconta.codconta, 1, 8)  AS codconta_1,
                                                    cconta.codconta,
                                                    cconta.descricao,
                                                    tmov.codtmv,
                                                    trelsld.idmov,
                                                    titmmov.valorbrutoitem,
                                                    trelsld.nseqitmmov,
                                                    tloc.codloc,
                                                    tloc.nome                      AS nomeloc,
                                                    round(trelsld.totalsaida, 2)   AS totalsaida,
                                                    round(trelsld.totalentrada, 2) AS totalentrada,
                                                    SUM(trelsld.valorfincomsinal)  AS valorfincomsinal
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
                                                    AND length(tloc.codloc) = 9
                                                GROUP BY
                                                    gfilial.nomefantasia,
                                                    cconta.codconta,
                                                    cconta.descricao,
                                                    tmov.codtmv,
                                                    trelsld.idprd,
                                                    tmov.idmov,
                                                    tmov.idnat,
                                                    titmmov.valorbrutoitem,
                                                    trelsld.totalsaida,
                                                    trelsld.totalentrada,
                                                    trelsld.nseqitmmov,
                                                    trelsld.idmov,
                                                    tloc.codloc,
                                                    tloc.nome,
                                                    tmov.codfilial
                                                ORDER BY
                                                    tmov.codtmv,
                                                    tmov.idmov
                                            ) tab1
                    /* OK */
                                        GROUP BY
                                            tab1.codfilial,
                                            tab1.nomefilial,
                                            tab1.codconta_1,
                                            tab1.codconta,
                                            tab1.descricao,
                                            tab1.codtmv,
                                            tab1.idnat,
                                            tab1.codloc,
                                            tab1.nomeloc
                                    ) tab2
            /* OK */
                                GROUP BY
                                    tab2.codfilial,
                                    tab2.nomefilial,
                                    tab2.codconta_1,
                                    tab2.codconta,
                                    tab2.descricao,
                                    tab2.codtmv,
                                    tab2.idnat,
                                    tab2.codloc,
                                    tab2.nomeloc
                            ) tab3
    /* OK */
                            RIGHT JOIN u_cfl8u4_rm.cconta ON cconta.codconta = tab3.codconta_1
                        WHERE
                            tab3.valortotal IS NOT NULL
                        GROUP BY
                            tab3.codtmv,
                            tab3.idnat,
                            tab3.codfilial,
                            tab3.nomefilial,
                            tab3.codloc,
                            tab3.codconta_1,
                            cconta.descricao,
                            tab3.codconta,
                            tab3.descricao,
                            tab3.codloc,
                            tab3.nomeloc
                        ORDER BY
                            tab3.codfilial,
                            tab3.codloc,
                            tab3.codtmv
                    ) tab4
    /* OK */
            ) tab5
        GROUP BY
            tab5.codfilial,
            tab5.codloc_1,
            tab5.codconta_1,
            tab5.descricao_1,
            tab5.descricao,
            tab5.nomefilial,
            tab5.codconta,
            tab5.nomeloc
/* FIM DO SALDO ANTERIOR */
    ) tab_main
GROUP BY
    tab_main.codfilial,
    tab_main.nomefilial,
    tab_main.codconta_1,
    tab_main.descricao_1,
    tab_main.codconta,
    tab_main.descricao,
    tab_main.codloc_1,
    tab_main.nomeloc
ORDER BY
    tab_main.codfilial,
    tab_main.codloc_1,
    tab_main.descricao_1,
    tab_main.descricao