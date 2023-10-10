import processing.sound.*;
import fisica.*;
//......................................... Elementos física
FWorld play, screen;
FCircle frut, enemi, pop, cursor;
FBox BI_PG, BI_PP, Bplay, taza, piso;
//......................................... Camara y sonido
int PUERTO_OSC = 12345;
Receptor receptor;
Administrador admin;
//......................................... Otros
float estado, contador = 0;
SoundFile musica, golpe, rebote, nombre, powerup, yupi, nuuu;
ArrayList<Confeti> confeti = new ArrayList<Confeti>();
PImage popI, tacita, titulo, ganar, perder, Cursor, fresas, uvas, BI_G, BI_P, BS, si, no;
PImage fondo, fondoDes, instruc, alimenta;
boolean que;
//______________________________________________________________________________________________- SETUP -
void setup() {
  size(1300, 900);
  Fisica.init(this);
  setupOSC(PUERTO_OSC);
  receptor = new Receptor();
  admin = new Administrador(play);
  //................................................................ sonido
  musica = new SoundFile(this, "AMBIENTACION.wav");
  golpe = new SoundFile(this, "DOLOR.wav");
  rebote = new SoundFile(this, "CHOCAR.wav");
  nombre = new SoundFile(this, "NOMBRE.wav");
  powerup = new SoundFile(this, "POWERUP.wav");
  yupi = new SoundFile(this, "yupii.wav");
  nuuu = new SoundFile(this, "nuuu.wav");
  //................................................................ Imagenes
  tacita = loadImage("taza.png");
  Cursor = loadImage("taza.png");
  Cursor.resize(100, 100);
  titulo = loadImage("TITULO.png");
  ganar = loadImage("ganaste.png");
  ganar.resize(900, 300);
  perder = loadImage("perdiste.png");
  perder.resize(850, 600);
  fondo = loadImage("fondoEn.png");
  fondo.resize(1300, 900);
  fondoDes = loadImage("fondoDes.png");
  fondoDes.resize(1300, 900);
  fresas = loadImage("fresas.png");
  fresas.resize(90, 90);
  uvas = loadImage("uvas.png");
  uvas.resize(90, 90);
  BI_G = loadImage("inicioG.png");
  BI_P = loadImage("inicioP.png");
  BS = loadImage("start.png");
  instruc = loadImage("instrucciones.png");
  instruc.resize(850, 600);
  alimenta = loadImage("jugo.png");
  alimenta.resize(350, 350);
  //................................................................. Genera confetti y lluvia
  for (int i = 0; i < 100; i++) {
    confeti.add(new Confeti());
  }

  //................................................................. Generar mundo
  reiniciar();
  //..................... Mùsica fondo
  musica.loop();
  musica.amp(0.8);
  nombre.play();
}
//----------------------------------------------------------------------- DIBUJO
void draw() {
  contador ++;
  println(contador); //cuando el contador llega 100 se habilitan los botones
  receptor.actualizar(mensajes); //
  receptor.dibujarBlobs(width, height);
  //-------------------------------------------------------AQUI ROMI
  if (estado == 0) {//_________________ pantalla inicio
    push();
    image(fondoDes, 0, 0);
    image(titulo, 150, 50);
    image(instruc, 210, 150);
    image(alimenta, 0, 550);
    screen.step();
    screen.draw();
    pop();
  } else if (estado == 1) { //_________ pantalla juego
    image(fondo, 0, 0);
    play.step();
    play.draw();
    pushMatrix();
    pushStyle();
    imageMode(CENTER);
    translate(pop.getX(), pop.getY());
    rotate(pop.getRotation());
    image(popI, 0, 0, pop.getSize(), pop.getSize());
    popStyle();
    popMatrix();
  } else if (estado == 2) {//__________ pantalla ganar
    push();
    image(fondoDes, 0, 0);
    image(ganar, 200, 300);
    screen.step();
    screen.draw();
    for (int i = 0; i < confeti.size(); i++) {
      Confeti c = confeti.get(i);
      c.fall();
      c.display();
    }
    pop();
  } else {//___________________________ pantalla perder
    push();
    image(fondoDes, 0, 0);
    image(perder, 200, 170);
    screen.step();
    screen.draw();
    pop();
  }
}
//------------------------------------------------------------------------------------ reiniciar
void reiniciar() {
  si = loadImage("POP.png");
  no = loadImage("POP2.png");
  contador = 0;
  //..............................Crear mundos
  play = new FWorld();
  play.setEdges();
  screen = new FWorld();
  screen.setEdges();
  //..............................Crear Objetos
  pop = circulo(width/2, 90, 250, color(103, 7, 47), 10, "monstripop");
  pop.setDrawable(false);
  si.resize(int(pop.getSize()), int(pop.getSize()));
  no.resize(int(pop.getSize()), int(pop.getSize()));
  //objetivos
  objetivo(frut, "frutas", 60, 6, 100, 50, color(237, 17, 46), fresas);
  objetivo(enemi, "enemi", 50, 5, 195, 160, color(73, 44, 173), uvas);
  //taza
  taza = plataforma(width/2, 800, 150, 50, "taza");
  taza.attachImage(tacita);
  tacita.resize(int(taza.getWidth()), int(taza.getWidth()));
  //cursor
  cursor = circulo(width/2, height/2, 100, color(103, 7, 47), 10, "cursor");
  cursor.attachImage(Cursor);
  Cursor.resize(int(cursor.getSize()), int(cursor.getSize()));
  //botones
  Bplay = plataforma(width/2, 790, 200, 100, "play");
  Bplay.attachImage(BS);
  BS.resize(330, 300);

  BI_PG = plataforma(105, 820, 200, 200, "inicioG");
  BI_PG.attachImage(BI_G);
  BI_G.resize(int(BI_PG.getWidth()), int(BI_PG.getHeight()));

  BI_PP = plataforma(105, 820, 200, 200, "inicioP");
  BI_PP.attachImage(BI_P);
  BI_P.resize(int(BI_PP.getWidth()), int(BI_PP.getHeight()));
  //............................................................................. borde inferior
  piso = plataforma(width/2, height, width, 10, "piso");
  //............................................................................. Añadir al juego
  play.add(taza);
  play.add(pop);
  play.add(piso);
  //............................................................................. Añadir al resto de pantallas
  screen.add(cursor);
  if (estado == 0) {
    screen.add(Bplay);
  } else if (estado == 2) {
    screen.add(BI_PG);
  } else {
    screen.add(BI_PP);
  }
}
