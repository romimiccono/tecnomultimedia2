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
float estado;
SoundFile musica, golpe, rebote, nombre, powerup;
PImage popI, tacita, titulo, ganar, perder, Cursor, fresas, uvas, BI_G, BI_P, BS;
PImage fondo, fondoDes;
PFont texto;
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
  //................................................................ Imagenes
  tacita = loadImage("taza.png");
  Cursor = loadImage("POP.png");
  Cursor.resize(100, 100);
  titulo = loadImage("TITULO.png");
  ganar = loadImage("ganaste.png");
  ganar.resize(900, 300);
  perder = loadImage("perdiste.png");
  perder.resize(750, 500);
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
  //................................................... Texto
  texto = loadFont("instrucciones.vlw");
  textAlign(CENTER);
  textSize(50);
  textFont(texto);
  //................................................................. Generar mundo
  reiniciar();
  //..................... Mùsica fondo
  musica.loop();
  musica.amp(0.8);
  nombre.play();
}
//----------------------------------------------------------------------- DIBUJO
void draw() {
 receptor.actualizar(mensajes); //  
 receptor.dibujarBlobs(width, height);
  //-------------------------------------------------------AQUI ROMI
    if (estado == 0) {//_________________ pantalla inicio
      push();
      image(fondoDes, 0, 0);
      image(titulo, 150, 50);
      fill(0);
      text("Alimenta al Monstripop\nsolamente con fresas", width/2 - 10, height/2 - 20);
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
      pop();
    } else {//___________________________ pantalla perder
      push();
      image(fondoDes, 0, 0);
      image(perder, 280, 230);
      screen.step();
      screen.draw();
      pop();
    }
  }
  //------------------------------------------------------------------------------------ reiniciar
  void reiniciar() {
    popI = loadImage("POP.png");
    //..............................Crear mundos
    play = new FWorld();
    play.setEdges();
    screen = new FWorld();
    screen.setEdges();
    //..............................Crear Objetos
    pop = circulo(width/2, 90, 250, color(103, 7, 47), 10, "monstripop");
    pop.setDrawable(false);
    popI.resize(int(pop.getSize()), int(pop.getSize()));
    //objetivos
    objetivo(frut, "frutas", 60, 6, 100, 50, color(237, 17, 46), fresas);
    objetivo(enemi, "enemi", 50, 5, 195, 160, color(73, 44, 173), uvas);
    //taza
    taza = plataforma(width/2, 600, 150, 50, "taza");
    taza.attachImage(tacita);
    tacita.resize(int(taza.getWidth()), int(taza.getWidth()));
    //cursor
    cursor = circulo(width/2, height/2, 150, color(103, 7, 47), 10, "cursor");
    cursor.attachImage(Cursor);
    Cursor.resize(int(cursor.getSize()), int(cursor.getSize()));
    //botones
    Bplay = plataforma(width/2, 760, 450, 400, "play");
    Bplay.attachImage(BS);
    BS.resize(int(Bplay.getWidth()), int(Bplay.getHeight()));

    BI_PG = plataforma(80, 855, 105, 100, "inicioG");
    BI_PG.attachImage(BI_G);
    BI_G.resize(int(BI_PG.getWidth()), int(BI_PG.getHeight()));

    BI_PP = plataforma(80, 855, 105, 100, "inicioP");
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
