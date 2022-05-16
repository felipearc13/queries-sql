SELECT CODFILIAL,
       CODCONTA,
       DESCRICAO,
       CASE
         WHEN SUM(TOTAL) < 0 THEN SUM(TOTAL)
         ELSE 0
       END AS SAIDAS,
       CASE
         WHEN SUM(TOTAL) > 0 THEN SUM(TOTAL)
         ELSE 0
       END AS ENTRADAS
FROM   (SELECT CODTMV,
               NOME_MOV,
               CODCONTA,
               DESCRICAO,
               TLOC.CODFILIAL         AS CODFILIAL,
               gfilial.nomefantasia   AS NOMEFANTASIA,
               TLOC.CODLOC            AS CODLOC,
               TLOC.NOME              AS NOME,
               NVL(SUM(VALORTOTAL), 0)AS TOTAL
        FROM   (SELECT CODTMV,
                       NOME_MOV,
                       CODCONTA,
                       DESCRICAO,
                       CASE
                         WHEN :DATAINICIO >= '01/01/2017' THEN TRUNC(SUM(VALORTOTAL_Atual), 2)
                         ELSE TRUNC(SUM(VALORTOTAL), 2)
                       END AS VALORTOTAL,                       
                       CODFILIAL,
                       CODLOC
                FROM   (SELECT CODTMV,
                               NOME_MOV,
                               CODCONTA,
                               DESCRICAO,
                               ( CASE
                                   WHEN CODTMV IN ( '1.2.02', '1.2.09', '1.2.61', '1.2.63',
                                                    '1.2.23', '1.2.48' )
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) < 0 THEN TRUNC(SUM(TOTALENTRADA), 2) * ( -1 )
                                   WHEN CODTMV IN ( '1.2.02', '1.2.09', '1.2.61', '1.2.63',
                                                    '1.2.23', '1.2.48' )
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) >= 0 THEN TRUNC(SUM(TOTALENTRADA), 2)
                                   WHEN CODTMV LIKE '1%'
                                        AND CODTMV NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61',
                                                            '1.2.63', '1.2.23', '1.2.48', '1.2.75' )
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) < 0 THEN TRUNC(SUM(VALORBRUTOITEM), 2) * ( -1 )
                                   WHEN CODTMV LIKE '1%'
                                        AND CODTMV NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61',
                                                            '1.2.63', '1.2.23', '1.2.48', '1.2.75' )
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) >= 0 THEN TRUNC(SUM(VALORBRUTOITEM), 2)
                                   WHEN CODTMV IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                    '2.2.09', '2.2.21', '2.2.22', '2.2.47' )
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) < 0 THEN TRUNC(SUM(TOTALSAIDA), 2) * ( -1 )
                                   WHEN CODTMV IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                    '2.2.09', '2.2.21', '2.2.22', '2.2.47' )
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) >= 0 THEN TRUNC(SUM(TOTALSAIDA), 2)
                                   WHEN CODTMV LIKE '2%'
                                        AND CODTMV NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                            '2.2.09', '2.2.21', '2.2.22', '2.2.47' )
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) < 0 THEN TRUNC(SUM(VALORBRUTOITEM), 2) * ( -1 )
                                   WHEN CODTMV LIKE '2%'
                                        AND CODTMV NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                            '2.2.09', '2.2.21', '2.2.22', '2.2.47' )
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) >= 0 THEN TRUNC(SUM(VALORBRUTOITEM), 2)
                                   WHEN CODTMV LIKE '3%'
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) < 0 THEN TRUNC(SUM(VALORBRUTOITEM), 2) * ( -1 )
                                   WHEN CODTMV LIKE '3%'
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) >= 0 THEN TRUNC(SUM(VALORBRUTOITEM), 2)
                                   WHEN CODTMV IN ( '4.1.08', '4.1.01', '4.1.14' )
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) < 0 THEN TRUNC(SUM(VALORBRUTOITEM), 2) * ( -1 )
                                   WHEN CODTMV IN ( '4.1.08', '4.1.01', '4.1.14' )
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) >= 0 THEN TRUNC(SUM(VALORBRUTOITEM), 2)
                                   WHEN CODTMV IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17' )
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) < 0 THEN TRUNC(SUM(VALORBRUTOITEM), 2) * ( -1 )
                                   WHEN CODTMV IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17' )
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) >= 0 THEN TRUNC(SUM(VALORBRUTOITEM), 2)
                                   ELSE SUM(VALORBRUTOITEM)
                                 END ) AS VALORTOTAL,
                               ( CASE
                                   WHEN CODTMV IN ( '1.2.02', '1.2.09', '1.2.61', '1.2.63',
                                                    '1.2.23', '1.2.48' )
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) < 0 THEN TRUNC(SUM(TOTALENTRADA), 2) * ( -1 )
                                   WHEN CODTMV IN ( '1.2.02', '1.2.09', '1.2.61', '1.2.63',
                                                    '1.2.23', '1.2.48' )
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) >= 0 THEN TRUNC(SUM(TOTALENTRADA), 2)
                                   WHEN CODTMV LIKE '1%'
                                        AND CODTMV NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61',
                                                            '1.2.63', '1.2.23', '1.2.48', '1.1.04',
                                                            '1.1.43', '1.2.75' )
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) < 0 THEN TRUNC(SUM(VALORBRUTOITEM), 2) * ( -1 )
                                   WHEN CODTMV LIKE '1%'
                                        AND CODTMV NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61',
                                                            '1.2.63', '1.2.23', '1.2.48', '1.1.04',
                                                            '1.1.43', '1.2.75' )
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) >= 0 THEN TRUNC(SUM(VALORBRUTOITEM), 2)
                                   WHEN CODTMV IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                    '2.2.09', '2.2.21', '2.2.22', '1.1.04',
                                                    '2.2.14', '2.2.47', '2.2.51', '2.2.16',
                                                    '1.1.43', '1.2.75' )
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) < 0 THEN TRUNC(SUM(TOTALSAIDA), 2) * ( -1 )
                                   WHEN CODTMV IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                    '2.2.09', '2.2.21', '2.2.22', '1.1.04',
                                                    '2.2.14', '2.2.47', '2.2.51', '2.2.16',
                                                    '1.1.43', '1.2.75' )
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) >= 0 THEN TRUNC(SUM(TOTALSAIDA), 2)
                                   WHEN CODTMV LIKE '2%'
                                        AND CODTMV NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                            '2.2.09', '2.2.21', '2.2.22', '2.2.14',
                                                            '2.2.47', '2.2.51', '2.2.16' )
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) < 0 THEN TRUNC(SUM(VALORBRUTOITEM), 2) * ( -1 )
                                   WHEN CODTMV LIKE '2%'
                                        AND CODTMV NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                            '2.2.09', '2.2.21', '2.2.22', '2.2.14',
                                                            '2.2.47', '2.2.51', '2.2.16' )
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) >= 0 THEN TRUNC(SUM(VALORBRUTOITEM), 2)
                                   WHEN CODTMV LIKE '3%'
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) < 0 THEN TRUNC(SUM(VALORBRUTOITEM), 2) * ( -1 )
                                   WHEN CODTMV LIKE '3%'
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) >= 0 THEN TRUNC(SUM(VALORBRUTOITEM), 2)
                                   WHEN CODTMV IN ( '4.1.08', '4.1.01', '4.1.14' )
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) < 0 THEN TRUNC(SUM(VALORBRUTOITEM), 2) * ( -1 )
                                   WHEN CODTMV IN ( '4.1.08', '4.1.01', '4.1.14' )
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) >= 0 THEN TRUNC(SUM(VALORBRUTOITEM), 2)
                                   WHEN CODTMV IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17' )
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) < 0 THEN TRUNC(SUM(VALORBRUTOITEM), 2) * ( -1 )
                                   WHEN CODTMV IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17' )
                                        AND SUM(TRUNC(VALORFINCOMSINAL, 2)) >= 0 THEN TRUNC(SUM(VALORBRUTOITEM), 2)
                                   ELSE SUM(VALORBRUTOITEM)
                                 END ) AS VALORTOTAL_Atual,
                               CODFILIAL,
                               CODLOC
                        FROM   (SELECT TMOV.CODTMV,
                                       TTMV.NOME                     AS NOME_MOV,
                                       CCONTA.CODCONTA,
                                       CCONTA.DESCRICAO,
                                       TPRD.CODIGOPRD,
                                       TRELSLD.IDMOV,
                                       SUM(TRELSLD.VALORFINCOMSINAL) AS VALORFINCOMSINAL,
                                       ROUND(TRELSLD.TOTALSAIDA, 2)  AS TOTALSAIDA,
                                       ROUND(TRELSLD.TOTALENTRADA, 2)AS TOTALENTRADA,
                                       TITMMOV.VALORBRUTOITEM,
                                       QTDESAIDA,
                                       CUSTOMEDITEM,
                                       TRELSLD.IDPRD,
                                       TRELSLD.NSEQITMMOV,
                                       TRELSLD.CODLOC,
                                       TMOV.CODFILIAL
                                FROM   U_CFL8U4_RM.TRELSLD
                                       LEFT JOIN U_CFL8U4_RM.TMOV
                                              ON TRELSLD.IDMOV = TMOV.IDMOV
                                       LEFT JOIN U_CFL8U4_RM.TITMMOV
                                              ON TITMMOV.IDMOV = TRELSLD.IDMOV
                                                 AND TITMMOV.IDPRD = TRELSLD.IDPRD
                                                 AND TITMMOV.NSEQITMMOV = TRELSLD.NSEQITMMOV
                                       LEFT JOIN U_CFL8U4_RM.TPRD
                                              ON TRELSLD.IDPRD = TPRD.IDPRD
                                       /* RIGHT JOIN U_CFL8U4_RM.TTB4
                                                ON TTB4.CODTB4FAT = TITMMOV.CODTB4FAT */
                                       RIGHT JOIN U_CFL8U4_RM.TTB4
                                               ON TTB4.CODTB4FAT = TPRD.CODTB4FAT
                                       RIGHT JOIN U_CFL8U4_RM.TTB4CONT
                                               ON TTB4CONT.CODTB4FAT = TTB4.CODTB4FAT
                                       RIGHT JOIN U_CFL8U4_RM.CCONTA
                                               ON CCONTA.CODCONTA = TTB4CONT.CODCONTA
                                       RIGHT JOIN U_CFL8U4_RM.GFILIAL
                                               ON GFILIAL.CODCOLIGADA = TMOV.CODCOLIGADA
                                                  AND GFILIAL.CODFILIAL = TMOV.CODFILIAL
                                       RIGHT JOIN U_CFL8U4_RM.TLOC
                                               ON TLOC.CODCOLIGADA = TRELSLD.CODCOLIGADA
                                                  AND TLOC.CODFILIAL = TRELSLD.CODFILIAL
                                                  AND TLOC.CODLOC = TRELSLD.CODLOC
                                       RIGHT JOIN U_CFL8U4_RM.TTMV
                                               ON TTMV.CODTMV = TMOV.CODTMV
                                WHERE  TRELSLD.DATAMOVIMENTO >= :DATAINICIO
                                       AND TRELSLD.DATAMOVIMENTO <= :DATAFIM
                                       AND TRELSLD.CODLOC >= :CODLOC_INICIAL
                                       AND TRELSLD.CODLOC <= :CODLOC_FINAL
                                       AND TRELSLD.CODFILIAL >= :CODFILIAL_INICIAL
                                       AND TRELSLD.CODFILIAL <= :CODFILIAL_FINAL
                                       AND TRELSLD.saldo = 2
                                       AND TMOV.CODTMV NOT IN ( '1.1.18', '1.1.19' )
                                       AND TTB4CONT.CLASSCONTA = 'ESTOQUE'
                                GROUP  BY TMOV.CODTMV,
                                          TTMV.NOME,
                                          CCONTA.CODCONTA,
                                          CCONTA.DESCRICAO,
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
                                          TRELSLD.CODLOC,
                                          TMOV.CODFILIAL
                                ORDER  BY TMOV.CODTMV,
                                          TMOV.IDMOV,
                                          CCONTA.CODCONTA,
                                          CCONTA.DESCRICAO,
                                          IDPRD)
                        GROUP  BY CODTMV,
                                  NOME_MOV,
                                  IDMOV,
                                  CODCONTA,
                                  DESCRICAO,
                                  IDPRD,
                                  CODFILIAL,
                                  CODLOC)
                GROUP  BY CODTMV,
                          NOME_MOV,
                          CODCONTA,
                          DESCRICAO,
                          CODFILIAL,
                          CODLOC

                UNION
                (SELECT TMOV.CODTMV,
                        TTMV.NOME AS NOME_MOV,
                        CCONTA.CODCONTA,
                        CCONTA.DESCRICAO,
                        TRUNC(NVL(SUM(VALORBRUTOITEM), 0), 2) * ( -1 ),
                        TMOV.CODFILIAL,
                        TMOV.CODLOC
                 FROM   U_CFL8U4_RM.TMOV
                        JOIN U_CFL8U4_RM.TITMMOV
                          ON TMOV.IDMOV = TITMMOV.IDMOV
                        RIGHT JOIN U_CFL8U4_RM.TPRD
                                ON TPRD.IDPRD = TITMMOV.IDPRD
                        RIGHT JOIN U_CFL8U4_RM.TTB4
                                ON TTB4.CODTB4FAT = TPRD.CODTB4FAT
                        RIGHT JOIN U_CFL8U4_RM.TTB4CONT
                                ON TTB4CONT.CODTB4FAT = TTB4.CODTB4FAT
                        RIGHT JOIN U_CFL8U4_RM.CCONTA
                                ON CCONTA.CODCONTA = TTB4CONT.CODCONTA
                        RIGHT JOIN U_CFL8U4_RM.TTMV
                                ON TTMV.CODTMV = TMOV.CODTMV
                 WHERE  TMOV.CODTMV IN ( '4.1.03' )
                        AND TMOV.DATAMOVIMENTO >= :DATAINICIO
                        AND TMOV.DATAMOVIMENTO <= :DATAFIM
                        AND TMOV.CODLOC >= :CODLOC_INICIAL
                        AND TMOV.CODLOC <= :CODLOC_FINAL
                        AND TMOV.CODFILIAL >= :CODFILIAL_INICIAL
                        AND TMOV.CODFILIAL <= :CODFILIAL_FINAL
                        AND TMOV.STATUS <> 'C'
                        AND TTB4CONT.CLASSCONTA = 'ESTOQUE'
                 GROUP  BY TMOV.CODTMV,
                           TTMV.NOME,
                           CCONTA.CODCONTA,
                           CCONTA.DESCRICAO,
                           TMOV.CODFILIAL,
                           TMOV.CODLOC)

                UNION
                (SELECT TMOV.CODTMV,
                        TTMV.NOME AS NOME_MOV,
                        CCONTA.CODCONTA,
                        CCONTA.DESCRICAO,
                        TRUNC(NVL(SUM(VALORBRUTOITEM), 0), 2),
                        TMOV.CODFILIAL,
                        TMOV.CODLOC
                 FROM   U_CFL8U4_RM.TMOV
                        JOIN U_CFL8U4_RM.TITMMOV
                          ON TMOV.IDMOV = TITMMOV.IDMOV
                        RIGHT JOIN U_CFL8U4_RM.TPRD
                                ON TPRD.IDPRD = TITMMOV.IDPRD
                        RIGHT JOIN U_CFL8U4_RM.TTB4
                                ON TTB4.CODTB4FAT = TPRD.CODTB4FAT
                        RIGHT JOIN U_CFL8U4_RM.TTB4CONT
                                ON TTB4CONT.CODTB4FAT = TTB4.CODTB4FAT
                        RIGHT JOIN U_CFL8U4_RM.CCONTA
                                ON CCONTA.CODCONTA = TTB4CONT.CODCONTA
                        RIGHT JOIN U_CFL8U4_RM.TTMV
                                ON TTMV.CODTMV = TMOV.CODTMV
                 WHERE  TMOV.CODTMV IN ( '4.1.04' )
                        AND TMOV.DATAMOVIMENTO >= :DATAINICIO
                        AND TMOV.DATAMOVIMENTO <= :DATAFIM
                        AND TMOV.CODLOC >= :CODLOC_INICIAL
                        AND TMOV.CODLOC <= :CODLOC_FINAL
                        AND TMOV.CODFILIAL >= :CODFILIAL_INICIAL
                        AND TMOV.CODFILIAL <= :CODFILIAL_FINAL
                        AND TTB4CONT.CLASSCONTA = 'ESTOQUE'
                 GROUP  BY TMOV.CODTMV,
                           TTMV.NOME,
                           CCONTA.CODCONTA,
                           CCONTA.DESCRICAO,
                           TMOV.CODFILIAL,
                           TMOV.CODLOC)) TABELA
               RIGHT JOIN U_CFL8U4_RM.TLOC
                       ON TLOC.CODFILIAL = TABELA.CODFILIAL
                          AND TLOC.CODLOC = TABELA.CODLOC
               LEFT JOIN U_CFL8U4_RM.GFILIAL
                      ON TLOC.CODFILIAL = GFILIAL.CODFILIAL
        WHERE  LENGTH(TLOC.CODLOC) = 9
        GROUP  BY TLOC.CODFILIAL,
                  gfilial.nomefantasia,
                  CODTMV,
                  NOME_MOV,
                  CODCONTA,
                  DESCRICAO,
                  TLOC.CODLOC,
                  TLOC.NOME
        ORDER  BY TLOC.CODFILIAL,
                  TLOC.CODLOC,
                  CODTMV,
                  CODCONTA,
                  DESCRICAO) TABELA2
WHERE  CODCONTA IS NOT NULL
GROUP  BY CODFILIAL,
          CODCONTA,
          DESCRICAO
ORDER  BY CODFILIAL,
          CODCONTA 
