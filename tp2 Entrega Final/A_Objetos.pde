//........................Jugador
Objetivo crearObjetivo(float px, float py, float tam, color c, float peso, String nombre, boolean puedeDividirse) {
  Objetivo main = new Objetivo (tam, puedeDividirse);
  main.setPosition(px, py);
  main.setRestitution(0.8);
  main.setFillColor(c);
  main.setDamping(0.3);
  main.setNoStroke();
  main.setName(nombre);
  float Indice = (tam/20)/2;
  main.setDensity(peso/PI*Indice*Indice);
  return main;
}
//........................Jugador
FCircle circulo(float px, float py, float tam, color c, float peso, String nombre) {
  FCircle main = new FCircle (tam);
  main.setPosition(px, py);
  main.setRestitution(0.8);
  main.setFillColor(c);
  main.setDamping(0.3);
  main.setNoStroke();
  main.setName(nombre);
  float Indice = (tam/20)/2;
  main.setDensity(peso/PI*Indice*Indice);
  return main;
}
//............................ Enemigos
void objetivo(FCircle objetivo, String nombre, float tam, float cant, float px, float py, color c, PImage foto) {
  for (int i = 0; i < cant; i++) {
    float Ix = map(i, 0, cant - 1, px, width - px);//se mapea la posicion entre las frutas
    objetivo = crearObjetivo(Ix, py, tam, c, 1000, nombre, true);//usar mouse
    objetivo.setStatic(true);
    objetivo.attachImage(foto);
    play.add(objetivo);
  }
}
//...............................Plataforma
FBox plataforma(float px, float py, float tw, float th, String nombre) {
  FBox main = new FBox (tw, th);
  main.setPosition(px, py);
  main.setName(nombre);
  main.setStatic(true);
  main.setNoStroke();
  return main;
}
//...............................Divición de enemigos
void Division(Objetivo objeto, String nombre, color c) {
  float d = objeto.getSize() / 3;
  boolean dividir = objeto.puedoDividirme;
  float x = objeto.getX();
  float y = objeto.getY();
  play.remove(objeto);
  if (!dividir) return;
  for (int i = 0; i < 3; i++) {
    Objetivo hijo = new Objetivo(d, false);
    hijo.setPosition(x + random(-d, d), y + random(-d, d));
    hijo.setNoStroke();
    hijo.setFillColor(c);
    hijo.setName(nombre);
    play.add(hijo);
  }
}
//.............................. Asignar Nombres
String Nombre(FBody cuerpo) {
  String nombre = "nada";
  if (cuerpo != null) {
    nombre = cuerpo.getName();
    if (nombre == null) {
      nombre = "nada";
    }
  }
  return nombre;
}
//_____________________________________________________________________ CLASE OBJETIVOS
class Objetivo extends FCircle {
  boolean puedoDividirme;
  Objetivo(float d, boolean puedoDividirme_) {
    super(d);
    puedoDividirme = puedoDividirme_;
  }
}
//_____________________________________________________________________ CLASE CONFETTI
class Confeti {
  float x, y, diametro, vel;
  color c;
  Confeti() {
    x = random(width);
    y = random(-height, 0);
    diametro = random(10, 20);
    c = color(random(255), random(255), random(255));
    vel= random(1, 5);
  }
  void fall() {
    y += vel;
    if (y > height) {
      y = random(-height, 0);
    }
  }
  void display() {
    noStroke();
    fill(c);
    ellipse(x, y, diametro, diametro);
  }
}
