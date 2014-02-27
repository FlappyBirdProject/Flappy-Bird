PImage tomceji;
PImage logo;
PImage playButton;
PImage scoresButton;
PImage playButtonHighlight;
PImage scoresButtonHighlight;
boolean mainMenu;
boolean play;

void setup() {
  size(600, 600);
  tomceji = loadImage("tomceji.jpg");
  logo = loadImage("logo.png");
  playButton = loadImage("playButton.png"); 
  scoresButton = loadImage("scoresButton.png");
  playButtonHighlight = loadImage("playButtonHighlight.png");
  scoresButtonHighlight = loadImage("scoresButtonHighlight.png");
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
  if (mouseX < 150 || mouseX > 280 || mouseY < 313.5 || mouseY > 386.5) {
    image(playButton, 215, 350);
  } 
  else {
    image(playButtonHighlight, 215, 350);
  }
}

void drawScoresButton() {
  if (mouseX < 320 || mouseX > 450 || mouseY < 313.5 || mouseY > 386.5) { 
    image(scoresButton, 385, 350);
  } 
  else {
    image(scoresButtonHighlight, 385, 350);
  }
}

void drawFlappy() {
}

void checkFlappy() {
}

void drawLogo() {
  imageMode(CENTER);
  image(logo, 300, 150);
  image(tomceji, 300, 250);
}

