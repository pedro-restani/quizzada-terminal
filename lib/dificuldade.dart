enum Dificuldade {
  facil,
  media,
  dificil;

  int get pontos => switch (this) {
    Dificuldade.facil => 10,
    Dificuldade.media => 20,
    Dificuldade.dificil => 30,
  };
}
