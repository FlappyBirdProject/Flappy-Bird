PImage tomceji;//56x74
PImage logo;
PImage playButton;
PImage scoresButton;
PImage playButtonHighlight;
PImage scoresButtonHighlight;
boolean mainMenu;
boolean play;
boolean scoreMenu;
boolean callPipe = true;
boolean goUp;
float logoX = 300;
float logoY = 250;
float speedOfLogo = .5;
float speed;
float grav = 0.1;
int randPipe;
int tomY;

void setup() {
  imageMode(CENTER);
  size(600, 600);
  tomceji = loadImage("tomceji.jpg");
  logo = loadImage("logo.png");
  playButton = loadImage("playButton.png"); 
  scoresButton = loadImage("scoresButton.png");
  playButtonHighlight = loadImage("playButtonHighlight.png");
  scoresButtonHighlight = loadImage("scoresButtonHighlight.png");
  backgroundFlappy();
  mainMenu = true;
  tomY = 2*height/5;
}

void draw() {

  randPipe = (int)random(4);

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
    checkFlappy();
    pipes.drawPipes(randPipe);

    image(tomceji, width/2, tomY);

    if (goUp) {
      speed -= grav;
    }
    else {
      speed += grav;
    }

    if (speed <= 0) {
      goUp = false;
    }
    
        tomY += speed;
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
  text("Made by Fisher Darling and Eric Lindau", 16*width/17, 595);
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
  image(logo, 300, 150);
}

void keyPressed() {
  if (goUp) {
    goUp = false;
  }
  else {
    speed = -3.25;
    goUp = true;
  }
}

static class pipes {
  static void drawPipes(int i) {
    switch(i) {
    case 0:
      break;
    case 1:
      break;
    case 2:
      break;
    case 3:
      break;
    }
  }
}

