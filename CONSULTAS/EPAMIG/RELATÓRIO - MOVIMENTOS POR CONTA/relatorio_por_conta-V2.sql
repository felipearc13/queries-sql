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
    /*AND TMOV.CODTMV IN ('1.1.04', '1.1.20', '1.1.24', '1.1.41')*/
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