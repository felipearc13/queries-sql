-- 0008.006 - Relatório SINTÉTICO Provisão Férias/Ceres
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
            
      /* 13o SALÁRIO */
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
      

               /*13o Salário */
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

                /*BAIXA 13o Salário pago */
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
            )                      AS baixa_13, /* verbas pago 2a parcela('0041') e rescisão ('0042')*/

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
            )                      AS saldo_anterior_ceres13, /*saldo Anterior = Acumulado do ano até o mes anterior  */

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
                    codencargo IN ( '132', '134' ) /* baixa rescisão ou 2a parcela */
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
            AND pfh1.ano = :ano
            AND pfh1.mes = :mes
    ) tabela
ORDER BY
    codfilial,
    nome