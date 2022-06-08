SELECT
    *
FROM
    (
        SELECT
            tab4.codfilial,
            tab4.nomefantasia,
            tab4.codloc,
            tab4.nome,
            tab4.descricao,
            tab4.codconta,
            cconta.descricao     AS descricao_n1,
            cconta.codconta      AS codconta_n1,
            SUM(baixa)           AS baixas,
            NULL                 AS baixas_ant,
            SUM(trasf_saida)     AS transf_saida,
            NULL                 AS transf_saida_ant,
            SUM(vendas)          AS vendas,
            NULL                 AS vendas_ant,
            SUM(outras_saidas)   AS outras_saidas,
            NULL                 AS outras_saidas_ant,
            SUM(outras_entradas) AS outras_entradas,
            NULL                 AS outras_entradas_ant,
            SUM(compras)         AS compras,
            NULL                 AS compras_ant,
            SUM(transferencia)   AS transf_entrada,
            NULL                 AS transf_entrada_ant
        FROM
            (
                SELECT
                    tab3.codconta,
                    substr(tab3.codconta, 1, 8) AS codconta_n1,
                    tab3.descricao,
                    tloc.codfilial,
                    gfilial.nomefantasia,
                    tloc.codloc,
                    tloc.nome,
                    CASE
                        WHEN codtmv IN ( '1.1.04', '1.1.20', '1.1.24', '1.1.41' ) THEN
                            SUM(valortotal)
                    END                         AS baixa,
                    CASE
                        WHEN codtmv = '2.2.16' THEN
                            SUM(valortotal)
                    END                         AS trasf_saida,
                    CASE
                        WHEN codtmv IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.21', '2.2.47',
                                         '2.2.51', '2.2.54' ) THEN
                            SUM(valortotal)
                    END                         AS vendas,
                    CASE
                        WHEN codtmv IN ( '2.2.09', '2.2.14', '4.1.02', '4.1.09', '4.1.14',
                                         '4.1.16' ) THEN
                            SUM(valortotal)
                    END                         AS outras_saidas,
                    CASE
                        WHEN codtmv IN ( '1.1.13', '1.1.21', '1.1.22', '1.1.40', '1.2.09',
                                         '1.2.41', '1.2.48', '1.2.51', '1.2.61', '1.2.63',
                                         '1.2.72', '1.2.75', '4.1.01', '4.1.08', '4.1.13',
                                         '4.1.15' ) THEN
                            SUM(valortotal)
                    END                         AS outras_entradas,
                    CASE
                        WHEN codtmv IN ( '1.2.02', '1.2.07', '1.2.23', '1.2.24', '1.2.28',
                                         '1.2.29', '1.2.17' ) THEN
                            SUM(valortotal)
                    END                         AS compras,
                    CASE
                        WHEN codtmv IN ( '1.2.17' ) THEN
                            SUM(valortotal)
                    END                         AS transferencia
                FROM
                    (
                        SELECT
                            tab2.codtmv,
                            tab2.codconta,
                            tab2.descricao,
                            tab2.codfilial,
                            tab2.codloc,
                            (
                                CASE
                                    WHEN '01/12/2021' >= '01/01/2017'
                          /* WHEN :DATAINICIO >= '01/01/2017' */ THEN
                                        trunc(SUM(valortotal_atual), 2)
                                    ELSE
                                        trunc(SUM(valortotal), 2)
                                END
                            ) AS valortotal
                        FROM
                            (
                                SELECT
                                    tab1.codtmv,
                                    tab1.codconta,
                                    tab1.descricao,
                                    tab1.codfilial,
                                    tab1.codloc,
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
                                            WHEN codtmv IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.09', '2.2.21',
                                                             '2.2.47' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                trunc(SUM(totalsaida), 2) * ( - 1 )
                                            WHEN codtmv IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.09', '2.2.21',
                                                             '2.2.47' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                trunc(SUM(totalsaida), 2)
                                            WHEN codtmv LIKE '2%'
                                                 AND codtmv NOT IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.09', '2.2.21',
                                                                     '2.2.47' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                            WHEN codtmv LIKE '2%'
                                                 AND codtmv NOT IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.09', '2.2.21',
                                                                     '2.2.47' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                trunc(SUM(valorbrutoitem), 2)
                                            WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                            WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                trunc(SUM(valorbrutoitem), 2)
                                            WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                            WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16' )
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
                                            WHEN codtmv IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.09', '2.2.21',
                                                             '1.1.04', '2.2.14', '2.2.47', '2.2.51', '2.2.16',
                                                             '1.1.43', '1.2.75' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                trunc(SUM(totalsaida), 2) * ( - 1 )
                                            WHEN codtmv IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.09', '2.2.21',
                                                             '1.1.04', '2.2.14', '2.2.47', '2.2.51', '2.2.16',
                                                             '1.1.43', '1.2.75' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                trunc(SUM(totalsaida), 2)
                                            WHEN codtmv LIKE '2%'
                                                 AND codtmv NOT IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.09', '2.2.21',
                                                                     '2.2.14', '2.2.47', '2.2.51', '2.2.16' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                            WHEN codtmv LIKE '2%'
                                                 AND codtmv NOT IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.09', '2.2.21',
                                                                     '2.2.14', '2.2.47', '2.2.51', '2.2.16' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                trunc(SUM(valorbrutoitem), 2)
                                            WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                            WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                trunc(SUM(valorbrutoitem), 2)
                                            WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                            WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                trunc(SUM(valorbrutoitem), 2)
                                            ELSE
                                                SUM(valorbrutoitem)
                                        END
                                    ) AS valortotal_atual
                                FROM
                                    (
                                        SELECT
                                            tmov.codtmv,
                                            cconta.codconta,
                                            cconta.descricao,
                                            SUM(trelsld.valorfincomsinal)  AS valorfincomsinal,
                                            round(trelsld.totalsaida, 2)   AS totalsaida,
                                            round(trelsld.totalentrada, 2) AS totalentrada,
                                            titmmov.valorbrutoitem,
                                            trelsld.codloc,
                                            tmov.codfilial
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
            /*
             WHERE TRELSLD.DATAMOVIMENTO 
             >= :DATAINICIO
             AND TRELSLD.DATAMOVIMENTO <= :DATAFIM
             AND TRELSLD.CODLOC >= :CODLOC_INICIAL
             AND TRELSLD.CODLOC <= :CODLOC_FINAL
             AND TRELSLD.CODFILIAL >= :CODFILIAL_INICIAL
             AND TRELSLD.CODFILIAL <= :CODFILIAL_FINAL
             */
                                        WHERE
                                                trelsld.datamovimento >= '01/12/2021'
                                            AND trelsld.datamovimento <= '31/12/2021'
                                            AND trelsld.codloc >= '01.001.01'
                                            AND trelsld.codloc <= '99.999.99'
                                            AND trelsld.codfilial >= 1
                                            AND trelsld.codfilial <= 1
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
                                            titmmov.valorbrutoitem,
                                            trelsld.totalsaida,
                                            trelsld.totalentrada,
                                            trelsld.codloc,
                                            tmov.codfilial
                                    ) tab1
                                GROUP BY
                                    tab1.codtmv,
                                    tab1.codconta,
                                    tab1.descricao,
                                    tab1.codfilial,
                                    tab1.codloc
                            ) tab2
                        GROUP BY
                            tab2.codtmv,
                            tab2.codconta,
                            tab2.descricao,
                            tab2.codfilial,
                            tab2.codloc
                    ) tab3
                    RIGHT JOIN u_cfl8u4_rm.tloc ON tloc.codfilial = tab3.codfilial
                                                   AND tloc.codloc = tab3.codloc
                    LEFT JOIN u_cfl8u4_rm.gfilial ON tloc.codfilial = gfilial.codfilial
                WHERE
                    length(tloc.codloc) = 9
                GROUP BY
                    tloc.codfilial,
                    gfilial.nomefantasia,
                    tab3.codtmv,
                    tab3.codconta,
                    tab3.descricao,
                    tloc.codloc,
                    tloc.nome
            ) tab4
            RIGHT JOIN u_cfl8u4_rm.cconta ON cconta.codconta = tab4.codconta_n1
        WHERE
            tab4.descricao IS NOT NULL
        GROUP BY
            tab4.codfilial,
            tab4.nomefantasia,
            tab4.codloc,
            tab4.nome,
            tab4.descricao,
            tab4.codconta,
            cconta.descricao,
            cconta.codconta
        UNION
        SELECT
            tab4.codfilial,
            tab4.nomefantasia,
            tab4.codloc,
            tab4.nome,
            tab4.descricao,
            tab4.codconta,
            cconta.descricao     AS descricao_n1,
            cconta.codconta      AS codconta_n1,
            NULL                 AS baixas,
            SUM(baixa)           AS baixas_ant,
            NULL                 AS transf_saida,
            SUM(trasf_saida)     AS transf_saida_ant,
            NULL                 AS vendas,
            SUM(vendas)          AS vendas_ant,
            NULL                 AS outras_saidas,
            SUM(outras_saidas)   AS outras_saidas_ant,
            NULL                 AS outras_entradas,
            SUM(outras_entradas) AS outras_entradas_ant,
            NULL                 AS compras,
            SUM(compras)         AS compras_ant,
            NULL                 AS transf_entrada,
            SUM(transferencia)   AS transf_entrada_ant
        FROM
            (
                SELECT
                    tab3.codconta,
                    substr(tab3.codconta, 1, 8) AS codconta_n1,
                    tab3.descricao,
                    tloc.codfilial,
                    gfilial.nomefantasia,
                    tloc.codloc,
                    tloc.nome,
                    CASE
                        WHEN codtmv IN ( '1.1.04', '1.1.20', '1.1.24', '1.1.41' ) THEN
                            SUM(valortotal)
                    END                         AS baixa,
                    CASE
                        WHEN codtmv = '2.2.16' THEN
                            SUM(valortotal)
                    END                         AS trasf_saida,
                    CASE
                        WHEN codtmv IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.21', '2.2.47',
                                         '2.2.51', '2.2.54' ) THEN
                            SUM(valortotal)
                    END                         AS vendas,
                    CASE
                        WHEN codtmv IN ( '2.2.09', '2.2.14', '4.1.02', '4.1.09', '4.1.14',
                                         '4.1.16' ) THEN
                            SUM(valortotal)
                    END                         AS outras_saidas,
                    CASE
                        WHEN codtmv IN ( '1.1.13', '1.1.21', '1.1.22', '1.1.40', '1.2.09',
                                         '1.2.41', '1.2.48', '1.2.51', '1.2.61', '1.2.63',
                                         '1.2.72', '1.2.75', '4.1.01', '4.1.08', '4.1.13',
                                         '4.1.15' ) THEN
                            SUM(valortotal)
                    END                         AS outras_entradas,
                    CASE
                        WHEN codtmv IN ( '1.2.02', '1.2.07', '1.2.23', '1.2.24', '1.2.28',
                                         '1.2.29', '1.2.17' ) THEN
                            SUM(valortotal)
                    END                         AS compras,
                    CASE
                        WHEN codtmv IN ( '1.2.17' ) THEN
                            SUM(valortotal)
                    END                         AS transferencia
                FROM
                    (
                        SELECT
                            tab2.codtmv,
                            tab2.codconta,
                            tab2.descricao,
                            tab2.codfilial,
                            tab2.codloc,
                            (
                                CASE
                                    WHEN '01/12/2021' >= '01/01/2017'
                          /* WHEN :DATAINICIO >= '01/01/2017' */ THEN
                                        trunc(SUM(valortotal_atual), 2)
                                    ELSE
                                        trunc(SUM(valortotal), 2)
                                END
                            ) AS valortotal
                        FROM
                            (
                                SELECT
                                    tab1.codtmv,
                                    tab1.codconta,
                                    tab1.descricao,
                                    tab1.codfilial,
                                    tab1.codloc,
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
                                            WHEN codtmv IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.09', '2.2.21',
                                                             '2.2.47' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                trunc(SUM(totalsaida), 2) * ( - 1 )
                                            WHEN codtmv IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.09', '2.2.21',
                                                             '2.2.47' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                trunc(SUM(totalsaida), 2)
                                            WHEN codtmv LIKE '2%'
                                                 AND codtmv NOT IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.09', '2.2.21',
                                                                     '2.2.47' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                            WHEN codtmv LIKE '2%'
                                                 AND codtmv NOT IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.09', '2.2.21',
                                                                     '2.2.47' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                trunc(SUM(valorbrutoitem), 2)
                                            WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                            WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                trunc(SUM(valorbrutoitem), 2)
                                            WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                            WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16' )
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
                                            WHEN codtmv IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.09', '2.2.21',
                                                             '1.1.04', '2.2.14', '2.2.47', '2.2.51', '2.2.16',
                                                             '1.1.43', '1.2.75' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                trunc(SUM(totalsaida), 2) * ( - 1 )
                                            WHEN codtmv IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.09', '2.2.21',
                                                             '1.1.04', '2.2.14', '2.2.47', '2.2.51', '2.2.16',
                                                             '1.1.43', '1.2.75' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                trunc(SUM(totalsaida), 2)
                                            WHEN codtmv LIKE '2%'
                                                 AND codtmv NOT IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.09', '2.2.21',
                                                                     '2.2.14', '2.2.47', '2.2.51', '2.2.16' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                            WHEN codtmv LIKE '2%'
                                                 AND codtmv NOT IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.09', '2.2.21',
                                                                     '2.2.14', '2.2.47', '2.2.51', '2.2.16' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                trunc(SUM(valorbrutoitem), 2)
                                            WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                            WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                trunc(SUM(valorbrutoitem), 2)
                                            WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                                trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                            WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16' )
                                                 AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                                trunc(SUM(valorbrutoitem), 2)
                                            ELSE
                                                SUM(valorbrutoitem)
                                        END
                                    ) AS valortotal_atual
                                FROM
                                    (
                                        SELECT
                                            tmov.codtmv,
                                            cconta.codconta,
                                            cconta.descricao,
                                            SUM(trelsld.valorfincomsinal)  AS valorfincomsinal,
                                            round(trelsld.totalsaida, 2)   AS totalsaida,
                                            round(trelsld.totalentrada, 2) AS totalentrada,
                                            titmmov.valorbrutoitem,
                                            trelsld.codloc,
                                            tmov.codfilial
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
            /*
             WHERE TRELSLD.DATAMOVIMENTO 
             >= :DATAINICIO
             AND TRELSLD.DATAMOVIMENTO <= :DATAFIM
             AND TRELSLD.CODLOC >= :CODLOC_INICIAL
             AND TRELSLD.CODLOC <= :CODLOC_FINAL
             AND TRELSLD.CODFILIAL >= :CODFILIAL_INICIAL
             AND TRELSLD.CODFILIAL <= :CODFILIAL_FINAL
             */
                                        WHERE
                                               trelsld.datamovimento >= '01/12/2021'
                                            AND trelsld.datamovimento <= '31/12/2021'
                                            AND trelsld.codloc >= '01.001.01'
                                            AND trelsld.codloc <= '99.999.99'
                                            AND trelsld.codfilial >= 1
                                            AND trelsld.codfilial <= 1
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
                                            titmmov.valorbrutoitem,
                                            trelsld.totalsaida,
                                            trelsld.totalentrada,
                                            trelsld.codloc,
                                            tmov.codfilial
                                    ) tab1
                                GROUP BY
                                    tab1.codtmv,
                                    tab1.codconta,
                                    tab1.descricao,
                                    tab1.codfilial,
                                    tab1.codloc
                            ) tab2
                        GROUP BY
                            tab2.codtmv,
                            tab2.codconta,
                            tab2.descricao,
                            tab2.codfilial,
                            tab2.codloc
                    ) tab3
                    RIGHT JOIN u_cfl8u4_rm.tloc ON tloc.codfilial = tab3.codfilial
                                                   AND tloc.codloc = tab3.codloc
                    LEFT JOIN u_cfl8u4_rm.gfilial ON tloc.codfilial = gfilial.codfilial
                WHERE
                    length(tloc.codloc) = 9
                GROUP BY
                    tloc.codfilial,
                    gfilial.nomefantasia,
                    tab3.codtmv,
                    tab3.codconta,
                    tab3.descricao,
                    tloc.codloc,
                    tloc.nome
            ) tab4
            RIGHT JOIN u_cfl8u4_rm.cconta ON cconta.codconta = tab4.codconta_n1
        WHERE
            tab4.descricao IS NOT NULL
        GROUP BY
            tab4.codfilial,
            tab4.nomefantasia,
            tab4.codloc,
            tab4.nome,
            tab4.descricao,
            tab4.codconta,
            cconta.descricao,
            cconta.codconta
        ORDER BY
            codfilial,
            nomefantasia,
            codloc,
            nome,
            descricao,
            codconta
    ) tab5

ORDER BY
    codfilial,
    codloc,
    descricao_n1,
    descricao