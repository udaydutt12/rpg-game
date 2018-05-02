class enemy {
  String folder;
  int ct;
  PImage[] imgs;
  PImage[] imgs1;
  int imgCt;
  int frame;
  float hp;
  float mp;
  float special;
  float normal;
  color col;
  int x;
  int y;
  int recx=x;
  boolean turn = false;
  StopWatchTimer sw;
  
  enemy(String folder, int ct, float hp, float special, float normal, color col) {
    this.folder = folder;
    this.ct= ct;
    this.hp=hp;
    this.special=special;
    this.normal=normal;
    this.col=col;
    x=width*6/7;
    y=height/2;
    
    sw = new StopWatchTimer();
    
    imgCt = ct;
    imgs = new PImage[imgCt];
    imgs1 = new PImage[3];
    mp = 4.0 * special;

    for (int i = 0; i < imgCt; i++) {
      String file = folder + nf(i, 1) + ".png";
      imgs[i] = loadImage(file);
      imgs[i].resize(40,height/4);
      
    }
    
    for (int i = 0; i < 3; i++) {
      String file = "special_" + nf(i, 1) + ".png";
      imgs1[i] = loadImage(file);
    }
  }
  
  void displayspecial(hero hero){
    frame = (frame + 1) % imgCt;
    image(imgs[frame], x-10, y);
  }
  
  void special(hero hero){
    mp-=special;
    if (hero.mp >=special/2){
      hero.mp-=special/2;
      hero.hp-=special/2;
    }
    else{
      float orig = special;
      while (hero.mp > 0){
        special -=1;
        hero.mp -=1;
      }
      hero.hp -= special;
      special = orig;
    }
  }
  
  void normal(hero hero){
    hero.hp -= normal;
  }
  
  void displayhp(){
    rectMode(CORNER);
    fill(col);
    rect(x+40,y-hp+100,5,hp);
  }
  
  void displaymp(){
    rectMode(CORNER);
    fill(0,0,255);
    rect(x+50,y-mp+100,5,mp);
  }
  
  void shootnormal(hero hero){
    int xinc = 1;
    pushMatrix();
    recx-=xinc;
    rectMode(CENTER);
    rect(recx,y,10,5);
    translate(xinc,0);
    rotate(PI/2);
    popMatrix();
    if (recx<=x){
      normal(hero);
      recx=x;
    }
  }
  
  void shootspecial(hero hero){
    displayspecial(hero);
    special(hero);
  }
  
  void shoot(hero hero){
    float random = random(0,20);
    if (turn==true){
      if (random>16){
        if (mp>special){
          shootspecial(hero);
        }
        else{
          hp += mp;
          mp = 0;
          shootnormal(hero);
        }
      }
      else{
        shootnormal(hero);
      }
      turn=false;
    }
  }
  
  void display() {
    frame = (frame + 1) % imgCt;
    image(imgs[frame], x-10, y);
    displayhp();
    displaymp();
  }
}