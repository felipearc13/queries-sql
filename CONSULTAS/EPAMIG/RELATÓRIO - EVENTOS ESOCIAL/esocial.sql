SELECT 
PFUNC.CHAPA,
PPESSOA.NOME,
PFUNC.DATAADMISSAO AS ADMISSÃO,
PFUNC.DATADEMISSAO AS DEMISSÃO,
PESOCIALEVENTOS.TIPOEVENTO EVENTO,
PESOCIALEVENTOS.STATUS,
CASE
WHEN PESOCIALEVENTOS.STATUS = 0 THEN '0 - Pendente'
WHEN PESOCIALEVENTOS.STATUS = 1 THEN '1 - Gerado'
WHEN PESOCIALEVENTOS.STATUS = 2 THEN '2 - Erro na geração'
WHEN PESOCIALEVENTOS.STATUS = 3 THEN '3 - Enviado'
WHEN PESOCIALEVENTOS.STATUS = 4 THEN '4 - Aceito TAF'
WHEN PESOCIALEVENTOS.STATUS = 5 THEN '5 - Erro na integração'
WHEN PESOCIALEVENTOS.STATUS = 6 THEN '6 - Rejeitado TAF'
WHEN PESOCIALEVENTOS.STATUS = 7 THEN '7 - Cancelado'
WHEN PESOCIALEVENTOS.STATUS = 8 THEN '8 - Retificado'
WHEN PESOCIALEVENTOS.STATUS = 9 THEN '9 - Rejeitado RET'
WHEN PESOCIALEVENTOS.STATUS = 10 THEN '10 - Aceito RET'
WHEN PESOCIALEVENTOS.STATUS = 11 THEN '11 - Excluído RET'
ELSE TO_CHAR(PESOCIALEVENTOS.STATUS)
END AS STATUS_EVENTO

FROM 
U_CFL8U4_RM.PFUNC 
RIGHT JOIN U_CFL8U4_RM.PESOCIALEVENTOS
ON PESOCIALEVENTOS.CHAPA = PFUNC.CHAPA
RIGHT JOIN U_CFL8U4_RM.PPESSOA
ON PPESSOA.CODIGO = PFUNC.CODPESSOA

WHERE 
PFUNC.CHAPA = :CHAPA
AND PPESSOA.NOME = :NOME
AND TO_CHAR(PFUNC.DATAADMISSAO,'DD/MM/AAAA') = :DATA_ADMISSAO
AND TO_CHAR(PFUNC.DATADEMISSAO,'DD/MM/AAAA') = :DATA_DEMISSAO
AND PESOCIALEVENTOS.TIPOEVENTO = :EVENTO
AND PESOCIALEVENTOS.STATUS = :STATUS

ORDER BY 
PFUNC.CHAPA,
PFUNC.DATAADMISSAO,
PFUNC.DATADEMISSAO,
PESOCIALEVENTOS.TIPOEVENTO,
PESOCIALEVENTOS.STATUS