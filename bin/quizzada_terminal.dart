import 'dart:io';

import 'package:quizzada_terminal/dificuldade.dart';
import 'package:quizzada_terminal/jogador.dart';
import 'package:quizzada_terminal/partida.dart';
import 'package:quizzada_terminal/pergunta.dart';
import 'package:quizzada_terminal/resposta_invalida_exception.dart';

void main() {
  // Criando as perguntas
  final dadosPerguntas = <Map<String, dynamic>>[
    {
      'texto': 'Qual linguagem é usada no Flutter?',
      'alternativas': ['Java', 'Dart', 'Python', 'C++'],
      'indiceCorreto': 1,
      'dificuldade': 'facil',
    },
    {
      'texto': 'Qual comando envia commits ao GitHub?',
      'alternativas': ['git add', 'git init', 'git push', 'git status'],
      'indiceCorreto': 2,
      'dificuldade': 'facil',
    },
    {
      'texto': 'Qual comando verifica a versão instalada do Dart?',
      'alternativas': [
        'dart run',
        'dart --version',
        'dart analyze',
        'dart pub get',
      ],
      'indiceCorreto': 1,
      'dificuldade': 'facil',
    },
    {
      'texto': 'Qual comando do Git registra alterações no histórico local?',
      'alternativas': ['git push', 'git status', 'git commit', 'git clone'],
      'indiceCorreto': 2,
      'dificuldade': 'facil',
    },
    {
      'texto': 'Qual símbolo encerra a maioria das instruções em Dart?',
      'alternativas': [':', '.', ',', ';'],
      'indiceCorreto': 3,
      'dificuldade': 'facil',
    },
    {
      'texto': 'Qual palavra-chave define uma classe em Dart?',
      'alternativas': ['object', 'class', 'new', 'void'],
      'indiceCorreto': 1,
      'dificuldade': 'media',
    },
    {
      'texto': 'Qual método transforma os elementos de uma lista?',
      'alternativas': ['where()', 'sort()', 'fold()', 'map()'],
      'indiceCorreto': 3,
      'dificuldade': 'media',
    },
    {
      'texto': 'Qual palavra-chave declara uma variável que só pode receber um valor uma vez em Dart?',
      'alternativas': ['var', 'late', 'final', 'dynamic'],
      'indiceCorreto': 2,
      'dificuldade': 'media',
    },
    {
      'texto': 'Qual método retorna apenas os elementos de uma lista que satisfazem uma condição?',
      'alternativas': ['map()', 'where()', 'add()', 'shuffle()'],
      'indiceCorreto': 1,
      'dificuldade': 'media',
    },
    {
      'texto':
          'Qual operador fornece um valor padrão quando uma expressão é nula?',
      'alternativas': ['??', '&&', '!=', '=>'],
      'indiceCorreto': 0,
      'dificuldade': 'media',
    },
    {
      'texto': 'Qual palavra-chave lança uma exceção?',
      'alternativas': ['catch', 'throw', 'try', 'on'],
      'indiceCorreto': 1,
      'dificuldade': 'dificil',
    },
    {
      'texto': 'Qual tipo de construtor pode retornar uma instância existente em Dart?',
      'alternativas': ['const', 'factory', 'super', 'late'],
      'indiceCorreto': 1,
      'dificuldade': 'dificil',
    },
    {
      'texto': 'Qual método acumula os elementos de uma coleção em um único resultado?',
      'alternativas': ['where()', 'map()', 'fold()', 'toList()'],
      'indiceCorreto': 2,
      'dificuldade': 'dificil',
    },
    {
      'texto': 'Qual recurso do Dart permite verificar padrões em uma expressão switch?',
      'alternativas': ['Patterns', 'Imports', 'Mixins', 'Futures'],
      'indiceCorreto': 0,
      'dificuldade': 'dificil',
    },
    {
      'texto': 'Qual palavra-chave relança uma exceção capturada preservando seu rastreamento original?',
      'alternativas': ['throw', 'return', 'assert', 'rethrow'],
      'indiceCorreto': 3,
      'dificuldade': 'dificil',
    },
  ];

  final perguntas = dadosPerguntas.map(Pergunta.fromMap).toList();

  // Coletando o número de jogadores
  int? quantidadeJogadores;

  print("");

  while (quantidadeJogadores == null) {
    stdout.write("Quantos jogadores participarão? ");
    String? entrada = stdin.readLineSync();

    if (entrada == null) {
      print("\nEntrada encerrada. Partida cancelada. ");
      return;
    }

    int? quantidade = int.tryParse(entrada.trim());

    if (quantidade != null && quantidade >= 1) {
      quantidadeJogadores = quantidade;
    } else {
      print("Informe um número inteiro igual ou superior a 1.");
    }
  }

  // Coletando o nome de cada jogador
  final jogadores = <Jogador>[];

  for (int i = 0; i < quantidadeJogadores; i++) {
    String nome = '';

    while (nome.isEmpty) {
      stdout.write('Nome do jogador ${i + 1}: ');
      String? entrada = stdin.readLineSync();

      if (entrada == null) {
        print('\nEntrada encerrada. Partida cancelada.');
        return;
      }

      nome = entrada.trim();

      if (nome.isEmpty) {
        print('O nome não pode estar vazio. Tente novamente.');
      }
    }

    jogadores.add(Jogador(nome: nome));
  }

  // Coletando o nível de dificuldade selecionado
  int? opcaoDificuldade;

  print("\n=== Dificuldade ===");
  print("1) Somente perguntas fáceis");
  print("2) Somente perguntas difíceis");
  print("3) Sem preferência de dificuldade");

  while (opcaoDificuldade == null) {
    stdout.write("Escolha uma opção: ");
    String? entrada = stdin.readLineSync();

    if (entrada == null) {
      print("\nEntrada encerrada. Partida cancelada.");
      return;
    }

    String resposta = entrada.trim();

    if (resposta == '1') {
      opcaoDificuldade = 1;
    } else if (resposta == '2') {
      opcaoDificuldade = 2;
    } else if (resposta == '3') {
      opcaoDificuldade = 3;
    } else {
      print("Opção inválida. Escolha 1, 2 ou 3.");
    }
  }

  // Filtrando as perguntas com base no nível de dificuldade escolhido
  final perguntasFiltradas = perguntas.where((pergunta) {
    return switch (opcaoDificuldade) {
      1 => pergunta.dificuldade == Dificuldade.facil,
      2 => pergunta.dificuldade == Dificuldade.dificil,
      3 => true,
      _ => false,
    };
  }).toList();

  // Embaralhando as alternativas de cada pergunta
  final perguntasEmbaralhadas = perguntasFiltradas
      .map((pergunta) => pergunta.embaralharAlternativas())
      .toList();

  // Criando a partida
  final partida = Partida(
    jogadores: jogadores,
    perguntas: perguntasEmbaralhadas,
  );

  // Gerenciando a interface da partida
  for (
    int indicePergunta = 0;
    indicePergunta < partida.perguntas.length;
    indicePergunta++
  ) {
    Pergunta pergunta = partida.perguntas[indicePergunta];

    int indiceJogador = indicePergunta % partida.jogadores.length;
    Jogador jogadorAtual = partida.jogadores[indiceJogador];

    print("\n=== Vez de ${jogadorAtual.nome} ===");

    partida.apresentarPergunta(pergunta, indicePergunta + 1);

    // Validando as respostas de cada pergunta
    bool respostaValida = false;

    while (!respostaValida) {
      try {
        int? indiceResposta = partida.validarEntrada();

        if (indiceResposta == null) {
          print("\nEntrada encerrada. Partida cancelada.");
          return;
        }

        partida.verificarResposta(jogadorAtual, pergunta, indiceResposta);
        respostaValida = true;
      } on RespostaInvalidaException catch (e) {
        print(e);
      }
    }
  }

  print("");

  // Mostrando o placar final
  partida.mostrarPlacar();
}
