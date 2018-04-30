 void setup(){
   size(800,600);
 }
 
 void draw(){
   display();
 }
 
 
 
 /*
 Code that goes here will manage the game by calling various classes and processes once established
 This GameManager will be the hub of the rest of the classes and determine game flow and progress
 */
 
 
 void display() { //creates the display function

    background(0);
    textSize(40); 

    text("Welcome to our RPG", width/12, height/6);

    textSize(20);
    text("Choose your class and avatar on the next screen", width/24, height/4);

    text("Progress through the level and defeat Hades", width/24, height/3.1);

    text("Use WASD to move and Space to jumo", width/24, height/2.5);

    text("Use SHIFT to attack when in the overworld", width/24, height/2.1);

    text("When fighting Hades, combat will be turn based", width/24, height/1.8);

    text("Select abilities and see if you can defeat Hades", width/24, height/1.6);

   

    

    textSize(40);
    text("Press Enter To Start The Game", width/8, height/1.15);
  }
