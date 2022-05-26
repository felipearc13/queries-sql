SELECT /* CODTMV,
       NOME_MOV,*/
    codconta,
    descricao,
    tloc.codfilial,
    gfilial.nomefantasia,
    tloc.codloc,
    tloc.nome,
    CASE
        WHEN codtmv IN ( '1.1.04', '1.1.20', '1.1.24', '1.1.41' ) THEN
            nvl(SUM(valortotal), 0)
    END AS baixa,
    CASE
        WHEN codtmv = '2.2.16' THEN
            nvl(SUM(valortotal), 0)
    END AS trasf_saida,
    CASE
        WHEN codtmv IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.21', '2.2.47 ',
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
            codtmv,
            nome_mov,
            codconta,
            descricao,
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
                    nome_mov,
                    codconta,
                    descricao,
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
                            tmov.codtmv,
                            ttmv.nome                      AS nome_mov,
                            cconta.codconta,
                            cconta.descricao,
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
                            trelsld.codloc,
                            tmov.codfilial
                        FROM
                            u_cfl8u4_rm.trelsld
                            LEFT JOIN u_cfl8u4_rm.tmov ON trelsld.idmov = tmov.idmov
                            LEFT JOIN u_cfl8u4_rm.titmmov ON titmmov.idmov = trelsld.idmov
                                                             AND titmmov.idprd = trelsld.idprd
                                                             AND titmmov.nseqitmmov = trelsld.nseqitmmov
                            LEFT JOIN u_cfl8u4_rm.tprd ON trelsld.idprd = tprd.idprd
                               /* RIGHT JOIN U_CFL8U4_RM.TTB4
                                        ON TTB4.CODTB4FAT = TITMMOV.CODTB4FAT */
                            RIGHT JOIN u_cfl8u4_rm.ttb4 ON ttb4.codtb4fat = tprd.codtb4fat
                            RIGHT JOIN u_cfl8u4_rm.ttb4cont ON ttb4cont.codtb4fat = ttb4.codtb4fat
                            RIGHT JOIN u_cfl8u4_rm.cconta ON cconta.codconta = ttb4cont.codconta
                            RIGHT JOIN u_cfl8u4_rm.gfilial ON gfilial.codcoligada = tmov.codcoligada
                                                              AND gfilial.codfilial = tmov.codfilial
                            RIGHT JOIN u_cfl8u4_rm.tloc ON tloc.codcoligada = trelsld.codcoligada
                                                           AND tloc.codfilial = trelsld.codfilial
                                                           AND tloc.codloc = trelsld.codloc
                            RIGHT JOIN u_cfl8u4_rm.ttmv ON ttmv.codtmv = tmov.codtmv
                        WHERE
                                trelsld.datamovimento >= :datainicio
                            AND trelsld.datamovimento <= :datafim
                            AND trelsld.codloc >= :codloc_inicial
                            AND trelsld.codloc <= :codloc_final
                            AND trelsld.codfilial >= :codfilial_inicial
                            AND trelsld.codfilial <= :codfilial_final
                            AND trelsld.saldo = 2
                            AND tmov.codtmv NOT IN ( '1.1.18', '1.1.19' )
                            AND ttb4cont.classconta = 'ESTOQUE'
                        GROUP BY
                            tmov.codtmv,
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
                        ORDER BY
                            tmov.codtmv,
                            tmov.idmov,
                            cconta.codconta,
                            cconta.descricao,
                            idprd
                    )
                GROUP BY
                    codtmv,
                    nome_mov,
                    idmov,
                    codconta,
                    descricao,
                    idprd,
                    codfilial,
                    codloc
            )
        GROUP BY
            codtmv,
            nome_mov,
            codconta,
            descricao,
            codfilial,
            codloc
    ) tabela
    RIGHT JOIN u_cfl8u4_rm.tloc ON tloc.codfilial = tabela.codfilial
                                   AND tloc.codloc = tabela.codloc
    LEFT JOIN u_cfl8u4_rm.gfilial ON tloc.codfilial = gfilial.codfilial
WHERE
    length(tloc.codloc) = 9
GROUP BY
    tloc.codfilial,
    gfilial.nomefantasia,
    codtmv,
    nome_mov,
    codconta,
    descricao,
    tloc.codloc,
    tloc.nome
ORDER BY
    tloc.codfilial,
    descricao,
    tloc.codloc,
    codtmv,
    codconta