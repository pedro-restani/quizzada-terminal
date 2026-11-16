import 'jogador.dart';
import 'pergunta.dart';
import 'resposta_invalida_exception.dart';

import 'dart:io';

class Partida {
  final List<Jogador> jogadores;
  final List<Pergunta> perguntas;
  static const List<String> itens = ['A', 'B', 'C', 'D'];

  Partida({required this.jogadores, required this.perguntas});

  void apresentarPergunta(Pergunta pergunta, int numero) {
    print(
      "Pergunta $numero/${perguntas.length} (${pergunta.dificuldade.name}, ${pergunta.dificuldade.pontos} pts)",
    );

    print(pergunta.texto);

    for (int i = 0; i < pergunta.alternativas.length; i++) {
      print("\t${itens[i]}) ${pergunta.alternativas[i]}");
    }
  }

  int? validarEntrada() {
    stdout.write('Sua resposta: ');
    String? resposta = stdin.readLineSync();

    if (resposta == null) {
      return null;
    }

    String respostaFormatada = resposta.trim().toUpperCase();
    int indiceResposta = itens.indexOf(respostaFormatada);

    if (indiceResposta == -1) {
      throw RespostaInvalidaException(
        'Resposta inválida. Digite A, B, C ou D.',
      );
    }

    return indiceResposta;
  }

  void verificarResposta(
    Jogador jogador,
    Pergunta pergunta,
    int indiceResposta,
  ) {
    if (pergunta.indiceCorreto == indiceResposta) {
      jogador.pontos += pergunta.dificuldade.pontos;
      jogador.acertos++;
      print("Acertou! +${pergunta.dificuldade.pontos}");
    } else {
      print(
        "Resposta incorreta. Alternativa correta: ${itens[pergunta.indiceCorreto]}",
      );
    }
  }

  void mostrarPlacar() {
    List<Jogador> ranking = List.from(jogadores);

    ranking.sort((a, b) => b.pontos.compareTo(a.pontos));

    print("=== Ranking ===");

    for (int i = 0; i < ranking.length; i++) {
      Jogador jogador = ranking[i];

      int indiceOriginal = jogadores.indexOf(jogador);

      List<Pergunta> perguntasDoJogador = [];

      for (
        int j = indiceOriginal;
        j < perguntas.length;
        j += jogadores.length
      ) {
        perguntasDoJogador.add(perguntas[j]);
      }

      int totalPontos = perguntasDoJogador.fold(
        0,
        (total, pergunta) => total + pergunta.dificuldade.pontos,
      );

      print(
        "${i + 1}º ${jogador.nome}: "
        "${jogador.pontos}/$totalPontos pontos, "
        "${jogador.acertos}/${perguntasDoJogador.length} acertos",
      );
    }
  }
}
