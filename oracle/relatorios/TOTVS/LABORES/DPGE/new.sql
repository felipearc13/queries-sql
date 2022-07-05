SELECT
    gfilial.codfilial              AS nr_filial,
    codsecao                       AS cod_filial,
    upper(gfilial.cidade)          AS cidade_filial,
    /* RELATORIO 1 */
    SUM(valor_mensal_ferias)       AS ferias_1,
    SUM(valor_mensal_ceres_ferias) AS ceres_2,
    SUM(valor_mensal_fgts_ferias)  AS fgts_3,
    SUM(valor_mensal_inss_ferias)  AS inss_4,
    SUM(valor_mensal_13)           AS dec_ter_5,
    SUM(valor_mensal_ceres13)      AS ceres_6,
    SUM(valor_mensal_fgts13)       AS fgts_7,
    SUM(valor_mensal_inss13)       AS inss_8,
    /* RELATORIO 2 */
    SUM(baixa_ferias)              AS baixa_ferias_9,
    SUM(baixa_ceres_ferias)        AS baixa_ceres_ferias_10,
    SUM(baixa_fgts_ferias)         AS baixa_fgts_ferias_11,
    SUM(baixa_inss_ferias)         AS baixa_inss_ferias_12,
    SUM(baixa_13)                  AS baixa_13_13,
    /* coluna 14 espressao Base.CONF_CONTAB.BAIXA_CERES13 */
    SUM(baixa_fgts13)              AS baixa_fgts_13_15,
    SUM(baixa_inss13)              AS baixa_inss_13_16
FROM
    (
        SELECT
        /*0008.005*/
            codfilial,
                     /* codsecao, */
            substr(codsecao, 1, 7)                                                                                                          AS
            codsecao,
            cidade,
            chapa,
            nome,
            centro_custo,
            codsituacao,
            codtipo,
            datademissao,
            tipodemissao,
            dataadmissao,
            dttransferencia,
            codsefip,
                     /* PROVISAO FERIAS */
            avos,
            saldo_anterior_ferias,
            valor_mensal_ferias,
            baixa_ferias,
            nvl(((saldo_anterior_ferias + valor_mensal_ferias) - baixa_ferias), 0)                                                          AS
            saldo_atual_ferias,
                     /* INSS FERIAS */
            acrescimo_inss,
            porc_inss_empresa,
            ( porc_inss_empresa + acrescimo_inss )                                                                                          AS
            inss_total,
            ( saldo_anterior_ferias * ( ( porc_inss_empresa + acrescimo_inss ) / 100 ) )                                                    AS
            saldo_anterior_inss_ferias,
            valor_mensal_inss_ferias,
            baixa_inss_ferias,
            ( ( saldo_anterior_ferias * ( ( porc_inss_empresa + acrescimo_inss ) / 100 ) ) + valor_mensal_inss_ferias - baixa_inss_ferias ) AS
            saldo_atual_inss_ferias,
                     /* FGTS FERIAS */
            porc_fgts,
            ( saldo_anterior_ferias * porc_fgts )                                                                                           AS
            saldo_anterior_fgts_ferias,
            valor_mensal_fgts_ferias,
            baixa_fgts_ferias,
            ( ( saldo_anterior_ferias * porc_fgts ) + valor_mensal_fgts_ferias - baixa_fgts_ferias )                                        AS
            saldo_atual_fgts_ferias,
                     /* CERES FERIAS */
            porc_ceres,
            ( saldo_anterior_ferias * porc_ceres )                                                                                          AS
            saldo_anterior_ceres_ferias,
            valor_mensal_ceres_ferias,
            ceres_ferias_pagas                                                                                                              AS
            baixa_ceres_ferias,
            ( ( saldo_anterior_ferias * porc_ceres ) + valor_mensal_ceres_ferias - ceres_ferias_pagas )                                     AS
            saldo_atual_ceres_ferias,
                     /* 13o SALARIO */
            0                                                                                                                               AS
            saldo_anterior_13,
            0                                                                                                                               AS
            valor_mensal_13,
            0                                                                                                                               AS
            baixa_13,
            0                                                                                                                               AS
            saldo_atual_13,
                     /* INSS 13 */
                     /*  0 AS acrescimo_inss, */
                     /*0                                                                                                                               AS porc_inss_empresa,*/
                     /* 0 AS inss_total, */
            0                                                                                                                               AS
            saldo_anterior_inss13,
            0                                                                                                                               AS
            valor_mensal_inss13,
            0                                                                                                                               AS
            baixa_inss13,
            0                                                                                                                               AS
            saldo_atual_inss13,
                     /* FGTS 13 */
            0                                                                                                                               AS
            saldo_anterior_fgts13,
            0                                                                                                                               AS
            valor_mensal_fgts13,
            0                                                                                                                               AS
            baixa_fgts13,
            0                                                                                                                               AS
            saldo_atual_fgts13,
                     /* CERES 13 */
                     /* 0 AS porc_ceres, */
            0                                                                                                                               AS
            saldo_anterior_ceres13,
            0                                                                                                                               AS
            valor_mensal_ceres13,
            0                                                                                                                               AS
            baixa_ceres13,
            0                                                                                                                               AS
            saldo_atual_ceres13
        FROM
            (
                SELECT
                    pfunc.codfilial,
                    pfunc.codsecao,
                    psecao.cidade,
                    pfunc.chapa,
                    pfunc.nome,
                    pfrateiofixo.codccusto                              AS centro_custo,
                    pfunc.codtipo,
                    pfunc.codsituacao,
                    dataadmissao,
                    dttransferencia,
                    datademissao,
                    tipodemissao,
                    pfunc.codocorrencia                                 AS codsefip,
                       /* PROVISAO DE FERIAS */
                    ( pfh1.nroavosvencferdec + pfh1.nroavosproporcdec ) avos,
                    nvl(pfh2.valprovcomabatfer, 0)                      AS saldo_anterior_ferias,
                    (
                        SELECT
                            nvl(SUM(valor), 0)
                        FROM
                            u_cfl8u4_rm.pfencargo
                        WHERE
                            codencargo IN ( '108' )
                            AND codcoligada = pfunc.codcoligada
                            AND chapa = pfunc.chapa
                            AND ( anocomp = pfh1.ano
                                  AND mescomp = pfh1.mes )
                    )                                                   AS valor_mensal_ferias,
                    (
                        SELECT
                            nvl(SUM(pffinanc.valor), 0)
                        FROM
                            u_cfl8u4_rm.pffinanc
                        WHERE
                                pffinanc.codcoligada = pfh1.codcoligada
                            AND pffinanc.chapa = pfh1.chapa
                            AND pffinanc.anocomp = pfh1.ano
                            AND pffinanc.mescomp = pfh1.mes
                            AND codevento IN ( '0046', '0047', '0048', '0101', '0102',
                                               '0104', '0105', '0106', '0109', '0115',
                                               '0133', '0186', '0188' )
                    )                                                   AS baixa_ferias,
                       /*INSS FERIAS  */
                    CASE
                        WHEN pfunc.codocorrencia IN ( 2, 6 ) THEN
                            12
                        WHEN pfunc.codocorrencia IN ( 3, 7 ) THEN
                            9
                        WHEN pfunc.codocorrencia IN ( 4, 8 ) THEN
                            6
                        ELSE
                            0
                    END                                                 acrescimo_inss,
                    (
                        SELECT
                            ( nvl(valor, 0) * nvl(percentacidtrab, 0) ) + nvl((
                                SELECT
                                    porcentagem
                                FROM
                                    u_cfl8u4_rm.pencargo
                                WHERE
                                    codigo = '109'
                            ), 0)
                        FROM
                            u_cfl8u4_rm.psecaofapaliquota,
                            u_cfl8u4_rm.psecao
                        WHERE
                                psecaofapaliquota.codcoligada = psecao.codcoligada
                            AND psecaofapaliquota.codsecao = psecao.codigo
                            AND psecao.codcoligada = 1
                            AND psecao.codfilial = pfunc.codfilial
                            AND iniciovigenciaaliquota >= '01/01/2022'
                    )                                                   AS porc_inss_empresa,
                    (
                        SELECT
                            nvl(SUM(valor), 0)
                        FROM
                            u_cfl8u4_rm.pfencargo
                        WHERE
                                codcoligada = 1
                            AND codencargo IN ( '109', '110' )
                            AND codcoligada = pfunc.codcoligada
                            AND chapa = pfunc.chapa
                            AND ( anocomp = pfh1.ano
                                  AND mescomp = pfh1.mes )
                    )                                                   AS valor_mensal_inss_ferias,
                    (
                        SELECT
                            nvl(SUM(valor), 0)
                        FROM
                            u_cfl8u4_rm.pfencargo
                        WHERE
                                codcoligada = 1
                            AND codencargo IN ( '124', '104' )
                               /* baixa recisao e folha */
                            AND codcoligada = pfunc.codcoligada
                            AND chapa = pfunc.chapa
                            AND ( anocomp = pfh1.ano
                                  AND mescomp = pfh1.mes )
                    )                                                   AS baixa_inss_ferias,
                       /*FGTS FERIAS  */
                    CASE
                        WHEN codtipo = 'Z' THEN
                            0.02
                        WHEN codtipo IN ( 'M', 'N', 'O', 'P', 'E' ) THEN
                            0.08
                        ELSE
                            0
                    END                                                 AS porc_fgts,
                    (
                        SELECT
                            nvl(SUM(valor), 0)
                        FROM
                            u_cfl8u4_rm.pfencargo
                        WHERE
                                codcoligada = 1
                            AND codencargo IN ( '111', '121' )
                            AND codcoligada = pfunc.codcoligada
                            AND chapa = pfunc.chapa
                            AND ( anocomp = pfh1.ano
                                  AND mescomp = pfh1.mes )
                    )                                                   AS valor_mensal_fgts_ferias,
                    (
                        SELECT
                            nvl(SUM(valor), 0)
                        FROM
                            u_cfl8u4_rm.pfencargo
                        WHERE
                                codcoligada = 1
                            AND codencargo IN ( '119', '125' )
                               /* baixa recisao e ferias */
                            AND codcoligada = pfunc.codcoligada
                            AND chapa = pfunc.chapa
                            AND ( anocomp = pfh1.ano
                                  AND mescomp = pfh1.mes )
                    )                                                   AS baixa_fgts_ferias,
                       /*CERES FERIAS  */
                    (
                        SELECT
                            ( ceresflex05 / 100 )
                        FROM
                            u_cfl8u4_rm.pfcompl
                        WHERE
                            chapa = pfunc.chapa
                    )                                                   AS porc_ceres,
                    (
                        SELECT
                            nvl(SUM(valor), 0)
                        FROM
                            u_cfl8u4_rm.pfencargo
                        WHERE
                                codcoligada = 1
                            AND codencargo IN ( '116' )
                            AND codcoligada = pfunc.codcoligada
                            AND chapa = pfunc.chapa
                            AND ( anocomp = pfh1.ano
                                  AND mescomp = pfh1.mes )
                    )                                                   AS valor_mensal_ceres_ferias,
                    (
                        SELECT
                            SUM(valor)
                        FROM
                            u_cfl8u4_rm.pfencargo
                        WHERE
                                codcoligada = 1
                            AND codencargo IN ( '126', '131' )
                            AND chapa = pfunc.chapa
                            AND anocomp = pfh1.ano
                            AND mescomp = pfh1.mes
                    )                                                   AS ceres_ferias_pagas
                FROM
                         u_cfl8u4_rm.pfunc
                    INNER JOIN u_cfl8u4_rm.pfhstprov pfh1 ON pfh1.codcoligada = pfunc.codcoligada
                                                             AND pfh1.chapa = pfunc.chapa
                    LEFT OUTER JOIN u_cfl8u4_rm.pfhstprov pfh2 ON pfh2.codcoligada = pfh1.codcoligada
                                                                  AND pfh2.chapa = pfh1.chapa
                                                                  AND pfh2.mes = (
                        CASE
                            WHEN pfh1.mes = 1 THEN
                                12
                            ELSE
                                pfh1.mes - 1
                        END
                    )
                                                                  AND pfh2.ano = (
                        CASE
                            WHEN pfh1.mes <> 1 THEN
                                pfh1.ano
                            ELSE
                                pfh1.ano - 1
                        END
                    )
                    LEFT JOIN u_cfl8u4_rm.psecao ON ( psecao.codcoligada = pfunc.codcoligada )
                                                    AND ( psecao.codigo = pfunc.codsecao )
                    LEFT JOIN u_cfl8u4_rm.pfcompl ON ( pfunc.codcoligada = pfcompl.codcoligada )
                                                     AND ( pfunc.chapa = pfcompl.chapa )
                    LEFT JOIN u_cfl8u4_rm.pfrateiofixo ON pfrateiofixo.codcoligada = pfunc.codcoligada
                                                          AND pfrateiofixo.chapa = pfunc.chapa
                WHERE
                        pfunc.codcoligada = 1
                    AND pfunc.codtipo <> 'D'
                    AND pfh1.ano = 2022
                    AND pfh1.mes = 5
            ) tabela1
        UNION
        SELECT
        /*0008.006*/
            codfilial,
                     /* codsecao, */
            substr(codsecao, 1, 7)                                                 AS codsecao,
            cidade,
            chapa,
            nome,
            centro_custo,
            codsituacao,
            codtipo,
            datademissao,
            tipodemissao,
            dataadmissao,
            dttransferencia,
            codsefip,
                     /* PROVISAO FERIAS */
            0                                                                      AS avos,
            0                                                                      AS saldo_anterior_ferias,
            0                                                                      AS valor_mensal_ferias,
            0                                                                      AS baixa_ferias,
            0                                                                      AS saldo_atual_ferias,
                     /* INSS FERIAS */
                     /*  0 AS acrescimo_inss, */
                     /* 0                                                                          AS porc_inss_empresa,*/
                     /* 0 AS inss_total, */
            0                                                                      AS saldo_anterior_inss_ferias,
            0                                                                      AS valor_mensal_inss_ferias,
            0                                                                      AS baixa_inss_ferias,
            0                                                                      AS saldo_atual_inss_ferias,
                     /* FGTS FERIAS */
            0                                                                      AS porc_fgts,
            0                                                                      AS saldo_anterior_fgts_ferias,
            0                                                                      AS valor_mensal_fgts_ferias,
            0                                                                      AS baixa_fgts_ferias,
            0                                                                      AS saldo_atual_fgts_ferias,
                     /* CERES FERIAS */
                     /* 0 AS porc_ceres, */
            0                                                                      AS saldo_anterior_ceres_ferias,
            0                                                                      AS valor_mensal_ceres_ferias,
            0                                                                      AS baixa_ceres_ferias,
            0                                                                      AS saldo_atual_ceres_ferias,
                     /* 13o SALARIO */
            saldo_anterior_13,
            valor_mensal_13,
            baixa_13,
            nvl(((saldo_anterior_13 + valor_mensal_13) - baixa_13), 0)             AS saldo_atual_13,
                     /* INSS 13 */
            acrescimo_inss,
            porc_inss_empresa,
            ( porc_inss_empresa + acrescimo_inss )                                 AS inss_total,
            saldo_anterior_inss13,
            valor_mensal_inss13,
            baixa_inss13,
            nvl(((saldo_anterior_inss13 + valor_mensal_inss13) - baixa_inss13), 0) AS saldo_atual_inss13,
                     /* FGTS 13 */
            saldo_anterior_fgts13,
            valor_mensal_fgts13,
            baixa_fgts13,
            nvl(((saldo_anterior_fgts13 + valor_mensal_fgts13) - baixa_fgts13), 0) AS saldo_atual_fgts13,
                     /* CERES 13 */
            porc_ceres,
            saldo_anterior_ceres13,
            valor_mensal_ceres13,
            baixa_ceres13,
            ( saldo_anterior_ceres13 + valor_mensal_ceres13 - baixa_ceres13 )      AS saldo_atual_ceres13
        FROM
            (
                SELECT
                    pfunc.codfilial,
                    pfunc.codsecao,
                    psecao.cidade,
                    pfunc.chapa,
                    pfunc.nome,
                    pfrateiofixo.codccusto AS centro_custo,
                    pfunc.codtipo,
                    pfunc.codsituacao,
                    dataadmissao,
                    dttransferencia,
                    datademissao,
                    tipodemissao,
                    pfunc.codocorrencia    AS codsefip,
                    CASE
                        WHEN codtipo = 'Z' THEN
                            2
                        WHEN codtipo IN ( 'M', 'N', 'O', 'P', 'E' ) THEN
                            8
                        ELSE
                            0
                    END                    AS porc_fgts,
                    CASE
                        WHEN pfunc.codocorrencia IN ( 2, 6 ) THEN
                            12
                        WHEN pfunc.codocorrencia IN ( 3, 7 ) THEN
                            9
                        WHEN pfunc.codocorrencia IN ( 4, 8 ) THEN
                            6
                        ELSE
                            0
                    END                    acrescimo_inss,
                    (
                        SELECT
                            ( nvl(valor, 0) * nvl(percentacidtrab, 0) ) + nvl((
                                SELECT
                                    porcentagem
                                FROM
                                    u_cfl8u4_rm.pencargo
                                WHERE
                                    codigo = '113'
                            ), 0)
                        FROM
                            u_cfl8u4_rm.psecaofapaliquota,
                            u_cfl8u4_rm.psecao
                        WHERE
                                psecaofapaliquota.codcoligada = psecao.codcoligada
                            AND psecaofapaliquota.codsecao = psecao.codigo
                            AND psecao.codcoligada = 1
                            AND psecao.codfilial = pfunc.codfilial
                            AND iniciovigenciaaliquota >= '01-JAN-2022'
                    )                      AS porc_inss_empresa,
                       /*13o SALARIO */
                    pfh1.nroavos13dec      AS avos13_atual,
                    pfh2.nroavos13dec      AS avos13_anterior,
                    (
                        SELECT
                            nvl(SUM(valor), 0)
                        FROM
                            u_cfl8u4_rm.pfencargo
                        WHERE
                                codencargo = '112'
                            AND codcoligada = pfunc.codcoligada
                            AND chapa = pfunc.chapa
                            AND ( anocomp = pfh1.ano
                                  AND mescomp < pfh1.mes )
                    )                      AS saldo_anterior_13,
                    (
                        SELECT
                            nvl(SUM(valor), 0)
                        FROM
                            u_cfl8u4_rm.pfencargo
                        WHERE
                                codencargo = '112'
                            AND codcoligada = pfunc.codcoligada
                            AND chapa = pfunc.chapa
                            AND ( anocomp = pfh1.ano
                                  AND mescomp = pfh1.mes )
                    )                      AS valor_mensal_13,
                       /*BAIXA 13o SALARIO pago */
                    (
                        SELECT
                            nvl(SUM(pffinanc.valor), 0)
                        FROM
                            u_cfl8u4_rm.pffinanc
                        WHERE
                                pffinanc.codcoligada = pfh1.codcoligada
                            AND pffinanc.chapa = pfh1.chapa
                            AND pffinanc.mescomp = pfh1.mes
                            AND pffinanc.anocomp = pfh1.ano
                            AND codevento IN ( '0041', '0042' )
                    )                      AS baixa_13,
                       /* verbas pago 2a parcela('0041') e recisao ('0042')*/
                       /*INSS */
                    (
                        SELECT
                            nvl(SUM(valor), 0)
                        FROM
                            u_cfl8u4_rm.pfencargo
                        WHERE
                            codencargo IN ( '113', '114' )
                            AND codcoligada = pfunc.codcoligada
                            AND chapa = pfunc.chapa
                            AND ( anocomp = pfh1.ano
                                  AND mescomp < pfh1.mes )
                    )                      AS saldo_anterior_inss13,
                    (
                        SELECT
                            nvl(SUM(valor), 0)
                        FROM
                            u_cfl8u4_rm.pfencargo
                        WHERE
                            codencargo IN ( '113', '114' )
                            AND codcoligada = pfunc.codcoligada
                            AND chapa = pfunc.chapa
                            AND anocomp = pfh1.ano
                            AND mescomp = pfh1.mes
                    )                      AS valor_mensal_inss13,
                       /*INSS%) */
                    (
                        SELECT
                            nvl(SUM(valor), 0)
                        FROM
                            u_cfl8u4_rm.pfencargo
                        WHERE
                            codencargo IN ( '105', '106' )
                            AND codcoligada = pfunc.codcoligada
                            AND chapa = pfunc.chapa
                            AND anocomp = pfh1.ano
                            AND mescomp = pfh1.mes
                    )                      AS baixa_inss13,
                       /*FGTS */
                    (
                        SELECT
                            nvl(SUM(valor), 0)
                        FROM
                            u_cfl8u4_rm.pfencargo
                        WHERE
                            codencargo IN ( '115', '122' )
                            AND codcoligada = pfunc.codcoligada
                            AND chapa = pfunc.chapa
                            AND ( anocomp = pfh1.ano
                                  AND mescomp < pfh1.mes )
                    )                      AS saldo_anterior_fgts13,
                    (
                        SELECT
                            nvl(SUM(valor), 0)
                        FROM
                            u_cfl8u4_rm.pfencargo
                        WHERE
                            codencargo IN ( '115', '122' )
                            AND codcoligada = pfunc.codcoligada
                            AND chapa = pfunc.chapa
                            AND anocomp = pfh1.ano
                            AND mescomp = pfh1.mes
                    )                      AS valor_mensal_fgts13,
                    (
                        SELECT
                            nvl(SUM(valor), 0)
                        FROM
                            u_cfl8u4_rm.pfencargo
                        WHERE
                            codencargo IN ( '107', '120' )
                            AND codcoligada = pfunc.codcoligada
                            AND chapa = pfunc.chapa
                            AND anocomp = pfh1.ano
                            AND mescomp = pfh1.mes
                    )                      AS baixa_fgts13,
                       /*CERES 13 */
                    (
                        SELECT
                            ( ceresflex05 / 100 )
                        FROM
                            u_cfl8u4_rm.pfcompl
                        WHERE
                            chapa = pfunc.chapa
                    )                      AS porc_ceres,
                    (
                        SELECT
                            nvl(SUM(valor), 0)
                        FROM
                            u_cfl8u4_rm.pfencargo
                        WHERE
                            codencargo IN ( '117' )
                            AND codcoligada = pfunc.codcoligada
                            AND chapa = pfunc.chapa
                            AND ( anocomp = pfh1.ano
                                  AND mescomp < pfh1.mes )
                    )                      AS saldo_anterior_ceres13,
                       /*saldo Anterior = Acumulado do ano ate o mes anterior  */
                    (
                        SELECT
                            nvl(SUM(valor), 0)
                        FROM
                            u_cfl8u4_rm.pfencargo
                        WHERE
                            codencargo IN ( '117' )
                            AND codcoligada = pfunc.codcoligada
                            AND chapa = pfunc.chapa
                            AND ( anocomp = pfh1.ano
                                  AND mescomp = pfh1.mes )
                    )                      AS valor_mensal_ceres13,
                    (
                        SELECT
                            nvl(SUM(valor), 0)
                        FROM
                            u_cfl8u4_rm.pfencargo
                        WHERE
                            codencargo IN ( '132', '134' )
                               /* baixa recisao ou 2a parcela */
                            AND codcoligada = pfunc.codcoligada
                            AND chapa = pfunc.chapa
                            AND ( anocomp = pfh1.ano
                                  AND mescomp = pfh1.mes )
                    )                      AS baixa_ceres13
                FROM
                         u_cfl8u4_rm.pfunc
                    INNER JOIN u_cfl8u4_rm.pfhstprov pfh1 ON pfh1.codcoligada = pfunc.codcoligada
                                                             AND pfh1.chapa = pfunc.chapa
                    LEFT OUTER JOIN u_cfl8u4_rm.pfhstprov pfh2 ON pfh2.codcoligada = pfh1.codcoligada
                                                                  AND pfh2.chapa = pfh1.chapa
                                                                  AND pfh2.mes = (
                        CASE
                            WHEN pfh1.mes = 1 THEN
                                12
                            ELSE
                                pfh1.mes - 1
                        END
                    )
                                                                  AND pfh2.ano = (
                        CASE
                            WHEN pfh1.mes <> 1 THEN
                                pfh1.ano
                            ELSE
                                pfh1.ano - 1
                        END
                    )
                    LEFT JOIN u_cfl8u4_rm.psecao ON ( psecao.codcoligada = pfunc.codcoligada )
                                                    AND ( psecao.codigo = pfunc.codsecao )
                    LEFT JOIN u_cfl8u4_rm.pfcompl ON ( pfunc.codcoligada = pfcompl.codcoligada )
                                                     AND ( pfunc.chapa = pfcompl.chapa )
                    LEFT JOIN u_cfl8u4_rm.pfrateiofixo ON pfrateiofixo.codcoligada = pfunc.codcoligada
                                                          AND pfrateiofixo.chapa = pfunc.chapa
                WHERE
                        pfunc.codcoligada = 1
                    AND pfh1.ano = 2022
                    AND pfh1.mes = 5
            ) tabela2
        ORDER BY
            codfilial
    ) tabela3
    RIGHT JOIN u_cfl8u4_rm.gfilial ON gfilial.codfilial = tabela3.codfilial
WHERE
    gfilial.codfilial <= 34
GROUP BY
    gfilial.codfilial,
    gfilial.cidade,
    codsecao
ORDER BY
    gfilial.codfilial