import 'dart:io';

import 'package:quizzada_terminal/dificuldade.dart';
import 'package:quizzada_terminal/jogador.dart';
import 'package:quizzada_terminal/partida.dart';
import 'package:quizzada_terminal/pergunta.dart';
import 'package:quizzada_terminal/resposta_invalida_exception.dart';

void main() {
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
      'texto': 'Qual palavra-chave lança uma exceção?',
      'alternativas': ['catch', 'throw', 'try', 'on'],
      'indiceCorreto': 1,
      'dificuldade': 'dificil',
    },
  ];

  final perguntas = dadosPerguntas.map(Pergunta.fromMap).toList();

  int? quantidadeJogadores;

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

  final perguntasFiltradas = perguntas.where((pergunta) {
    return switch (opcaoDificuldade) {
      1 => pergunta.dificuldade == Dificuldade.facil,
      2 => pergunta.dificuldade == Dificuldade.dificil,
      3 => true,
      _ => false,
    };
  }).toList();

  final perguntasEmbaralhadas = perguntasFiltradas
      .map((pergunta) => pergunta.embaralharAlternativas())
      .toList();

  final partida = Partida(
    jogadores: jogadores,
    perguntas: perguntasEmbaralhadas,
  );

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

  print('');
  partida.mostrarPlacar();
}
