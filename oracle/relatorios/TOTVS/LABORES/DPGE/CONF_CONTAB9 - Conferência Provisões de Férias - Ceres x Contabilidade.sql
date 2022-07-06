-- 0008.005 - RELATÓRIO ANALÍTICO PROVISÃO FÉRIAS/CERES 
SELECT
    codfilial,
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

      /* PROVISÃO FERIAS */
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
    saldo_atual_ceres_ferias
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

			   /* PROVISÃO DE FÉRIAS */

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
                    AND codencargo IN ( '124', '104' ) /* baixa rescisão e folha */
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
                    AND codencargo IN ( '119', '125' ) /* baixa rescisão e ferias */
                    AND codcoligada = pfunc.codcoligada
                    AND chapa = pfunc.chapa
                    AND ( anocomp = pfh1.ano
                          AND mescomp = pfh1.mes )
            )                                                   AS baixa_fgts_ferias,
                       

			   /*CERES FÉRIAS  */

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
            AND pfh1.ano = :ano
            AND pfh1.mes = :mes
    ) tabela
ORDER BY
    codfilial,
    nome