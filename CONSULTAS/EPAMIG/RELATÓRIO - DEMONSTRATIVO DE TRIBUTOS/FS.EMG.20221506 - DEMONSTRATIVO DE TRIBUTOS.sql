SELECT
    tmov.datasaida,
    tmov.codfilial,
    tmov.numeromov,
    ttrbmov.codtrb    AS codtributo,
    ttrbmov.basedecalculo,
    ttrbmov.aliquota,
    ttrbmov.valor,
    fcfo.nome,
    fcfo.cgccfo       AS cnpj,
    titmmov.codccusto AS centro_custo
FROM
    u_cfl8u4_rm.ttrbmov
    LEFT JOIN u_cfl8u4_rm.tmov ON ttrbmov.idmov = tmov.idmov
    LEFT JOIN u_cfl8u4_rm.fcfo ON tmov.codcfo = fcfo.codcfo
    LEFT JOIN u_cfl8u4_rm.titmmov ON tmov.idmov = titmmov.idmov
WHERE
        tmov.datasaida >= :data_inicial
    AND tmov.datasaida <= :data_final
    AND tmov.codfilial >= :filial_inicial
    AND tmov.codfilial <= :filial_final
    AND ttrbmov.codtrb LIKE :codtributo
    AND ttrbmov.valor <> 0
    AND tmov.codtmv NOT LIKE '2%'
ORDER BY
    tmov.codfilial,
    tmov.datasaida,
    tmov.numeromov,
    ttrbmov.codtrb,
    ttrbmov.basedecalculo,
    ttrbmov.aliquota,
    ttrbmov.valor,
    fcfo.nome,
    fcfo.cgccfo,
    titmmov.codccusto



    git config --global user.name "felipearc13"
$ git config --global user.email felipesilva1302@gmail.com