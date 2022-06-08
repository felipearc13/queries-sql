SELECT
    codfilial,
    codloc,
    SUM(valoranterior_2019 + valoranterior_2020) AS valortotal
FROM
    (/* Saldo Final de Dez 2019 */
        SELECT
            codtmv,
            codloc,
            codfilial,
            trunc(SUM(valortotal), 2) AS valoranterior_2019,
            0                         AS valoranterior_2020
        FROM
            (
                SELECT
                    codtmv,
                    codloc,
                    codfilial,
                    trunc(SUM(valortotal_atual), 2) AS valortotal
                FROM
                    (
                        SELECT
                            codtmv,
                            codloc,
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
                                                             '1.2.23', '1.2.48', '1.1.04' )
                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                        trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                    WHEN codtmv LIKE '1%'
                                         AND codtmv NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61', '1.2.63',
                                                             '1.2.23', '1.2.48', '1.1.04' )
                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                        trunc(SUM(valorbrutoitem), 2)
                                    WHEN codtmv IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                     '2.2.21', '2.2.22', '1.1.04', '2.2.14', '1.1.04',
                                                     '2.2.47' )
                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                        trunc(SUM(totalsaida), 2) * ( - 1 )
                                    WHEN codtmv IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                     '2.2.21', '2.2.22', '1.1.04', '2.2.14', '1.1.04',
                                                     '2.2.47' )
                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                        trunc(SUM(totalsaida), 2)
                                    WHEN codtmv LIKE '2%'
                                         AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                             '2.2.21', '2.2.22', '2.2.14', '2.2.47' )
                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                        trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                    WHEN codtmv LIKE '2%'
                                         AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                             '2.2.21', '2.2.22', '2.2.14', '2.2.47' )
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
                            codfilial
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
                                    tmov.codloc,
                                    tmov.codfilial
                                FROM
                                         u_cfl8u4_rm.trelsld
                                    JOIN u_cfl8u4_rm.tmov ON ( tmov.idmov = trelsld.idmov )
                                    JOIN u_cfl8u4_rm.titmmov ON ( titmmov.idmov = trelsld.idmov
                                                                  AND titmmov.idprd = trelsld.idprd
                                                                  AND titmmov.nseqitmmov = trelsld.nseqitmmov )
                                    JOIN u_cfl8u4_rm.tprd ON ( trelsld.idprd = tprd.idprd )
                                WHERE
                                        trelsld.datamovimento < '01/01/2020'
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
                                    tmov.codloc,
                                    tmov.codfilial
                                ORDER BY
                                    codtmv,
                                    codloc,
                                    idmov,
                                    idprd
                            )
                        GROUP BY
                            codtmv,
                            codloc,
                            idmov,
                            idprd,
                            codfilial
                    )
                GROUP BY
                    codtmv,
                    codloc,
                    codfilial
            )
        GROUP BY
            codtmv,
            codloc,
            codfilial
    
/* Saldo a partir jan 2020 */

        UNION
        SELECT
            codtmv,
            codloc,
            codfilial,
            0                         AS valoranterior_2019,
            trunc(SUM(valortotal), 2) AS valoranterior_2020
        FROM
            (
                SELECT
                    codtmv,
                    codloc,
                    codfilial,
                    trunc(SUM(valortotal_atual), 2) AS valortotal
             /*CASE WHEN TO_CHAR(:DATAINICIO, 'DD/MM/YYYY') >='01/01/2017' THEN trunc(Sum(VALORTOTAL_Atual),2) ELSE trunc(Sum(VALORTOTAL),2) END  AS VALORTOTAL*/
                FROM
                    (
                        SELECT
                            codtmv,
                            codloc,
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
                            codfilial
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
                                    tmov.codloc,
                                    tmov.codfilial
                                FROM
                                         u_cfl8u4_rm.trelsld
                                    JOIN u_cfl8u4_rm.tmov ON ( tmov.idmov = trelsld.idmov )
                                    JOIN u_cfl8u4_rm.titmmov ON ( titmmov.idmov = trelsld.idmov
                                                                  AND titmmov.idprd = trelsld.idprd
                                                                  AND titmmov.nseqitmmov = trelsld.nseqitmmov )
                                    JOIN u_cfl8u4_rm.tprd ON ( trelsld.idprd = tprd.idprd )
                                WHERE
                            /*TRELSLD.DATAMOVIMENTO < '01/01/2020' --TO_CHAR(:DATAINICIO, 'DD/MM/YYYY')*/
                                        tmov.datamovimento > '31/12/2019'
                                    AND tmov.datamovimento < '01/12/2021'
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
                                    tmov.codloc,
                                    tmov.codfilial
                                ORDER BY
                                    codtmv,
                                    idmov,
                                    idprd
                            )
                        GROUP BY
                            codtmv,
                            codloc,
                            idmov,
                            idprd,
                            codfilial
                    )
                GROUP BY
                    codtmv,
                    codloc,
                    codfilial
            )
        GROUP BY
            codtmv,
            codloc,
            codfilial
    )
GROUP BY
    codfilial,
    codloc