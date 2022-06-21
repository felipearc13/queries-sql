SELECT
    tab1.tipoevento,
    tab1.status,
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
            
                    NVL(pfunc.chapa,'Registro Preliminar sem chapa')
                                      AS chapa,
            ppessoa.nome,
            pfunc.dataadmissao              AS admissao,
            pfunc.datademissao              AS demissao,
            pesocialeventos.tipoevento,
            to_char(pesocialeventos.status) AS status,
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
    tipoevento LIKE /*'S-2190'*/ '%%'
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