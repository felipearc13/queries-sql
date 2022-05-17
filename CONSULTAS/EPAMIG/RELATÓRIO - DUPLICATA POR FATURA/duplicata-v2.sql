SELECT *
FROM (
        SELECT FLAN.IDFAT,
            TMOV.VALORLIQUIDO AS VALOR_T
        FROM U_CFL8U4_RM.TMOV
            LEFT JOIN U_CFL8U4_RM.FLAN ON TMOV.IDMOV = FLAN.IDMOV
        WHERE TMOV.IDMOV = 601075
            AND FLAN.IDFAT IS NOT NULL
    ) TAB1
    LEFT JOIN U_CFL8U4_RM.FLAN ON TAB1.IDFAT = FLAN.IDFAT
    LEFT JOIN U_CFL8U4_RM.FCFO ON FLAN.CODCFO = FCFO.CODCFO
    LEFT JOIN U_CFL8U4_RM.GMUNICIPIO ON FCFO.CODMUNICIPIO = GMUNICIPIO.CODMUNICIPIO