SELECT
    tab1.tipoevento         AS evento,
    to_char(tab1.status)    AS status#,
    CASE
        WHEN tab1.status = 0  THEN
            '0-Pendente'
        WHEN tab1.status = 1  THEN
            '1-Gerado'
        WHEN tab1.status = 2  THEN
            '2-Erro no Geração'
        WHEN tab1.status = 3  THEN
            '3-Enviado'
        WHEN tab1.status = 4  THEN
            '4-Aceito TAF'
        WHEN tab1.status = 5  THEN
            '5-Erro na integração'
        WHEN tab1.status = 6  THEN
            '6-Rejeitado TAF'
        WHEN tab1.status = 7  THEN
            '7-Cancelado'
        WHEN tab1.status = 8  THEN
            '8-Retificado'
        WHEN tab1.status = 9  THEN
            '9-Rejeitado RET'
        WHEN tab1.status = 10 THEN
            '10-Aceito RET'
        WHEN tab1.status = 11 THEN
            '11-Excluido RET'
        ELSE
            tab1.status
    END                     AS status,
    tab1.id,
    tab1.chapa,
    tab1.nome,
    gfilial.codfilial
    || ' - '
    || gfilial.nomefantasia AS filial,
    tab1.admissao,
    tab1.demissao,
    tab1.dt_evento,
    tab1.dt_envio
FROM
    (
        SELECT
            pfunc.chapa,
            ppessoa.nome,
            pfunc.dataadmissao               AS admissao,
            pfunc.datademissao               AS demissao,
            pesocialeventos.tipoevento,
            to_char(pesocialeventos.status)  AS status,
            id,
            pfunc.codsecao,
            dataevento                       AS dt_evento,
            to_char(dataenvio, 'dd/mm/yyyy') AS dt_envio
        FROM
            u_cfl8u4_rm.pfunc
            LEFT JOIN u_cfl8u4_rm.pesocialeventos ON pfunc.chapa = pesocialeventos.chapa
            LEFT JOIN u_cfl8u4_rm.ppessoa ON pfunc.codpessoa = ppessoa.codigo
        WHERE
            tipoevento <> 'S-2190'
        UNION
        SELECT
            nvl(pfunc.chapa, 'Registro Preliminar sem chapa') AS chapa,
            ppessoa.nome,
            pfunc.dataadmissao                                AS admissao,
            pfunc.datademissao                                AS demissao,
            pesocialeventos.tipoevento,
            to_char(pesocialeventos.status)                   AS status,
            id,
            pfunc.codsecao,
            dataevento,
            to_char(dataenvio, 'dd/mm/yyyy')
        FROM
            u_cfl8u4_rm.pesocialeventos
            LEFT JOIN u_cfl8u4_rm.pfuncpreliminar ON pesocialeventos.idregpreliminar = pfuncpreliminar.idregistro
            LEFT JOIN u_cfl8u4_rm.pfunc ON pfuncpreliminar.chapa = pfunc.chapa
            LEFT JOIN u_cfl8u4_rm.ppessoa ON pfuncpreliminar.codpessoa = ppessoa.codigo
        WHERE
                tipoevento = 'S-2190'
            AND pfuncpreliminar.idregistro IS NOT NULL
    ) tab1
    LEFT JOIN u_cfl8u4_rm.psecao ON tab1.codsecao = psecao.codigo
    LEFT JOIN u_cfl8u4_rm.gfilial ON psecao.codfilial = gfilial.codfilial
WHERE
    tab1.tipoevento LIKE :evento
    AND to_char(tab1.status) LIKE :status
    AND tab1.id LIKE :id
    AND tab1.chapa LIKE :chapa
    AND tab1.nome LIKE :nome
    AND gfilial.codfilial >= :filial_ini
    AND gfilial.codfilial <= :filial_fim
    AND tab1.admissao >= :adm_ini
    AND tab1.admissao <= :adm_fim
    AND tab1.dt_evento >= :data_evento_ini
    AND tab1.dt_evento <= :data_evento_fim
    AND tab1.dt_envio >= :data_envio_ini
    AND tab1.dt_envio <= :data_envio_fim
ORDER BY
    tab1.tipoevento,
    tab1.status,
    tab1.chapa,
    tab1.nome,
    tab1.admissao,
    tab1.demissao,
    tab1.codsecao,
    tab1.dt_evento,
    tab1.dt_envio