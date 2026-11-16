# Quizzada Terminal

O **Quizzada Terminal** é um jogo de perguntas e respostas desenvolvido em **Dart**, executado diretamente pelo terminal.

O projeto foi desenvolvido como parte da capacitação da **Asimov Jr.**, com o objetivo de aplicar conceitos fundamentais da linguagem Dart.

## Requisitos e execução

Para executar o projeto, é necessário ter o **Dart SDK** instalado, em uma versão compatível com `^3.13.7`.

**1. Clone o repositório:**

```bash
git clone https://github.com/pedro-restani/quizzada-terminal.git
```

**2. Acesse a pasta do projeto:**

```bash
cd quizzada-terminal
```

**3. Instale as dependências:**

```bash
dart pub get
```

**4. Execute o jogo:**

```bash
dart run
```

## Como jogar

Ao iniciar o programa, siga estas etapas:

1. Informe a quantidade de jogadores (mínimo de um).
2. Digite o nome de cada participante.
3. Escolha uma das opções de dificuldade:
   - `1` — Somente perguntas fáceis.
   - `2` — Somente perguntas difíceis.
   - `3` — Todas as dificuldades.
4. Responda às perguntas digitando uma alternativa de `A` a `D`.
5. Consulte o ranking apresentado ao final da partida.

As respostas aceitam letras maiúsculas ou minúsculas, além de espaços antes ou depois da letra. Entradas inválidas são rejeitadas e solicitadas novamente.

Em partidas com múltiplos jogadores, as perguntas são distribuídas em turnos alternados.

## Demonstração em vídeo

A demonstração do funcionamento do Quizzada Terminal está disponível no Google Drive.

[Assistir à demonstração do projeto](https://drive.google.com/drive/folders/15M8xA6bPg7AD2nM_TWw00JK12fKqvpuQ?usp=drive_link)

## Funcionalidades e pontuação

O jogo utiliza perguntas de múltipla escolha, organizadas em três níveis de dificuldade.

Cada resposta correta acrescenta pontos conforme a dificuldade da pergunta:

| Dificuldade | Pontuação |
|-------------|-----------|
| Fácil | 10 pontos |
| Média | 20 pontos |
| Difícil | 30 pontos |

Respostas incorretas não acrescentam pontos, e o programa informa a alternativa correta.

Ao final da partida, é apresentado um placar com a pontuação obtida, a pontuação máxima possível e a quantidade de acertos de cada participante. A pontuação máxima é calculada considerando as perguntas atribuídas individualmente a cada jogador.

O programa também oferece validação das entradas, tratamento de exceções para respostas inválidas e organização das perguntas por meio de objetos.

### Funcionalidades bônus

Foram implementadas quatro funcionalidades adicionais:

- **Múltiplos jogadores:** permite partidas com dois ou mais participantes, alternando os turnos.
- **Ranking:** classifica os jogadores em ordem decrescente de pontuação.
- **Filtro de dificuldade:** permite selecionar apenas perguntas fáceis, apenas difíceis ou todas as dificuldades.
- **Embaralhamento de alternativas:** altera a ordem das opções de cada pergunta, mantendo a identificação da resposta correta.

## Estrutura do projeto

Os principais arquivos do projeto estão organizados da seguinte forma:

```text
quizzada-terminal/
├── bin/
│   └── quizzada_terminal.dart
├── lib/
│   ├── dificuldade.dart
│   ├── jogador.dart
│   ├── partida.dart
│   ├── pergunta.dart
│   └── resposta_invalida_exception.dart
├── analysis_options.yaml
├── pubspec.yaml
└── README.md
```

**Responsabilidades dos arquivos:**

- `bin/quizzada_terminal.dart`: ponto de entrada da aplicação, responsável pela configuração e execução do jogo.
- `lib/pergunta.dart`: representa as perguntas, converte os dados armazenados em mapas e embaralha as alternativas.
- `lib/jogador.dart`: armazena o nome, a pontuação e a quantidade de acertos dos jogadores.
- `lib/partida.dart`: gerencia a apresentação das perguntas, a validação das respostas e o placar final.
- `lib/dificuldade.dart`: define os níveis de dificuldade e suas respectivas pontuações.
- `lib/resposta_invalida_exception.dart`: define a exceção personalizada utilizada na validação das respostas.

## Verificação do código

Para executar a análise estática do projeto:

```bash
dart analyze
```

Para formatar os arquivos Dart:

```bash
dart format .
```

---

Projeto desenvolvido para a capacitação da **Asimov Jr.**