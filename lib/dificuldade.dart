enum Dificuldade {
  facil,
  media,
  dificil;

  //Método que atribui uma determinada quantidade de pontos a cada nível de dificuldade
  int get pontos => switch (this) {
    Dificuldade.facil => 10,
    Dificuldade.media => 20,
    Dificuldade.dificil => 30,
  };
}
