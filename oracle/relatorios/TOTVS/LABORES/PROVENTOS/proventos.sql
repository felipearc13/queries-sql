FROM
    u_cfl8u4_rm.pffinanc
    LEFT JOIN u_cfl8u4_rm.pevento ON pffinanc.codevento = pevento.codigo
WHERE
        chapa = '012329'
    AND nroperiodo = 3
    AND anocomp = 2022
    AND mescomp = 4
    AND provdescbase = 'P'