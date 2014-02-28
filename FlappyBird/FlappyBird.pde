PImage tomceji;
PImage logo;
PImage playButton;
PImage scoresButton;
PImage playButtonHighlight;
PImage scoresButtonHighlight;
boolean mainMenu;
boolean play;
boolean scoreMenu;
float logoX = 300;
float logoY = 250;
float speedOfLogo = .5;

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

  backgroundFlappy();

  if (mainMenu) {
    drawPlayButton();
    drawScoresButton();
    drawLogo();
    image(tomceji, logoX, logoY);
    logoY += speedOfLogo;
    if (logoY > 265) {
      speedOfLogo *= -1;
    }
    if (logoY < 235) {
      speedOfLogo *= -1;
    }
  }
  if (play) {
    drawFlappy();
    drawPipes();
    checkFlappy();
  }
  
  if (scoreMenu) {
    
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
  if (mouseX < 152 || mouseX > 277 || mouseY < 313.5 || mouseY > 386.5) {
    image(playButton, 215, 350);
  } 
  else {
    image(playButtonHighlight, 215, 350);
    if (mousePressed) {
      play = true;
      mainMenu = false;
    }
  }
}

void drawScoresButton() {
  if (mouseX < 322 || mouseX > 447 || mouseY < 313.5 || mouseY > 386.5) { 
    image(scoresButton, 385, 350);
  } 
  else {
    image(scoresButtonHighlight, 385, 350);
    if (mousePressed) {
      scoreMenu = true;
      mainMenu = false;
    }
  }
}

void drawFlappy() {
}

void checkFlappy() {
}

void drawLogo() {
  imageMode(CENTER);
  image(logo, 300, 150);
}

