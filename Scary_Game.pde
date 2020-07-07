/*
Ethan Massey July 2020
*/

// imports
import processing.video.*;
Movie scary_video;

// static variables
PImage BACKGROUND;
int FRAME_WIDTH;
int FRAME_HEIGHT;
color GOOD_COLOR;
boolean squarePickedUp;
boolean doingScare;
int scareYThreshold;
String DIRECTIONS;

void settings() {
  // size and background
  FRAME_WIDTH = 1200;
  FRAME_HEIGHT = 700;
  size(FRAME_WIDTH, FRAME_HEIGHT);
  BACKGROUND = loadImage("game_background.png");
}

void setup(){
  // init variables
  surface.setTitle("The Maze");
  noStroke();
  strokeWeight(2);
  GOOD_COLOR = color(0);
  fill(0);
  rect(0, 0, 408, 674);
  squarePickedUp = false;
  scary_video = new Movie(this, "scary_girl.mp4");
  doingScare = false;
  scareYThreshold = 100;
  DIRECTIONS = "1. Pick up the square with your mouse\n2. Move it through the maze";
}

void draw(){
  background(BACKGROUND);

  // console + directions
  fill(0);
  //textSize(32);
  //text(mouseX, 10, 30); 
  //text(mouseY, 200, 30); 
  textSize(20);
  text(DIRECTIONS, 68, 193); 
  
  // before square is picked up
  if(!squarePickedUp){
    fill(255);
    rectMode(CENTER);
    rect(420,650,7,7);
    if(mouseInRangeOfSquare(380, 460, 610, 680)){
      pickUpSquare();
    }
  // once square is picked up
  }else{
    fill(255);
    rect(mouseX,mouseY - 15,7,7);
    handleOutOfBounds();
    handleReachScarePoint();
  }
}

void restart(){
  putDownSquare();
}

void handleOutOfBounds(){
  if(!squareInBounds() && !doingScare){
    restart();
  }
}

void handleReachScarePoint(){
  if(mouseY - 20 < scareYThreshold){
    doingScare = true;
    scary_video.play();
    image(scary_video, 0, 0);
    scareYThreshold = FRAME_HEIGHT;
  }
}

void movieEvent(Movie m){
  m.read();
}

boolean squareInBounds(){
  if (get(mouseX, mouseY - 20) == GOOD_COLOR){
    return true;
  }else{
    return false;
  }
}

boolean mouseInRangeOfSquare(int xmin, int xmax, int ymin, int ymax){
  if (mouseY < ymax && mouseY > ymin && mouseX > xmin && mouseX < xmax){
    return true;
  }
  return false;
}

void pickUpSquare(){
  squarePickedUp = true;
}

void putDownSquare(){
  squarePickedUp = false;
}
