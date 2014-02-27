PImage tomceji;

void setup() {
  size(600, 600);
  tomceji = loadImage("tomceji.jpg");
  backgroundFlappy();
}

void backgroundFlappy() {
  strokeWeight(10);
  stroke(54,188,2);
  fill(234, 237, 165);
  rect(-11, 500, 621, 110);
  fill(122,126,4);
  textAlign(RIGHT);
  text("Made by Fisher Darling and Eric Lindau", 300, 595); 
}

