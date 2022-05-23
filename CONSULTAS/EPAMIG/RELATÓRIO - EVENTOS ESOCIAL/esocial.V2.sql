SELECT tab1.chapa,
    tab1.nome,
    gfilial.codfilial || ' - ' || gfilial.nomefantasia AS filial,
    tab1.admissao,
    tab1.demissao,
    tab1.tipoevento,
    CASE
        WHEN tab1.tipoevento = 'S-1000' THEN 'S-1000 - Informações do Empregador/Contribuinte/Órgão Público'
        WHEN tab1.tipoevento = 'S-1005' THEN 'S-1005 - Tabela de Estabelecimentos, Obras ou Unidades de Órgãos Públicos'
        WHEN tab1.tipoevento = 'S-1010' THEN 'S-1010 - Tabela de Rubricas'
        WHEN tab1.tipoevento = 'S-1020' THEN 'S-1020 - Tabela de Lotações Tributárias'
        WHEN tab1.tipoevento = 'S-1070' THEN 'S-1070 - Tabela de Processos Administrativos/Judiciais'
        WHEN tab1.tipoevento = 'S-1200' THEN 'S-1200 - Remuneração de trabalhador vinculado ao Regime Geral de Previdência Social'
        WHEN tab1.tipoevento = 'S-1202' THEN 'S-1202 - Remuneração de servidor vinculado a Regime Próprio de Previdência Social - RPPS'
        WHEN tab1.tipoevento = 'S-1207' THEN 'S-1207 - Benefícios - Entes públicos'
        WHEN tab1.tipoevento = 'S-1210' THEN 'S-1210 - Pagamentos de Rendimentos do Trabalho'
        WHEN tab1.tipoevento = 'S-1260' THEN 'S-1260 - Comercialização da Produção Rural Pessoa Física'
        WHEN tab1.tipoevento = 'S-1270' THEN 'S-1270 - Contratação de Trabalhadores Avulsos Não Portuários'
        WHEN tab1.tipoevento = 'S-1280' THEN 'S-1280 - Informações Complementares aos Eventos Periódicos'
        WHEN tab1.tipoevento = 'S-1298' THEN 'S-1298 - Reabertura dos Eventos Periódicos'
        WHEN tab1.tipoevento = 'S-1299' THEN 'S-1299 - Fechamento dos Eventos Periódicos'
        WHEN tab1.tipoevento = 'S-2190' THEN 'S-2190 - Registro Preliminar de Trabalhador'
        WHEN tab1.tipoevento = 'S-2200' THEN 'S-2200 - Cadastramento Inicial do Vínculo e admissao/Ingresso de Trabalhador'
        WHEN tab1.tipoevento = 'S-2205' THEN 'S-2205 - Alteração de Dados Cadastrais do Trabalhador'
        WHEN tab1.tipoevento = 'S-2206' THEN 'S-2206 - Alteração de Contrato de Trabalho/Relação Estatutária'
        WHEN tab1.tipoevento = 'S-2210' THEN 'S-2210 - Comunicação de Acidente de Trabalho'
        WHEN tab1.tipoevento = 'S-2220' THEN 'S-2220 - Monitoramento da Saúde do Trabalhador'
        WHEN tab1.tipoevento = 'S-2230' THEN 'S-2230 - Afastamento Temporário'
        WHEN tab1.tipoevento = 'S-2231' THEN 'S-2231 - Cessão/Exercício em outro Órgão'
        WHEN tab1.tipoevento = 'S-2240' THEN 'S-2240 - Condições Ambientais do Trabalho - Agentes Nocivos'
        WHEN tab1.tipoevento = 'S-2298' THEN 'S-2298 - Reintegração/Outros provimentos'
        WHEN tab1.tipoevento = 'S-2299' THEN 'S-2299 - Desligamento'
        WHEN tab1.tipoevento = 'S-2300' THEN 'S-2300 - Trabalhador Sem Vínculo de Emprego/Estatutário - Início'
        WHEN tab1.tipoevento = 'S-2306' THEN 'S-2306 - Trabalhador Sem Vínculo de Emprego/Estatutário - Alteração Contratual'
        WHEN tab1.tipoevento = 'S-2399' THEN 'S-2399 - Trabalhador Sem Vínculo de Emprego/Estatutário - Término'
        WHEN tab1.tipoevento = 'S-2400' THEN 'S-2400 - Cadastro de Beneficiários - Entes Públicos'
        WHEN tab1.tipoevento = 'S-2405' THEN 'S-2405 - Alteração de Dados Cadastrais do Beneficiário - Entes Públicos'
        WHEN tab1.tipoevento = 'S-2410' THEN 'S-2410 - Cadastro de Benefícios Ente Público'
        WHEN tab1.tipoevento = 'S-2416' THEN 'S-2416 - Alteração do Cadastro de Benefícios - Entes Públicos'
        WHEN tab1.tipoevento = 'S-2418' THEN 'S-2418 - Reativação de Benefícios'
        WHEN tab1.tipoevento = 'S-2420' THEN 'S-2420 - Cadastro de Benefícios - Entes Públicos - Término'
        WHEN tab1.tipoevento = 'S-3000' THEN 'S-3000 - Exclusão de Eventos'
        WHEN tab1.tipoevento = 'S-5001' THEN 'S-5001 - Informações das contribuições sociais consolidadas por trabalhador'
        WHEN tab1.tipoevento = 'S-5002' THEN 'S-5002 - Imposto de Renda Retido na Fonte'
        WHEN tab1.tipoevento = 'S-5003' THEN 'S-5003 - Informações do FGTS por Trabalhador'
        WHEN tab1.tipoevento = 'S-5011' THEN 'S-5011 - Informações das contribuições sociais consolidadas por contribuinte'
        WHEN tab1.tipoevento = 'S-5013' THEN 'S-5013 - Informações do FGTS consolidadas por contribuinte'
        ELSE to_char(tab1.tipoevento)
    END AS evento,
    CASE
        WHEN tab1.status = 0 THEN '0 - Pendente'
        WHEN tab1.status = 1 THEN '1 - Gerado'
        WHEN tab1.status = 2 THEN '2 - Erro na geração'
        WHEN tab1.status = 3 THEN '3 - Enviado'
        WHEN tab1.status = 4 THEN '4 - Aceito TAF'
        WHEN tab1.status = 5 THEN '5 - Erro na integração'
        WHEN tab1.status = 6 THEN '6 - Rejeitado TAF'
        WHEN tab1.status = 7 THEN '7 - Cancelado'
        WHEN tab1.status = 8 THEN '8 - Retificado'
        WHEN tab1.status = 9 THEN '9 - Rejeitado RET'
        WHEN tab1.status = 10 THEN '10 - Aceito RET'
        WHEN tab1.status = 11 THEN '11 - Excluído RET'
        ELSE to_char(tab1.status)
    END AS status_evento,
    tab1.id,
    tab1.dt_evento,
    tab1.dt_envio
FROM (
        SELECT pfunc.chapa,
            ppessoa.nome,
            pfunc.dataadmissao AS admissao,
            pfunc.datademissao AS demissao,
            pesocialeventos.tipoevento,
            pesocialeventos.status,
            id,
            pfunc.codsecao,
            dataevento AS dt_evento,
            dataenvio AS dt_envio
        FROM u_cfl8u4_rm.pfunc
            right JOIN u_cfl8u4_rm.pesocialeventos ON pesocialeventos.chapa = pfunc.chapa
            RIGHT JOIN u_cfl8u4_rm.ppessoa ON ppessoa.codigo = pfunc.codpessoa
        WHERE tipoevento <> 'S-2190'
            AND to_char(dataenvio, 'dd/mm/yyyy') = :data_envio
        UNION
        SELECT pfunc.chapa,
            ppessoa.nome,
            pfunc.dataadmissao AS admissao,
            pfunc.datademissao AS demissao,
            pesocialeventos.tipoevento,
            pesocialeventos.status,
            id,
            pfunc.codsecao,
            dataevento,
            dataenvio
        FROM u_cfl8u4_rm.pesocialeventos
            LEFT JOIN u_cfl8u4_rm.pfuncpreliminar ON pesocialeventos.idregpreliminar = pfuncpreliminar.idregistro
            LEFT JOIN u_cfl8u4_rm.pfunc ON pfuncpreliminar.chapa = pfunc.chapa
            LEFT JOIN u_cfl8u4_rm.ppessoa ON pfunc.codpessoa = ppessoa.codigo
        WHERE tipoevento = 'S-2190'
            AND to_char(dataenvio, 'dd/mm/yyyy') = :data_envio
    ) tab1
    LEFT JOIN u_cfl8u4_rm.psecao ON tab1.codsecao = psecao.codigo
    LEFT JOIN u_cfl8u4_rm.gfilial ON psecao.codfilial = gfilial.codfilial
WHERE chapa = '012691'
    AND tab1.nome LIKE 'MARCIO FERREIRA DA COSTA'
    AND admissao = '01/02/2022'
    AND tab1.demissao IS NULL
    AND tipoevento = 'S-2190'
    AND tab1.status = '10'
    AND tab1.id = 'ID1171381400000002022013114223500000'
    AND to_char(tab1.dt_evento, 'dd/mm/yyyy') = :data_evento
ORDER BY chapa,
    nome,
    evento