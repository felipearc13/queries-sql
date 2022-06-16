SELECT
    tab3.codtmv,
    tab3.idmov,
    tab3.codfilial,
    tab3.codloc,
    tab3.nomeloc,
    nvl(SUM(valortotal), 0) AS total,
    tab3.nomefilial,
    tab3.codconta_1,
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
                            AND trelsld.saldo = 2
                            AND tmov.idmov <> 595328
                            AND tmov.idmov = 586243
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
GROUP BY
    tab3.codtmv,
    tab3.idmov,
    tab3.codfilial,
    tab3.codloc,
    tab3.nomeloc,
    tab3.nomefilial,
    tab3.codconta_1,
    tab3.codconta,
    tab3.descricao