SELECT codfilial,
       nomefantasia,
       codfilial,
       nomefantasia,
       codloc,
       nome,
       codloc,
       nome,
       descricao,
       codconta,
       ( CASE
           WHEN CODCONTA_N1 = '1.1.1.01' THEN 'CAIXA                                  '
           WHEN CODCONTA_N1 = '1.1.1.02' THEN 'FUNDO FIXO'
           WHEN CODCONTA_N1 = '1.1.1.03' THEN 'BANCOS CONTA MOVIMENTO'
           WHEN CODCONTA_N1 = '1.1.1.04' THEN 'VALORES EM TRANSITO CONTA MOVIMENTO'
           WHEN CODCONTA_N1 = '1.1.1.05' THEN 'BANCOS CONTA CONVENIO'
           WHEN CODCONTA_N1 = '1.1.1.06' THEN 'VALORES EM TRANSITO CONTA CONVENIO'
           WHEN CODCONTA_N1 = '1.1.1.07' THEN 'APLICACOES LIQUIDEZ IMEDIATA CONTA MOVTO'
           WHEN CODCONTA_N1 = '1.1.1.08' THEN 'APLICACAO LIQUIDEZ IMEDIATA CTA CONVENIO'
           WHEN CODCONTA_N1 = '1.1.1.09' THEN 'VALORES EM TRANSITO PELO DAE DEC. 44180'
           WHEN CODCONTA_N1 = '1.1.2.01' THEN 'CLIENTES'
           WHEN CODCONTA_N1 = '1.1.2.02' THEN 'PROVISAO P/CREDITOS LIQUIDACAO DUVIDOSA '
           WHEN CODCONTA_N1 = '1.1.2.03' THEN 'DEPOSITOS BANCARIOS VINCULADOS'
           WHEN CODCONTA_N1 = '1.1.2.04' THEN 'CHEQUES EM COBRANÇA'
           WHEN CODCONTA_N1 = '1.1.2.05' THEN 'ADIANTAMENTOS PARA VIAGENS'
           WHEN CODCONTA_N1 = '1.1.2.06' THEN 'ADIANTAMENTOS PARA VIAGENS CONVENIOS'
           WHEN CODCONTA_N1 = '1.1.2.07' THEN 'ADIANTAMENTOS A FORNECEDORES'
           WHEN CODCONTA_N1 = '1.1.2.08' THEN 'ADIANTAMENTOS INERENTES FOLHA DE PAGTO.'
           WHEN CODCONTA_N1 = '1.1.2.09' THEN 'ADIANTAMENTOS DIVERSOS'
           WHEN CODCONTA_N1 = '1.1.2.10' THEN 'IRPJ/CSLL PAGOS POR ESTIMATIVA'
           WHEN CODCONTA_N1 = '1.1.2.11' THEN 'IMPOSTOS CONTRIB. A RECUPERAR/COMPENSAR '
           WHEN CODCONTA_N1 = '1.1.2.12' THEN 'OUTROS VALORES A RECUPERAR'
           WHEN CODCONTA_N1 = '1.1.2.13' THEN 'RECURSOS A RECEBER TESOURO ESTADUAL'
           WHEN CODCONTA_N1 = '1.1.3.01' THEN 'MATÉRIAS-PRIMAS'
           WHEN CODCONTA_N1 = '1.1.3.02' THEN 'MATERIAL DE USO E CONSUMO'
           WHEN CODCONTA_N1 = '1.1.3.03' THEN 'PRODUTOS AGROPECUÁRIOS EM FORMAÇÃO'
           WHEN CODCONTA_N1 = '1.1.3.04' THEN 'PRODUTOS EM ELABORAÇÃO'
           WHEN CODCONTA_N1 = '1.1.3.05' THEN 'PRODUTOS AGROPECUÁRIOS ACABADOS'
           WHEN CODCONTA_N1 = '1.1.3.06' THEN 'PRODUTOS ACABADOS'
           WHEN CODCONTA_N1 = '1.1.3.07' THEN 'MERCADORIAS PARA REVENDA'
           WHEN CODCONTA_N1 = '1.1.3.08' THEN 'ANIMAIS'
           WHEN CODCONTA_N1 = '1.1.3.09' THEN 'ESTOQUE EM PODER DE TERCEIROS'
           WHEN CODCONTA_N1 = '1.1.3.10' THEN 'TRANSFERÊNCIA DE PRODUTOS E MERCADORIAS'
           WHEN CODCONTA_N1 = '1.1.3.11' THEN 'TRANSFERÊNCIA DE ANIMAIS'
           WHEN CODCONTA_N1 = '1.1.3.12' THEN 'OUTROS ESTOQUES'
           WHEN CODCONTA_N1 = '1.1.4.01' THEN 'SEGUROS A APROPRIAR'
           WHEN CODCONTA_N1 = '1.1.4.02' THEN 'ASSINATURAS A APROPRIAR'
           WHEN CODCONTA_N1 = '1.1.4.03' THEN 'DESPESAS ANTECIPADAS'
           WHEN CODCONTA_N1 = '1.1.4.04' THEN 'CONTRAPARTIDA FINANCEIRA CONVÊNIO'
           WHEN CODCONTA_N1 = '1.2.1.01' THEN 'DEPOSITOS JUDICIAIS'
           WHEN CODCONTA_N1 = '1.2.1.02' THEN 'DEPOSITO RECURSAL'
           WHEN CODCONTA_N1 = '1.2.1.03' THEN 'EMPRESTIMOS COMPULSORIOS'
           WHEN CODCONTA_N1 = '1.2.1.04' THEN 'DESPESAS ANTECIPADAS LONGO PRAZO'
           WHEN CODCONTA_N1 = '1.2.1.05' THEN 'RECURSOS A RECEBER TESOURO ESTADUAL'
           WHEN CODCONTA_N1 = '1.2.1.06' THEN 'ATIVOS FISCAIS DIFERIDOS'
           WHEN CODCONTA_N1 = '1.2.2.01' THEN 'PARTICIPAÇÃO PERMAN.EM OUTRAS SOCIEDADES'
           WHEN CODCONTA_N1 = '1.2.3.01' THEN 'TERRENOS'
           WHEN CODCONTA_N1 = '1.2.3.02' THEN 'EDIFÍCIOS, BENFEITORIAS E INSTALAÇÕES'
           WHEN CODCONTA_N1 = '1.2.3.03' THEN 'MAQUINAS, APARELHOS E EQUIPAMENTOS'
           WHEN CODCONTA_N1 = '1.2.3.04' THEN 'EQUIPAMENTOS DE PROCESSAMENTO DE DADOS'
           WHEN CODCONTA_N1 = '1.2.3.05' THEN 'MÓVEIS E UTENSILIOS'
           WHEN CODCONTA_N1 = '1.2.3.06' THEN 'VEÍCULOS'
           WHEN CODCONTA_N1 = '1.2.3.07' THEN 'BIBLIOTECA, MAPOTECA E DISCOTECA'
           WHEN CODCONTA_N1 = '1.2.3.08' THEN 'IMOBILIZADO BIOLÓGICO'
           WHEN CODCONTA_N1 = '1.2.3.09' THEN 'OBRAS EM ANDAMENTO'
           WHEN CODCONTA_N1 = '1.2.3.10' THEN 'IMOBILIZADO ADIANTAMENTO A FORNECEDORES '
           WHEN CODCONTA_N1 = '1.2.3.11' THEN 'CORREÇÃO MONETÁRIA DIFERENÇA IPC/BTNF/90'
           WHEN CODCONTA_N1 = '1.2.3.12' THEN 'DEPRECIAÇÃO ACUMULADA'
           WHEN CODCONTA_N1 = '1.2.3.13' THEN 'DEPRECIAÇÃO ACUMUL.DIFERENÇA IPC/BTNF/90'
           WHEN CODCONTA_N1 = '1.2.3.14' THEN 'TRANSFERÊNCIA DE BENS MÓVEIS'
           WHEN CODCONTA_N1 = '1.2.4.01' THEN 'MARCAS E PATENTES'
           WHEN CODCONTA_N1 = '1.2.4.02' THEN 'DIREITO DE USO '
           WHEN CODCONTA_N1 = '1.2.4.03' THEN 'REGISTRO DE PATENTES EM ANDAMENTO'
           WHEN CODCONTA_N1 = '1.2.4.04' THEN 'CORREÇÃO MONETÁRIA DIFERENÇA IPC/BTNF/90'
           WHEN CODCONTA_N1 = '1.2.4.05' THEN 'AMORTIZAÇÃO ACUMULADA'
           WHEN CODCONTA_N1 = '2.1.1.01' THEN 'FORNECEDORES'
           WHEN CODCONTA_N1 = '2.1.1.02' THEN 'ADIANTAMENTO DE CLIENTES'
           WHEN CODCONTA_N1 = '2.1.1.03' THEN 'SALÁRIOS E ENCARGOS SOCIAIS'
           WHEN CODCONTA_N1 = '2.1.1.04' THEN 'CREDORES DIVERSOS'
           WHEN CODCONTA_N1 = '2.1.1.05' THEN 'PARCELAMENTO DE AÇÕES JUDICIAIS'
           WHEN CODCONTA_N1 = '2.1.2.01' THEN 'TRIBUTOS E CONTRIBUIÇÕES A RECOLHER'
           WHEN CODCONTA_N1 = '2.1.2.02' THEN 'PARCELAMENTOS DE DÉBITOS FISCAIS'
           WHEN CODCONTA_N1 = '2.1.3.01' THEN 'CREDORES POR CONVÊNIO'
           WHEN CODCONTA_N1 = '2.1.4.01' THEN 'PROVISÃO DE FÉRIAS '
           WHEN CODCONTA_N1 = '2.1.4.02' THEN 'PROVISÃO DE 13º SALÁRIO '
           WHEN CODCONTA_N1 = '2.1.4.03' THEN 'PROVISÃO DE AÇÕES TRABALHISTAS'
           WHEN CODCONTA_N1 = '2.1.4.04' THEN 'OUTRAS PROVISÕES'
           WHEN CODCONTA_N1 = '2.1.5.01' THEN 'PRODUTOS DE TERCEIROS EM NOSSO PODER '
           WHEN CODCONTA_N1 = '2.2.1.01' THEN 'PARCELAMENTOS DE DÉBITOS FISCAIS'
           WHEN CODCONTA_N1 = '2.2.1.02' THEN 'FORNECEDORES'
           WHEN CODCONTA_N1 = '2.2.1.03' THEN 'PROVISÃO PARA RISCOS TRABALHISTAS'
           WHEN CODCONTA_N1 = '2.2.1.04' THEN 'PROVISÃO PARA RISCOS CIVEIS'
           WHEN CODCONTA_N1 = '2.2.1.05' THEN 'OUTRAS PROVISÕES'
           WHEN CODCONTA_N1 = '2.3.1.01' THEN 'CAPITAL SOCIAL'
           WHEN CODCONTA_N1 = '2.3.2.01' THEN 'RESERVAS DE CAPITAL'
           WHEN CODCONTA_N1 = '2.3.2.02' THEN 'RESERVAS DE LUCROS'
           WHEN CODCONTA_N1 = '2.3.3.01' THEN 'PREJUÍZOS ACUMULADOS'
           WHEN CODCONTA_N1 = '2.3.4.01' THEN 'AJUSTES DE AVALIAÇÃO PATRIMONIAL'
           WHEN CODCONTA_N1 = '3.1.1.01' THEN 'MATÉRIA-PRIMA DIRETA'
           WHEN CODCONTA_N1 = '3.1.1.02' THEN 'MÃO-DE-OBRA DIRETA'
           WHEN CODCONTA_N1 = '3.1.1.03' THEN 'CUSTOS INDIRETOS'
           WHEN CODCONTA_N1 = '3.1.1.04' THEN 'CUSTO DO SERVIÇO PRESTADO'
           WHEN CODCONTA_N1 = '3.1.1.05' THEN 'CUSTO DO PRODUTO AGROPECUARIO VENDIDO'
           WHEN CODCONTA_N1 = '3.1.1.06' THEN 'CUSTO DE REVISTAS E PUBLICAÇÕES VENDIDAS'
           WHEN CODCONTA_N1 = '3.1.1.07' THEN 'CUSTO DOS ANIMAIS VENDIDOS'
           WHEN CODCONTA_N1 = '3.1.1.08' THEN 'CUSTO DO PRODUTO INDUSTRIAL VENDIDO'
           WHEN CODCONTA_N1 = '3.1.1.09' THEN 'CUSTO DA MERCADORIA REVENDIDA'
           WHEN CODCONTA_N1 = '3.1.1.10' THEN 'PERDAS DE PRODUTOS'
           WHEN CODCONTA_N1 = '3.1.1.11' THEN 'PERDAS DE ANIMAIS'
           WHEN CODCONTA_N1 = '3.2.1.01' THEN 'DESPESA COM PESSOAL DE VENDAS '
           WHEN CODCONTA_N1 = '3.2.1.02' THEN 'DESPESAS COMERCIAIS'
           WHEN CODCONTA_N1 = '3.2.2.01' THEN 'DESPESA COM PESSOAL ADMINISTRATIVO'
           WHEN CODCONTA_N1 = '3.2.2.02' THEN 'MATERIAL DE CONSUMO'
           WHEN CODCONTA_N1 = '3.2.2.03' THEN 'SERVIÇOS DE TERCEIROS'
           WHEN CODCONTA_N1 = '3.2.2.04' THEN 'DESPESAS GERAIS '
           WHEN CODCONTA_N1 = '3.2.2.05' THEN 'DESPESAS COM PROVISÕES'
           WHEN CODCONTA_N1 = '3.2.3.01' THEN 'INSUBSISTÊNCIAS ATIVAS'
           WHEN CODCONTA_N1 = '3.2.3.02' THEN 'PERDAS DE PRODUTOS'
           WHEN CODCONTA_N1 = '3.2.3.03' THEN 'PERDAS DE ANIMAIS'
           WHEN CODCONTA_N1 = '3.3.1.01' THEN 'DESPESAS FINANCEIRAS'
           WHEN CODCONTA_N1 = '3.3.1.02' THEN '( - ) RECEITAS FINANCEIRAS'
           WHEN CODCONTA_N1 = '3.4.1.01' THEN 'IMPOSTO DE RENDA E CONTRIBUIÇÃO SOCIAL'
           WHEN CODCONTA_N1 = '4.1.1.01' THEN 'PRODUTOS AGROPECUÁRIOS'
           WHEN CODCONTA_N1 = '4.1.1.02' THEN 'REVISTAS E PUBLICAÇÕES'
           WHEN CODCONTA_N1 = '4.1.1.03' THEN 'ANIMAIS'
           WHEN CODCONTA_N1 = '4.1.1.04' THEN 'PRODUTOS INDUSTRIALIZADOS'
           WHEN CODCONTA_N1 = '4.1.1.05' THEN 'VENDA DE SERVIÇOS'
           WHEN CODCONTA_N1 = '4.1.1.06' THEN 'REVENDA DE MERCADORIAS'
           WHEN CODCONTA_N1 = '4.1.2.01' THEN '(-) DEDUÇÕES DA RECEITA'
           WHEN CODCONTA_N1 = '4.2.1.01' THEN 'TRANSFERENCIAS DE RECURSOS DO ESTADO'
           WHEN CODCONTA_N1 = '4.2.1.02' THEN 'TRANSFERENCIAS DE RECURSOS DO MUNICÍPIO'
           WHEN CODCONTA_N1 = '4.2.2.01' THEN 'RECURSOS DE CONVÊNIOS PODER PÚBLICO'
           WHEN CODCONTA_N1 = '4.2.2.02' THEN 'RECURSOS DE CONVÊNIOS INICIATIVA PRIVADA'
           WHEN CODCONTA_N1 = '4.2.3.01' THEN 'RECEITAS DE DOAÇÕES DO PODER PÚBLICO'
           WHEN CODCONTA_N1 = '4.2.4.01' THEN 'SUPERVENIÊNCIAS ATIVAS'
           WHEN CODCONTA_N1 = '4.2.5.01' THEN 'DIVERSAS RECEITAS OPERACIONAIS'
           WHEN CODCONTA_N1 = '4.3.1.01' THEN 'GANHOS E PERDAS NO IMOBILIZADO/INTANGIVE'
           WHEN CODCONTA_N1 = '4.3.1.02' THEN 'OUTROS GANHOS E PERDAS'
           WHEN CODCONTA_N1 = '4.3.2.01' THEN 'RESULTADO DA CORRECAO MONETARIA'
           WHEN CODCONTA_N1 = '5.1.1.01' THEN 'APURAÇÃO DO RESULTADO'
           WHEN CODCONTA_N1 = '5.1.2.01' THEN 'RESULTADOS TRIMESTRAIS'
           WHEN CODCONTA_N1 = '5.1.3.01' THEN 'RESULTADOS ACUMULADOS'
           WHEN CODCONTA_N1 = '6.1.1.01' THEN 'BENS RECEBIDOS EM CONVENIOS/COMODATO'
           WHEN CODCONTA_N1 = '6.1.1.02' THEN 'REMESSA EM CONSIGNACAO'
           WHEN CODCONTA_N1 = '6.1.1.03' THEN 'BENS/MERCAD RECEBIDOS EM DEMONSTRACAO'
           WHEN CODCONTA_N1 = '6.1.1.04' THEN 'MERCAD RECEBIDAS PARA BENEF/INDUSTRIALIZ'
           WHEN CODCONTA_N1 = '6.1.1.05' THEN 'SIMPLES FAT.COMPRA P/RECEBIMENTO FUTURO'
           WHEN CODCONTA_N1 = '6.1.1.06' THEN 'MERCADORIAS RECEBIDAS EM CONSIGNACAO'
           WHEN CODCONTA_N1 = '6.1.1.07' THEN 'ANIMAIS RECEBIDOS EM CONVENIOS/COMODATO'
           WHEN CODCONTA_N1 = '6.1.1.08' THEN 'REMESSA DE ANIMAIS EM CONVENIOS/COMODATO'
           WHEN CODCONTA_N1 = '6.1.1.09' THEN 'SIMPLES FAT.VENDA PARA ENTREGA FUTURA'
           WHEN CODCONTA_N1 = '6.1.1.10' THEN 'DIVERSOS RESPONSAVEIS EM APURACAO'
           WHEN CODCONTA_N1 = '6.1.1.11' THEN 'PRODUTOS DE TERCEIROS EM NOSSO PODER/VENDA PARA ENTREGA FUTURA'
           WHEN CODCONTA_N1 = '7.1.1.01' THEN 'BENS DE TERCEIROS EM CONVENIOS/COMODATO'
           WHEN CODCONTA_N1 = '7.1.1.02' THEN 'MERCADORIAS COM TERCEIROS CONSIGNATARIOS'
           WHEN CODCONTA_N1 = '7.1.1.03' THEN 'BENS/MERCAD DE TERCEIROS EM DEMONSTRACAO'
           WHEN CODCONTA_N1 = '7.1.1.04' THEN 'MERCAD DE TERCEIROS P/ BENEF/INDUSTRIAL'
           WHEN CODCONTA_N1 = '7.1.1.05' THEN 'SIMPLES FAT.COMPRA P/RECEBIMENTO FUTURO'
           WHEN CODCONTA_N1 = '7.1.1.06' THEN 'MERCADORIAS DE TERCEIROS CONSIGNANTES'
           WHEN CODCONTA_N1 = '7.1.1.07' THEN 'ANIMAIS DE TERCEIROS CONVENIOS/COMODATO'
           WHEN CODCONTA_N1 = '7.1.1.08' THEN 'ANIMAIS COM TERCEIROS CONVENIOS/COMODATO'
           WHEN CODCONTA_N1 = '7.1.1.09' THEN 'SIMPLES FAT.VENDA PARA ENTREGA FUTURA'
           WHEN CODCONTA_N1 = '7.1.1.10' THEN 'DIVERSOS RESPONSAVEIS EM APURACAO'
           WHEN CODCONTA_N1 = '7.1.1.11' THEN 'PRODUTOS DE TERCEIROS EM NOSSO PODER/VENDA PARA ENTREGA FUTURA'
         END )                      AS descricao_n1,
       codconta_n1,
       NVL(SUM(baixa), 0)           AS baixas,
       NVL(SUM(trasf_saida), 0)     AS transf_saida,
       NVL(SUM(vendas), 0)          AS vendas,
       NVL(SUM(outras_saidas), 0)   AS outras_saidas,
       NVL(SUM(outras_entradas), 0) AS outras_entradas,
       NVL(SUM(compras), 0)         AS compras,
       NVL(SUM(transferencia), 0)   AS transf_entrada
FROM   (SELECT codconta,
               SUBSTR(codconta, 1, 8) AS codconta_n1,
               descricao,
               tloc.codfilial,
               gfilial.nomefantasia,
               tloc.codloc,
               tloc.nome,
               CASE
                 WHEN codtmv IN ( '1.1.04', '1.1.20', '1.1.24', '1.1.41' ) THEN NVL(SUM(valortotal), 0)
               END                    AS baixa,
               CASE
                 WHEN codtmv = '2.2.16' THEN NVL(SUM(valortotal), 0)
               END                    AS trasf_saida,
               CASE
                 WHEN codtmv IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.21',
                                  '2.2.47', '2.2.51', '2.2.54' ) THEN NVL(SUM(valortotal), 0)
               END                    AS vendas,
               CASE
                 WHEN codtmv IN ( '2.2.09', '2.2.14', '4.1.02', '4.1.09',
                                  '4.1.14', '4.1.16' ) THEN NVL(SUM(valortotal), 0)
               END                    AS outras_saidas,
               CASE
                 WHEN codtmv IN ( '1.1.13', '1.1.21', '1.1.22', '1.1.40',
                                  '1.2.09', '1.2.41', '1.2.48', '1.2.51',
                                  '1.2.61', '1.2.63', '1.2.72', '1.2.75',
                                  '4.1.01', '4.1.08', '4.1.13', '4.1.15' ) THEN NVL(SUM(valortotal), 0)
               END                    AS outras_entradas,
               CASE
                 WHEN codtmv IN ( '1.2.02', '1.2.07', '1.2.23', '1.2.24',
                                  '1.2.28', '1.2.29', '1.2.17' ) THEN NVL(SUM(valortotal), 0)
               END                    AS compras,
               CASE
                 WHEN codtmv IN ( '1.2.17' ) THEN NVL(SUM(valortotal), 0)
               END                    AS transferencia
        FROM   (SELECT codtmv,
                       nome_mov,
                       codconta,
                       descricao,
                       CASE
                         /*  WHEN '01/12/2021' >= '01/01/2017'*/
                         WHEN '01/12/2021' >= '01/01/2017' THEN TRUNC(SUM(valortotal_atual), 2)
                         ELSE TRUNC(SUM(valortotal), 2)
                       END AS valortotal,
                       codfilial,
                       codloc
                FROM   (SELECT codtmv,
                               nome_mov,
                               codconta,
                               descricao,
                               ( CASE
                                   WHEN codtmv IN ( '1.2.02', '1.2.09', '1.2.61', '1.2.63',
                                                    '1.2.23', '1.2.48' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(totalentrada), 2) * ( -1 )
                                   WHEN codtmv IN ( '1.2.02', '1.2.09', '1.2.61', '1.2.63',
                                                    '1.2.23', '1.2.48' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(totalentrada), 2)
                                   WHEN codtmv LIKE '1%'
                                        AND codtmv NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61',
                                                            '1.2.63', '1.2.23', '1.2.48', '1.2.75' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(valorbrutoitem), 2) * ( -1 )
                                   WHEN codtmv LIKE '1%'
                                        AND codtmv NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61',
                                                            '1.2.63', '1.2.23', '1.2.48', '1.2.75' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(valorbrutoitem), 2)
                                   WHEN codtmv IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                    '2.2.09', '2.2.21', '2.2.22', '2.2.47' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(totalsaida), 2) * ( -1 )
                                   WHEN codtmv IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                    '2.2.09', '2.2.21', '2.2.22', '2.2.47' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(totalsaida), 2)
                                   WHEN codtmv LIKE '2%'
                                        AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                            '2.2.09', '2.2.21', '2.2.22', '2.2.47' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(valorbrutoitem), 2) * ( -1 )
                                   WHEN codtmv LIKE '2%'
                                        AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                            '2.2.09', '2.2.21', '2.2.22', '2.2.47' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(valorbrutoitem), 2)
                                   WHEN codtmv LIKE '3%'
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(valorbrutoitem), 2) * ( -1 )
                                   WHEN codtmv LIKE '3%'
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(valorbrutoitem), 2)
                                   WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(valorbrutoitem), 2) * ( -1 )
                                   WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(valorbrutoitem), 2)
                                   WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(valorbrutoitem), 2) * ( -1 )
                                   WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(valorbrutoitem), 2)
                                   ELSE SUM(valorbrutoitem)
                                 END ) AS valortotal,
                               ( CASE
                                   WHEN codtmv IN ( '1.2.02', '1.2.09', '1.2.61', '1.2.63',
                                                    '1.2.23', '1.2.48' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(totalentrada), 2) * ( -1 )
                                   WHEN codtmv IN ( '1.2.02', '1.2.09', '1.2.61', '1.2.63',
                                                    '1.2.23', '1.2.48' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(totalentrada), 2)
                                   WHEN codtmv LIKE '1%'
                                        AND codtmv NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61',
                                                            '1.2.63', '1.2.23', '1.2.48', '1.1.04',
                                                            '1.1.43', '1.2.75' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(valorbrutoitem), 2) * ( -1 )
                                   WHEN codtmv LIKE '1%'
                                        AND codtmv NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61',
                                                            '1.2.63', '1.2.23', '1.2.48', '1.1.04',
                                                            '1.1.43', '1.2.75' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(valorbrutoitem), 2)
                                   WHEN codtmv IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                    '2.2.09', '2.2.21', '2.2.22', '1.1.04',
                                                    '2.2.14', '2.2.47', '2.2.51', '2.2.16',
                                                    '1.1.43', '1.2.75' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(totalsaida), 2) * ( -1 )
                                   WHEN codtmv IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                    '2.2.09', '2.2.21', '2.2.22', '1.1.04',
                                                    '2.2.14', '2.2.47', '2.2.51', '2.2.16',
                                                    '1.1.43', '1.2.75' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(totalsaida), 2)
                                   WHEN codtmv LIKE '2%'
                                        AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                            '2.2.09', '2.2.21', '2.2.22', '2.2.14',
                                                            '2.2.47', '2.2.51', '2.2.16' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(valorbrutoitem), 2) * ( -1 )
                                   WHEN codtmv LIKE '2%'
                                        AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08',
                                                            '2.2.09', '2.2.21', '2.2.22', '2.2.14',
                                                            '2.2.47', '2.2.51', '2.2.16' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(valorbrutoitem), 2)
                                   WHEN codtmv LIKE '3%'
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(valorbrutoitem), 2) * ( -1 )
                                   WHEN codtmv LIKE '3%'
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(valorbrutoitem), 2)
                                   WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(valorbrutoitem), 2) * ( -1 )
                                   WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(valorbrutoitem), 2)
                                   WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) < 0 THEN TRUNC(SUM(valorbrutoitem), 2) * ( -1 )
                                   WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17' )
                                        AND SUM(TRUNC(valorfincomsinal, 2)) >= 0 THEN TRUNC(SUM(valorbrutoitem), 2)
                                   ELSE SUM(valorbrutoitem)
                                 END ) AS valortotal_atual,
                               codfilial,
                               codloc
                        FROM   (SELECT tmov.codtmv,
                                       ttmv.nome                      AS nome_mov,
                                       cconta.codconta,
                                       cconta.descricao,
                                       tprd.codigoprd,
                                       trelsld.idmov,
                                       SUM(trelsld.valorfincomsinal)  AS valorfincomsinal,
                                       ROUND(trelsld.totalsaida, 2)   AS totalsaida,
                                       ROUND(trelsld.totalentrada, 2) AS totalentrada,
                                       titmmov.valorbrutoitem,
                                       qtdesaida,
                                       customeditem,
                                       trelsld.idprd,
                                       trelsld.nseqitmmov,
                                       trelsld.codloc,
                                       tmov.codfilial
                                FROM   U_CFL8U4_RM.trelsld
                                       LEFT JOIN U_CFL8U4_RM.tmov
                                              ON trelsld.idmov = tmov.idmov
                                       LEFT JOIN U_CFL8U4_RM.titmmov
                                              ON titmmov.idmov = trelsld.idmov
                                                 AND titmmov.idprd = trelsld.idprd
                                                 AND titmmov.nseqitmmov = trelsld.nseqitmmov
                                       LEFT JOIN U_CFL8U4_RM.tprd
                                              ON trelsld.idprd = tprd.idprd
                                       /* RIGHT JOIN U_CFL8U4_RM.TTB4
                                        ON TTB4.CODTB4FAT = TITMMOV.CODTB4FAT */
                                       RIGHT JOIN U_CFL8U4_RM.ttb4
                                               ON ttb4.codtb4fat = tprd.codtb4fat
                                       RIGHT JOIN U_CFL8U4_RM.ttb4cont
                                               ON ttb4cont.codtb4fat = ttb4.codtb4fat
                                       RIGHT JOIN U_CFL8U4_RM.cconta
                                               ON cconta.codconta = ttb4cont.codconta
                                       RIGHT JOIN U_CFL8U4_RM.gfilial
                                               ON gfilial.codcoligada = tmov.codcoligada
                                                  AND gfilial.codfilial = tmov.codfilial
                                       RIGHT JOIN U_CFL8U4_RM.tloc
                                               ON tloc.codcoligada = trelsld.codcoligada
                                                  AND tloc.codfilial = trelsld.codfilial
                                                  AND tloc.codloc = trelsld.codloc
                                       RIGHT JOIN U_CFL8U4_RM.ttmv
                                               ON ttmv.codtmv = tmov.codtmv
                                WHERE  TRELSLD.DATAMOVIMENTO >= :DATAINICIO
                                       AND TRELSLD.DATAMOVIMENTO <= :DATAFIM
                                       AND TRELSLD.CODLOC >= :CODLOC_INICIAL
                                       AND TRELSLD.CODLOC <= :CODLOC_FINAL
                                       AND TRELSLD.CODFILIAL >= :CODFILIAL_INICIAL
                                       AND TRELSLD.CODFILIAL <= :CODFILIAL_FINAL
                                       /*   WHERE
                                                 trelsld.datamovimento >= '01/12/2019'
                                             AND trelsld.datamovimento < '01/12/2021'
                                             AND trelsld.codloc >= '01.001.01'
                                             AND trelsld.codloc <= '99.999.99'
                                             AND trelsld.codfilial >= 1
                                             AND trelsld.codfilial <= 1 */
                                       AND trelsld.saldo = 2
                                       AND tmov.codtmv IN ( '1.1.04', '1.1.13', '1.1.20', '1.1.21',
                                                            '1.1.22', '1.1.24', '1.1.40', '1.1.41',
                                                            '1.2.02', '1.2.07', '1.2.09', '1.2.17',
                                                            '1.2.23', '1.2.24', '1.2.28', '1.2.29',
                                                            '1.2.41', '1.2.48', '1.2.51', '1.2.61',
                                                            '1.2.63', '1.2.72', '1.2.75', '2.2.01',
                                                            '2.2.07', '2.2.08', '2.2.09', '2.2.14',
                                                            '2.2.16', '2.2.21', '2.2.47', '2.2.51',
                                                            '2.2.54', '4.1.01', '4.1.02', '4.1.08',
                                                            '4.1.09', '4.1.13', '4.1.14', '4.1.15', '4.1.16' )
                                       AND ttb4cont.classconta = 'ESTOQUE'
                                GROUP  BY tmov.codtmv,
                                          ttmv.nome,
                                          cconta.codconta,
                                          cconta.descricao,
                                          trelsld.idprd,
                                          tmov.idmov,
                                          trelsld.idprd,
                                          valorbrutoitem,
                                          qtdesaida,
                                          customeditem,
                                          tprd.codigoprd,
                                          trelsld.totalsaida,
                                          trelsld.totalentrada,
                                          trelsld.nseqitmmov,
                                          trelsld.idmov,
                                          trelsld.codloc,
                                          tmov.codfilial
                                ORDER  BY tmov.codtmv,
                                          tmov.idmov,
                                          cconta.codconta,
                                          cconta.descricao,
                                          idprd)
                        GROUP  BY codtmv,
                                  nome_mov,
                                  idmov,
                                  codconta,
                                  descricao,
                                  idprd,
                                  codfilial,
                                  codloc)
                GROUP  BY codtmv,
                          nome_mov,
                          codconta,
                          descricao,
                          codfilial,
                          codloc) tabela
               RIGHT JOIN U_CFL8U4_RM.tloc
                       ON tloc.codfilial = tabela.codfilial
                          AND tloc.codloc = tabela.codloc
               LEFT JOIN U_CFL8U4_RM.gfilial
                      ON tloc.codfilial = gfilial.codfilial
        WHERE  LENGTH(tloc.codloc) = 9
        GROUP  BY tloc.codfilial,
                  gfilial.nomefantasia,
                  codtmv,
                  nome_mov,
                  codconta,
                  descricao,
                  tloc.codloc,
                  tloc.nome
        ORDER  BY codfilial,
                  codloc,
                  codconta)
WHERE  descricao IS NOT NULL
GROUP  BY codfilial,
          nomefantasia,
          codloc,
          nome,
          descricao,
          codconta,
          codconta_n1 
