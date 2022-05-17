SELECT TAB1.VALOR_TOTAL,
    TAB1.IDMOV,
    EMITENTE,
    CNPJ,
    RUA_EMT,
    NUMERO_EMT,
    MUNICIPIO_EMT,
    CEP_EMT,
    BAIRRO_EMT,
    ESTADO_EMT,
    DDD_EMT,
    TELEFONE_EMT,
    GMUNICIPIO.NOMEMUNICIPIO AS MUNICIPIO_SAC,
    FCFO.NOMEFANTASIA AS SACADO,
    FCFO.RUA AS RUA_SAC,
    FCFO.NUMERO AS NUMERO_SAC,
    FCFO.CEP AS CEP_SAC,
    FCFO.BAIRRO AS BAIRRO_SAC,
    FCFO.CODETD AS UF_SAC,
    FCFO.CGCCFO AS CPF_CNPJ_SAC,
    FCFO.INSCRESTADUAL AS INSC_EST_SAC,
    FLAN.IDLAN
FROM (
        SELECT FLAN.IDFAT AS ID_FATURA,
            TMOV.IDMOV,
            TMOV.VALORLIQUIDO AS VALOR_TOTAL,
            GFILIAL.NOME AS EMITENTE,
            GFILIAL.CGC AS CNPJ,
            GFILIAL.RUA AS RUA_EMT,
            GFILIAL.NUMERO AS NUMERO_EMT,
            GMUNICIPIO.NOMEMUNICIPIO AS MUNICIPIO_EMT,
            GFILIAL.CEP AS CEP_EMT,
            GFILIAL.BAIRRO AS BAIRRO_EMT,
            GFILIAL.ESTADO AS ESTADO_EMT,
            GFILIAL.DDD AS DDD_EMT,
            GFILIAL.TELEFONE AS TELEFONE_EMT
        FROM U_CFL8U4_RM.TMOV
            LEFT JOIN U_CFL8U4_RM.FLAN ON TMOV.IDMOV = FLAN.IDMOV
            LEFT JOIN U_CFL8U4_RM.GFILIAL ON FLAN.CODFILIAL = GFILIAL.CODFILIAL
            LEFT JOIN U_CFL8U4_RM.GMUNICIPIO ON GFILIAL.CODMUNICIPIO = GMUNICIPIO.CODMUNICIPIO
        WHERE TMOV.IDMOV = 601075
            AND FLAN.IDFAT IS NOT NULL
    ) TAB1
    LEFT JOIN U_CFL8U4_RM.FLAN ON TAB1.ID_FATURA = FLAN.IDFAT
    LEFT JOIN U_CFL8U4_RM.FCFO ON FLAN.CODCFO = FCFO.CODCFO
    LEFT JOIN U_CFL8U4_RM.GMUNICIPIO ON FCFO.CODMUNICIPIO = GMUNICIPIO.CODMUNICIPIO