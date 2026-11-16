import 'dificuldade.dart';

class Pergunta {
  final String texto;
  final List<String> alternativas;
  final int indiceCorreto;
  final Dificuldade dificuldade;

  //Construtor padrão
  Pergunta({
    required this.texto,
    required this.alternativas,
    required this.indiceCorreto,
    required this.dificuldade,
  });

  //Método que embaralha as alternativas de uma pergunta
  Pergunta embaralharAlternativas() {
    List<int> indices = List.generate(alternativas.length, (index) => index);

    indices.shuffle();

    List<String> alternativasEmbaralhadas = indices
        .map((indice) => alternativas[indice])
        .toList();

    int novoIndiceCorreto = indices.indexOf(indiceCorreto);

    return Pergunta(
      texto: texto,
      alternativas: alternativasEmbaralhadas,
      indiceCorreto: novoIndiceCorreto,
      dificuldade: dificuldade,
    );
  }

  //Construtor factory fromMap 
  factory Pergunta.fromMap(Map<String, dynamic> mapa) {
    return Pergunta(
      texto: mapa['texto'] as String,
      alternativas: List<String>.from(mapa['alternativas'] as List),
      indiceCorreto: mapa['indiceCorreto'] as int,
      dificuldade: Dificuldade.values.byName(mapa['dificuldade'] as String),
    );
  }
}
