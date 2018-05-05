class character extends Sprite{
  float hp=100; float mp=30;
  boolean dontmove=false; boolean hero; char wartype;
character(float posx,float posy,PImage[] images, boolean hero, char type){
 super(posx,posy,images);
 this.hero=hero;
 wartype=type;
}

void dontmove()
{
  dontmove=true;
}
  void alterX(int n){
    if(!dontmove){
      switch(wartype)
      {
            case 'm': frame = (frame + 1) % 2 ;
                     break;
            case 'w':  frame = (frame + 1) % 4;
                     break;
            case 'g':  frame = (frame + 1) % 4;
                     break;                     
                     
      }
      if (n==1)
        position.x+=3;
        else position.x-=3;
  }}
  void alterY(int n){
    if(!dontmove){
      switch(wartype)
      {
            case 'm': frame = (frame + 1) % 2 ;
                     break;
            case 'w':  frame = (frame + 1) % 4;
                     break;
            case 'g':  frame = (frame + 1) % 4;
                     break;                     
                     
      }
            if (n==1)
        position.y-=3;
        else position.y+=3;
  }}
  boolean isReady()
{
  if(ready)
  return true;
  if((position.x<hades.position.x&&position.x>hades.position.x-100)&&(position.y<hades.position.y+30&&position.y>hades.position.y-30))
   return true;
   return false;
}
    void displayhp(){
    rectMode(CORNER);
    fill(255,0,0);
    rect(position.x+40,position.y-hp+210,5,hp);
  }
  
  void displaymp(){
    rectMode(CORNER);
    fill(0,0,255);
    rect(position.x+60,position.y-mp+210,5,mp);
  }
  void attack(character other)
  {   
   if (hero){
     Shot newShot= new Shot(position.x+50,position.y-10,bullet,90);
     shots.add(newShot);
     other.hp-=5;
     
   }
   else{
     Shot newShot= new Shot(position.x-50,position.y-10,bullet,90);
     shots.add(newShot);
     other.hp-=3;
   }
  }
  
}