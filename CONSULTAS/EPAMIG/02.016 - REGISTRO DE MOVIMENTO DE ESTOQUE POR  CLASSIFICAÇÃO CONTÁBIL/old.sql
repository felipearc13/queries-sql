SELECT SUM(total)
FROM
(SELECT
    codtmv,
    idmov,
    tloc.codfilial,
    tloc.codloc,
    nvl(SUM(valortotal), 0) AS total
FROM
    (
        SELECT
            codtmv,
            idmov,
            CASE
                WHEN :datainicio >= '01/01/2017' THEN
                    trunc(SUM(valortotal_atual), 2)
                ELSE
                    trunc(SUM(valortotal), 2)
            END AS valortotal,
            codfilial,
            codloc
        FROM
            (
                SELECT
                    codtmv,
                    idmov,
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
                    codfilial,
                    codloc
                FROM
                    (
                        SELECT
                            codtmv,
                            tprd.codigoprd,
                            trelsld.idmov,
                            SUM(trelsld.valorfincomsinal)  AS valorfincomsinal,
                            round(trelsld.totalsaida, 2)   AS totalsaida,
                            round(trelsld.totalentrada, 2) AS totalentrada,
                            titmmov.valorbrutoitem,
                            qtdesaida,
                            customeditem,
                            trelsld.idprd,
                            trelsld.nseqitmmov,
                            
                            tmov.codfilial
                        FROM
                                 u_cfl8u4_rm.trelsld
                            JOIN u_cfl8u4_rm.tmov ON ( tmov.idmov = trelsld.idmov )
                            JOIN u_cfl8u4_rm.titmmov ON ( titmmov.idmov = trelsld.idmov
                                                          AND titmmov.idprd = trelsld.idprd
                                                          AND titmmov.nseqitmmov = trelsld.nseqitmmov )
                            JOIN u_cfl8u4_rm.tprd ON ( trelsld.idprd = tprd.idprd )
                        WHERE
                                trelsld.datamovimento >= :datainicio
                            AND trelsld.datamovimento <= :datafim
                            AND trelsld.codloc >= :codloc_inicial
                            AND trelsld.codloc <= :codloc_final
                            AND trelsld.codfilial >= :codfilial_inicial
                            AND trelsld.codfilial <= :codfilial_final
                            AND trelsld.saldo = 2
                            AND tmov.idmov <> 595328
                            AND tmov.codtmv IN ( '1.1.04', '1.1.13', '1.1.20', '1.1.21', '1.1.22',
                                                 '1.1.24', '1.1.40', '1.1.41', '1.2.02', '1.2.07',
                                                 '1.2.09', '1.2.17', '1.2.23', '1.2.24', '1.2.28',
                                                 '1.2.29', '1.2.41', '1.2.48', '1.2.51', '1.2.61',
                                                 '1.2.63', '1.2.72', '1.2.75', '2.2.01', '2.2.07',
                                                 '2.2.08', '2.2.09', '2.2.14', '2.2.16', '2.2.21',
                                                 '2.2.47', '2.2.51', '2.2.54', '4.1.01', '4.1.02',
                                                 '4.1.08', '4.1.09', '4.1.13', '4.1.14', '4.1.15',
                                                 '4.1.16' )
                        GROUP BY
                            codtmv,
                            trelsld.idprd,
                            tmov.idmov,
                            trelsld.idprd,
                            valorbrutoitem,
                            qtdesaida,
                            customeditem,
                            tprd.codigoprd,
                            trelsld.totalsaida,
                            trelsld.totalentrada,
                            trelsld.nseqitmmov,
                            trelsld.idmov,
                            trelsld.codloc,
                            tmov.codfilial
                        ORDER BY
                            codtmv,
                            idmov,
                            idprd
                    )
                GROUP BY
                    codtmv,
                    idmov,
                    idprd,
                    codfilial,
                    codloc
            )
        GROUP BY
            codtmv,
            idmov,
            codfilial,
            codloc /*
        UNION
        ( SELECT
            codtmv,
            trunc(nvl(SUM(valorbrutoitem), 0), 2) * ( - 1 ),
            tmov.codfilial,
            tmov.codloc
        FROM
                 u_cfl8u4_rm.tmov
            JOIN u_cfl8u4_rm.titmmov ON ( tmov.idmov = titmmov.idmov )
        WHERE
            codtmv IN ( '4.1.03' )
            AND tmov.datamovimento >= to_char(:datainicio, 'DD/MM/YYYY')
            AND tmov.datamovimento <= to_char(:datafim, 'DD/MM/YYYY')
            AND tmov.codloc >= :codloc_inicial
            AND tmov.codloc <= :codloc_final
            AND tmov.codfilial >= :codfilial_inicial
            AND tmov.codfilial <= :codfilial_final
            AND tmov.status <> 'C'
        GROUP BY
            tmov.codtmv,
            tmov.codfilial,
            tmov.codloc
        )
        UNION
        ( SELECT
            codtmv,
            trunc(nvl(SUM(valorbrutoitem), 0), 2),
            tmov.codfilial,
            tmov.codloc
        FROM
                 u_cfl8u4_rm.tmov
            JOIN u_cfl8u4_rm.titmmov ON ( tmov.idmov = titmmov.idmov )
        WHERE
            codtmv IN ( '4.1.04' )
            AND tmov.datamovimento >= :datainicio
            AND tmov.datamovimento <= :datafim
            AND tmov.codloc >= :codloc_inicial
            AND tmov.codloc <= :codloc_final
            AND tmov.codfilial >= :codfilial_inicial
            AND tmov.codfilial <= :codfilial_final
        GROUP BY
            tmov.codtmv,
            tmov.codfilial,
            tmov.codloc
       )*/
    ) tabela
    RIGHT JOIN u_cfl8u4_rm.tloc ON ( tloc.codfilial = tabela.codfilial
                                     AND tloc.codloc = tabela.codloc )
WHERE
    length(tloc.codloc) = 9
GROUP BY
    codtmv,
    idmov,
    tloc.codfilial,
    tloc.codloc
ORDER BY
    codtmv,
    idmov,
    tloc.codfilial,
    tloc.codloc)
