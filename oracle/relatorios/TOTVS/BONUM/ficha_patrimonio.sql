SELECT icalculopatrimonio.*,
itaxadepreciacao.*/*
    ipatrimonio.codpatrimonio                       AS codigo_bem,
    ipatrimonio.codpatrimonio                       AS codigo_patri,
    ipatrimonio.descricao,
    ipatrimonio.observacoes,
    ipatrimonio.codfornecedor
    || ' - '
    || fcfo.nome                                    AS fornecedor,
    ipatrimonio.numerodocumento                     AS nf,
    igrupopatrimonio.codgrupopatrimonio
    || ' - '
    || igrupopatrimonio.descricao                   AS grup_cont,
    ipatrimonio.codlocal                            AS localizacao,
    ipatrimonio.dataaquisicao,
    ipatrimonio.aquisicao                           AS valor_aqui,
    itaxadepreciacao.datainiciovigencia             dt_depreciacao,
    itaxadepreciacao.valor                          AS taxa_depre,
    isaldocalculopatrimoniomoeda.valorbase,
    isaldocalculopatrimoniomoeda.databasepatrimonio AS dt_base */
FROM
    u_cfl8u4_rm.ipatrimonio
  /*  LEFT JOIN u_cfl8u4_rm.titmmovbem ON ipatrimonio.codpatrimonio = titmmovbem.codbem */
    LEFT JOIN u_cfl8u4_rm.fcfo ON ipatrimonio.codfornecedor = fcfo.codcfo
    LEFT JOIN u_cfl8u4_rm.igrupopatrimonio ON ipatrimonio.idgrupopatrimonio = igrupopatrimonio.idgrupopatrimonio
    LEFT JOIN u_cfl8u4_rm.icalculopatrimonio ON ipatrimonio.idpatrimonio = icalculopatrimonio.idpatrimonio
    LEFT JOIN u_cfl8u4_rm.isaldocalculopatrimoniomoeda ON icalculopatrimonio.idcalculopatrimonio = isaldocalculopatrimoniomoeda.idcalculopatrimonio
    LEFT JOIN u_cfl8u4_rm.itaxadepreciacao ON icalculopatrimonio.idcalculopatrimonio = itaxadepreciacao.idcalculopatrimonio
WHERE
     /*   codpatrimonio = '000.01.001203400'  itaxadepreciacao.idcalculopatrimonio IN (90712) 
    AND */ isaldocalculopatrimoniomoeda.idcalculo = 1