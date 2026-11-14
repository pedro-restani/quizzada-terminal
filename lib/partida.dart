import 'jogador.dart';
import 'pergunta.dart';
import 'resposta_invalida_exception.dart';

import 'dart:io';

class Partida {
  final Jogador jogador;
  final List<Pergunta> perguntas;
  int acertos = 0;
  static const List<String> itens = ['A', 'B', 'C', 'D'];

  Partida({required this.jogador, required this.perguntas});

  void apresentarPergunta(Pergunta pergunta, int numero) {
    print(
      "Pergunta $numero/${perguntas.length} (${pergunta.dificuldade.name}, ${pergunta.dificuldade.pontos} pts)",
    );

    print(pergunta.texto);

    for (int i = 0; i < pergunta.alternativas.length; i++) {
      print("\t${itens[i]}) ${pergunta.alternativas[i]}");
    }
  }

  int validarEntrada() {
    stdout.write('Sua resposta: ');
    String? resposta = stdin.readLineSync();

    if (resposta == null) {
      throw RespostaInvalidaException('Não foi possível ler a resposta.');
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

  void verificarResposta(Pergunta pergunta, int indiceResposta) {
    if (pergunta.indiceCorreto == indiceResposta) {
      jogador.pontos += pergunta.dificuldade.pontos;
      acertos++;
      print("Acertou! +${pergunta.dificuldade.pontos}");
    } else {
      print(
        "Resposta incorreta. Alternativa correta: ${itens[pergunta.indiceCorreto]}",
      );
    }
  }

  void mostrarPlacar() {
    int totalPontos = perguntas.fold(
      0,
      (total, pergunta) => total + pergunta.dificuldade.pontos,
    );
    print("--- Placar ---");
    print(
      "${jogador.nome}: ${jogador.pontos}/$totalPontos pontos, $acertos/${perguntas.length} acertos",
    );
  }
}
