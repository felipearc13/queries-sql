SELECT codfilial,
       nomefantasia,
       codloc,
       nome,
       descricao,
       NVL(SUM(baixa), 0)           AS baixas,
       NVL(SUM(trasf_saida), 0)     AS transf_saida,
       NVL(SUM(vendas), 0)          AS vendas,
       NVL(SUM(outras_saidas), 0)   AS outras_saidas,
       NVL(SUM(outras_entradas), 0) AS outras_entradas,
       NVL(SUM(compras), 0)         AS compras,
       NVL(SUM(transferencia), 0)   AS transf_entrada
FROM   (SELECT codconta,
               descricao,
               tloc.codfilial,
               gfilial.nomefantasia,
               tloc.codloc,
               tloc.nome,
               CASE
                 WHEN codtmv IN ( '1.1.04', '1.1.20', '1.1.24', '1.1.41' ) THEN NVL(SUM(valortotal), 0)
               END AS baixa,
               CASE
                 WHEN codtmv = '2.2.16' THEN NVL(SUM(valortotal), 0)
               END AS trasf_saida,
               CASE
                 WHEN codtmv IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.21',
                                  '2.2.47', '2.2.51', '2.2.54' ) THEN NVL(SUM(valortotal), 0)
               END AS vendas,
               CASE
                 WHEN codtmv IN ( '2.2.09', '2.2.14', '4.1.02', '4.1.09',
                                  '4.1.14', '4.1.16' ) THEN NVL(SUM(valortotal), 0)
               END AS outras_saidas,
               CASE
                 WHEN codtmv IN ( '1.1.13', '1.1.21', '1.1.22', '1.1.40',
                                  '1.2.09', '1.2.41', '1.2.48', '1.2.51',
                                  '1.2.61', '1.2.63', '1.2.72', '1.2.75',
                                  '4.1.01', '4.1.08', '4.1.13', '4.1.15' ) THEN NVL(SUM(valortotal), 0)
               END AS outras_entradas,
               CASE
                 WHEN codtmv IN ( '1.2.02', '1.2.07', '1.2.23', '1.2.24',
                                  '1.2.28', '1.2.29', '1.2.17' ) THEN NVL(SUM(valortotal), 0)
               END AS compras,
               CASE
                 WHEN codtmv IN ( '1.2.17' ) THEN NVL(SUM(valortotal), 0)
               END AS transferencia
        FROM   (SELECT codtmv,
                       nome_mov,
                       codconta,
                       descricao,
                       CASE
                       /* WHEN '01/12/2021' >= '01/01/2017'*/
                         WHEN :DATAINICIO >= '01/01/2017' THEN TRUNC(SUM(valortotal_atual), 2)
                         ELSE TRUNC(SUM(valortotal), 2)
                       END AS valortotal,
                       codfilial,
                       codloc
                FROM   (SELECT codtmv,
                               nome_mov,
                               codconta,
                               descricao,
                               ( CASE
                                   WHEN codtmv IN ( '1.2.02', '1.2.09', '1.2.61', '1.2.63',
                                                    '1.2.23', '1.2.48' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(totalentrada), 2) * ( -1 )
                                   WHEN codtmv IN ( '1.2.02', '1.2.09', '1.2.61', '1.2.63',
                                                    '1.2.23', '1.2.48' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(totalentrada), 2)
                                   WHEN codtmv LIKE '1%'
                                        AND codtmv NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61',
                                                            '1.2.63', '1.2.23', '1.2.48', '1.2.75' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(valorbrutoitem), 2) * ( -1 )
                                   WHEN codtmv LIKE '1%'
                                        AND codtmv NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61',
                                                            '1.2.63', '1.2.23', '1.2.48', '1.2.75' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(valorbrutoitem), 2)
                                   WHEN codtmv IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                    '2.2.09', '2.2.21', '2.2.22', '2.2.47' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(totalsaida), 2) * ( -1 )
                                   WHEN codtmv IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                    '2.2.09', '2.2.21', '2.2.22', '2.2.47' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(totalsaida), 2)
                                   WHEN codtmv LIKE '2%'
                                        AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                            '2.2.09', '2.2.21', '2.2.22', '2.2.47' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(valorbrutoitem), 2) * ( -1 )
                                   WHEN codtmv LIKE '2%'
                                        AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                            '2.2.09', '2.2.21', '2.2.22', '2.2.47' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(valorbrutoitem), 2)
                                   WHEN codtmv LIKE '3%'
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(valorbrutoitem), 2) * ( -1 )
                                   WHEN codtmv LIKE '3%'
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(valorbrutoitem), 2)
                                   WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(valorbrutoitem), 2) * ( -1 )
                                   WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(valorbrutoitem), 2)
                                   WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(valorbrutoitem), 2) * ( -1 )
                                   WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(valorbrutoitem), 2)
                                   ELSE SUM(valorbrutoitem)
                                 END ) AS valortotal,
                               ( CASE
                                   WHEN codtmv IN ( '1.2.02', '1.2.09', '1.2.61', '1.2.63',
                                                    '1.2.23', '1.2.48' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(totalentrada), 2) * ( -1 )
                                   WHEN codtmv IN ( '1.2.02', '1.2.09', '1.2.61', '1.2.63',
                                                    '1.2.23', '1.2.48' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(totalentrada), 2)
                                   WHEN codtmv LIKE '1%'
                                        AND codtmv NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61',
                                                            '1.2.63', '1.2.23', '1.2.48', '1.1.04',
                                                            '1.1.43', '1.2.75' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(valorbrutoitem), 2) * ( -1 )
                                   WHEN codtmv LIKE '1%'
                                        AND codtmv NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61',
                                                            '1.2.63', '1.2.23', '1.2.48', '1.1.04',
                                                            '1.1.43', '1.2.75' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(valorbrutoitem), 2)
                                   WHEN codtmv IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                    '2.2.09', '2.2.21', '2.2.22', '1.1.04',
                                                    '2.2.14', '2.2.47', '2.2.51', '2.2.16',
                                                    '1.1.43', '1.2.75' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(totalsaida), 2) * ( -1 )
                                   WHEN codtmv IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                    '2.2.09', '2.2.21', '2.2.22', '1.1.04',
                                                    '2.2.14', '2.2.47', '2.2.51', '2.2.16',
                                                    '1.1.43', '1.2.75' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(totalsaida), 2)
                                   WHEN codtmv LIKE '2%'
                                        AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                            '2.2.09', '2.2.21', '2.2.22', '2.2.14',
                                                            '2.2.47', '2.2.51', '2.2.16' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(valorbrutoitem), 2) * ( -1 )
                                   WHEN codtmv LIKE '2%'
                                        AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                            '2.2.09', '2.2.21', '2.2.22', '2.2.14',
                                                            '2.2.47', '2.2.51', '2.2.16' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(valorbrutoitem), 2)
                                   WHEN codtmv LIKE '3%'
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(valorbrutoitem), 2) * ( -1 )
                                   WHEN codtmv LIKE '3%'
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(valorbrutoitem), 2)
                                   WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(valorbrutoitem), 2) * ( -1 )
                                   WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(valorbrutoitem), 2)
                                   WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(valorbrutoitem), 2) * ( -1 )
                                   WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(valorbrutoitem), 2)
                                   ELSE SUM(valorbrutoitem)
                                 END ) AS valortotal_atual,
                               codfilial,
                               codloc
                        FROM   (SELECT tmov.codtmv,
                                       ttmv.nome                      AS nome_mov,
                                       cconta.codconta,
                                       cconta.descricao,
                                       tprd.codigoprd,
                                       trelsld.idmov,
                                       SUM(trelsld.valorfincomsinal)  AS valorfincomsinal,
                                       ROUND(trelsld.totalsaida, 2)   AS totalsaida,
                                       ROUND(trelsld.totalentrada, 2) AS totalentrada,
                                       titmmov.valorbrutoitem,
                                       qtdesaida,
                                       customeditem,
                                       trelsld.idprd,
                                       trelsld.nseqitmmov,
                                       trelsld.codloc,
                                       tmov.codfilial
                                FROM   U_CFL8U4_RM.trelsld
                                       LEFT JOIN U_CFL8U4_RM.tmov
                                              ON trelsld.idmov = tmov.idmov
                                       LEFT JOIN U_CFL8U4_RM.titmmov
                                              ON titmmov.idmov = trelsld.idmov
                                                 AND titmmov.idprd = trelsld.idprd
                                                 AND titmmov.nseqitmmov = trelsld.nseqitmmov
                                       LEFT JOIN U_CFL8U4_RM.tprd
                                              ON trelsld.idprd = tprd.idprd
                                       /* RIGHT JOIN U_CFL8U4_RM.TTB4
                                        ON TTB4.CODTB4FAT = TITMMOV.CODTB4FAT */
                                       RIGHT JOIN U_CFL8U4_RM.ttb4
                                               ON ttb4.codtb4fat = tprd.codtb4fat
                                       RIGHT JOIN U_CFL8U4_RM.ttb4cont
                                               ON ttb4cont.codtb4fat = ttb4.codtb4fat
                                       RIGHT JOIN U_CFL8U4_RM.cconta
                                               ON cconta.codconta = ttb4cont.codconta
                                       RIGHT JOIN U_CFL8U4_RM.gfilial
                                               ON gfilial.codcoligada = tmov.codcoligada
                                                  AND gfilial.codfilial = tmov.codfilial
                                       RIGHT JOIN U_CFL8U4_RM.tloc
                                               ON tloc.codcoligada = trelsld.codcoligada
                                                  AND tloc.codfilial = trelsld.codfilial
                                                  AND tloc.codloc = trelsld.codloc
                                       RIGHT JOIN U_CFL8U4_RM.ttmv
                                               ON ttmv.codtmv = tmov.codtmv
                                WHERE  TRELSLD.DATAMOVIMENTO >= :DATAINICIO
                                       AND TRELSLD.DATAMOVIMENTO <= :DATAFIM
                                       AND TRELSLD.CODLOC >= :CODLOC_INICIAL
                                       AND TRELSLD.CODLOC <= :CODLOC_FINAL
                                       AND TRELSLD.CODFILIAL >= :CODFILIAL_INICIAL
                                       AND TRELSLD.CODFILIAL <= :CODFILIAL_FINAL
                                       /* WHERE  trelsld.datamovimento >= '01/01/2021'
                                              AND trelsld.datamovimento <= '31/12/2021'
                                              AND trelsld.codloc >= '01.001.01'
                                              AND trelsld.codloc <= '99.999.99'
                                              AND trelsld.codfilial >= 1
                                              AND trelsld.codfilial <= 20 */
                                       AND trelsld.saldo = 2
                                       AND tmov.codtmv IN ( '1.1.04', '1.1.13', '1.1.20', '1.1.21',
                                                            '1.1.22', '1.1.24', '1.1.40', '1.1.41',
                                                            '1.2.02', '1.2.07', '1.2.09', '1.2.17',
                                                            '1.2.23', '1.2.24', '1.2.28', '1.2.29',
                                                            '1.2.41', '1.2.48', '1.2.51', '1.2.61',
                                                            '1.2.63', '1.2.72', '1.2.75', '2.2.01',
                                                            '2.2.07', '2.2.08', '2.2.09', '2.2.14',
                                                            '2.2.16', '2.2.21', '2.2.47', '2.2.51',
                                                            '2.2.54', '4.1.01', '4.1.02', '4.1.08',
                                                            '4.1.09', '4.1.13', '4.1.14', '4.1.15', '4.1.16' )
                                       AND ttb4cont.classconta = 'ESTOQUE'
                                GROUP  BY tmov.codtmv,
                                          ttmv.nome,
                                          cconta.codconta,
                                          cconta.descricao,
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
                                ORDER  BY tmov.codtmv,
                                          tmov.idmov,
                                          cconta.codconta,
                                          cconta.descricao,
                                          idprd)
                        GROUP  BY codtmv,
                                  nome_mov,
                                  idmov,
                                  codconta,
                                  descricao,
                                  idprd,
                                  codfilial,
                                  codloc)
                GROUP  BY codtmv,
                          nome_mov,
                          codconta,
                          descricao,
                          codfilial,
                          codloc) tabela
               RIGHT JOIN U_CFL8U4_RM.tloc
                       ON tloc.codfilial = tabela.codfilial
                          AND tloc.codloc = tabela.codloc
               LEFT JOIN U_CFL8U4_RM.gfilial
                      ON tloc.codfilial = gfilial.codfilial
        WHERE  LENGTH(tloc.codloc) = 9
        GROUP  BY tloc.codfilial,
                  gfilial.nomefantasia,
                  codtmv,
                  nome_mov,
                  codconta,
                  descricao,
                  tloc.codloc,
                  tloc.nome)
WHERE  descricao IS NOT NULL
GROUP  BY codfilial,
          nomefantasia,
          codloc,
          nome,
          descricao
ORDER  BY codfilial,
          nomefantasia,
          codloc,
          nome,
          descricao

/*SELECT CODTMV,
       NOME_MOV,
       CODCONTA,
       DESCRICAO,
       TLOC.CODFILIAL,
       gfilial.nomefantasia,
       TLOC.CODLOC,
       TLOC.NOME,
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
          DESCRICAO */
