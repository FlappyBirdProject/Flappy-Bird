PImage tomceji;
PImage logo;
PImage playButton;
PImage scoresButton;
boolean mainMenu;
boolean play;

void setup() {
  size(600, 600);
  tomceji = loadImage("tomceji.jpg");
  logo = loadImage("logo.png");
  playButton = loadImage("playButton.png"); 
  scoresButton = loadImage("scoresButton.png");
  backgroundFlappy();
  mainMenu = true;
}

void draw() {
  if (mainMenu) {
    backgroundFlappy();
    drawPlayButton();
    drawScoresButton();
    drawLogo();
  }
  if (play) {
    drawFlappy();
    drawPipes();
    checkFlappy();
  }
}


void backgroundFlappy() {
  noStroke();
  fill(111, 206, 255);
  rect(-1, 0, 601, 495);
  strokeWeight(10);
  stroke(54, 188, 2);
  fill(234, 237, 165);
  rect(-11, 500, 621, 110);
  fill(122, 126, 4);
  textAlign(RIGHT);
  text("Made by Fisher Darling and Eric Lindau", 578, 595);
}

void drawPipes() {
}

void drawPlayButton() {
}

void drawScoresButton() {
}

void drawFlappy() {
}

void checkFlappy() {
}

void drawLogo() {
  imageMode(CENTER);
  image(playButton, 215, 350);
  image(scoresButton, 385, 350);
  image(logo, 300, 150);
  image(tomceji, 300, 235);
}

