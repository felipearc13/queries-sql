SELECT
    pffinanc.codevento,
    pevento.descricao,
    SUM(pffinanc.valor)
FROM
    u_cfl8u4_rm.pffinanc
    LEFT JOIN u_cfl8u4_rm.pevento ON pffinanc.codevento = pevento.codigo
    LEFT JOIN u_cfl8u4_rm.pfunc ON pffinanc.chapa = pfunc.chapa
    LEFT JOIN u_cfl8u4_rm.psecao ON pfunc.codsecao = psecao.codigo
WHERE
    /*    chapa = '012329'
    AND nroperiodo = 3 
    AND */
    nroperiodo BETWEEN :periodo_1 AND :periodo_2
    AND anocomp = 2022 /*ano*/
    AND mescomp = 4 /*mes*/
    AND pfunc.codsecao LIKE :secao || '%'
    AND pffinanc.valor <> 0
    AND provdescbase = 'P'
GROUP BY
    pffinanc.codevento,
    pevento.descricao
ORDER BY
    pffinanc.codevento