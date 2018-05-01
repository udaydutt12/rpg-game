import ddf.minim.*;
Minim minim;
AudioPlayer song;

// 0: main menu screen
int screen = 0;

Button button1;
Button button2;
Button button3;

void setup() {
  size(800, 600);
  minim = new Minim(this);
  song = minim.loadFile("FireEmblem.mp3");
  song.loop();
  
 
}

void draw() {
  if (screen == 0) {
    menuScreen();
  }
  
}
  

void menuScreen() {
  background(#21CE2E);
  fill(0);
  textSize(50);
  textAlign(CENTER);
  text("Dungeon Crawler" , width/2, 100);
  textSize(20);
  button1 = new Button("Play", width/2 - 60, height/2 - 100, 60, color(0), color(#468BFF), color(255));
  button1.display();
  button2 = new Button("Instructions", width/2 - 95, height/2, 60, color(0), color(#468BFF), color(255));
  button2.display();
  button3 = new Button("Scores", width/2 - 65, height/2 + 100, 60, color(0), color(#468BFF), color(255));
  button3.display();
  
}


void keyPressed() {
  if(key == 'm' || key == 'M') {
    if(song.isMuted()) song.unmute();
    else song.mute();
  }

  }


  