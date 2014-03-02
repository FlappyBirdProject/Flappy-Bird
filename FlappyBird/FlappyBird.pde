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
//size 10
PFont flap10;

//The menu booleans
boolean mainMenu;
boolean play;
boolean scoreMenu;
boolean gameOver;
boolean pipes;

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
int waitStart = 5000;
int score;
int yTop;
int yBot;
int xRight;
int z;
float[] randPipes = { random(100, 500), random(100, 500), random(100, 500), random(100, 500), random(100, 500), random(100, 500), random(100, 500), random(100, 500), random(100, 500), random(100, 500) };

String in = "";
String out = "";

Table table;

IntList scoreVals;
StringList nameStr;

//This here is Java in a nutshell.... (I hate Oracle -Eric)
pipe pipe = new pipe();

void setup() {
  imageMode(CENTER);
  size(600, 600);
  scoreVals = new IntList();
  nameStr = new StringList();
  //loading the images fonts and sound to RAM
  tomceji = loadImage("tomceji.jpg");
  logo = loadImage("logo.png");
  playButton = loadImage("playButton.png"); 
  scoresButton = loadImage("scoresButton.png");
  playButtonHighlight = loadImage("playButtonHighlight.png");
  scoresButtonHighlight = loadImage("scoresButtonHighlight.png");
  flap10 = loadFont("04b19-10.vlw");
  flap20 = loadFont("04b19-20.vlw");
  flap48 = loadFont("04b19-48.vlw");
  backgroundFlappy();
  mainMenu = true;
  tomY = 2*height/5;
  table = loadTable("scores.csv", "header");
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
  score = 0;
  out = "";
  in = "";
  textFont(flap20);
  checkFlappy();
  image(tomceji, width/2, tomY);
  //make first pipe appear here
  if (millis() >= waitStart) {
    pipes = true;
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
  if (pipes) {}
}

void drawScoreMenu() {
  fill(255);
  textAlign(CENTER);
  textFont(flap48);
  text("Scores", 300, 100);
  textFont(flap20);
  for (z = 0; z < table.getRowCount(); z++) {
    textAlign(RIGHT);
    text(table.getInt(z, 1), 500, 185 + z * 35);
    textAlign(LEFT);
    text(table.getString(z, 0), 100, 185 + z * 35);
  }
  textAlign(RIGHT);
  text("SCORE", 500, 150);
  textAlign(LEFT);
  text("PLAYER", 100, 150);
}

void gameOverMenu() {
  textAlign(CENTER);
  fill(255);
  text("YOU LOST WITH A SCORE OF:\n" + score, 300, 150);
  text("Click anywhere to continue without saving score", 300, 250);
  text("Type your name:", 300, 350);
  text(in + "\nPress the return key when you are done...", 300, 375);
  if (mousePressed) {
    gameOver = false;
    mainMenu = true;
    tomY = 2*height/5;
    speed = 0;
  }
}

void mousePressed() {
}

void keyPressed() {
  if (gameOver) {
    if (key == '\n') {
      out = in;
      int rows = table.getRowCount();
      table.setString(rows, 0, out);
      table.setInt(rows, 1, score);
      saveTable(table, "data/scores.csv");
      mainMenu = true;
      gameOver = false;
    }
    else {
      in += key;
    }
  }
  if (play) {
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
  text("Made by Fisher Darling and Eric Lindau", 79*width/80, 595);
  textAlign(LEFT);
  text("main menu", 5, 595);
  if (mouseX >= 5 && mouseX <= 105 && mouseY <= 595 && mouseY >= 580) {
    fill(0, 0, 255);
    text("main menu", 5, 595);
    if (mousePressed) {
      mainMenu = true;
      play = false;
      scoreMenu = false;
      gameOver = false;
    }
  }
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

public class pipe {

  /*int topY;
   int botY;
   int pipeY;*/

  int pipeX = 615;
  int i = 200;

  void drawPipe(float i) {
    fill(0, 255, 0);
    rect(pipeX, - 1, 80, i);
    rect(pipeX - 20, i - 25, 120, 35);
    rect(pipeX, i + 200, 80, height);
    rect(pipeX - 20, i + 185, 120, 35);
    pipeX -= 1.7;


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

