import 'dificuldade.dart';

class Pergunta {
  final String texto;
  final List<String> alternativas;
  final int indiceCorreto;
  final Dificuldade dificuldade;

  Pergunta({
    required this.texto,
    required this.alternativas,
    required this.indiceCorreto,
    required this.dificuldade,
  });

  factory Pergunta.fromMap(Map<String, dynamic> mapa) {
    return Pergunta(
      texto: mapa['texto'] as String,
      alternativas: List<String>.from(mapa['alternativas'] as List),
      indiceCorreto: mapa['indiceCorreto'] as int,
      dificuldade: Dificuldade.values.byName(mapa['dificuldade'] as String),
    );
  }
}
