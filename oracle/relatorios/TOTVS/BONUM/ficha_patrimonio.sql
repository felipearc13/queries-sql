SELECT
    titmmovbem.codbem,
    ipatrimonio.descricao,
    ipatrimonio.observacoes,
    ipatrimonio.codfornecedor
    || ' - '
    || fcfo.nome    AS fornecedor,
    ipatrimonio.numerodocumento AS nf,
    ipatrimonio.dataaquisicao,
    ipatrimonio.aquisicao       AS valor
FROM
    u_cfl8u4_rm.ipatrimonio
    LEFT JOIN u_cfl8u4_rm.titmmovbem ON ipatrimonio.codpatrimonio = titmmovbem.codbem
    LEFT JOIN u_cfl8u4_rm.fcfo ON ipatrimonio.codfornecedor = fcfo.codcfo
    
/*    IPATRIMONIO	TITMMOVBEM	CODCOLIGADA,CODPATRIMONIO	CODCOLIGADA,CODBEM */

WHERE
    codpatrimonio = '000.69.000089500'