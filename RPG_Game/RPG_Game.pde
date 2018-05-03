TextBox tbox;
 
final int stateNormal   = 0;
final int stateInputBox = 1;
int state=stateNormal; 
 
// the user name 
String result="/"; 


//WidthxHeight=800x480
character hades;
character hero;
ArrayList <StopWatchTimer> watches=new ArrayList <StopWatchTimer>(0);
ArrayList <Shot> shots=new ArrayList <Shot>(0);
PImage [] imgs=new PImage[7];
PImage bg;
PImage [] imgct;
PImage [] imgs1;
PImage[] bullet=new PImage[1];
PImage[] bullets=new PImage[1];
float x;
boolean ready=false;
boolean hasnotflashed=true;
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
Button button1;
Button button2;
Button button3;
Button button4;


void setup() 
{  
   bullet[0]=loadImage("bullet0.png");
   bullets[0]=loadImage("bullet1.png");
   imgct=new PImage[1];
   imgs1=new PImage[3];
   for (int i = 0; i < 4; i++)
     {
       file = "Gunrun" + nf(i, 1) + ".png";
       imgs[i] = loadImage(file);
     }
   imgs[4]=loadImage("GunIdle.png");
   imgs[5]=loadImage("Gunhurt.png"); 
   imgs[6]=loadImage("Gunjump.png");
   file = "hades" + nf(0, 1) + ".png";
   imgct[0] = loadImage(file); 
   frameRate(9);
   minim = new Minim(this);
   song = minim.loadFile("FireEmblem.mp3");
   song.loop();
   surface.setResizable(true);
   bg = loadImage("arena.jpg");
   surface.setSize(bg.width, bg.height);
   frameRate(15);
   hades = new character(width*6/7,height/2.0,imgct);
   hero = new character(width/6.0,height/2.0,imgs);
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
          screen=4;
          combatScreen();
        }
    }
}

void keyPressed()
{
  if(key == 'm' || key == 'M') 
    {
      if(song.isMuted()) song.unmute();
      else song.mute();
    }
  if(key=='w' && screen!=4)
      hero.alterY(1);
      

  if(key=='s'&& screen!=4)
    hero.alterY(0);
  if (key=='a'&& screen!=4)
    hero.alterX(0);
  if (key=='d'&& screen!=4)
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
        screen=3;
        
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
  button1 = new Button("New Game", width/2 - 95, height/2 - 100, 60, color(0), color(#468BFF), color(255));
  button1.display();
  button2 = new Button("Load Game", width/2 - 95, height/2, 60, color(0), color(#468BFF), color(255));
  button2.display();
  if (button1.mouseOver()&&mousePressed)
    screen=1;
}
void mouseReleased()
{
   if (state==stateNormal&&screen==2) 
    state = stateInputBox;

}
void NewGameMenu()
{

 //   rectMode(CENTER);
  //textAlign(CENTER);
//  strokeWeight(1.5);
//  background(0);
//  fill(255);
      background(0);
      textAlign(LEFT);
      fill(255);
      textSize(40); 
   //   text("Welcome to our RPG", width/12+140, height/6);
  if (state==stateNormal) {
    text("Click mouse\nYour name: "+result, width/2, height/2);
  } else  if (state==stateInputBox) {
    tbox.display();
  }
}
void instantiateBox() {
  tbox = new TextBox(
    "Please enter your name: ", 
    400, 200, // x, y
    100, 40, // w, h
    215, // lim
    0300 << 030, color(-1, 040), // textC, baseC
    color(-1, 0100), color(#FF00FF, 0200)); // bordC, slctC
}
void combatScreen()
{
  background(bg);
  hero.position.x=width/4;
  hero.position.y=height/2;
  hero.display(200,200,imgs[4]);
  hades.position.x=width*3/4;
  hades.position.y=height/2; 
  //hero.dontmove();
  hades.display(200,200);
  button3 = new Button("Attack", width/10-100, height*7/8 -60, 60, color(0), color(#468BFF), color(255));
  button3.display();
  button4 = new Button("Abilities", width/10-100, height*7/8, 60, color(0), color(#468BFF), color(255));
  button4.display();
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
      hero.attack();
      
      hades.attack();
    }
  for (int i=0; i<shots.size(); i++)
    { 
      shots.get(i).move();
      shots.get(i).display();
    }
}