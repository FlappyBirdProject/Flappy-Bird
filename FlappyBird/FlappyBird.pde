PImage tomceji; //Declare Tom's picture ... 56x74
PImage logo; //Declare "Flappy Tom" logo
PImage playButton; //Declare play button's image
PImage scoresButton; //Declare score button's image
PImage playButtonHighlight; //Declare the image of the play button when highlighted
PImage scoresButtonHighlight; //Declare the image of the score button when highlighted

PFont flap20; //The beautiful 20 size font
PFont flap48; //size 48

boolean mainMenu; //Checks if main menu is active
boolean play; //Checks if game is playing
boolean scoreMenu; //Checks if score menu is active
boolean gameOver; //Checks if player loses
boolean goUp; //Checks if player wants to "flap" (move up)
boolean draw; //Checks if pipes should be drawn/redrawn
boolean time = true; //Along with the millis() function, this boolean determines at which times to generate/draw pipes
boolean game = true; //If player hits pipe, game will be false and cause the player to fall and lose
boolean randPipe;

float logoY = 250; //Y coordinate of Tom's face on the main menu
float speedOfLogo = .5; //Speed of Tom's face on the main menu
float speed; //Speed of Tom's face ingame
float grav = 0.2; //"Force" applied downward on Tom's face ingame to simulate gravity
//float i; //First random float (for first pipe drawn in drawPipe)
//float j; //Second random float (for second pipe drawn in drawPipe)
float x;

int pipeSpd = 2; //Number of pixels to move pipes by every frame
int tomY; //Y coordinate of Tom's face ingame
int waitStart = 5000; //Time (in milliseconds) to wait for first pipe to draw
int score; //Score held for player
int yTop; //Top of Tom
int yBot; //Bot of Tom
int xRight; //Right of Tom ... All of these coords are used to check if Tom hits a pipe or the ground
int z; //Used in for statements to check the number of rows in the table (CSV) file to print onto score screen
int y = 185; //Y coordinate of the first string of text from the table to print in the score menu
int pipeX = 615; //Initial x coordinate of first pipe
int pipeX2 = 615; //Initial x coordinate of second pipe
int zwag;
int m;
int n;
int u;
int ord;
int wait;

String in = "";
String out = "";

Table table;

IntList scoreVals;
IntList pipes;
StringList nameStr;

//This here is Java in a nutshell.... (I hate Oracle -Eric)
pipe pipe = new pipe();

void setup() {
  imageMode(CENTER);
  size(600, 600);
  scoreVals = new IntList();
  pipes = new IntList();
  nameStr = new StringList();
  //loading the images fonts and sound to RAM
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
  table = loadTable("scores.csv", "header");
  for (zwag = 0; zwag < 200; zwag++) {
    pipes.append(zwag);
    pipes.set(zwag, (int)random(100, 300));
  }
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
  if (scoreMenu == false) {
    y = 185;
  }
}

void drawMainMenu() {
  textFont(flap20);
  drawPlayButton();
  drawScoresButton();
  drawLogo();
  image(tomceji, width / 2, logoY);
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
  if (millis() >= waitStart && time) {
    randPipe = true;
    //draw = true;
    time = false;
  }
  if (randPipe) {
    n = pipes.get(ord);
    u = pipes.get(ord + 1);
    ord += 2;
    randPipe = false;
  }
   if (millis() - wait >= waitStart) {
   pipe.drawPipe1();
   wait = 4000;
   }
   if (millis() - wait + 3000 >= waitStart) {
   pipe.drawPipe2();
   wait = 4000;
   }
  if (goUp && game) {
    speed -= grav;
  }
  else {
    //speed += grav;
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
  for (z = 0; z < table.getRowCount(); z++) {
    textAlign(RIGHT);
    text(table.getInt(z, 1), 500, y + z * 35);
    textAlign(LEFT);
    text(table.getString(z, 0), 100, y + z * 35);
  }
  fill(111, 206, 255);
  noStroke();
  rect(0, 0, 600, 160);
  strokeWeight(10);
  stroke(54, 188, 2);
  fill(234, 237, 165);
  rect(-11, 500, 621, 110);
  fill(255);
  textAlign(CENTER);
  textFont(flap20);
  text("Press the up and down keys to navigate", 300, 50);
  textFont(flap48);
  text("Scores", 300, 100);
  textFont(flap20);
  textAlign(RIGHT);
  text("SCORE", 500, 150);
  textAlign(LEFT);
  text("PLAYER", 100, 150);
  textAlign(RIGHT);
  fill(122, 126, 4);
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
  if (keyPressed && key == CODED) {
    if (keyCode == UP) {
      y -= 2;
    }
    if (keyCode == DOWN) {
      y += 2;
    }
  }
}

void gameOverMenu() {
  if (play) {
    gameOver = false;
  }
  textAlign(CENTER);
  fill(255);
  text("YOU LOST WITH A SCORE OF:\n" + score, 300, 150);
  text("Click anywhere to continue without saving score", 300, 250);
  text("Type your name:", 300, 350);
  text(in + "\nPress the return key when you are done...", 300, 375);
}

void mousePressed() {
  if (gameOver) {
    gameOver = false;
    mainMenu = true;
    tomY = 2*height/5;
    speed = 0;
  }
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
    if (key != '\n' && key != BACKSPACE) {
      in += key;
    }
    if (key == BACKSPACE && in.length() > 0) {
      in = in.substring(0, in.length() - 1);
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
  if (mainMenu == false) {
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
      gameOver = false;
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

  void drawPipe1() {

    fill(0, 255, 0);
    rect(pipeX, -10, 60, n);
    rect(pipeX - 20, n - 25, 100, 35);
    rect(pipeX, n + 200, 60, height);
    rect(pipeX - 20, n + 185, 100, 35);

    pipeX -= 2;
  }

  void drawPipe2() {
    fill(0, 255, 0);
    rect(pipeX2, -10, 60, u);
    rect(pipeX2 - 20, u - 25, 100, 35);
    rect(pipeX2, u + 200, 60, height);
    rect(pipeX2 - 20, u + 185, 100, 35);

    pipeX2 -= 2;
  }
}

