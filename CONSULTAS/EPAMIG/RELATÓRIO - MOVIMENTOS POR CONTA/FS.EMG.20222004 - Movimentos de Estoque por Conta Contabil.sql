SELECT
    codfilial,
    nomefantasia,
    codloc,
    nome,
    descricao,
    codconta,
    (
        CASE
            WHEN codconta_n1 = '1.1.1.01' THEN
                'CAIXA'
            WHEN codconta_n1 = '1.1.1.02' THEN
                'FUNDO FIXO'
            WHEN codconta_n1 = '1.1.1.03' THEN
                'BANCOS CONTA MOVIMENTO'
            WHEN codconta_n1 = '1.1.1.04' THEN
                'VALORES EM TRANSITO CONTA MOVIMENTO'
            WHEN codconta_n1 = '1.1.1.05' THEN
                'BANCOS CONTA CONVENIO'
            WHEN codconta_n1 = '1.1.1.06' THEN
                'VALORES EM TRANSITO CONTA CONVENIO'
            WHEN codconta_n1 = '1.1.1.07' THEN
                'APLICACOES LIQUIDEZ IMEDIATA CONTA MOVTO'
            WHEN codconta_n1 = '1.1.1.08' THEN
                'APLICACAO LIQUIDEZ IMEDIATA CTA CONVENIO'
            WHEN codconta_n1 = '1.1.1.09' THEN
                'VALORES EM TRANSITO PELO DAE DEC. 44180'
            WHEN codconta_n1 = '1.1.2.01' THEN
                'CLIENTES'
            WHEN codconta_n1 = '1.1.2.02' THEN
                'PROVISAO P/CREDITOS LIQUIDACAO DUVIDOSA '
            WHEN codconta_n1 = '1.1.2.03' THEN
                'DEPOSITOS BANCARIOS VINCULADOS'
            WHEN codconta_n1 = '1.1.2.04' THEN
                'CHEQUES EM COBRANÇA'
            WHEN codconta_n1 = '1.1.2.05' THEN
                'ADIANTAMENTOS PARA VIAGENS'
            WHEN codconta_n1 = '1.1.2.06' THEN
                'ADIANTAMENTOS PARA VIAGENS CONVENIOS'
            WHEN codconta_n1 = '1.1.2.07' THEN
                'ADIANTAMENTOS A FORNECEDORES'
            WHEN codconta_n1 = '1.1.2.08' THEN
                'ADIANTAMENTOS INERENTES FOLHA DE PAGTO.'
            WHEN codconta_n1 = '1.1.2.09' THEN
                'ADIANTAMENTOS DIVERSOS'
            WHEN codconta_n1 = '1.1.2.10' THEN
                'IRPJ/CSLL PAGOS POR ESTIMATIVA'
            WHEN codconta_n1 = '1.1.2.11' THEN
                'IMPOSTOS CONTRIB. A RECUPERAR/COMPENSAR '
            WHEN codconta_n1 = '1.1.2.12' THEN
                'OUTROS VALORES A RECUPERAR'
            WHEN codconta_n1 = '1.1.2.13' THEN
                'RECURSOS A RECEBER TESOURO ESTADUAL'
            WHEN codconta_n1 = '1.1.3.01' THEN
                'MATÉRIAS-PRIMAS'
            WHEN codconta_n1 = '1.1.3.02' THEN
                'MATERIAL DE USO E CONSUMO'
            WHEN codconta_n1 = '1.1.3.03' THEN
                'PRODUTOS AGROPECUÁRIOS EM FORMAÇÃO'
            WHEN codconta_n1 = '1.1.3.04' THEN
                'PRODUTOS EM ELABORAÇÃO'
            WHEN codconta_n1 = '1.1.3.05' THEN
                'PRODUTOS AGROPECUÁRIOS ACABADOS'
            WHEN codconta_n1 = '1.1.3.06' THEN
                'PRODUTOS ACABADOS'
            WHEN codconta_n1 = '1.1.3.07' THEN
                'MERCADORIAS PARA REVENDA'
            WHEN codconta_n1 = '1.1.3.08' THEN
                'ANIMAIS'
            WHEN codconta_n1 = '1.1.3.09' THEN
                'ESTOQUE EM PODER DE TERCEIROS'
            WHEN codconta_n1 = '1.1.3.10' THEN
                'TRANSFERÊNCIA DE PRODUTOS E MERCADORIAS'
            WHEN codconta_n1 = '1.1.3.11' THEN
                'TRANSFERÊNCIA DE ANIMAIS'
            WHEN codconta_n1 = '1.1.3.12' THEN
                'OUTROS ESTOQUES'
            WHEN codconta_n1 = '1.1.4.01' THEN
                'SEGUROS A APROPRIAR'
            WHEN codconta_n1 = '1.1.4.02' THEN
                'ASSINATURAS A APROPRIAR'
            WHEN codconta_n1 = '1.1.4.03' THEN
                'DESPESAS ANTECIPADAS'
            WHEN codconta_n1 = '1.1.4.04' THEN
                'CONTRAPARTIDA FINANCEIRA CONVÊNIO'
            WHEN codconta_n1 = '1.2.1.01' THEN
                'DEPOSITOS JUDICIAIS'
            WHEN codconta_n1 = '1.2.1.02' THEN
                'DEPOSITO RECURSAL'
            WHEN codconta_n1 = '1.2.1.03' THEN
                'EMPRESTIMOS COMPULSORIOS'
            WHEN codconta_n1 = '1.2.1.04' THEN
                'DESPESAS ANTECIPADAS LONGO PRAZO'
            WHEN codconta_n1 = '1.2.1.05' THEN
                'RECURSOS A RECEBER TESOURO ESTADUAL'
            WHEN codconta_n1 = '1.2.1.06' THEN
                'ATIVOS FISCAIS DIFERIDOS'
            WHEN codconta_n1 = '1.2.2.01' THEN
                'PARTICIPAÇÃO PERMAN.EM OUTRAS SOCIEDADES'
            WHEN codconta_n1 = '1.2.3.01' THEN
                'TERRENOS'
            WHEN codconta_n1 = '1.2.3.02' THEN
                'EDIFÍCIOS, BENFEITORIAS E INSTALAÇÕES'
            WHEN codconta_n1 = '1.2.3.03' THEN
                'MAQUINAS, APARELHOS E EQUIPAMENTOS'
            WHEN codconta_n1 = '1.2.3.04' THEN
                'EQUIPAMENTOS DE PROCESSAMENTO DE DADOS'
            WHEN codconta_n1 = '1.2.3.05' THEN
                'MÓVEIS E UTENSILIOS'
            WHEN codconta_n1 = '1.2.3.06' THEN
                'VEÍCULOS'
            WHEN codconta_n1 = '1.2.3.07' THEN
                'BIBLIOTECA, MAPOTECA E DISCOTECA'
            WHEN codconta_n1 = '1.2.3.08' THEN
                'IMOBILIZADO BIOLÓGICO'
            WHEN codconta_n1 = '1.2.3.09' THEN
                'OBRAS EM ANDAMENTO'
            WHEN codconta_n1 = '1.2.3.10' THEN
                'IMOBILIZADO ADIANTAMENTO A FORNECEDORES '
            WHEN codconta_n1 = '1.2.3.11' THEN
                'CORREÇÃO MONETÁRIA DIFERENÇA IPC/BTNF/90'
            WHEN codconta_n1 = '1.2.3.12' THEN
                'DEPRECIAÇÃO ACUMULADA'
            WHEN codconta_n1 = '1.2.3.13' THEN
                'DEPRECIAÇÃO ACUMUL.DIFERENÇA IPC/BTNF/90'
            WHEN codconta_n1 = '1.2.3.14' THEN
                'TRANSFERÊNCIA DE BENS MÓVEIS'
            WHEN codconta_n1 = '1.2.4.01' THEN
                'MARCAS E PATENTES'
            WHEN codconta_n1 = '1.2.4.02' THEN
                'DIREITO DE USO '
            WHEN codconta_n1 = '1.2.4.03' THEN
                'REGISTRO DE PATENTES EM ANDAMENTO'
            WHEN codconta_n1 = '1.2.4.04' THEN
                'CORREÇÃO MONETÁRIA DIFERENÇA IPC/BTNF/90'
            WHEN codconta_n1 = '1.2.4.05' THEN
                'AMORTIZAÇÃO ACUMULADA'
            WHEN codconta_n1 = '2.1.1.01' THEN
                'FORNECEDORES'
            WHEN codconta_n1 = '2.1.1.02' THEN
                'ADIANTAMENTO DE CLIENTES'
            WHEN codconta_n1 = '2.1.1.03' THEN
                'SALÁRIOS E ENCARGOS SOCIAIS'
            WHEN codconta_n1 = '2.1.1.04' THEN
                'CREDORES DIVERSOS'
            WHEN codconta_n1 = '2.1.1.05' THEN
                'PARCELAMENTO DE AÇÕES JUDICIAIS'
            WHEN codconta_n1 = '2.1.2.01' THEN
                'TRIBUTOS E CONTRIBUIÇÕES A RECOLHER'
            WHEN codconta_n1 = '2.1.2.02' THEN
                'PARCELAMENTOS DE DÉBITOS FISCAIS'
            WHEN codconta_n1 = '2.1.3.01' THEN
                'CREDORES POR CONVÊNIO'
            WHEN codconta_n1 = '2.1.4.01' THEN
                'PROVISÃO DE FÉRIAS '
            WHEN codconta_n1 = '2.1.4.02' THEN
                'PROVISÃO DE 13º SALÁRIO '
            WHEN codconta_n1 = '2.1.4.03' THEN
                'PROVISÃO DE AÇÕES TRABALHISTAS'
            WHEN codconta_n1 = '2.1.4.04' THEN
                'OUTRAS PROVISÕES'
            WHEN codconta_n1 = '2.1.5.01' THEN
                'PRODUTOS DE TERCEIROS EM NOSSO PODER '
            WHEN codconta_n1 = '2.2.1.01' THEN
                'PARCELAMENTOS DE DÉBITOS FISCAIS'
            WHEN codconta_n1 = '2.2.1.02' THEN
                'FORNECEDORES'
            WHEN codconta_n1 = '2.2.1.03' THEN
                'PROVISÃO PARA RISCOS TRABALHISTAS'
            WHEN codconta_n1 = '2.2.1.04' THEN
                'PROVISÃO PARA RISCOS CIVEIS'
            WHEN codconta_n1 = '2.2.1.05' THEN
                'OUTRAS PROVISÕES'
            WHEN codconta_n1 = '2.3.1.01' THEN
                'CAPITAL SOCIAL'
            WHEN codconta_n1 = '2.3.2.01' THEN
                'RESERVAS DE CAPITAL'
            WHEN codconta_n1 = '2.3.2.02' THEN
                'RESERVAS DE LUCROS'
            WHEN codconta_n1 = '2.3.3.01' THEN
                'PREJUÍZOS ACUMULADOS'
            WHEN codconta_n1 = '2.3.4.01' THEN
                'AJUSTES DE AVALIAÇÃO PATRIMONIAL'
            WHEN codconta_n1 = '3.1.1.01' THEN
                'MATÉRIA-PRIMA DIRETA'
            WHEN codconta_n1 = '3.1.1.02' THEN
                'MÃO-DE-OBRA DIRETA'
            WHEN codconta_n1 = '3.1.1.03' THEN
                'CUSTOS INDIRETOS'
            WHEN codconta_n1 = '3.1.1.04' THEN
                'CUSTO DO SERVIÇO PRESTADO'
            WHEN codconta_n1 = '3.1.1.05' THEN
                'CUSTO DO PRODUTO AGROPECUARIO VENDIDO'
            WHEN codconta_n1 = '3.1.1.06' THEN
                'CUSTO DE REVISTAS E PUBLICAÇÕES VENDIDAS'
            WHEN codconta_n1 = '3.1.1.07' THEN
                'CUSTO DOS ANIMAIS VENDIDOS'
            WHEN codconta_n1 = '3.1.1.08' THEN
                'CUSTO DO PRODUTO INDUSTRIAL VENDIDO'
            WHEN codconta_n1 = '3.1.1.09' THEN
                'CUSTO DA MERCADORIA REVENDIDA'
            WHEN codconta_n1 = '3.1.1.10' THEN
                'PERDAS DE PRODUTOS'
            WHEN codconta_n1 = '3.1.1.11' THEN
                'PERDAS DE ANIMAIS'
            WHEN codconta_n1 = '3.2.1.01' THEN
                'DESPESA COM PESSOAL DE VENDAS '
            WHEN codconta_n1 = '3.2.1.02' THEN
                'DESPESAS COMERCIAIS'
            WHEN codconta_n1 = '3.2.2.01' THEN
                'DESPESA COM PESSOAL ADMINISTRATIVO'
            WHEN codconta_n1 = '3.2.2.02' THEN
                'MATERIAL DE CONSUMO'
            WHEN codconta_n1 = '3.2.2.03' THEN
                'SERVIÇOS DE TERCEIROS'
            WHEN codconta_n1 = '3.2.2.04' THEN
                'DESPESAS GERAIS '
            WHEN codconta_n1 = '3.2.2.05' THEN
                'DESPESAS COM PROVISÕES'
            WHEN codconta_n1 = '3.2.3.01' THEN
                'INSUBSISTÊNCIAS ATIVAS'
            WHEN codconta_n1 = '3.2.3.02' THEN
                'PERDAS DE PRODUTOS'
            WHEN codconta_n1 = '3.2.3.03' THEN
                'PERDAS DE ANIMAIS'
            WHEN codconta_n1 = '3.3.1.01' THEN
                'DESPESAS FINANCEIRAS'
            WHEN codconta_n1 = '3.3.1.02' THEN
                '( - ) RECEITAS FINANCEIRAS'
            WHEN codconta_n1 = '3.4.1.01' THEN
                'IMPOSTO DE RENDA E CONTRIBUIÇÃO SOCIAL'
            WHEN codconta_n1 = '4.1.1.01' THEN
                'PRODUTOS AGROPECUÁRIOS'
            WHEN codconta_n1 = '4.1.1.02' THEN
                'REVISTAS E PUBLICAÇÕES'
            WHEN codconta_n1 = '4.1.1.03' THEN
                'ANIMAIS'
            WHEN codconta_n1 = '4.1.1.04' THEN
                'PRODUTOS INDUSTRIALIZADOS'
            WHEN codconta_n1 = '4.1.1.05' THEN
                'VENDA DE SERVIÇOS'
            WHEN codconta_n1 = '4.1.1.06' THEN
                'REVENDA DE MERCADORIAS'
            WHEN codconta_n1 = '4.1.2.01' THEN
                '(-) DEDUÇÕES DA RECEITA'
            WHEN codconta_n1 = '4.2.1.01' THEN
                'TRANSFERENCIAS DE RECURSOS DO ESTADO'
            WHEN codconta_n1 = '4.2.1.02' THEN
                'TRANSFERENCIAS DE RECURSOS DO MUNICÍPIO'
            WHEN codconta_n1 = '4.2.2.01' THEN
                'RECURSOS DE CONVÊNIOS PODER PÚBLICO'
            WHEN codconta_n1 = '4.2.2.02' THEN
                'RECURSOS DE CONVÊNIOS INICIATIVA PRIVADA'
            WHEN codconta_n1 = '4.2.3.01' THEN
                'RECEITAS DE DOAÇÕES DO PODER PÚBLICO'
            WHEN codconta_n1 = '4.2.4.01' THEN
                'SUPERVENIÊNCIAS ATIVAS'
            WHEN codconta_n1 = '4.2.5.01' THEN
                'DIVERSAS RECEITAS OPERACIONAIS'
            WHEN codconta_n1 = '4.3.1.01' THEN
                'GANHOS E PERDAS NO IMOBILIZADO/INTANGIVE'
            WHEN codconta_n1 = '4.3.1.02' THEN
                'OUTROS GANHOS E PERDAS'
            WHEN codconta_n1 = '4.3.2.01' THEN
                'RESULTADO DA CORRECAO MONETARIA'
            WHEN codconta_n1 = '5.1.1.01' THEN
                'APURAÇÃO DO RESULTADO'
            WHEN codconta_n1 = '5.1.2.01' THEN
                'RESULTADOS TRIMESTRAIS'
            WHEN codconta_n1 = '5.1.3.01' THEN
                'RESULTADOS ACUMULADOS'
            WHEN codconta_n1 = '6.1.1.01' THEN
                'BENS RECEBIDOS EM CONVENIOS/COMODATO'
            WHEN codconta_n1 = '6.1.1.02' THEN
                'REMESSA EM CONSIGNACAO'
            WHEN codconta_n1 = '6.1.1.03' THEN
                'BENS/MERCAD RECEBIDOS EM DEMONSTRACAO'
            WHEN codconta_n1 = '6.1.1.04' THEN
                'MERCAD RECEBIDAS PARA BENEF/INDUSTRIALIZ'
            WHEN codconta_n1 = '6.1.1.05' THEN
                'SIMPLES FAT.COMPRA P/RECEBIMENTO FUTURO'
            WHEN codconta_n1 = '6.1.1.06' THEN
                'MERCADORIAS RECEBIDAS EM CONSIGNACAO'
            WHEN codconta_n1 = '6.1.1.07' THEN
                'ANIMAIS RECEBIDOS EM CONVENIOS/COMODATO'
            WHEN codconta_n1 = '6.1.1.08' THEN
                'REMESSA DE ANIMAIS EM CONVENIOS/COMODATO'
            WHEN codconta_n1 = '6.1.1.09' THEN
                'SIMPLES FAT.VENDA PARA ENTREGA FUTURA'
            WHEN codconta_n1 = '6.1.1.10' THEN
                'DIVERSOS RESPONSAVEIS EM APURACAO'
            WHEN codconta_n1 = '6.1.1.11' THEN
                'PRODUTOS DE TERCEIROS EM NOSSO PODER/VENDA PARA ENTREGA FUTURA'
            WHEN codconta_n1 = '7.1.1.01' THEN
                'BENS DE TERCEIROS EM CONVENIOS/COMODATO'
            WHEN codconta_n1 = '7.1.1.02' THEN
                'MERCADORIAS COM TERCEIROS CONSIGNATARIOS'
            WHEN codconta_n1 = '7.1.1.03' THEN
                'BENS/MERCAD DE TERCEIROS EM DEMONSTRACAO'
            WHEN codconta_n1 = '7.1.1.04' THEN
                'MERCAD DE TERCEIROS P/ BENEF/INDUSTRIAL'
            WHEN codconta_n1 = '7.1.1.05' THEN
                'SIMPLES FAT.COMPRA P/RECEBIMENTO FUTURO'
            WHEN codconta_n1 = '7.1.1.06' THEN
                'MERCADORIAS DE TERCEIROS CONSIGNANTES'
            WHEN codconta_n1 = '7.1.1.07' THEN
                'ANIMAIS DE TERCEIROS CONVENIOS/COMODATO'
            WHEN codconta_n1 = '7.1.1.08' THEN
                'ANIMAIS COM TERCEIROS CONVENIOS/COMODATO'
            WHEN codconta_n1 = '7.1.1.09' THEN
                'SIMPLES FAT.VENDA PARA ENTREGA FUTURA'
            WHEN codconta_n1 = '7.1.1.10' THEN
                'DIVERSOS RESPONSAVEIS EM APURACAO'
            WHEN codconta_n1 = '7.1.1.11' THEN
                'PRODUTOS DE TERCEIROS EM NOSSO PODER/VENDA PARA ENTREGA FUTURA'
        END
    )                            AS descricao_n1,
    codconta_n1,
    nvl(SUM(baixa), 0)           AS baixas,
    nvl(SUM(trasf_saida), 0)     AS transf_saida,
    nvl(SUM(vendas), 0)          AS vendas,
    nvl(SUM(outras_saidas), 0)   AS outras_saidas,
    nvl(SUM(outras_entradas), 0) AS outras_entradas,
    nvl(SUM(compras), 0)         AS compras,
    nvl(SUM(transferencia), 0)   AS transf_entrada
FROM
    (
        SELECT
            codconta,
            substr(codconta, 1, 8) AS codconta_n1,
            descricao,
            tloc.codfilial,
            gfilial.nomefantasia,
            tloc.codloc,
            tloc.nome,
            CASE
                WHEN codtmv IN ( '1.1.04', '1.1.20', '1.1.24', '1.1.41' ) THEN
                    nvl(SUM(valortotal), 0)
            END                    AS baixa,
            CASE
                WHEN codtmv = '2.2.16' THEN
                    nvl(SUM(valortotal), 0)
            END                    AS trasf_saida,
            CASE
                WHEN codtmv IN ( '2.2.01', '2.2.07', '2.2.08', '2.2.21', '2.2.47',
                                 '2.2.51', '2.2.54' ) THEN
                    nvl(SUM(valortotal), 0)
            END                    AS vendas,
            CASE
                WHEN codtmv IN ( '2.2.09', '2.2.14', '4.1.02', '4.1.09', '4.1.14',
                                 '4.1.16' ) THEN
                    nvl(SUM(valortotal), 0)
            END                    AS outras_saidas,
            CASE
                WHEN codtmv IN ( '1.1.13', '1.1.21', '1.1.22', '1.1.40', '1.2.09',
                                 '1.2.41', '1.2.48', '1.2.51', '1.2.61', '1.2.63',
                                 '1.2.72', '1.2.75', '4.1.01', '4.1.08', '4.1.13',
                                 '4.1.15' ) THEN
                    nvl(SUM(valortotal), 0)
            END                    AS outras_entradas,
            CASE
                WHEN codtmv IN ( '1.2.02', '1.2.07', '1.2.23', '1.2.24', '1.2.28',
                                 '1.2.29', '1.2.17' ) THEN
                    nvl(SUM(valortotal), 0)
            END                    AS compras,
            CASE
                WHEN codtmv IN ( '1.2.17' ) THEN
                    nvl(SUM(valortotal), 0)
            END                    AS transferencia
        FROM
            (
                SELECT
                    codtmv,
                    nome_mov,
                    codconta,
                    descricao,
                    CASE
                        WHEN '01/12/2021' >= '01/01/2017'
                         /* WHEN :DATAINICIO >= '01/01/2017' */ THEN
                            trunc(SUM(valortotal_atual), 2)
                        ELSE
                            trunc(SUM(valortotal), 2)
                    END AS valortotal,
                    codfilial,
                    codloc
                FROM
                    (
                        SELECT
                            codtmv,
                            nome_mov,
                            codconta,
                            descricao,
                            (
                                CASE
                                    WHEN codtmv IN ( '1.2.02', '1.2.09', '1.2.61', '1.2.63', '1.2.23',
                                                     '1.2.48' )
                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                        trunc(SUM(totalentrada), 2) * ( - 1 )
                                    WHEN codtmv IN ( '1.2.02', '1.2.09', '1.2.61', '1.2.63', '1.2.23',
                                                     '1.2.48' )
                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                        trunc(SUM(totalentrada), 2)
                                    WHEN codtmv LIKE '1%'
                                         AND codtmv NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61', '1.2.63',
                                                             '1.2.23', '1.2.48', '1.2.75' )
                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                        trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                    WHEN codtmv LIKE '1%'
                                         AND codtmv NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61', '1.2.63',
                                                             '1.2.23', '1.2.48', '1.2.75' )
                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                        trunc(SUM(valorbrutoitem), 2)
                                    WHEN codtmv IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                     '2.2.21', '2.2.22', '2.2.47' )
                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                        trunc(SUM(totalsaida), 2) * ( - 1 )
                                    WHEN codtmv IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                     '2.2.21', '2.2.22', '2.2.47' )
                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                        trunc(SUM(totalsaida), 2)
                                    WHEN codtmv LIKE '2%'
                                         AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                             '2.2.21', '2.2.22', '2.2.47' )
                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                        trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                    WHEN codtmv LIKE '2%'
                                         AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                             '2.2.21', '2.2.22', '2.2.47' )
                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                        trunc(SUM(valorbrutoitem), 2)
                                    WHEN codtmv LIKE '3%'
                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                        trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                    WHEN codtmv LIKE '3%'
                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                        trunc(SUM(valorbrutoitem), 2)
                                    WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                        trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                    WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                        trunc(SUM(valorbrutoitem), 2)
                                    WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17' )
                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                        trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                    WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17' )
                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                        trunc(SUM(valorbrutoitem), 2)
                                    ELSE
                                        SUM(valorbrutoitem)
                                END
                            ) AS valortotal,
                            (
                                CASE
                                    WHEN codtmv IN ( '1.2.02', '1.2.09', '1.2.61', '1.2.63', '1.2.23',
                                                     '1.2.48' )
                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                        trunc(SUM(totalentrada), 2) * ( - 1 )
                                    WHEN codtmv IN ( '1.2.02', '1.2.09', '1.2.61', '1.2.63', '1.2.23',
                                                     '1.2.48' )
                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                        trunc(SUM(totalentrada), 2)
                                    WHEN codtmv LIKE '1%'
                                         AND codtmv NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61', '1.2.63',
                                                             '1.2.23', '1.2.48', '1.1.04', '1.1.43', '1.2.75' )
                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                        trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                    WHEN codtmv LIKE '1%'
                                         AND codtmv NOT IN ( '1.2.02', '1.2.48', '1.2.09', '1.2.61', '1.2.63',
                                                             '1.2.23', '1.2.48', '1.1.04', '1.1.43', '1.2.75' )
                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                        trunc(SUM(valorbrutoitem), 2)
                                    WHEN codtmv IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                     '2.2.21', '2.2.22', '1.1.04', '2.2.14', '2.2.47',
                                                     '2.2.51', '2.2.16', '1.1.43', '1.2.75' )
                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                        trunc(SUM(totalsaida), 2) * ( - 1 )
                                    WHEN codtmv IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                     '2.2.21', '2.2.22', '1.1.04', '2.2.14', '2.2.47',
                                                     '2.2.51', '2.2.16', '1.1.43', '1.2.75' )
                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                        trunc(SUM(totalsaida), 2)
                                    WHEN codtmv LIKE '2%'
                                         AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                             '2.2.21', '2.2.22', '2.2.14', '2.2.47', '2.2.51',
                                                             '2.2.16' )
                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                        trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                    WHEN codtmv LIKE '2%'
                                         AND codtmv NOT IN ( '2.2.01', '2.2.02', '2.2.07', '2.2.08', '2.2.09',
                                                             '2.2.21', '2.2.22', '2.2.14', '2.2.47', '2.2.51',
                                                             '2.2.16' )
                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                        trunc(SUM(valorbrutoitem), 2)
                                    WHEN codtmv LIKE '3%'
                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                        trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                    WHEN codtmv LIKE '3%'
                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                        trunc(SUM(valorbrutoitem), 2)
                                    WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                        trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                    WHEN codtmv IN ( '4.1.08', '4.1.01', '4.1.14' )
                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                        trunc(SUM(valorbrutoitem), 2)
                                    WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17' )
                                         AND SUM(trunc(valorfincomsinal, 2)) < 0 THEN
                                        trunc(SUM(valorbrutoitem), 2) * ( - 1 )
                                    WHEN codtmv IN ( '4.1.09', '4.1.02', '4.1.13', '4.1.16', '4.1.17' )
                                         AND SUM(trunc(valorfincomsinal, 2)) >= 0 THEN
                                        trunc(SUM(valorbrutoitem), 2)
                                    ELSE
                                        SUM(valorbrutoitem)
                                END
                            ) AS valortotal_atual,
                            codfilial,
                            codloc
                        FROM
                            (
                                SELECT
                                    tmov.codtmv,
                                    ttmv.nome                      AS nome_mov,
                                    cconta.codconta,
                                    cconta.descricao,
                                    tprd.codigoprd,
                                    trelsld.idmov,
                                    SUM(trelsld.valorfincomsinal)  AS valorfincomsinal,
                                    round(trelsld.totalsaida, 2)   AS totalsaida,
                                    round(trelsld.totalentrada, 2) AS totalentrada,
                                    titmmov.valorbrutoitem,
                                    qtdesaida,
                                    customeditem,
                                    trelsld.idprd,
                                    trelsld.nseqitmmov,
                                    trelsld.codloc,
                                    tmov.codfilial
                                FROM
                                    u_cfl8u4_rm.trelsld
                                    LEFT JOIN u_cfl8u4_rm.tmov ON trelsld.idmov = tmov.idmov
                                    LEFT JOIN u_cfl8u4_rm.titmmov ON titmmov.idmov = trelsld.idmov
                                                                     AND titmmov.idprd = trelsld.idprd
                                                                     AND titmmov.nseqitmmov = trelsld.nseqitmmov
                                    LEFT JOIN u_cfl8u4_rm.tprd ON trelsld.idprd = tprd.idprd
                                       /* RIGHT JOIN U_CFL8U4_RM.TTB4
                                        ON TTB4.CODTB4FAT = TITMMOV.CODTB4FAT */
                                    RIGHT JOIN u_cfl8u4_rm.ttb4 ON ttb4.codtb4fat = tprd.codtb4fat
                                    RIGHT JOIN u_cfl8u4_rm.ttb4cont ON ttb4cont.codtb4fat = ttb4.codtb4fat
                                    RIGHT JOIN u_cfl8u4_rm.cconta ON cconta.codconta = ttb4cont.codconta
                                    RIGHT JOIN u_cfl8u4_rm.gfilial ON gfilial.codcoligada = tmov.codcoligada
                                                                      AND gfilial.codfilial = tmov.codfilial
                                    RIGHT JOIN u_cfl8u4_rm.tloc ON tloc.codcoligada = trelsld.codcoligada
                                                                   AND tloc.codfilial = trelsld.codfilial
                                                                   AND tloc.codloc = trelsld.codloc
                                    RIGHT JOIN u_cfl8u4_rm.ttmv ON ttmv.codtmv = tmov.codtmv
                                 /* WHERE  TRELSLD.DATAMOVIMENTO >= :DATAINICIO
                                       AND TRELSLD.DATAMOVIMENTO <= :DATAFIM
                                       AND TRELSLD.CODLOC >= :CODLOC_INICIAL
                                       AND TRELSLD.CODLOC <= :CODLOC_FINAL
                                       AND TRELSLD.CODFILIAL >= :CODFILIAL_INICIAL
                                       AND TRELSLD.CODFILIAL <= :CODFILIAL_FINAL */
                                WHERE
                                        trelsld.datamovimento >= '01/01/2021'
                                    AND trelsld.datamovimento <= '31/12/2021'
                                    AND trelsld.codloc >= '01.001.01'
                                    AND trelsld.codloc <= '99.999.99'
                                    AND trelsld.codfilial >= 1
                                    AND trelsld.codfilial <= 20
                                    AND trelsld.saldo = 2
                                    AND tmov.codtmv IN ( '1.1.04', '1.1.13', '1.1.20', '1.1.21', '1.1.22',
                                                         '1.1.24', '1.1.40', '1.1.41', '1.2.02', '1.2.07',
                                                         '1.2.09', '1.2.17', '1.2.23', '1.2.24', '1.2.28',
                                                         '1.2.29', '1.2.41', '1.2.48', '1.2.51', '1.2.61',
                                                         '1.2.63', '1.2.72', '1.2.75', '2.2.01', '2.2.07',
                                                         '2.2.08', '2.2.09', '2.2.14', '2.2.16', '2.2.21',
                                                         '2.2.47', '2.2.51', '2.2.54', '4.1.01', '4.1.02',
                                                         '4.1.08', '4.1.09', '4.1.13', '4.1.14', '4.1.15',
                                                         '4.1.16' )
                                    AND ttb4cont.classconta = 'ESTOQUE'
                                GROUP BY
                                    tmov.codtmv,
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
                                ORDER BY
                                    tmov.codtmv,
                                    tmov.idmov,
                                    cconta.codconta,
                                    cconta.descricao,
                                    idprd
                            )
                        GROUP BY
                            codtmv,
                            nome_mov,
                            idmov,
                            codconta,
                            descricao,
                            idprd,
                            codfilial,
                            codloc
                    )
                GROUP BY
                    codtmv,
                    nome_mov,
                    codconta,
                    descricao,
                    codfilial,
                    codloc
            ) tabela
            RIGHT JOIN u_cfl8u4_rm.tloc ON tloc.codfilial = tabela.codfilial
                                           AND tloc.codloc = tabela.codloc
            LEFT JOIN u_cfl8u4_rm.gfilial ON tloc.codfilial = gfilial.codfilial
        WHERE
            length(tloc.codloc) = 9
        GROUP BY
            tloc.codfilial,
            gfilial.nomefantasia,
            codtmv,
            nome_mov,
            codconta,
            descricao,
            tloc.codloc,
            tloc.nome
    )
WHERE
    descricao IS NOT NULL
GROUP BY
    codfilial,
    nomefantasia,
    codloc,
    nome,
    descricao,
    codconta,
    codconta_n1
ORDER BY
    codfilial,
    nomefantasia,
    codloc,
    nome,
    descricao,
    codconta,
    codconta_n1