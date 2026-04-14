# Como LLM Pode Promover o Aprendizado e o Desenvolvimento de Aplicacoes Ruby?

## Introducao

Este trabalho foi desenvolvido a partir da resolucao dos exercicios do Homework 01 em Ruby. A proposta nao se limitou a produzir respostas funcionais para cada parte, mas tambem a registrar o raciocinio envolvido na construcao das solucoes e a refletir sobre o uso de modelos de linguagem de grande porte (LLMs) como apoio ao processo de aprendizagem.

Ruby foi uma linguagem adequada para esse tipo de atividade porque permite resolver problemas relativamente pequenos usando recursos expressivos e de alto nivel. Ao mesmo tempo, essa expressividade exige atencao: muitas vezes existem varias formas corretas de chegar ao mesmo resultado, e comparar essas formas faz parte do aprendizado. Nesse contexto, o uso de LLM ajudou principalmente como apoio para discutir alternativas, revisar a clareza dos algoritmos e acelerar a consulta sobre recursos da linguagem, sem substituir a necessidade de entendimento do codigo.

O objetivo central deste relatorio e apresentar a resolucao das Partes 01 a 06, explicar as principais estruturas e algoritmos empregados, discutir alternativas de implementacao e analisar criticamente como o uso de LLM contribuiu para o estudo de Ruby e para a organizacao do trabalho.

## Resolucao das Partes 01 a 06

### Parte 01A - Verificacao de palindromos

**Objetivo do exercicio**

O objetivo foi verificar se uma string pode ser considerada um palindromo, desconsiderando diferencas entre letras maiusculas e minusculas e ignorando caracteres que nao sao alfanumericos.

**Logica utilizada**

A solucao normaliza a string antes da comparacao. Primeiro, converte todo o texto para minusculas com `downcase`. Em seguida, remove caracteres nao relevantes com `gsub(/\W/, "")`. Depois disso, compara a string normalizada com sua versao invertida, obtida por `reverse`. Se ambas forem iguais, o metodo retorna `true`; caso contrario, retorna `false`.

Essa abordagem e simples e direta porque transforma o problema em uma comparacao entre duas sequencias equivalentes. Em vez de comparar caractere por caractere com ponteiros ou indices, a implementacao aproveita metodos prontos da linguagem para reduzir a complexidade do codigo.

**Estruturas do Ruby envolvidas**

- `String`
- expressoes regulares
- metodos `downcase`, `gsub` e `reverse`
- retorno booleano por comparacao

**Possiveis alternativas de implementacao**

Uma alternativa seria percorrer a string com dois indices, um no inicio e outro no fim, ignorando os caracteres indesejados durante o percurso. Essa abordagem evita criar uma string invertida inteira, mas tende a deixar a implementacao menos legivel.

Tambem seria possivel usar `scan` para selecionar apenas os caracteres validos e, depois, comparar o array gerado com sua versao invertida. A vantagem seria deixar mais explicita a etapa de filtragem; a desvantagem e introduzir uma estrutura intermediaria sem necessidade real para esse caso.

Em uma comparacao entre estilo mais funcional e mais imperativo, a solucao adotada fica mais proxima de um estilo declarativo, porque descreve transformacoes sobre os dados em vez de controlar passo a passo o fluxo da comparacao.

### Parte 01B - Contagem de palavras

**Objetivo do exercicio**

O exercicio pede a contagem da frequencia de cada palavra presente em uma string.

**Logica utilizada**

A solucao comeca convertendo a string para minusculas com `downcase`, o que evita que a mesma palavra seja contada separadamente por causa de variacoes de caixa. Depois, usa `scan(/\b\w+\b/)` para extrair as palavras. O resultado dessa etapa e percorrido com `each_with_object(Hash.new(0))`, produzindo um hash cujo valor padrao e zero. A cada palavra encontrada, o contador correspondente e incrementado.

O algoritmo e eficiente para o tamanho esperado do problema, pois realiza uma passagem principal sobre a colecao de palavras e armazena as frequencias em uma estrutura de acesso rapido.

**Estruturas do Ruby envolvidas**

- `String`
- expressoes regulares
- `Array` gerado por `scan`
- `Hash.new(0)` para contagem
- `each_with_object`

**Possiveis alternativas de implementacao**

Uma alternativa mais imperativa seria iniciar um hash vazio e atualiza-lo com um `each` tradicional. O resultado seria equivalente, mas com um pouco mais de codigo.

Outra possibilidade seria usar `group_by` seguido de transformacao dos grupos em contagens. Essa abordagem pode ser elegante, mas tende a consumir mais memoria porque armazena todas as ocorrencias agrupadas antes de calcular o total.

Tambem seria possivel tratar pontuacao e separadores com logica manual, percorrendo caractere por caractere. Isso daria maior controle sobre casos especiais, mas reduziria a clareza da solucao em um problema que pode ser resolvido de forma idiomatica com regex.

### Parte 02A - Vencedor de uma partida de pedra-papel-tesoura

**Objetivo do exercicio**

O objetivo foi determinar o vencedor de uma partida entre dois jogadores no jogo pedra-papel-tesoura, validando a estrutura da entrada e as estrategias informadas.

**Logica utilizada**

A implementacao primeiro verifica se a partida possui exatamente dois jogadores. Caso contrario, lanca `WrongNumberOfPlayersError`. Em seguida, separa os jogadores, converte as jogadas para letras maiusculas com `to_s.upcase` e valida se as estrategias pertencem ao conjunto permitido `R`, `P` ou `S`. Se houver valor invalido, e lancada a excecao `NoSuchStrategyError`.

Depois da validacao, a regra do jogo e representada por um hash chamado `winning_strategy`, no qual cada jogada vencedora aponta para a jogada que ela derrota. O vencedor e decidido por uma expressao condicional: em caso de empate, o primeiro jogador vence; caso contrario, o hash e consultado para verificar se a estrategia do primeiro jogador vence a do segundo.

**Estruturas do Ruby envolvidas**

- `Array` para representar a partida e os jogadores
- paralelizacao de atribuicao com `player1, player2 = game`
- `Hash` para representar regras de vitoria
- excecoes personalizadas
- validacao com `include?`

**Possiveis alternativas de implementacao**

Uma alternativa seria usar varias estruturas condicionais com `if` e `elsif` para comparar as jogadas. Isso funciona, mas a solucao com hash concentra melhor a regra do dominio em uma estrutura de dados, o que facilita manutencao.

Outra possibilidade seria transformar as estrategias em simbolos, como `:R`, `:P` e `:S`. Isso poderia tornar a representacao mais idiomatica em alguns contextos, mas nao alteraria de forma significativa a logica do exercicio.

Tambem seria possivel nao criar excecoes personalizadas e apenas retornar algum valor especial em caso de erro. No entanto, a opcao por excecoes deixa mais claro que a entrada e invalida e que o problema nao deve prosseguir silenciosamente.

### Parte 02B - Vencedor de um torneio

**Objetivo do exercicio**

O objetivo foi determinar o vencedor de um torneio de pedra-papel-tesoura representado por uma estrutura aninhada.

**Logica utilizada**

A solucao usa recursao. O caso base ocorre quando o primeiro elemento da estrutura do torneio e uma string, o que indica que ja se chegou a um jogador individual. Nesse caso, o proprio elemento e retornado.

Quando a estrutura ainda representa rodadas internas do torneio, a funcao chama a si mesma para encontrar os vencedores das subchaves e depois envia o resultado das duas partidas para `rps_game_winner`. Assim, o problema maior e reduzido sucessivamente a problemas menores da mesma natureza.

Essa implementacao e adequada porque a propria entrada tem formato recursivo. Em vez de tentar achatar o torneio antes de processa-lo, a funcao acompanha a estrutura natural dos dados.

**Estruturas do Ruby envolvidas**

- `Array` aninhado
- recursao
- bloco com `map`
- reaproveitamento da funcao `rps_game_winner`

**Possiveis alternativas de implementacao**

Uma alternativa seria percorrer o torneio de forma iterativa, convertendo a estrutura em filas ou pilhas auxiliares. Essa estrategia pode funcionar, mas normalmente fica menos natural do que a recursao para esse formato de entrada.

Outra possibilidade seria criar objetos para representar partidas e torneios. Isso deixaria o dominio mais orientado a objetos, mas seria um custo extra de modelagem para um exercicio cujo foco principal esta na manipulacao de estruturas aninhadas.

Em termos de estilo, esta parte combina um raciocinio declarativo no uso de `map` com um controle de fluxo recursivo bastante claro.

### Parte 03 - Agrupamento de anagramas

**Objetivo do exercicio**

O objetivo foi agrupar palavras que sao anagramas entre si.

**Logica utilizada**

A solucao utiliza `group_by` para reunir palavras pela mesma chave canonica. Essa chave e produzida convertendo a palavra para minusculas, separando seus caracteres com `chars`, ordenando-os com `sort` e juntando novamente com `join`. Palavras que geram a mesma chave pertencem ao mesmo grupo de anagramas. Ao final, o metodo retorna apenas os valores do hash produzido, isto e, os grupos encontrados.

O algoritmo e direto e aproveita uma ideia importante: duas palavras sao anagramas quando possuem o mesmo conjunto de letras com a mesma multiplicidade. Ordenar os caracteres e uma forma simples de representar essa propriedade.

**Estruturas do Ruby envolvidas**

- `Array`
- `Hash` produzido por `group_by`
- `String`
- cadeia de chamadas com `downcase`, `chars`, `sort` e `join`

**Possiveis alternativas de implementacao**

Uma alternativa seria usar, como chave, um hash de frequencia de letras em vez da palavra ordenada. Isso pode ser vantajoso em casos maiores ou quando se quer evitar ordenacao, mas produz uma chave menos simples de manipular.

Tambem seria possivel escrever a logica de agrupamento manualmente, verificando palavra por palavra e inserindo em grupos existentes. Essa abordagem seria mais trabalhosa e menos eficiente, alem de ignorar um recurso bastante apropriado da linguagem, que e o `group_by`.

Do ponto de vista funcional versus imperativo, esta solucao fica claramente mais proxima de um estilo funcional, porque transforma a colecao e delega a agregacao ao proprio metodo da linguagem.

### Parte 04 - Classes `Dessert` e `JellyBean`

**Objetivo do exercicio**

O objetivo foi trabalhar conceitos de orientacao a objetos em Ruby, definindo classes, atributos, metodos de instancia e heranca.

**Logica utilizada**

Foram definidas duas classes. A primeira, `Dessert`, possui os atributos `name` e `calories`, com acesso por `attr_accessor`. O metodo `healthy?` verifica se o valor de calorias e menor que 200, enquanto `delicious?` retorna `true` por padrao.

A classe `JellyBean` herda de `Dessert`, adiciona o atributo `flavor` e reaproveita o construtor da superclasse por meio de `super`. O metodo `delicious?` e sobrescrito para tratar um caso especifico: quando o sabor e `"black licorice"`, o retorno passa a ser `false`; nos demais casos, continua sendo verdadeiro.

Essa parte evidencia bem o uso de heranca para especializar comportamento sem duplicar a estrutura comum da classe base.

**Estruturas do Ruby envolvidas**

- definicao de classes
- `attr_accessor`
- construtor `initialize`
- heranca
- uso de `super`
- sobrescrita de metodo

**Possiveis alternativas de implementacao**

Uma alternativa seria evitar heranca e tratar tudo em uma unica classe com condicionais internas. Isso reduziria a quantidade de classes, mas pioraria a separacao de responsabilidades.

Outra possibilidade seria usar composicao em vez de heranca, separando o conceito de sobremesa do criterio de sabor. Em um sistema maior, isso poderia aumentar a flexibilidade. Para este exercicio, porem, a heranca resolve o problema com mais simplicidade.

Tambem seria possivel validar tipos ou valores no construtor, mas isso nao foi necessario para atender ao comportamento esperado pelo enunciado.

### Parte 05 - `attr_accessor_with_history`

**Objetivo do exercicio**

O exercicio pede a criacao de um recurso semelhante ao `attr_accessor`, mas com armazenamento do historico dos valores atribuidos a um atributo.

**Logica utilizada**

A implementacao reabre a classe `Class` e define o metodo `attr_accessor_with_history`. Esse metodo recebe o nome do atributo, converte-o para string e cria dinamicamente o leitor comum com `attr_reader`.

Em seguida, define um metodo `<atributo>_history` com `define_method`. Esse metodo garante que a variavel de instancia responsavel pelo historico exista e, se ainda nao existir, inicializa o historico com `[nil]`. Depois, retorna o array armazenado.

Tambem e criado dinamicamente o metodo de escrita `<atributo>=`. Sempre que um novo valor e atribuido, ele e acrescentado ao historico com `send("#{attr_name}_history") << value`, e so depois a variavel de instancia principal recebe o valor atual com `instance_variable_set`.

Essa solucao demonstra metaprogramacao porque gera metodos em tempo de execucao a partir de um nome informado pelo programador.

**Estruturas do Ruby envolvidas**

- classes abertas
- metaprogramacao
- `define_method`
- `instance_variable_get`
- `instance_variable_set`
- `instance_variable_defined?`
- `send`
- `Array` para o historico

**Possiveis alternativas de implementacao**

Uma alternativa seria armazenar o historico em uma estrutura externa, como um hash indexado por objeto. Embora possivel, isso aumentaria o acoplamento e deixaria a interface menos natural.

Outra possibilidade seria usar `class_eval` com construcao de metodos por string. Essa tecnica tambem e comum em Ruby, mas `define_method` tende a ser mais segura e legivel para esse tipo de tarefa.

Quanto ao uso de `yield`, ele nao aparece na implementacao atual. Como alternativa teorica, seria possivel criar uma API baseada em blocos para acompanhar atribuicoes ou interceptar atualizacoes, mas isso representaria outro desenho de solucao, nao o que foi efetivamente implementado aqui.

### Parte 06 - Classes abertas em `Numeric`, `String` e `Enumerable`

**Objetivo do exercicio**

O objetivo desta parte foi explorar a abertura de classes nativas da linguagem para adicionar novos comportamentos.

**Logica utilizada**

Na classe `Numeric`, foi criado um mecanismo de conversao de moedas. Um hash de taxas de conversao fica armazenado em uma variavel de classe. O metodo `method_missing` intercepta chamadas como `5.euros` ou `10.dollars`, normaliza o nome da moeda para o singular e, se a moeda existir no hash, multiplica o numero pela taxa correspondente. O metodo `respond_to_missing?` foi implementado para manter a consistencia da introspeccao. Alem disso, o metodo `in(currency)` converte o valor atual para a moeda desejada, dividindo pela taxa correspondente e lancando erro quando a moeda nao existe.

Na classe `String`, foi adicionado um metodo `palindrome?` semelhante ao da Parte 01A, reutilizando a ideia de normalizar a string e compara-la com sua versao invertida.

No modulo `Enumerable`, foi adicionado um metodo `palindrome?` que verifica se uma colecao e igual a sua reversa depois de convertida para array com `to_a`.

Essa parte mostra bem o poder e, ao mesmo tempo, o cuidado necessario ao modificar classes e modulos nativos da linguagem. O ganho de expressividade e grande, mas mudancas desse tipo podem impactar legibilidade e manutencao se forem usadas sem criterio.

**Estruturas do Ruby envolvidas**

- classes abertas
- modulo `Enumerable`
- `method_missing`
- `respond_to_missing?`
- `Hash` para taxas
- `String`
- `Array`
- tratamento de erro com `NoMethodError`

**Possiveis alternativas de implementacao**

Uma alternativa seria evitar `method_missing` e definir explicitamente um metodo para cada moeda. Essa opcao melhora previsibilidade e pode facilitar depuracao, mas perde flexibilidade.

Outra alternativa seria encapsular as conversoes em uma classe ou modulo especifico, em vez de alterar `Numeric`. Isso reduziria o impacto global sobre a linguagem e deixaria o codigo mais conservador.

Sobre mixins, a implementacao atual nao cria um novo modulo reutilizavel para ser incluido em outras classes; ela reabre diretamente `Enumerable` e classes nativas. Como alternativa, seria possivel criar um modulo proprio e inclui-lo seletivamente. Essa abordagem diminuiria o acoplamento global e tornaria o comportamento mais controlado.

## Estruturas de Dados, Recursos da Linguagem e Algoritmos Utilizados

Ao longo do trabalho, algumas estruturas e recursos apareceram com mais frequencia e tiveram papel central na resolucao dos problemas.

Os `Hash` foram importantes em diferentes contextos. Na contagem de palavras, permitiram armazenar frequencias com acesso rapido. No jogo pedra-papel-tesoura, serviram para representar a regra de vitoria de forma compacta. Nas conversoes de moedas, organizaram as taxas de maneira simples e extensivel.

Os `Array` tambem foram essenciais, tanto como estrutura principal das entradas quanto como suporte para transformacoes. Eles aparecem na representacao de partidas, torneios, listas de palavras, historico de atributos e sequencias verificadas como palindromo.

As expressoes regulares tiveram funcao relevante nas tarefas de processamento textual. Em especial, ajudaram a remover caracteres irrelevantes e a identificar palavras com mais precisao do que uma simples divisao por espacos.

Entre os recursos da linguagem, destacaram-se:

- tratamento de excecoes com classes personalizadas
- recursao para estruturas aninhadas
- heranca e sobrescrita de metodos
- metaprogramacao com `define_method`
- classes abertas e extensao de classes nativas

Em termos algoritmicos, as solucoes exploraram principalmente transformacoes de colecoes, comparacoes diretas, agrupamento por chave e decomposicao recursiva. Nenhum exercicio exigiu algoritmos complexos do ponto de vista assintotico, mas todos exigiram escolhas de representacao que impactam clareza e manutenibilidade.

## Alternativas de Implementacao e Comparacao Critica

Um dos pontos mais importantes deste trabalho foi perceber que, em Ruby, a mesma ideia pode ser implementada com estilos bem diferentes.

No eixo funcional versus imperativo, varias solucoes se beneficiaram de metodos mais declarativos, como `group_by`, `map`, `scan` e `each_with_object`. Eles deixam o codigo mais conciso e aproximam a leitura da intencao do algoritmo. Em contrapartida, solucoes mais imperativas podem ser mais explicitas para quem esta iniciando, especialmente quando o estudante ainda esta construindo familiaridade com os iteradores da linguagem.

No uso de collections, o trabalho mostrou que escolher entre `Array` e `Hash` nao e apenas uma questao de sintaxe, mas de modelo mental. Quando o problema envolve busca por chave, contagem ou mapeamento de regras, o hash tende a ser mais apropriado. Quando o problema envolve ordem, sequencia ou agrupamento direto de elementos, arrays sao suficientes e naturais.

Sobre mixins, eles nao foram usados como estrategia principal nas solucoes entregues. Mesmo assim, a comparacao e importante. Em partes ligadas a comportamento compartilhado, como verificacao de palindromos, seria possivel criar modulos proprios e inclui-los em classes selecionadas. A vantagem seria maior reuso controlado; a desvantagem seria adicionar uma camada de abstracao talvez desnecessaria para exercicios pequenos.

Em relacao ao uso de `yield`, ele tambem nao foi empregado nas implementacoes atuais. Ainda assim, e uma comparacao valida como alternativa. Em vez de centralizar toda a logica dentro de metodos, seria possivel expor pontos de extensao por meio de blocos, principalmente em situacoes que exigissem personalizacao de comportamento. A vantagem seria flexibilidade; a desvantagem, neste trabalho, seria aumentar a complexidade sem ganho claro para os requisitos pedidos.

Outro ponto de comparacao relevante apareceu na Parte 06, entre usar `method_missing` e definir metodos explicitamente. `method_missing` produz uma interface elegante, mas deve ser usado com cautela, porque torna o comportamento menos visivel a primeira leitura. A implementacao de `respond_to_missing?` ajuda a corrigir parte desse problema, mas nao elimina completamente o custo de legibilidade.

De forma geral, a escolha mais adequada nem sempre e a mais curta. Em varios momentos, a melhor decisao foi equilibrar expressividade, fidelidade ao enunciado e clareza para manutencao.

## Como o Uso de LLM Ajudou no Aprendizado e no Desenvolvimento em Ruby

O uso de LLM foi util principalmente como ferramenta de apoio ao raciocinio, e nao como substituto da compreensao dos exercicios. Em vez de apenas pedir respostas prontas, o uso mais produtivo ocorreu quando o modelo foi empregado para:

- revisar se uma abordagem estava coerente com o enunciado
- comparar formas diferentes de resolver o mesmo problema
- esclarecer recursos especificos da linguagem Ruby
- ajudar a explicar, em linguagem mais organizada, por que uma solucao funciona

No estudo de Ruby, isso foi particularmente relevante porque a linguagem oferece muitos recursos idiomaticos. Um estudante pode resolver um problema de forma correta, mas ainda assim deixar de perceber que existe uma forma mais expressiva ou mais alinhada ao estilo da linguagem. Nesse ponto, o LLM ajudou a sugerir pontos de revisao e a ampliar o repertorio de possibilidades.

Ao mesmo tempo, a experiencia tambem mostrou limites importantes. Nem toda sugestao deve ser aceita automaticamente. Em tarefas de documentacao e comparacao critica, foi necessario verificar se a explicacao realmente correspondia ao codigo implementado. Esse cuidado foi essencial para nao atribuir ao projeto recursos que nao foram usados, como mixins ou `yield`, tratando esses elementos apenas como alternativas possiveis quando pertinente.

Portanto, a principal contribuicao do LLM nao esteve apenas em acelerar a escrita, mas em apoiar um processo iterativo de leitura, comparacao, revisao e explicacao.

## Tempo, Esforco e Analise Critica da Experiencia

O trabalho exigiu esforco em tres frentes diferentes: entender os enunciados, implementar as solucoes e analisar criticamente as proprias escolhas.

Na etapa de entendimento, o principal desafio foi interpretar corretamente o comportamento esperado em cada parte, especialmente nos exercicios que envolviam estruturas aninhadas, tratamento de erros e metaprogramacao. Mesmo quando o problema parecia pequeno, detalhes como formato da entrada, tratamento de casos invalidos e comportamento padrao faziam diferenca.

Na etapa de implementacao, algumas partes foram mais diretas, como as relacionadas a strings e agrupamentos. Outras exigiram mais cuidado conceitual, como a criacao de `attr_accessor_with_history` e a abertura de classes nativas na Parte 06. Nessas partes, nao bastava chegar ao resultado; era preciso entender como Ruby trata metodos, variaveis de instancia e despacho dinamico.

A etapa mais trabalhosa foi justamente a analise critica. Resolver o exercicio e diferente de explicar por que aquela implementacao foi escolhida e quais seriam as alternativas. Essa reflexao exigiu voltar ao codigo, identificar as estruturas mais relevantes e avaliar trade-offs entre clareza, flexibilidade e fidelidade ao estilo da linguagem.

Minha avaliacao final da experiencia e positiva. O uso de LLM ajudou a tornar o processo mais rapido em consultas pontuais e na organizacao das explicacoes, mas o ganho real apareceu quando houve validacao critica das respostas. Em outras palavras, a ferramenta foi mais util como apoio de estudo e revisao do que como fonte definitiva de solucao.

## Conclusao

O desenvolvimento deste trabalho permitiu revisar conceitos fundamentais de Ruby por meio de exercicios que, embora curtos, cobrem aspectos importantes da linguagem. As Partes 01 a 06 envolveram desde manipulacao de texto e colecoes ate orientacao a objetos, tratamento de excecoes e metaprogramacao, mostrando como Ruby combina simplicidade sintatica com grande expressividade.

Tambem ficou evidente que aprender Ruby nao consiste apenas em fazer o codigo funcionar. Parte importante do processo esta em comparar abordagens, entender os recursos da linguagem e justificar tecnicamente as escolhas feitas. Nesse sentido, o uso de LLM foi valioso quando empregado com criterio, como apoio para revisar ideias, discutir alternativas e organizar a documentacao do trabalho.

Assim, concluo que LLM pode sim promover o aprendizado e o desenvolvimento de aplicacoes Ruby, desde que seja utilizado de forma consciente e critica. O beneficio maior nao esta em automatizar integralmente a resolucao dos problemas, mas em ampliar a capacidade de analise, revisao e reflexao do estudante sobre o proprio codigo.

## Versao Curta da Introducao

Este trabalho apresenta a resolucao do Homework 01 em Ruby e discute como o uso de LLM pode apoiar o aprendizado da linguagem e a elaboracao das solucoes. Alem de registrar as implementacoes, o relatorio destaca estruturas utilizadas, alternativas de abordagem e uma analise critica do processo.

## Versao Curta da Conclusao

O trabalho mostrou que LLM pode ser um apoio relevante no estudo de Ruby, principalmente para esclarecer conceitos, comparar implementacoes e organizar a reflexao sobre o codigo. Ainda assim, o melhor resultado aparece quando o estudante usa a ferramenta com analise critica e verifica se as respostas realmente correspondem ao que foi implementado.

## Sugestao de Estrutura para a Wiki

Se houver interesse em dividir o relatorio em mais de uma pagina, uma organizacao possivel e:

- `Home`: visao geral do trabalho, introducao, objetivo e conclusao
- `Resolucao-dos-Exercicios`: detalhamento das Partes 01 a 06
- `Analise-do-Uso-de-LLM`: aprendizado, apoio da ferramenta e limites
- `Conclusao`: sintese final e reflexao critica
