SELECT TTMV.CODTMV, Upper(TTMV.NOME),
CASE WHEN TITMTMV.HABILITAORCAMENTO = 1 THEN 'S' ELSE 'N' END,
CASE WHEN TITMTMV.EFEITOSALDOA2 = 'N' THEN 'N' ELSE 'S' END,
CASE WHEN TTMV.USAREVC > 0 THEN 'S' ELSE 'N' END,
CASE WHEN TTMV.FATURA  > 0 THEN 'S' ELSE 'N' END,
CASE WHEN TTMV.EDICAOTB1FLXMOV > 0 THEN 'S' ELSE 'N' END,
CASE WHEN TTMVEXT.CODCOLATENDIMENTO = 1 THEN 'S' ELSE 'N' END,
CASE WHEN TITMTMV.GERAESCRITURACAO = 1 THEN 'S' ELSE 'N' END,
CASE WHEN TITMTMV.INTEGRARBONUM = 1 THEN 'S' ELSE 'N' END,
CASE WHEN TITMTMV.OBRIGAEVENTOCONT = 1 THEN 'S' ELSE 'N' END AS OBRIGAEVENTOCONT


FROM TTMV LEFT JOIN TITMTMV ON TTMV.CODTMV = TITMTMV.CODTMV LEFT JOIN TTMVEXT ON TTMV.CODTMV = TTMVEXT.CODTMV
WHERE TTMV.CODTMV LIKE '%.%.%%'
ORDER BY TTMV.CODTMV

