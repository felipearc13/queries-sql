SELECT EMITENTE,
    CNPJ,
    RUA_EMT,
    NUMERO_EMT,
    MUNICIPIO_EMT,
    CEP_EMT,
    BAIRRO_EMT,
    ESTADO_EMT,
    DDD_EMT,
    TELEFONE_EMT,
    SACADO,
    RUA_SAC,
    NUMERO_SAC,
    CEP_SAC,
    BAIRRO_SAC,
    ESTADO_SAC,
    NOMEMUNICIPIO AS MUNICIPIO_SAC,
    CPF_CNPJ_SAC,
    INSC_EST_SAC,
    FLAN.IDLAN,
    FLAN.DATAVENCIMENTO AS VENCIMENTO,
    FLAN.VALORORIGINAL AS VALOR
FROM (
        SELECT GFILIAL.NOME AS EMITENTE,
            GFILIAL.CGC AS CNPJ,
            GFILIAL.RUA AS RUA_EMT,
            GFILIAL.NUMERO AS NUMERO_EMT,
            GMUNICIPIO.NOMEMUNICIPIO AS MUNICIPIO_EMT,
            GFILIAL.CEP AS CEP_EMT,
            GFILIAL.BAIRRO AS BAIRRO_EMT,
            GFILIAL.ESTADO AS ESTADO_EMT,
            GFILIAL.DDD AS DDD_EMT,
            GFILIAL.TELEFONE AS TELEFONE_EMT,
            FCFO.NOMEFANTASIA AS SACADO,
            FCFO.RUA AS RUA_SAC,
            FCFO.NUMERO AS NUMERO_SAC,
            FCFO.CEP AS CEP_SAC,
            FCFO.BAIRRO AS BAIRRO_SAC,
            FCFO.CODETD AS ESTADO_SAC,
            FCFO.CODMUNICIPIO,
            FCFO.CGCCFO AS CPF_CNPJ_SAC,
            FCFO.INSCRESTADUAL AS INSC_EST_SAC,
            FLAN.IDLAN
        FROM U_CFL8U4_RM.FLAN
            LEFT JOIN U_CFL8U4_RM.GFILIAL ON FLAN.CODFILIAL = GFILIAL.CODFILIAL
            LEFT JOIN U_CFL8U4_RM.FCFO ON FLAN.CODCFO = FCFO.CODCFO
            LEFT JOIN U_CFL8U4_RM.GMUNICIPIO ON GFILIAL.CODMUNICIPIO = GMUNICIPIO.CODMUNICIPIO
        WHERE FCFO.CODCFO = '000027724'
        AND FLAN.CODAPLICACAO = 'F'
    ) TABELA
    LEFT JOIN U_CFL8U4_RM.GMUNICIPIO ON TABELA.CODMUNICIPIO = GMUNICIPIO.CODMUNICIPIO
    LEFT JOIN U_CFL8U4_RM.FLAN ON TABELA.IDLAN = FLAN.IDLAN
ORDER BY FLAN.DATAVENCIMENTO