class RespostaInvalidaException implements Exception {
  final String mensagem;

  // Construtor padrão
  RespostaInvalidaException(this.mensagem);

  @override
  String toString() => mensagem;
}
