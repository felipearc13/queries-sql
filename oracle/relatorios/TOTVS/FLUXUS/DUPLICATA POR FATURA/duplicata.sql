SELECT *
FROM   (SELECT DISTINCT FLAN.IDLAN,
                        ROW_NUMBER()
                          OVER(
                            ORDER BY FLAN.DATAVENCIMENTO ASC)AS R,
                        ID_FATURA,
                        FLAN.DATAVENCIMENTO                  AS VENCIMENTO,
                        TAB1.VALOR_TOTAL,
                        FLAN.VALORORIGINAL                   AS VALOR,
                        TAB1.IDMOV,
                        TAB1.NUMEROMOV,
                        EMITENTE,
                        CNPJ,
                        RUA_EMT,
                        NUMERO_EMT,
                        MUNICIPIO_EMT,
                        CEP_EMT,
                        BAIRRO_EMT,
                        UF_EMT,
                        DDD_EMT,
                        TELEFONE_EMT,
                        GMUNICIPIO.NOMEMUNICIPIO             AS MUNICIPIO_SAC,
                        FCFO.NOMEFANTASIA                    AS SACADO,
                        FCFO.RUA                             AS RUA_SAC,
                        FCFO.NUMERO                          AS NUMERO_SAC,
                        FCFO.CEP                             AS CEP_SAC,
                        FCFO.BAIRRO                          AS BAIRRO_SAC,
                        FCFO.CODETD                          AS UF_SAC,
                        FCFO.CGCCFO                          AS CPF_CNPJ_SAC,
                        FCFO.INSCRESTADUAL                   AS INSC_EST_SAC,
                        DATASAIDA
        FROM   (SELECT FLAN.IDFAT               AS ID_FATURA,
                       FLAN.DATAVENCIMENTO      AS VENCIROW,
                       TMOV.IDMOV,
                       TMOV.NUMEROMOV,
                       TMOV.DATASAIDA,
                       TMOV.VALORLIQUIDO        AS VALOR_TOTAL,
                       GFILIAL.NOME             AS EMITENTE,
                       GFILIAL.CGC              AS CNPJ,
                       GFILIAL.RUA              AS RUA_EMT,
                       GFILIAL.NUMERO           AS NUMERO_EMT,
                       GMUNICIPIO.NOMEMUNICIPIO AS MUNICIPIO_EMT,
                       GFILIAL.CEP              AS CEP_EMT,
                       GFILIAL.BAIRRO           AS BAIRRO_EMT,
                       GFILIAL.ESTADO           AS UF_EMT,
                       GFILIAL.DDD              AS DDD_EMT,
                       GFILIAL.TELEFONE         AS TELEFONE_EMT
                FROM   U_CFL8U4_RM.TMOV
                       LEFT JOIN U_CFL8U4_RM.FLAN
                              ON TMOV.IDMOV = FLAN.IDMOV
                       LEFT JOIN U_CFL8U4_RM.GFILIAL
                              ON FLAN.CODFILIAL = GFILIAL.CODFILIAL
                       LEFT JOIN U_CFL8U4_RM.GMUNICIPIO
                              ON GFILIAL.CODMUNICIPIO = GMUNICIPIO.CODMUNICIPIO
                                 AND GFILIAL.ESTADO = GMUNICIPIO.CODETDMUNICIPIO
                WHERE  FLAN.IDFAT IS NOT NULL) TAB1
               LEFT JOIN U_CFL8U4_RM.FLAN
                      ON TAB1.ID_FATURA = FLAN.IDFAT
               LEFT JOIN U_CFL8U4_RM.FCFO
                      ON FLAN.CODCFO = FCFO.CODCFO
               LEFT JOIN U_CFL8U4_RM.GMUNICIPIO
                      ON FCFO.CODMUNICIPIO = GMUNICIPIO.CODMUNICIPIO
                         AND FCFO.CODETD = GMUNICIPIO.CODETDMUNICIPIO
        WHERE  FLAN.CODAPLICACAO = 'F'
               AND ID_FATURA = :FATURA
        ORDER  BY FLAN.DATAVENCIMENTO)TAB2
WHERE  R >= :PARCELA_INICIAL
       AND R <= :PARCELA_FINAL