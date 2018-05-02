enemy hades;
hero hero;
StopWatchTimer sw;

PImage bg;
float x;
float y = 350;
float delay = 10.0;
float change;

void setup() {
  frameRate(9);
  surface.setResizable(true);
  bg = loadImage("arena.jpg");
  surface.setSize(bg.width, bg.height);
  frameRate(15);
  color col = color(0,255,255);
  sw = new StopWatchTimer();
  hades = new enemy("hades", 1, 100, 10,  1, col);
  hero = new hero(30);
  sw.start();
}

void draw() { 
  background(bg);
  hades.display();
  hero.display();
  hades.displayspecial(hero);
  if (sw.second() % 3 == 0){
    hades.shoot(hero);
  }
  fill(0);
  text("HP: "+hades.hp,hades.x,hades.y+150);
  text("MP: "+hades.mp,hades.x,hades.y+170);
  text("HP: "+hero.hp,hero.x,hero.y+140);
  text("MP: "+hero.mp,hero.x,hero.y+160);
}

void keyPressed(){
  final int k=keyCode;
  if (hades.turn==false){
    if (k==' '){
      hades.hp-=5;
      hades.turn=true;
    }
    else if (k=='H'){
      if (hero.mp<5 && hero.mp>0){
        hero.hp+=hero.mp;
        hero.mp=0;
        hades.turn=true;
      }
      else if (hero.mp>=5){
        hero.hp+=5;
        hero.mp-=5;
        hades.turn=true;
      }
    }
  }
}

class hero{
  float mp;
  float hp;
  float x;
  float y;
  PImage[] imgs;
  int frame;
  
  hero(float hp){
    this.hp=hp;
    mp=30;
    x=width/6;
    y=height/2;
    imgs = new PImage[4];
    for (int i = 0; i < 4; i++) {
      String file = "Gunrun" + nf(i, 1) + ".png";
      imgs[i] = loadImage(file);
      imgs[i].resize(40,height/5);
    }
  }
  
    void displayhp(){
    rectMode(CORNER);
    fill(255,0,0);
    rect(x-50,y-hp+100,5,hp);
  }
  
  void displaymp(){
    rectMode(CORNER);
    fill(0,0,255);
    rect(x-60,y-mp+100,5,mp);
  }
  
  void display() {
    frame = (frame + 1) % 4;
    image(imgs[frame], x-10, y);
    displayhp();
    displaymp();
  }
}