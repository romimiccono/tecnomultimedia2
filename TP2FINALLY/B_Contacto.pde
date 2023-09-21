void contactStarted(FContact contacto) {
  FBody cuerpo1 = contacto.getBody1();
  FBody cuerpo2 = contacto.getBody2();
  String nombre1 = Nombre(cuerpo1);
  String nombre2 = Nombre(cuerpo2);
  //..........................................................Rebote sobre la plataforma
  if (nombre1 == "monstripop" && nombre2 == "taza") {
    float dx = cuerpo1.getX() - cuerpo2.getX();
    pop.setVelocity(dx*10, 1000);
    rebote.play();
  }
  if (nombre2 == "monstripop" && nombre1 == "taza") {
    float dx = cuerpo2.getX() - cuerpo1.getX();
    pop.setVelocity(dx*10, 1000);
    rebote.play();
  }
  //................................................................Absorver y camBI_Go de tamaño
  if (nombre1 == "monstripop" && nombre2 == "frutas") {
    Division((Objetivo)cuerpo2, "frutas", color(237, 17, 46));
    FCircle este = (FCircle)cuerpo1;
    if (este.getSize() > 150) {
      este.setSize(este.getSize()-15);
    }
    powerup.play();
  } else if (nombre2 == "monstripop" && nombre1 == "enemi") {
    golpe.play();
    Division((Objetivo)cuerpo1, "enemi", color(73, 44, 173));
    FCircle este = (FCircle)cuerpo2;
    este.setSize(este.getSize()+5);
  }
  if (nombre2 == "monstripop" && nombre1 == "frutas") {
    Division((Objetivo)cuerpo1, "frutas", color(237, 17, 46));
    FCircle este = (FCircle)cuerpo2;
    if (este.getSize() > 150) {
      este.setSize(este.getSize()-15);
    }
    powerup.play();
  } else if (nombre1 == "monstripop" && nombre2 == "enemi") {
    golpe.play();
    Division((Objetivo)cuerpo2, "enemi", color(73, 44, 173));
    FCircle este = (FCircle)cuerpo1;
    este.setSize(este.getSize()+5);
  }
  //...................................................................Condición para ganar
  if (nombre1 == "monstripop" && nombre2 == "taza" && pop.getSize() <= 150) {
    estado = 2;
  }
  if (nombre2 == "monstripop" && nombre1 == "taza" && pop.getSize() <= 150) {
    estado = 2;
  }
  //...................................................................Condición para perder
  if (nombre1 == "monstripop" && nombre2 == "piso" || pop.getSize() >= 350) {
    estado = 3;
  }
  if (nombre2 == "monstripop" && nombre1 == "piso" || pop.getSize() >= 350) {
    estado = 3;
  }
  //.......................................................... CamBI_Go de pantalla
  if (nombre1 == "cursor" && nombre2 == "play" && estado == 0) {
    estado = 1;
  }
  if (nombre2 == "cursor" && nombre1 == "play" && estado == 0) {
    estado = 1;
  }
  // perder
  if (nombre1 == "cursor" && nombre2 == "inicioP" && estado == 3) {
    estado = 0;
  }
  if (nombre2 == "cursor" && nombre1 == "inicioP" && estado == 3) {
    estado = 0;
  }
  // ganar
  if (nombre1 == "cursor" && nombre2 == "inicioG" && estado == 2) {
    estado = 0;
  }
  if (nombre2 == "cursor" && nombre1 == "inicioG" && estado == 2) {
    estado = 0;
  }
  //.............................................................. reiniciar pantallas
  if (estado == 0 || estado == 2 || estado == 3  ) {
    play.clear();
    screen.clear();
    reiniciar();
  }
}
