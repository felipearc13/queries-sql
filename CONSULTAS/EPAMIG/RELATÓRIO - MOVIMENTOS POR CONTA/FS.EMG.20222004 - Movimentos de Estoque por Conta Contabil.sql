SELECT
    codfilial,
    codloc,
    codconta,
    SUM(baixas)                AS baixas_pe,
    SUM(baixas2)               AS baixas_ant,
    SUM(baixas) + SUM(baixas2) AS baixas_atual
FROM
    (
        SELECT
            codfilial,
            nomefantasia,
            codfilial
            || ' - '
            || nomefantasia              AS filial,
            codloc,
            nome,
            codloc
            || ' - '
            || nome                      AS estoque,
            descricao,
            codconta,
            (
                CASE
                    WHEN codconta_n1 = '1.1.1.01' THEN
                        'Caixa                                  '
                    WHEN codconta_n1 = '1.1.1.02' THEN
                        'Fundo Fixo'
                    WHEN codconta_n1 = '1.1.1.03' THEN
                        'Bancos Conta Movimento'
                    WHEN codconta_n1 = '1.1.1.04' THEN
                        'Valores Em Transito Conta Movimento'
                    WHEN codconta_n1 = '1.1.1.05' THEN
                        'Bancos Conta Convenio'
                    WHEN codconta_n1 = '1.1.1.06' THEN
                        'Valores Em Transito Conta Convenio'
                    WHEN codconta_n1 = '1.1.1.07' THEN
                        'Aplicacoes Liquidez Imediata Conta Movto'
                    WHEN codconta_n1 = '1.1.1.08' THEN
                        'Aplicacao Liquidez Imediata Cta Convenio'
                    WHEN codconta_n1 = '1.1.1.09' THEN
                        'Valores Em Transito Pelo Dae Dec. 44180'
                    WHEN codconta_n1 = '1.1.2.01' THEN
                        'Clientes'
                    WHEN codconta_n1 = '1.1.2.02' THEN
                        'Provisao P/Creditos Liquidacao Duvidosa '
                    WHEN codconta_n1 = '1.1.2.03' THEN
                        'Depositos Bancarios Vinculados'
                    WHEN codconta_n1 = '1.1.2.04' THEN
                        'Cheques Em Cobrança'
                    WHEN codconta_n1 = '1.1.2.05' THEN
                        'Adiantamentos Para Viagens'
                    WHEN codconta_n1 = '1.1.2.06' THEN
                        'Adiantamentos Para Viagens Convenios'
                    WHEN codconta_n1 = '1.1.2.07' THEN
                        'Adiantamentos A Fornecedores'
                    WHEN codconta_n1 = '1.1.2.08' THEN
                        'Adiantamentos Inerentes Folha De Pagto.'
                    WHEN codconta_n1 = '1.1.2.09' THEN
                        'Adiantamentos Diversos'
                    WHEN codconta_n1 = '1.1.2.10' THEN
                        'Irpj/Csll Pagos Por Estimativa'
                    WHEN codconta_n1 = '1.1.2.11' THEN
                        'Impostos Contrib. A Recuperar/Compensar '
                    WHEN codconta_n1 = '1.1.2.12' THEN
                        'Outros Valores A Recuperar'
                    WHEN codconta_n1 = '1.1.2.13' THEN
                        'Recursos A Receber Tesouro Estadual'
                    WHEN codconta_n1 = '1.1.3.01' THEN
                        'Matérias-Primas'
                    WHEN codconta_n1 = '1.1.3.02' THEN
                        'Material De Uso E Consumo'
                    WHEN codconta_n1 = '1.1.3.03' THEN
                        'Produtos Agropecuários Em Formação'
                    WHEN codconta_n1 = '1.1.3.04' THEN
                        'Produtos Em Elaboração'
                    WHEN codconta_n1 = '1.1.3.05' THEN
                        'Produtos Agropecuários Acabados'
                    WHEN codconta_n1 = '1.1.3.06' THEN
                        'Produtos Acabados'
                    WHEN codconta_n1 = '1.1.3.07' THEN
                        'Mercadorias Para Revenda'
                    WHEN codconta_n1 = '1.1.3.08' THEN
                        'Animais'
                    WHEN codconta_n1 = '1.1.3.09' THEN
                        'Estoque Em Poder De Terceiros'
                    WHEN codconta_n1 = '1.1.3.10' THEN
                        'Transferência De Produtos E Mercadorias'
                    WHEN codconta_n1 = '1.1.3.11' THEN
                        'Transferência De Animais'
                    WHEN codconta_n1 = '1.1.3.12' THEN
                        'Outros Estoques'
                    WHEN codconta_n1 = '1.1.4.01' THEN
                        'Seguros A Apropriar'
                    WHEN codconta_n1 = '1.1.4.02' THEN
                        'Assinaturas A Apropriar'
                    WHEN codconta_n1 = '1.1.4.03' THEN
                        'Despesas Antecipadas'
                    WHEN codconta_n1 = '1.1.4.04' THEN
                        'Contrapartida Financeira Convênio'
                    WHEN codconta_n1 = '1.2.1.01' THEN
                        'Depositos Judiciais'
                    WHEN codconta_n1 = '1.2.1.02' THEN
                        'Deposito Recursal'
                    WHEN codconta_n1 = '1.2.1.03' THEN
                        'Emprestimos Compulsorios'
                    WHEN codconta_n1 = '1.2.1.04' THEN
                        'Despesas Antecipadas Longo Prazo'
                    WHEN codconta_n1 = '1.2.1.05' THEN
                        'Recursos A Receber Tesouro Estadual'
                    WHEN codconta_n1 = '1.2.1.06' THEN
                        'Ativos Fiscais Diferidos'
                    WHEN codconta_n1 = '1.2.2.01' THEN
                        'Participação Perman.Em Outras Sociedades'
                    WHEN codconta_n1 = '1.2.3.01' THEN
                        'Terrenos'
                    WHEN codconta_n1 = '1.2.3.02' THEN
                        'Edifícios, Benfeitorias E Instalações'
                    WHEN codconta_n1 = '1.2.3.03' THEN
                        'Maquinas, Aparelhos E Equipamentos'
                    WHEN codconta_n1 = '1.2.3.04' THEN
                        'Equipamentos De Processamento De Dados'
                    WHEN codconta_n1 = '1.2.3.05' THEN
                        'Móveis E Utensilios'
                    WHEN codconta_n1 = '1.2.3.06' THEN
                        'Veículos'
                    WHEN codconta_n1 = '1.2.3.07' THEN
                        'Biblioteca, Mapoteca E Discoteca'
                    WHEN codconta_n1 = '1.2.3.08' THEN
                        'Imobilizado Biológico'
                    WHEN codconta_n1 = '1.2.3.09' THEN
                        'Obras Em Andamento'
                    WHEN codconta_n1 = '1.2.3.10' THEN
                        'Imobilizado Adiantamento A Fornecedores '
                    WHEN codconta_n1 = '1.2.3.11' THEN
                        'Correção Monetária Diferença Ipc/Btnf/90'
                    WHEN codconta_n1 = '1.2.3.12' THEN
                        'Depreciação Acumulada'
                    WHEN codconta_n1 = '1.2.3.13' THEN
                        'Depreciação Acumul.Diferença Ipc/Btnf/90'
                    WHEN codconta_n1 = '1.2.3.14' THEN
                        'Transferência De Bens Móveis'
                    WHEN codconta_n1 = '1.2.4.01' THEN
                        'Marcas E Patentes'
                    WHEN codconta_n1 = '1.2.4.02' THEN
                        'Direito De Uso '
                    WHEN codconta_n1 = '1.2.4.03' THEN
                        'Registro De Patentes Em Andamento'
                    WHEN codconta_n1 = '1.2.4.04' THEN
                        'Correção Monetária Diferença Ipc/Btnf/90'
                    WHEN codconta_n1 = '1.2.4.05' THEN
                        'Amortização Acumulada'
                    WHEN codconta_n1 = '2.1.1.01' THEN
                        'Fornecedores'
                    WHEN codconta_n1 = '2.1.1.02' THEN
                        'Adiantamento De Clientes'
                    WHEN codconta_n1 = '2.1.1.03' THEN
                        'Salários E Encargos Sociais'
                    WHEN codconta_n1 = '2.1.1.04' THEN
                        'Credores Diversos'
                    WHEN codconta_n1 = '2.1.1.05' THEN
                        'Parcelamento De Ações Judiciais'
                    WHEN codconta_n1 = '2.1.2.01' THEN
                        'Tributos E Contribuições A Recolher'
                    WHEN codconta_n1 = '2.1.2.02' THEN
                        'Parcelamentos De Débitos Fiscais'
                    WHEN codconta_n1 = '2.1.3.01' THEN
                        'Credores Por Convênio'
                    WHEN codconta_n1 = '2.1.4.01' THEN
                        'Provisão De Férias '
                    WHEN codconta_n1 = '2.1.4.02' THEN
                        'Provisão De 13º Salário '
                    WHEN codconta_n1 = '2.1.4.03' THEN
                        'Provisão De Ações Trabalhistas'
                    WHEN codconta_n1 = '2.1.4.04' THEN
                        'Outras Provisões'
                    WHEN codconta_n1 = '2.1.5.01' THEN
                        'Produtos De Terceiros Em Nosso Poder '
                    WHEN codconta_n1 = '2.2.1.01' THEN
                        'Parcelamentos De Débitos Fiscais'
                    WHEN codconta_n1 = '2.2.1.02' THEN
                        'Fornecedores'
                    WHEN codconta_n1 = '2.2.1.03' THEN
                        'Provisão Para Riscos Trabalhistas'
                    WHEN codconta_n1 = '2.2.1.04' THEN
                        'Provisão Para Riscos Civeis'
                    WHEN codconta_n1 = '2.2.1.05' THEN
                        'Outras Provisões'
                    WHEN codconta_n1 = '2.3.1.01' THEN
                        'Capital Social'
                    WHEN codconta_n1 = '2.3.2.01' THEN
                        'Reservas De Capital'
                    WHEN codconta_n1 = '2.3.2.02' THEN
                        'Reservas De Lucros'
                    WHEN codconta_n1 = '2.3.3.01' THEN
                        'Prejuízos Acumulados'
                    WHEN codconta_n1 = '2.3.4.01' THEN
                        'Ajustes De Avaliação Patrimonial'
                    WHEN codconta_n1 = '3.1.1.01' THEN
                        'Matéria-Prima Direta'
                    WHEN codconta_n1 = '3.1.1.02' THEN
                        'Mão-De-Obra Direta'
                    WHEN codconta_n1 = '3.1.1.03' THEN
                        'Custos Indiretos'
                    WHEN codconta_n1 = '3.1.1.04' THEN
                        'Custo Do Serviço Prestado'
                    WHEN codconta_n1 = '3.1.1.05' THEN
                        'Custo Do Produto Agropecuario Vendido'
                    WHEN codconta_n1 = '3.1.1.06' THEN
                        'Custo De Revistas E Publicações Vendidas'
                    WHEN codconta_n1 = '3.1.1.07' THEN
                        'Custo Dos Animais Vendidos'
                    WHEN codconta_n1 = '3.1.1.08' THEN
                        'Custo Do Produto Industrial Vendido'
                    WHEN codconta_n1 = '3.1.1.09' THEN
                        'Custo Da Mercadoria Revendida'
                    WHEN codconta_n1 = '3.1.1.10' THEN
                        'Perdas De Produtos'
                    WHEN codconta_n1 = '3.1.1.11' THEN
                        'Perdas De Animais'
                    WHEN codconta_n1 = '3.2.1.01' THEN
                        'Despesa Com Pessoal De Vendas '
                    WHEN codconta_n1 = '3.2.1.02' THEN
                        'Despesas Comerciais'
                    WHEN codconta_n1 = '3.2.2.01' THEN
                        'Despesa Com Pessoal Administrativo'
                    WHEN codconta_n1 = '3.2.2.02' THEN
                        'Material De Consumo'
                    WHEN codconta_n1 = '3.2.2.03' THEN
                        'Serviços De Terceiros'
                    WHEN codconta_n1 = '3.2.2.04' THEN
                        'Despesas Gerais '
                    WHEN codconta_n1 = '3.2.2.05' THEN
                        'Despesas Com Provisões'
                    WHEN codconta_n1 = '3.2.3.01' THEN
                        'Insubsistências Ativas'
                    WHEN codconta_n1 = '3.2.3.02' THEN
                        'Perdas De Produtos'
                    WHEN codconta_n1 = '3.2.3.03' THEN
                        'Perdas De Animais'
                    WHEN codconta_n1 = '3.3.1.01' THEN
                        'Despesas Financeiras'
                    WHEN codconta_n1 = '3.3.1.02' THEN
                        '( - ) Receitas Financeiras'
                    WHEN codconta_n1 = '3.4.1.01' THEN
                        'Imposto De Renda E Contribuição Social'
                    WHEN codconta_n1 = '4.1.1.01' THEN
                        'Produtos Agropecuários'
                    WHEN codconta_n1 = '4.1.1.02' THEN
                        'Revistas E Publicações'
                    WHEN codconta_n1 = '4.1.1.03' THEN
                        'Animais'
                    WHEN codconta_n1 = '4.1.1.04' THEN
                        'Produtos Industrializados'
                    WHEN codconta_n1 = '4.1.1.05' THEN
                        'Venda De Serviços'
                    WHEN codconta_n1 = '4.1.1.06' THEN
                        'Revenda De Mercadorias'
                    WHEN codconta_n1 = '4.1.2.01' THEN
                        '(-) Deduções Da Receita'
                    WHEN codconta_n1 = '4.2.1.01' THEN
                        'Transferencias De Recursos Do Estado'
                    WHEN codconta_n1 = '4.2.1.02' THEN
                        'Transferencias De Recursos Do Município'
                    WHEN codconta_n1 = '4.2.2.01' THEN
                        'Recursos De Convênios Poder Público'
                    WHEN codconta_n1 = '4.2.2.02' THEN
                        'Recursos De Convênios Iniciativa Privada'
                    WHEN codconta_n1 = '4.2.3.01' THEN
                        'Receitas De Doações Do Poder Público'
                    WHEN codconta_n1 = '4.2.4.01' THEN
                        'Superveniências Ativas'
                    WHEN codconta_n1 = '4.2.5.01' THEN
                        'Diversas Receitas Operacionais'
                    WHEN codconta_n1 = '4.3.1.01' THEN
                        'Ganhos E Perdas No Imobilizado/Intangive'
                    WHEN codconta_n1 = '4.3.1.02' THEN
                        'Outros Ganhos E Perdas'
                    WHEN codconta_n1 = '4.3.2.01' THEN
                        'Resultado Da Correcao Monetaria'
                    WHEN codconta_n1 = '5.1.1.01' THEN
                        'Apuração Do Resultado'
                    WHEN codconta_n1 = '5.1.2.01' THEN
                        'Resultados Trimestrais'
                    WHEN codconta_n1 = '5.1.3.01' THEN
                        'Resultados Acumulados'
                    WHEN codconta_n1 = '6.1.1.01' THEN
                        'Bens Recebidos Em Convenios/Comodato'
                    WHEN codconta_n1 = '6.1.1.02' THEN
                        'Remessa Em Consignacao'
                    WHEN codconta_n1 = '6.1.1.03' THEN
                        'Bens/Mercad Recebidos Em Demonstracao'
                    WHEN codconta_n1 = '6.1.1.04' THEN
                        'Mercad Recebidas Para Benef/Industrializ'
                    WHEN codconta_n1 = '6.1.1.05' THEN
                        'Simples Fat.Compra P/Recebimento Futuro'
                    WHEN codconta_n1 = '6.1.1.06' THEN
                        'Mercadorias Recebidas Em Consignacao'
                    WHEN codconta_n1 = '6.1.1.07' THEN
                        'Animais Recebidos Em Convenios/Comodato'
                    WHEN codconta_n1 = '6.1.1.08' THEN
                        'Remessa De Animais Em Convenios/Comodato'
                    WHEN codconta_n1 = '6.1.1.09' THEN
                        'Simples Fat.Venda Para Entrega Futura'
                    WHEN codconta_n1 = '6.1.1.10' THEN
                        'Diversos Responsaveis Em Apuracao'
                    WHEN codconta_n1 = '6.1.1.11' THEN
                        'Produtos De Terceiros Em Nosso Poder/Venda Para Entrega Futura'
                    WHEN codconta_n1 = '7.1.1.01' THEN
                        'Bens De Terceiros Em Convenios/Comodato'
                    WHEN codconta_n1 = '7.1.1.02' THEN
                        'Mercadorias Com Terceiros Consignatarios'
                    WHEN codconta_n1 = '7.1.1.03' THEN
                        'Bens/Mercad De Terceiros Em Demonstracao'
                    WHEN codconta_n1 = '7.1.1.04' THEN
                        'Mercad De Terceiros P/ Benef/Industrial'
                    WHEN codconta_n1 = '7.1.1.05' THEN
                        'Simples Fat.Compra P/Recebimento Futuro'
                    WHEN codconta_n1 = '7.1.1.06' THEN
                        'Mercadorias De Terceiros Consignantes'
                    WHEN codconta_n1 = '7.1.1.07' THEN
                        'Animais De Terceiros Convenios/Comodato'
                    WHEN codconta_n1 = '7.1.1.08' THEN
                        'Animais Com Terceiros Convenios/Comodato'
                    WHEN codconta_n1 = '7.1.1.09' THEN
                        'Simples Fat.Venda Para Entrega Futura'
                    WHEN codconta_n1 = '7.1.1.10' THEN
                        'Diversos Responsaveis Em Apuracao'
                    WHEN codconta_n1 = '7.1.1.11' THEN
                        'Produtos De Terceiros Em Nosso Poder/Venda Para Entrega Futura'
                END
            )                            AS descricao_n1,
            codconta_n1,
            nvl(SUM(baixa), 0)           AS baixas,
            0                            AS baixas2,
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
                        /*  WHEN '01/12/2021' >= '01/01/2017'*/
                                WHEN '01/12/2021' >= '01/01/2017' THEN
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
                                /* WHERE TRELSLD.DATAMOVIMENTO >= :DATAINICIO
                                    AND TRELSLD.DATAMOVIMENTO <= :DATAFIM
                                    AND TRELSLD.CODLOC >= :CODLOC_INICIAL
                                    AND TRELSLD.CODLOC <= :CODLOC_FINAL
                                    AND TRELSLD.CODFILIAL >= :CODFILIAL_INICIAL
                                    AND TRELSLD.CODFILIAL <= :CODFILIAL_FINAL*/
                                        WHERE
                                                trelsld.datamovimento >= '01/12/2019'
                                            AND trelsld.datamovimento < '01/12/2021'
                                            AND trelsld.codloc >= '01.001.01'
                                            AND trelsld.codloc <= '99.999.99'
                                            AND trelsld.codfilial >= 1
                                            AND trelsld.codfilial <= 1
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
                ORDER BY
                    codfilial,
                    codloc,
                    codconta
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
        UNION
        SELECT
            codfilial,
            nomefantasia,
            codfilial
            || ' - '
            || nomefantasia              AS filial,
            codloc,
            nome,
            codloc
            || ' - '
            || nome                      AS estoque,
            descricao,
            codconta,
            (
                CASE
                    WHEN codconta_n1 = '1.1.1.01' THEN
                        'Caixa                                  '
                    WHEN codconta_n1 = '1.1.1.02' THEN
                        'Fundo Fixo'
                    WHEN codconta_n1 = '1.1.1.03' THEN
                        'Bancos Conta Movimento'
                    WHEN codconta_n1 = '1.1.1.04' THEN
                        'Valores Em Transito Conta Movimento'
                    WHEN codconta_n1 = '1.1.1.05' THEN
                        'Bancos Conta Convenio'
                    WHEN codconta_n1 = '1.1.1.06' THEN
                        'Valores Em Transito Conta Convenio'
                    WHEN codconta_n1 = '1.1.1.07' THEN
                        'Aplicacoes Liquidez Imediata Conta Movto'
                    WHEN codconta_n1 = '1.1.1.08' THEN
                        'Aplicacao Liquidez Imediata Cta Convenio'
                    WHEN codconta_n1 = '1.1.1.09' THEN
                        'Valores Em Transito Pelo Dae Dec. 44180'
                    WHEN codconta_n1 = '1.1.2.01' THEN
                        'Clientes'
                    WHEN codconta_n1 = '1.1.2.02' THEN
                        'Provisao P/Creditos Liquidacao Duvidosa '
                    WHEN codconta_n1 = '1.1.2.03' THEN
                        'Depositos Bancarios Vinculados'
                    WHEN codconta_n1 = '1.1.2.04' THEN
                        'Cheques Em Cobrança'
                    WHEN codconta_n1 = '1.1.2.05' THEN
                        'Adiantamentos Para Viagens'
                    WHEN codconta_n1 = '1.1.2.06' THEN
                        'Adiantamentos Para Viagens Convenios'
                    WHEN codconta_n1 = '1.1.2.07' THEN
                        'Adiantamentos A Fornecedores'
                    WHEN codconta_n1 = '1.1.2.08' THEN
                        'Adiantamentos Inerentes Folha De Pagto.'
                    WHEN codconta_n1 = '1.1.2.09' THEN
                        'Adiantamentos Diversos'
                    WHEN codconta_n1 = '1.1.2.10' THEN
                        'Irpj/Csll Pagos Por Estimativa'
                    WHEN codconta_n1 = '1.1.2.11' THEN
                        'Impostos Contrib. A Recuperar/Compensar '
                    WHEN codconta_n1 = '1.1.2.12' THEN
                        'Outros Valores A Recuperar'
                    WHEN codconta_n1 = '1.1.2.13' THEN
                        'Recursos A Receber Tesouro Estadual'
                    WHEN codconta_n1 = '1.1.3.01' THEN
                        'Matérias-Primas'
                    WHEN codconta_n1 = '1.1.3.02' THEN
                        'Material De Uso E Consumo'
                    WHEN codconta_n1 = '1.1.3.03' THEN
                        'Produtos Agropecuários Em Formação'
                    WHEN codconta_n1 = '1.1.3.04' THEN
                        'Produtos Em Elaboração'
                    WHEN codconta_n1 = '1.1.3.05' THEN
                        'Produtos Agropecuários Acabados'
                    WHEN codconta_n1 = '1.1.3.06' THEN
                        'Produtos Acabados'
                    WHEN codconta_n1 = '1.1.3.07' THEN
                        'Mercadorias Para Revenda'
                    WHEN codconta_n1 = '1.1.3.08' THEN
                        'Animais'
                    WHEN codconta_n1 = '1.1.3.09' THEN
                        'Estoque Em Poder De Terceiros'
                    WHEN codconta_n1 = '1.1.3.10' THEN
                        'Transferência De Produtos E Mercadorias'
                    WHEN codconta_n1 = '1.1.3.11' THEN
                        'Transferência De Animais'
                    WHEN codconta_n1 = '1.1.3.12' THEN
                        'Outros Estoques'
                    WHEN codconta_n1 = '1.1.4.01' THEN
                        'Seguros A Apropriar'
                    WHEN codconta_n1 = '1.1.4.02' THEN
                        'Assinaturas A Apropriar'
                    WHEN codconta_n1 = '1.1.4.03' THEN
                        'Despesas Antecipadas'
                    WHEN codconta_n1 = '1.1.4.04' THEN
                        'Contrapartida Financeira Convênio'
                    WHEN codconta_n1 = '1.2.1.01' THEN
                        'Depositos Judiciais'
                    WHEN codconta_n1 = '1.2.1.02' THEN
                        'Deposito Recursal'
                    WHEN codconta_n1 = '1.2.1.03' THEN
                        'Emprestimos Compulsorios'
                    WHEN codconta_n1 = '1.2.1.04' THEN
                        'Despesas Antecipadas Longo Prazo'
                    WHEN codconta_n1 = '1.2.1.05' THEN
                        'Recursos A Receber Tesouro Estadual'
                    WHEN codconta_n1 = '1.2.1.06' THEN
                        'Ativos Fiscais Diferidos'
                    WHEN codconta_n1 = '1.2.2.01' THEN
                        'Participação Perman.Em Outras Sociedades'
                    WHEN codconta_n1 = '1.2.3.01' THEN
                        'Terrenos'
                    WHEN codconta_n1 = '1.2.3.02' THEN
                        'Edifícios, Benfeitorias E Instalações'
                    WHEN codconta_n1 = '1.2.3.03' THEN
                        'Maquinas, Aparelhos E Equipamentos'
                    WHEN codconta_n1 = '1.2.3.04' THEN
                        'Equipamentos De Processamento De Dados'
                    WHEN codconta_n1 = '1.2.3.05' THEN
                        'Móveis E Utensilios'
                    WHEN codconta_n1 = '1.2.3.06' THEN
                        'Veículos'
                    WHEN codconta_n1 = '1.2.3.07' THEN
                        'Biblioteca, Mapoteca E Discoteca'
                    WHEN codconta_n1 = '1.2.3.08' THEN
                        'Imobilizado Biológico'
                    WHEN codconta_n1 = '1.2.3.09' THEN
                        'Obras Em Andamento'
                    WHEN codconta_n1 = '1.2.3.10' THEN
                        'Imobilizado Adiantamento A Fornecedores '
                    WHEN codconta_n1 = '1.2.3.11' THEN
                        'Correção Monetária Diferença Ipc/Btnf/90'
                    WHEN codconta_n1 = '1.2.3.12' THEN
                        'Depreciação Acumulada'
                    WHEN codconta_n1 = '1.2.3.13' THEN
                        'Depreciação Acumul.Diferença Ipc/Btnf/90'
                    WHEN codconta_n1 = '1.2.3.14' THEN
                        'Transferência De Bens Móveis'
                    WHEN codconta_n1 = '1.2.4.01' THEN
                        'Marcas E Patentes'
                    WHEN codconta_n1 = '1.2.4.02' THEN
                        'Direito De Uso '
                    WHEN codconta_n1 = '1.2.4.03' THEN
                        'Registro De Patentes Em Andamento'
                    WHEN codconta_n1 = '1.2.4.04' THEN
                        'Correção Monetária Diferença Ipc/Btnf/90'
                    WHEN codconta_n1 = '1.2.4.05' THEN
                        'Amortização Acumulada'
                    WHEN codconta_n1 = '2.1.1.01' THEN
                        'Fornecedores'
                    WHEN codconta_n1 = '2.1.1.02' THEN
                        'Adiantamento De Clientes'
                    WHEN codconta_n1 = '2.1.1.03' THEN
                        'Salários E Encargos Sociais'
                    WHEN codconta_n1 = '2.1.1.04' THEN
                        'Credores Diversos'
                    WHEN codconta_n1 = '2.1.1.05' THEN
                        'Parcelamento De Ações Judiciais'
                    WHEN codconta_n1 = '2.1.2.01' THEN
                        'Tributos E Contribuições A Recolher'
                    WHEN codconta_n1 = '2.1.2.02' THEN
                        'Parcelamentos De Débitos Fiscais'
                    WHEN codconta_n1 = '2.1.3.01' THEN
                        'Credores Por Convênio'
                    WHEN codconta_n1 = '2.1.4.01' THEN
                        'Provisão De Férias '
                    WHEN codconta_n1 = '2.1.4.02' THEN
                        'Provisão De 13º Salário '
                    WHEN codconta_n1 = '2.1.4.03' THEN
                        'Provisão De Ações Trabalhistas'
                    WHEN codconta_n1 = '2.1.4.04' THEN
                        'Outras Provisões'
                    WHEN codconta_n1 = '2.1.5.01' THEN
                        'Produtos De Terceiros Em Nosso Poder '
                    WHEN codconta_n1 = '2.2.1.01' THEN
                        'Parcelamentos De Débitos Fiscais'
                    WHEN codconta_n1 = '2.2.1.02' THEN
                        'Fornecedores'
                    WHEN codconta_n1 = '2.2.1.03' THEN
                        'Provisão Para Riscos Trabalhistas'
                    WHEN codconta_n1 = '2.2.1.04' THEN
                        'Provisão Para Riscos Civeis'
                    WHEN codconta_n1 = '2.2.1.05' THEN
                        'Outras Provisões'
                    WHEN codconta_n1 = '2.3.1.01' THEN
                        'Capital Social'
                    WHEN codconta_n1 = '2.3.2.01' THEN
                        'Reservas De Capital'
                    WHEN codconta_n1 = '2.3.2.02' THEN
                        'Reservas De Lucros'
                    WHEN codconta_n1 = '2.3.3.01' THEN
                        'Prejuízos Acumulados'
                    WHEN codconta_n1 = '2.3.4.01' THEN
                        'Ajustes De Avaliação Patrimonial'
                    WHEN codconta_n1 = '3.1.1.01' THEN
                        'Matéria-Prima Direta'
                    WHEN codconta_n1 = '3.1.1.02' THEN
                        'Mão-De-Obra Direta'
                    WHEN codconta_n1 = '3.1.1.03' THEN
                        'Custos Indiretos'
                    WHEN codconta_n1 = '3.1.1.04' THEN
                        'Custo Do Serviço Prestado'
                    WHEN codconta_n1 = '3.1.1.05' THEN
                        'Custo Do Produto Agropecuario Vendido'
                    WHEN codconta_n1 = '3.1.1.06' THEN
                        'Custo De Revistas E Publicações Vendidas'
                    WHEN codconta_n1 = '3.1.1.07' THEN
                        'Custo Dos Animais Vendidos'
                    WHEN codconta_n1 = '3.1.1.08' THEN
                        'Custo Do Produto Industrial Vendido'
                    WHEN codconta_n1 = '3.1.1.09' THEN
                        'Custo Da Mercadoria Revendida'
                    WHEN codconta_n1 = '3.1.1.10' THEN
                        'Perdas De Produtos'
                    WHEN codconta_n1 = '3.1.1.11' THEN
                        'Perdas De Animais'
                    WHEN codconta_n1 = '3.2.1.01' THEN
                        'Despesa Com Pessoal De Vendas '
                    WHEN codconta_n1 = '3.2.1.02' THEN
                        'Despesas Comerciais'
                    WHEN codconta_n1 = '3.2.2.01' THEN
                        'Despesa Com Pessoal Administrativo'
                    WHEN codconta_n1 = '3.2.2.02' THEN
                        'Material De Consumo'
                    WHEN codconta_n1 = '3.2.2.03' THEN
                        'Serviços De Terceiros'
                    WHEN codconta_n1 = '3.2.2.04' THEN
                        'Despesas Gerais '
                    WHEN codconta_n1 = '3.2.2.05' THEN
                        'Despesas Com Provisões'
                    WHEN codconta_n1 = '3.2.3.01' THEN
                        'Insubsistências Ativas'
                    WHEN codconta_n1 = '3.2.3.02' THEN
                        'Perdas De Produtos'
                    WHEN codconta_n1 = '3.2.3.03' THEN
                        'Perdas De Animais'
                    WHEN codconta_n1 = '3.3.1.01' THEN
                        'Despesas Financeiras'
                    WHEN codconta_n1 = '3.3.1.02' THEN
                        '( - ) Receitas Financeiras'
                    WHEN codconta_n1 = '3.4.1.01' THEN
                        'Imposto De Renda E Contribuição Social'
                    WHEN codconta_n1 = '4.1.1.01' THEN
                        'Produtos Agropecuários'
                    WHEN codconta_n1 = '4.1.1.02' THEN
                        'Revistas E Publicações'
                    WHEN codconta_n1 = '4.1.1.03' THEN
                        'Animais'
                    WHEN codconta_n1 = '4.1.1.04' THEN
                        'Produtos Industrializados'
                    WHEN codconta_n1 = '4.1.1.05' THEN
                        'Venda De Serviços'
                    WHEN codconta_n1 = '4.1.1.06' THEN
                        'Revenda De Mercadorias'
                    WHEN codconta_n1 = '4.1.2.01' THEN
                        '(-) Deduções Da Receita'
                    WHEN codconta_n1 = '4.2.1.01' THEN
                        'Transferencias De Recursos Do Estado'
                    WHEN codconta_n1 = '4.2.1.02' THEN
                        'Transferencias De Recursos Do Município'
                    WHEN codconta_n1 = '4.2.2.01' THEN
                        'Recursos De Convênios Poder Público'
                    WHEN codconta_n1 = '4.2.2.02' THEN
                        'Recursos De Convênios Iniciativa Privada'
                    WHEN codconta_n1 = '4.2.3.01' THEN
                        'Receitas De Doações Do Poder Público'
                    WHEN codconta_n1 = '4.2.4.01' THEN
                        'Superveniências Ativas'
                    WHEN codconta_n1 = '4.2.5.01' THEN
                        'Diversas Receitas Operacionais'
                    WHEN codconta_n1 = '4.3.1.01' THEN
                        'Ganhos E Perdas No Imobilizado/Intangive'
                    WHEN codconta_n1 = '4.3.1.02' THEN
                        'Outros Ganhos E Perdas'
                    WHEN codconta_n1 = '4.3.2.01' THEN
                        'Resultado Da Correcao Monetaria'
                    WHEN codconta_n1 = '5.1.1.01' THEN
                        'Apuração Do Resultado'
                    WHEN codconta_n1 = '5.1.2.01' THEN
                        'Resultados Trimestrais'
                    WHEN codconta_n1 = '5.1.3.01' THEN
                        'Resultados Acumulados'
                    WHEN codconta_n1 = '6.1.1.01' THEN
                        'Bens Recebidos Em Convenios/Comodato'
                    WHEN codconta_n1 = '6.1.1.02' THEN
                        'Remessa Em Consignacao'
                    WHEN codconta_n1 = '6.1.1.03' THEN
                        'Bens/Mercad Recebidos Em Demonstracao'
                    WHEN codconta_n1 = '6.1.1.04' THEN
                        'Mercad Recebidas Para Benef/Industrializ'
                    WHEN codconta_n1 = '6.1.1.05' THEN
                        'Simples Fat.Compra P/Recebimento Futuro'
                    WHEN codconta_n1 = '6.1.1.06' THEN
                        'Mercadorias Recebidas Em Consignacao'
                    WHEN codconta_n1 = '6.1.1.07' THEN
                        'Animais Recebidos Em Convenios/Comodato'
                    WHEN codconta_n1 = '6.1.1.08' THEN
                        'Remessa De Animais Em Convenios/Comodato'
                    WHEN codconta_n1 = '6.1.1.09' THEN
                        'Simples Fat.Venda Para Entrega Futura'
                    WHEN codconta_n1 = '6.1.1.10' THEN
                        'Diversos Responsaveis Em Apuracao'
                    WHEN codconta_n1 = '6.1.1.11' THEN
                        'Produtos De Terceiros Em Nosso Poder/Venda Para Entrega Futura'
                    WHEN codconta_n1 = '7.1.1.01' THEN
                        'Bens De Terceiros Em Convenios/Comodato'
                    WHEN codconta_n1 = '7.1.1.02' THEN
                        'Mercadorias Com Terceiros Consignatarios'
                    WHEN codconta_n1 = '7.1.1.03' THEN
                        'Bens/Mercad De Terceiros Em Demonstracao'
                    WHEN codconta_n1 = '7.1.1.04' THEN
                        'Mercad De Terceiros P/ Benef/Industrial'
                    WHEN codconta_n1 = '7.1.1.05' THEN
                        'Simples Fat.Compra P/Recebimento Futuro'
                    WHEN codconta_n1 = '7.1.1.06' THEN
                        'Mercadorias De Terceiros Consignantes'
                    WHEN codconta_n1 = '7.1.1.07' THEN
                        'Animais De Terceiros Convenios/Comodato'
                    WHEN codconta_n1 = '7.1.1.08' THEN
                        'Animais Com Terceiros Convenios/Comodato'
                    WHEN codconta_n1 = '7.1.1.09' THEN
                        'Simples Fat.Venda Para Entrega Futura'
                    WHEN codconta_n1 = '7.1.1.10' THEN
                        'Diversos Responsaveis Em Apuracao'
                    WHEN codconta_n1 = '7.1.1.11' THEN
                        'Produtos De Terceiros Em Nosso Poder/Venda Para Entrega Futura'
                END
            )                            AS descricao_n1,
            codconta_n1,
            0                            AS baixas,
            nvl(SUM(baixa), 0)           AS baixas2,
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
                        /*  WHEN '01/12/2021' >= '01/01/2017'*/
                                WHEN '01/12/2021' >= '01/01/2017' THEN
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
                                /* WHERE TRELSLD.DATAMOVIMENTO >= :DATAINICIO
                                    AND TRELSLD.DATAMOVIMENTO <= :DATAFIM
                                    AND TRELSLD.CODLOC >= :CODLOC_INICIAL
                                    AND TRELSLD.CODLOC <= :CODLOC_FINAL
                                    AND TRELSLD.CODFILIAL >= :CODFILIAL_INICIAL
                                    AND TRELSLD.CODFILIAL <= :CODFILIAL_FINAL*/
                                        WHERE
                                                trelsld.datamovimento >= '01/12/2021'
                                            AND trelsld.datamovimento <= '31/12/2021'
                                            AND trelsld.codloc >= '01.001.01'
                                            AND trelsld.codloc <= '99.999.99'
                                            AND trelsld.codfilial >= 1
                                            AND trelsld.codfilial <= 1
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
            codloc,
            codconta
    )
GROUP BY
    codfilial,
    codloc,
    codconta
ORDER BY
    codfilial,
    codloc,
    codconta