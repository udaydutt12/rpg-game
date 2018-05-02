class enemy extends Sprite{
  float hp=200; float mp=30;
enemy(float posx,float posy,PImage[] images){
 super(posx,posy,images);
}
    void displayhp(){
    rectMode(CORNER);
    fill(255,0,0);
    rect(position.x+140,position.y-hp+210,5,hp);
  }
  
  void displaymp(){
    rectMode(CORNER);
    fill(0,0,255);
    rect(position.x+160,position.y-mp+210,5,mp);
  }
    void attack()
  {
   Shot newShot= new Shot(position.x,position.y,bullets,270);
   shots.add(newShot);
  }
}