class Puntero {

  float id;
  float x;
  float y;

  float diametro;

FWorld play;
FCircle frut, enemi, pop;
FBox taza, piso;


  Puntero(FWorld _juego, float _id, float _x, float _y) {
    play = _juego;
    id = _id;
    x = _x;
    y = _y;
    diametro = 80;

    pop = new FCircle(diametro);
    taza.setPosition(x, y);
    
    play.add(pop);
    play.add(taza);
  }

 
  void setID(float id) {
    this.id = id;
  }

  void borrar() {
    play.remove(pop);
    play.remove(taza);
  }
  
  void dibujar() {

    pushStyle();
    noFill();
    stroke(255, 0, 0);
    ellipse(pop.getX(), pop.getY(), diametro, diametro);
    popStyle();
  }
}
