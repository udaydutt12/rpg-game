MultilineTextBox textBox;
import java.awt.event.KeyEvent;
//WidthxHeight=800x480
character hades;
character hero;
PImage [] character;
boolean hurt=false;
Boolean turnOffGUI=false;
ArrayList <StopWatchTimer> watches=new ArrayList <StopWatchTimer>(0);
ArrayList <Shot> shots=new ArrayList <Shot>(0);
PImage [] gunner=new PImage[7];
PImage [] magesprite=new PImage[7];
PImage [] warsprite=new PImage[10];
PImage bg;
PImage [] hadessprite;
PImage [] gunner1;
PImage[] bullet=new PImage[1];
PImage[] bullets=new PImage[1];
float x;
boolean ready=false;
boolean hasnotflashed=true;
boolean move=false;
boolean turn=true;
boolean counter=false;
float y = 350;
float delay = 10.0;
float change;
String file;
import ddf.minim.*;
Minim minim;
AudioPlayer song;
// 0: main menu screen
int screen = 0;
int flash=1;
int start=0;
int interval=2;
int t;
int pic=1;
int picx=width/2;
int picchange=20;
int pic1=1;
Button button1;
Button button2;
Button button3;
Button button4;
Button hero1;
Button hero2;
Button hero3;
StopWatchTimer sw;
 
void loadImages(){
  hadessprite=new PImage[1];
   bullet[0]=loadImage("bullet0.png");
   bullets[0]=loadImage("bullet1.png");
   for (int i = 0; i < 4; i++)
     {
       file = "Gunrun" + nf(i, 1) + ".png";
       gunner[i] = loadImage(file);
     }
   gunner[4]=loadImage("GunIdle.png");
   gunner[5]=loadImage("Gunhurt.png"); 
   gunner[6]=loadImage("Gunjump.png");
   file = "hades" + nf(0, 1) + ".png";
   hadessprite[0] = loadImage(file);
      bg = loadImage("arena.jpg");
   magesprite[0]=loadImage("Magewalk.png");
   magesprite[1]=loadImage("Magewalk2.png");
   magesprite[2]=loadImage("MageIdle.png");
   magesprite[3]=loadImage("Mageattack1.png");
   magesprite[4]=loadImage("Mageattack2.png");
   magesprite[5]=loadImage("Magehurt.png");
   magesprite[6]=loadImage("Magejump.png");
   warsprite[0]=loadImage("Warrun1.png");
   warsprite[1]=loadImage("Warrun2.png");
   warsprite[2]=loadImage("Warrun3.png");
   warsprite[3]=loadImage("Warrun4.png");
   warsprite[4]=loadImage("WarIdle.png");
   warsprite[5]=loadImage("WarSelect.png");
   warsprite[6]=loadImage("Warattack1.png");
   warsprite[7]=loadImage("Warattack2.png");
   warsprite[8]=loadImage("Warattack3.png");
   warsprite[9]=loadImage("Warattack4.png");
}

void setup() 
{  
   sw = new StopWatchTimer();
   loadImages();
    
   frameRate(9);
   minim = new Minim(this);
   song = minim.loadFile("FireEmblem.mp3");
   song.loop();
   surface.setResizable(true);
   surface.setSize(bg.width, bg.height);
   frameRate(15);
   hades = new character(width*6/7,height/2.0,hadessprite, false,'h');
   textBox = new MultilineTextBox("Your Text", width/2-250, height/2+50, 500, 20);
}

void draw() 
{ 
  if (screen == 0) 
    {
      menuScreen();
    }
  else if( screen==1)
    {
      InstructionsMenu();
    }
  else if(screen==2)
    {
      NewGameMenu();
    }
   else if(screen==3)
   {
     HeroSelect();
   }
  else
    {
      textSize(12);
      background(bg);
      frameRate(25);
      hades.display();
      hero.display();
      fill(0);
      if(hero.isReady())
        {
          ready=true;
          screen=5;
          combatScreen();
        }
    }
    if (move && counter==true){
      t = interval-sw.getElapsedTime()/1000;
      if (t==0){
        hades.attack(hero);
        move=false;
        interval=2;
        turn=true;
      }
    }
}
void mousePressed() {
  if(screen==2)
  textBox.updatePress();
}
void mouseDragged() {
  if(screen==2)
  textBox.updateDrag();
}

void keyPressed()
{
  if(screen==2)
   textBox.updateKeys();
  if(key == 'm' || key == 'M') 
    {
      if(song.isMuted()) song.unmute();
      else song.mute();
    }
  if(key=='w' && screen!=5)
      hero.alterY(1);
  if(key=='s'&& screen!=5)
    hero.alterY(0);
  if (key=='a'&& screen!=5)
    hero.alterX(0);
  if (key=='d'&& screen!=5)
    hero.alterX(1);
}
void keyReleased()
{
        if (key==ENTER&&screen==1)
        {
          screen=2;
          key=' ';
        }
        if (key==ENTER&&screen==2)
        {
          screen=3;
          key=' ';
        }
}
void InstructionsMenu()
{
      background(0);
      textAlign(LEFT);
      fill(255);
      textSize(40); 
      text("Welcome to our RPG", width/12+140, height/6);
      textSize(20);
      text("Choose your class and avatar on the next screen", width/24+140, height/4+20);
      text("Progress through the level and defeat Hades", width/24+140, height/3.1+20);
      text("Use WASD to move and Space to jump", width/24+140, height/2.5+20);
      text("Use SHIFT to attack when in the overworld", width/24+140, height/2.1+20);
      text("When fighting Hades, combat will be turn based", width/24+140, height/1.8+20);
      text("Select abilities and see if you can defeat Hades", width/24+140, height/1.6+20);
      textSize(40);
      if (flash==0)
        {
          frameRate(6);
          text("Press Enter To Start The Game", width/8+20, height/1.15);
          flash=1;
        }
      else flash=0;
  }

void menuScreen()
{
  background(#21CE2E);
  fill(0);
  textSize(50);
  textAlign(CENTER);
  text("Our Game" , width/2, 100);
  textSize(20);
  PImage[] x=new PImage[3];
  x[0]=loadImage("special_0.png");
  x[1]=loadImage("special_1.png");
  x[2]=loadImage("special_2.png");
  image(x[pic],picx, height/2);
  if (pic==0 || pic==2){
    pic1*=-1;
  }
  if (picx>width-100 || picx<0){
    picchange*=-1;
  }
  pic+=pic1;
  picx+=picchange;
  button1 = new Button("New Game", width/2 - 95, height/2 - 100, 200,60, color(0), color(#468BFF), color(255));
  button1.display();
  button2 = new Button("Load Game", width/2 - 95, height/2, 200,60, color(0), color(#468BFF), color(255));
  button2.display();
  if (button1.mouseOver()&&mousePressed)
    screen=1;
}
void mouseReleased()
{
    if(screen==2)
  textBox.updateRelease();


}
void NewGameMenu()
{
      background(0);
      textAlign(CENTER);
      fill(255);
      textSize(40); 
   //   text("Welcome to our RPG", width/12+140, height/6);
      text("Enter your Name Here", width/2, height/2);
      textBox.update();
      textBox.display();
  }

//void instantiateBox() {
//  tbox = new TextBox(
//    "Please enter your name: ", 
//    400, 200, // x, y
//    100, 40, // w, h
//    215, // lim
//    0300 << 030, color(-1, 040), // textC, baseC
//    color(-1, 0100), color(#FF00FF, 0200)); // bordC, slctC
//}
void HeroSelect()
{
  PImage [] x=new PImage[3];
  x[0]=loadImage("GunIdle.png");
  x[1]=loadImage("MageIdle.png");
  x[2]=loadImage("WarIdle.png");
  background(0);
  hero1 = new Button(" ", 0, 0,width/3, height, color(0), color(#468BFF), color(255));
  hero1.display();
  image(x[0],0,0,width/3,height);
  hero2 = new Button(" ", width/3, 0,width/3, height, color(0), color(#468BFF), color(255));
  hero2.display();
  image(x[1],width/3,0,width/3,height);
  hero3 = new Button(" ", width/3*2, 0,width/3, height, color(0), color(#468BFF), color(255));
  hero3.display();
  image(x[2],width/3*2,0,width/3,height);
  if (hero1.mouseOver() && mousePressed)
    {
      screen=4;
      character=gunner;
      hero = new character(width/6.0,height/2.0,character, true,'g');
    }
      if (hero2.mouseOver()&&mousePressed)
    {screen=4;
    character=magesprite;
    hero = new character(width/6.0,height/2.0,character, true,'m');
    hero.hp=90;
    hero.mp=40;
    }
      if (hero3.mouseOver()&&mousePressed)
      {
        character=warsprite;
        hero = new character(width/6.0,height/2.0,character, true,'w');
        hero.hp=70;
        hero.mp=50;
    screen=4;
      }
  
}
void combatScreen()
{
  background(bg);
  hero.position.x=width/4;
  hero.position.y=height/2;
  if(!hurt)
  hero.display(200,200,character[4]);
  else
  hero.display(200,200,character[5]);
  hades.position.x=width*3/4;
  hades.position.y=height/2; 
  //hero.dontmove();
  hades.display(200,200);
  if(!turnOffGUI){
  button3 = new Button("Attack", width/10-100, height*7/8 -60,140, 60, color(0), color(#468BFF), color(255));
  button3.display();
  button4 = new Button("Abilities", width/10-100, height*7/8,140, 60, color(0), color(#468BFF), color(255));
  button4.display();
  }
  hero.displayhp();
  hero.displaymp();
  hades.displayhp();
  hades.displaymp();
  text("HP: "+hades.hp,hades.position.x+140,hades.position.y+150);
  text("MP: "+hades.mp,hades.position.x+160,hades.position.y+170);
  text("HP: "+hero.hp,hero.position.x+40,hero.position.y+140);
  text("MP: "+hero.mp,hero.position.x+60,hero.position.y+160);
  if (button3.mouseOver()&&mousePressed)
    {     
      if (turn){
        hero.attack(hades);
        hurt=false;
        move=true;
        sw.start();
        turn=false;
        turnOffGUI=true;
      }
    }
  for (Shot shot: new ArrayList <Shot> (shots))
    { 
      if (!counter){
        shot.move();
        if (shot.position.x<hades.position.x){;
          shot.display();
        }
        else{
          counter=true;
          shots.remove(shot);
        }
      }
      else{
        shot.counter();
        if (shot.position.x>hero.position.x){
          shot.display();
        }
        else{
          counter=false;
          shots.remove(shot);
          hero.display(200,200,character[5]);
          hurt=true;
          turnOffGUI=false;
        }
      }
    }
}