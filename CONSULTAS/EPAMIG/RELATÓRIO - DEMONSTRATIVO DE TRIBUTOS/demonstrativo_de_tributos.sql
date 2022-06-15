-- CABEÇALHO 
'PERÍODO: XX/XX/XXXX Á XX/XX/XXXX (UTILIZAR FUNÇÃO PARA TRAZER ESSES DADOS DOS FILTROS)'


-- CORPO 
'DATA:' TMOV.DATASAIDA 'DATA DA SAÍDA' OK
'TRIBUTO:' TTRBMOV.CODTRB 'CÓDIGO DO TRIBUTO' OK
'BASE DE CÁLCULO:' TTRBMOV.BASEDECALCULO 'BASE DE CÁLCULO'
'ALÍQUOTA' TTRBMOV.ALIQUOTA 'ALÍQUOTA' OK
'VALOR' TTRBMO.VALOR 'VALOR' OK
'FILIAL' TMOV.CODFILIAL 'CÓDIGO DA FILIAL' OK
'Nº DO MOVIMEMNTO' TMOV.NUMEROMOV 'NÚMERO DO MOVIMENTO' OK
'FORNECEDOR' FCFO.NOME 'NOME'
'CNPJ' FCFCO.CGCCFO 'CNPJ'
'CENTRO DE CUSTO' TITMMOV.CODCUSTO 'CENTRO DE CUSTO'

-- CAMPOS CHAVE
TMOV.CODTMV - 'CÓDIGO DO TIPO DE MOVIMENTO'
TMOV.TIPO - 'TIPO'
TMOV.DATAEMISSAO -' DATA DA EMISSÃO'
GFILIAL.NOME - 'NOME DA FILIAL'

--FILTROS
'TRIBUTO:' TTRBMOV.CODTRB 'CÓDIGO DO TRIBUTO' LIKE 
'FILIAL' TMOV.CODFILIAL 'CÓDIGO DA FILIAL' >= E <= OK
'DATA:' TMOV.DATASAIDA 'DATA DA SAÍDA' >= E <= OK











