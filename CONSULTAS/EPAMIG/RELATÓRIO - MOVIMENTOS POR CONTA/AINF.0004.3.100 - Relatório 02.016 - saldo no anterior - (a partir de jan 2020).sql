SELECT Trunc(Sum(VALORTOTAL), 2) AS VALORANTERIOR
FROM (
        SELECT CODFILIAL,
            trunc(Sum(VALORTOTAL_Atual), 2) AS VALORTOTAL
            /*CASE WHEN TO_CHAR(:DATAINICIO, 'DD/MM/YYYY') >='01/01/2017' THEN trunc(Sum(VALORTOTAL_Atual),2) ELSE trunc(Sum(VALORTOTAL),2) END  AS VALORTOTAL*/
        FROM (
                SELECT CODTMV,
                    (
                        CASE
                            WHEN CODTMV IN (
                                '1.2.02',
                                '1.2.09',
                                '1.2.61',
                                '1.2.63',
                                '1.2.23',
                                '1.2.48'
                            )
                            AND Sum(TRUNC(VALORFINCOMSINAL, 2)) < 0 THEN Trunc(Sum(TOTALENTRADA), 2) *(-1)
                            WHEN CODTMV IN (
                                '1.2.02',
                                '1.2.09',
                                '1.2.61',
                                '1.2.63',
                                '1.2.23',
                                '1.2.48'
                            )
                            AND Sum(TRUNC(VALORFINCOMSINAL, 2)) >= 0 THEN Trunc(Sum(TOTALENTRADA), 2)
                            WHEN CODTMV LIKE '1%'
                            AND CODTMV NOT IN (
                                '1.2.02',
                                '1.2.48',
                                '1.2.09',
                                '1.2.61',
                                '1.2.63',
                                '1.2.23',
                                '1.2.48',
                                '1.1.04',
                                '1.1.43',
                                '1.2.75'
                            )
                            AND Sum(TRUNC(VALORFINCOMSINAL, 2)) < 0 THEN Trunc(Sum(VALORBRUTOITEM), 2) *(-1)
                            WHEN CODTMV LIKE '1%'
                            AND CODTMV NOT IN (
                                '1.2.02',
                                '1.2.48',
                                '1.2.09',
                                '1.2.61',
                                '1.2.63',
                                '1.2.23',
                                '1.2.48',
                                '1.1.04',
                                '1.1.43',
                                '1.2.75'
                            )
                            AND Sum(TRUNC(VALORFINCOMSINAL, 2)) >= 0 THEN Trunc(Sum(VALORBRUTOITEM), 2)
                            WHEN CODTMV IN (
                                '2.2.01',
                                '2.2.02',
                                '2.2.07',
                                '2.2.08',
                                '2.2.09',
                                '2.2.21',
                                '2.2.22',
                                '1.1.04',
                                '2.2.14',
                                '2.2.47',
                                '2.2.51',
                                '2.2.16',
                                '1.1.43',
                                '1.2.75'
                            )
                            AND Sum(TRUNC(VALORFINCOMSINAL, 2)) < 0 THEN Trunc(Sum(TOTALSAIDA), 2) *(-1)
                            WHEN CODTMV IN (
                                '2.2.01',
                                '2.2.02',
                                '2.2.07',
                                '2.2.08',
                                '2.2.09',
                                '2.2.21',
                                '2.2.22',
                                '1.1.04',
                                '2.2.14',
                                '2.2.47',
                                '2.2.51',
                                '2.2.16',
                                '1.1.43',
                                '1.2.75'
                            )
                            AND Sum(TRUNC(VALORFINCOMSINAL, 2)) >= 0 THEN Trunc(Sum(TOTALSAIDA), 2)
                            WHEN CODTMV LIKE '2%'
                            AND CODTMV NOT IN (
                                '2.2.01',
                                '2.2.02',
                                '2.2.07',
                                '2.2.08',
                                '2.2.09',
                                '2.2.21',
                                '2.2.22',
                                '2.2.14',
                                '2.2.47',
                                '2.2.51',
                                '2.2.16'
                            )
                            AND Sum(TRUNC(VALORFINCOMSINAL, 2)) < 0 THEN Trunc(Sum(VALORBRUTOITEM), 2) *(-1)
                            WHEN CODTMV LIKE '2%'
                            AND CODTMV NOT IN (
                                '2.2.01',
                                '2.2.02',
                                '2.2.07',
                                '2.2.08',
                                '2.2.09',
                                '2.2.21',
                                '2.2.22',
                                '2.2.14',
                                '2.2.47',
                                '2.2.51',
                                '2.2.16'
                            )
                            AND Sum(TRUNC(VALORFINCOMSINAL, 2)) >= 0 THEN Trunc(Sum(VALORBRUTOITEM), 2)
                            WHEN CODTMV LIKE '3%'
                            AND Sum(TRUNC(VALORFINCOMSINAL, 2)) < 0 THEN Trunc(Sum(VALORBRUTOITEM), 2) *(-1)
                            WHEN CODTMV LIKE '3%'
                            AND Sum(TRUNC(VALORFINCOMSINAL, 2)) >= 0 THEN Trunc(Sum(VALORBRUTOITEM), 2)
                            WHEN CODTMV IN ('4.1.08', '4.1.01', '4.1.14')
                            AND Sum(TRUNC(VALORFINCOMSINAL, 2)) < 0 THEN Trunc(Sum(VALORBRUTOITEM), 2) *(-1)
                            WHEN CODTMV IN ('4.1.08', '4.1.01', '4.1.14')
                            AND Sum(TRUNC(VALORFINCOMSINAL, 2)) >= 0 THEN Trunc(Sum(VALORBRUTOITEM), 2)
                            WHEN CODTMV IN ('4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17')
                            AND Sum(TRUNC(VALORFINCOMSINAL, 2)) < 0 THEN Trunc(Sum(VALORBRUTOITEM), 2) *(-1)
                            WHEN CODTMV IN ('4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17')
                            AND Sum(TRUNC(VALORFINCOMSINAL, 2)) >= 0 THEN Trunc(Sum(VALORBRUTOITEM), 2)
                            ELSE Sum(VALORBRUTOITEM)
                        END
                    ) AS VALORTOTAL_Atual,
                    CODFILIAL
                FROM (
                        SELECT CODTMV,
                            TPRD.CODIGOPRD,
                            TRELSLD.IDMOV,
                            sum(TRELSLD.VALORFINCOMSINAL) AS VALORFINCOMSINAL,
                            Round(TRELSLD.TOTALSAIDA, 2) AS TOTALSAIDA,
                            Round(TRELSLD.TOTALENTRADA, 2) AS TOTALENTRADA,
                            TITMMOV.VALORBRUTOITEM,
                            QTDESAIDA,
                            CUSTOMEDITEM,
                            TRELSLD.IDPRD,
                            TRELSLD.NSEQITMMOV,
                            tmov.codloc,
                            TMOV.CODFILIAL
                        FROM u_cfl8u4_rm.TRELSLD
                            JOIN u_cfl8u4_rm.TMOV ON (TMOV.IDMOV = TRELSLD.IDMOV)
                            JOIN u_cfl8u4_rm.TITMMOV ON (
                                TITMMOV.IDMOV = TRELSLD.IDMOV
                                AND TITMMOV.IDPRD = TRELSLD.IDPRD
                                AND TITMMOV.NSEQITMMOV = TRELSLD.NSEQITMMOV
                            )
                            JOIN u_cfl8u4_rm.TPRD ON (TRELSLD.IDPRD = TPRD.IDPRD)
                        WHERE
                            /*TRELSLD.DATAMOVIMENTO < '01/01/2020' --TO_CHAR(:DATAINICIO, 'DD/MM/YYYY')*/
                            tmov.DATAMOVIMENTO > '31/12/2019'
                            AND tmov.DATAMOVIMENTO < '01/12/2021'
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
                 
                        GROUP BY CODTMV,
                            TRELSLD.IDPRD,
                            TMOV.IDMOV,
                            TRELSLD.IDPRD,
                            VALORBRUTOITEM,
                            QTDESAIDA,
                            CUSTOMEDITEM,
                            TPRD.CODIGOPRD,
                            TRELSLD.TOTALSAIDA,
                            TRELSLD.TOTALENTRADA,
                            TRELSLD.NSEQITMMOV,
                            TRELSLD.IDMOV,
                            tmov.codloc,
                            TMOV.CODFILIAL
                        ORDER BY CODTMV,
                            idmov,
                            idprd
                    )
                GROUP BY CODTMV,
                    IDMOV,
                    IDPRD,
                    CODFILIAL
            )
        GROUP BY CODFILIAL
    )
GROUP BY CODFILIAL