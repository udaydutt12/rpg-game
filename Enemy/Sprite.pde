class Sprite
{

  PVector position;
  PImage[] image_data;
  int frame=0;
 
  Sprite(float posx,float posy,PImage[] images)
  {
      position=new PVector(posx,posy);
      image_data=images;
      //image_data=new PImage[images.length];
      //image_data=images;
  }

 void display()
  {
    imageMode(CENTER);
    image(image_data[frame],position.x,position.y);
  }
 void display(int w, int h)
 {
       imageMode(CENTER);
    image(image_data[frame],position.x,position.y,w,h);
 }
 void display (int w, int h, PImage i)
 {
   image(i,position.x,position.y,w,h);
 }
}