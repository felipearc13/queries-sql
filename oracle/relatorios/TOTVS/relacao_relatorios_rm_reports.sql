SELECT
    rrptreport.codaplicacao     AS aplicacao,
    gsistema.nomesistema,
    gsistema.descricao,
    rrptreport.codigo,
    rrptreport.descricao,
    rrptreport.tipo,
    rrptreport.datacriacao,
    rrptreport.dataultalteracao AS dt_alteracao,
    rrptreport.usrultalteracao  AS usr_alteracao,
    rrptreport.recgeneratedon   AS dt_geracao,
    rrptreport.recgeneratedby   AS usr_geracao
FROM
    u_cfl8u4_rm.rrptreport
    LEFT JOIN u_cfl8u4_rm.gsistema ON rrptreport.codaplicacao = gsistema.codsistema
ORDER BY
    rrptreport.codaplicacao,
    rrptreport.codigo,
    rrptreport.descricao
