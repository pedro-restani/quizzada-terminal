import 'dart:io';

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

  String nome = '';

  while (nome.isEmpty) {
    stdout.write('Digite seu nome: ');
    String? entrada = stdin.readLineSync();

    if (entrada == null) {
      print('\nEntrada encerrada.');
      return;
    }

    nome = entrada.trim();

    if (nome.isEmpty) {
      print('O nome não pode estar vazio. Tente novamente.');
    }
  }

  final jogador = Jogador(nome: nome);
  final partida = Partida(jogador: jogador, perguntas: perguntas);

  int numPergunta = 1;

  for (Pergunta pergunta in partida.perguntas) {
    print('');
    partida.apresentarPergunta(pergunta, numPergunta);

    bool respostaValida = false;

    while (!respostaValida) {
      try {
        int? indiceResposta = partida.validarEntrada();

        if (indiceResposta == null){
          print("\nEntrada encerrada. Partida cancelada.");
          return;
        }
        
        partida.verificarResposta(pergunta, indiceResposta);
        respostaValida = true;
      } on RespostaInvalidaException catch (e) {
        print(e);
      }
    }

    numPergunta++;
  }

  print('');
  partida.mostrarPlacar();
}
