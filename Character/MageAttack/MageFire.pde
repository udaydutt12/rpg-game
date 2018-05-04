class mageFire{

ArrayList<Curves> fire = new ArrayList<Curves>();

float noiseScale;
float noise;
float fireLength;
float drawCount;
int move;
boolean isActive;

mageFire(){
noiseScale = 100;
noise = 0;
fireLength = 10;
drawCount = 30;
move = 0;
isActive = true;
}

boolean active(){
  return isActive;
}

void fireDraw(){
    fadeToBG ();
    
    //Determines how far the flame has moved to place it back
    //at the original position for a following attack
    //if(move > width){
    //isActive = false;
    //move = 0;
    //}
    //else{
    //  isActive = true;
      
    //}
   
  //CREATE FIRE/MOVE
  for (int i = 0 ; i < 5 ; i++) {
        //Adjust the first value in "new Curves" for the width and height placement for the fire.
        //ORIGINAL fire.add (new Curves( (250 + move + random( 0 , 100)) - 100 , (350 + random( 0 , 50)) - 100));
        fire.add (new Curves( (width/4 + move + random( 0 , 100)) - 100 , (height + random( 0 , 50)) - 100));
    }
  noFill();
  
  
  
  

  for ( int i = 0 ; i < fire.size() ; i++) {
      
      Curves direct = fire.get(i);
      float b = noise ( direct.x4 / noiseScale , direct.y4 / noiseScale , noise ) * -PI; 
      
      direct.addPos( cos(b) * fireLength , sin(b) * fireLength);
      
      strokeWeight ( 20 * ( drawCount - direct.n ) / drawCount+1);
      stroke ( 240+ random(5,15) , 20 + random(0,50) ,random(0,10) ,50 );
      
      curve ( direct.x1 , direct.y1 , direct.x2 , direct.y2 , direct.x3 , direct.y3 , direct.x4 , direct.y4 );
 
      if (direct.n >= drawCount) {
        fire.remove( i );
        i--;
        
      }
 
   }
     noise += 0.01;  
     
     //CONTROL FIRE SPEED
     move += 10;
   }
}


void fadeToBG () {
   noStroke();
   fill ( 0 , 10);
   rect ( 0 , 0 , width , height );   

}
