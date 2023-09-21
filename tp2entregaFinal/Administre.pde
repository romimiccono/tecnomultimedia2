class Administrador {

  ArrayList <Puntero> punteros;

  FWorld play; // puntero al mundo en el main

  Administrador(FWorld _play) {
    punteros = new ArrayList<Puntero>();

    play = _play;
  
  }

  void crearPuntero(Blob b) {

    Puntero p = new Puntero(play, b.id, b.centroidX * width, b.centroidY * height);
    punteros.add(p);
  }

  void removerPuntero(Blob b) {
    for (int i= punteros.size()-1; i>=0; i--) {

      Puntero p = punteros.get(i);

      if (p.id == b.id) {
        p.borrar();  
        punteros.remove(i);
        break;
      }
    }
  }
  
  void dibujar() {
    for (Puntero p : punteros) {
      p.dibujar();
    }
  }
}
