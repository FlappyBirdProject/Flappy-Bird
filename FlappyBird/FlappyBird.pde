//Declaring the Image names and what they hold
PImage tomceji; //56x74
PImage logo;
PImage playButton;
PImage scoresButton;
PImage playButtonHighlight;
PImage scoresButtonHighlight;

//The Beautiful 20 size font
PFont flap20;
//size 48
PFont flap48;

//The menu booleans
boolean mainMenu;
boolean play;
boolean scoreMenu;
boolean gameOver;

//Other game booleans
boolean callPipe = true;
boolean goUp;

//Game variables with location and timing/scoring
float logoX = 300;
float logoY = 250;
float speedOfLogo = .5;
float speed;
float grav = 0.15;
int randPipe;
int tomY;
int timeStart;
int waitStart = 5000;
int score;
int yTop;
int yBot;
int xRight;

//This here is Java in a nutshell.... (I hate Oracle -Eric)
pipe pipe = new pipe();

void setup() {
  imageMode(CENTER);
  size(600, 600);

  //loading the images fonts and soun to RAM
  tomceji = loadImage("tomceji.jpg");
  logo = loadImage("logo.png");
  playButton = loadImage("playButton.png"); 
  scoresButton = loadImage("scoresButton.png");
  playButtonHighlight = loadImage("playButtonHighlight.png");
  scoresButtonHighlight = loadImage("scoresButtonHighlight.png");
  flap20 = loadFont("04b19-20.vlw");
  flap48 = loadFont("04b19-48.vlw");
  backgroundFlappy();
  mainMenu = true;
  tomY = 2*height/5;
}

void draw() {
  yTop = tomY - 37;
  yBot = tomY + 37;
  xRight = 328;
  backgroundFlappy();
  if (mainMenu) {
    drawMainMenu();
  }
  if (play) {
    playGame();
  }
  if (scoreMenu) {
    drawScoreMenu();
  }
  if (gameOver) {
    gameOverMenu();
  }
}

void drawMainMenu() {
  textFont(flap20);
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

void playGame() {
  textFont(flap20);
  checkFlappy();
  image(tomceji, width/2, tomY);
  //make first pipe appear here
  if (millis() - timeStart >= waitStart) {
    print("test");
    //pipe.drawPipe(some value here; we need to decide how to determine pipe value);
    timeStart = millis() - 1500;
  }
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
  //checks if he hits ground ... will add check for him hitting pipes once pipes are added!
  if (tomY >= 458 || yTop <= 37) {
    gameOver = true;
    play = false;
  }
}

void drawScoreMenu() {
  fill(255);
  textAlign(CENTER);
  textFont(flap48);
  text("Scores", 300, 100);
}

void gameOverMenu() {
  textAlign(CENTER);
  fill(255);
  text("(this is just a test ending screen; we need fonts and stuff)\nYOU LOST WITH A SCORE OF:\n" + score, 300, 250);
  text("Press the '+' key to continue", 300, 400);
  if (keyPressed && key == '+') {
    gameOver = false;
    mainMenu = true;
    tomY = 2*height/5;
    speed = 0;
  }
} 

void backgroundFlappy() {
  textFont(flap20);
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
  fill(0, 230, 0);
  stroke(0, 30, 0);
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

void checkFlappy() {
}

void drawLogo() {
  image(logo, 300, 150);
}

void keyPressed() {
  if (key == ' ') {
    if (goUp) {
      goUp = false;
    }
    else {
      speed = -5;
      goUp = true;
    }
  }
}

public class pipe {

  /*int topY;
   int botY;
   int pipeY;*/


  void drawPipe(float i) {
    //I think we should just make a formula relating the randomly generated int to the rect drawing!

    /*switch(i) {
     case 0:
     break;
     case 1:
     rect(coorX, topY, 50, pipeY);
     rect(coorX, botY, 50, pipeY);
     break;
     case 2:
     break;
     case 3:
     break;
     }*/
  }
}


