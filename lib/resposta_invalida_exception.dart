class RespostaInvalidaException implements Exception {
  final String mensagem;

  RespostaInvalidaException(this.mensagem);

  @override
  String toString() => mensagem;
}
