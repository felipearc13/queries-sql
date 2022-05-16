SELECT 
    GFILIAL.NOME AS EMITENTE,
    GFILIAL.CGC  AS CNPJ,
    GFILIAL.RUA  AS RUA_EMT,
    GFILIAL.NUMERO NUMERO_EMT,
    GMUNICIPIO.NOMEMUNICIPIO AS MUNICIPIO_EMT,
    GFILIAL.CEP AS CEP_EMT,
    GFILIAL.BAIRRO BAIRRO_EMT,
    GFILIAL.ESTADO ESTADO_EMT,
    GFILIAL.DDD DDD_EMT,
    GFILIAL.TELEFONE TELEFONE_EMT,
    FCFO.NOMEFANTASIA AS SACADO,
    FCFO.RUA AS RUA_SAC,
    FCFO.NUMERO AS NUMERO_SAC,
    FCFO.CEP AS CEP_SAC,
    FCFO.BAIRRO AS BAIRRO_SAC,
    FCFO.CODETD AS ESTADO_SAC,
    CASE WHEN GFILIAL.CODMUNICIPIO = GMUNICIPIO.CODMUNICIPIO THEN GMUNICIPIO.NOMEMUNICIPIO
    ELSE NULL END AS MUNI
    
FROM   U_CFL8U4_RM.FLAN
    LEFT JOIN U_CFL8U4_RM.GFILIAL
        ON FLAN.CODFILIAL = GFILIAL.CODFILIAL
    LEFT JOIN U_CFL8U4_RM.GMUNICIPIO 
        ON GFILIAL.CODMUNICIPIO = GMUNICIPIO.CODMUNICIPIO
    LEFT JOIN U_CFL8U4_RM.FCFO
        ON FLAN.CODCFO = FCFO.CODCFO

WHERE  FLAN.IDLAN = 507685 
