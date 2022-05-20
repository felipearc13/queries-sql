SELECT
    pfunc.chapa,
    ppessoa.nome,
    pfunc.dataadmissao         AS admissão,
    pfunc.datademissao         AS demissão,
    pesocialeventos.tipoevento evento,
    pesocialeventos.status,
    CASE
        WHEN pesocialeventos.status = 0  THEN
            '0 - Pendente'
        WHEN pesocialeventos.status = 1  THEN
            '1 - Gerado'
        WHEN pesocialeventos.status = 2  THEN
            '2 - Erro na geração'
        WHEN pesocialeventos.status = 3  THEN
            '3 - Enviado'
        WHEN pesocialeventos.status = 4  THEN
            '4 - Aceito TAF'
        WHEN pesocialeventos.status = 5  THEN
            '5 - Erro na integração'
        WHEN pesocialeventos.status = 6  THEN
            '6 - Rejeitado TAF'
        WHEN pesocialeventos.status = 7  THEN
            '7 - Cancelado'
        WHEN pesocialeventos.status = 8  THEN
            '8 - Retificado'
        WHEN pesocialeventos.status = 9  THEN
            '9 - Rejeitado RET'
        WHEN pesocialeventos.status = 10 THEN
            '10 - Aceito RET'
        WHEN pesocialeventos.status = 11 THEN
            '11 - Excluído RET'
        ELSE
            to_char(pesocialeventos.status)
    END                        AS status_evento
FROM
         u_cfl8u4_rm.pfunc right
    JOIN u_cfl8u4_rm.pesocialeventos ON pesocialeventos.chapa = pfunc.chapa
    RIGHT JOIN u_cfl8u4_rm.ppessoa ON ppessoa.codigo = pfunc.codpessoa
WHERE
        tipoevento <> 'S-2190'
    AND pfunc.codpessoa = 5967
UNION
SELECT
    pfunc.chapa,
    ppessoa.nome,
    pfunc.dataadmissao         AS admissão,
    pfunc.datademissao         AS demissão,
    pesocialeventos.tipoevento evento,
    pesocialeventos.status,
    CASE
        WHEN pesocialeventos.status = 0  THEN
            '0 - Pendente'
        WHEN pesocialeventos.status = 1  THEN
            '1 - Gerado'
        WHEN pesocialeventos.status = 2  THEN
            '2 - Erro na geração'
        WHEN pesocialeventos.status = 3  THEN
            '3 - Enviado'
        WHEN pesocialeventos.status = 4  THEN
            '4 - Aceito TAF'
        WHEN pesocialeventos.status = 5  THEN
            '5 - Erro na integração'
        WHEN pesocialeventos.status = 6  THEN
            '6 - Rejeitado TAF'
        WHEN pesocialeventos.status = 7  THEN
            '7 - Cancelado'
        WHEN pesocialeventos.status = 8  THEN
            '8 - Retificado'
        WHEN pesocialeventos.status = 9  THEN
            '9 - Rejeitado RET'
        WHEN pesocialeventos.status = 10 THEN
            '10 - Aceito RET'
        WHEN pesocialeventos.status = 11 THEN
            '11 - Excluído RET'
        ELSE
            to_char(pesocialeventos.status)
    END                        AS status_evento
FROM
    u_cfl8u4_rm.pesocialeventos
    LEFT JOIN u_cfl8u4_rm.pfuncpreliminar ON pesocialeventos.idregpreliminar = pfuncpreliminar.idregistro
    LEFT JOIN u_cfl8u4_rm.pfunc ON pfuncpreliminar.chapa = pfunc.chapa
    LEFT JOIN u_cfl8u4_rm.ppessoa ON pfunc.codpessoa = ppessoa.codigo
WHERE
        tipoevento = 'S-2190'
    AND pfuncpreliminar.codpessoa = 5967