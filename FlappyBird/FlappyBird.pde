  //****************************//
//         Flappy Tom!        //
//      by Eric Lindau and    //
//        Fisher Darling      //
//****************************//

PImage tomceji; //Tom's picture ... 56x74 (54x72 without considering useless pixels)
PImage logo; //"Flappy Tom" logo
PImage playButton; //Play button's image
PImage scoresButton; //Score button's image
PImage playButtonHighlight; //Image of the play button when hovered over
PImage scoresButtonHighlight; //Image of the score button when hovered over

PFont flap20; //The beautiful size 20 font
PFont flap48; //size 48

boolean mainMenu; //Checks if main menu is active
boolean play; //Checks if game is playing
boolean scoreMenu; //Checks if score menu is active`
boolean gameOver; //Checks if player loses
boolean goUp; //Checks if player wants to "flap" (move up)
boolean pipeMove = true; //If pipes are allowed to move left
boolean jumped = false; //If Tom has 'jumped'

float logoY = 250; //Y coordinate of Tom's face on the main menu
float speedOfLogo = .5; //Speed of Tom's face on the main menu
float speed; //Speed of Tom's face ingame
float grav = 0.36; //"Force" applied downward on Tom's face ingame to simulate gravity
float tomY; //Y coordinate of Tom's face ingame

int waitTime; //Used with a timer (using millis()) used to generate a new pipe for a certain number of seconds
int yTop; //Top of Tom
int yBot; //Bot of Tom
int y = 185; //Y coordinate of the first string of text from the table to print in the score menu

String in = ""; //In the score screen, this String is used to display the current name to be saved with the current score
String out = ""; //Once enter is pressed, out is saved as in's last entry and saved in a CSV file along with the score

Table table; //The table of scores and names

Pipe[] pipes;
Score score;

void setup() {
  imageMode(CENTER);
  size(600, 600);
  tomceji = loadImage("tomceji.png"); //Tom's cropped picture
  logo = loadImage("logo.png"); //"Flappy Tom" on the main menu
  playButton = loadImage("playButton.png"); //Image for the play button on main menu
  scoresButton = loadImage("scoresButton.png"); //Image for the score button on main menu
  playButtonHighlight = loadImage("playButtonHighlight.png"); //Image for play button on main menu when hovered over
  scoresButtonHighlight = loadImage("scoresButtonHighlight.png"); //Image for scores button on main menu when hovered over
  flap20 = loadFont("04b19-20.vlw"); //Load size 20 font
  flap48 = loadFont("04b19-48.vlw"); //Load size 48 font
  backgroundFlappy();
  mainMenu = true; //Sends player to main menu by default
  tomY = 2*height/5; //Sets Tom's position to a near-center position initially
  table = loadTable("scores.csv", "header"); //Loads the score/name table
  pipes = new Pipe[3];
  score = new Score(0);
  for (int a = 0; a < pipes.length; a++) {
    pipes[a] = new Pipe(a*300+700, (int)random(50, 250));
  }
}

void draw() {
  background(111, 206, 255); //Dat Flappy Blue
  if (score.getScore() >= 1000) //If you (for some reason) have a score of 1000+, you get a groovy background
    background(random(256), random(256), random(256));
  yTop = (int)tomY - 36; //Always sets Tom's top pos relative to his y coordinate
  yBot = (int)tomY + 36; //Always sets Tom's bot pos relative to his y coordinate
  if (play) {
    playGame();
  }
  if (scoreMenu) {
    drawScoreMenu();
  }
  backgroundFlappy(); //This is drawn after the score menu so that the text goes under the ground if it is moved so
  if (mainMenu) {
    drawMainMenu();
  }
  if (gameOver) {
    gameOverMenu();
  }
}

void drawMainMenu() {
  textFont(flap20);
  drawPlayButton();
  drawScoresButton();
  image(logo, 300, 150);
  image(tomceji, width/2, logoY); //Tom's swaggin' face
  logoY += speedOfLogo; //Lets Tom's face "levitate" but also "bounce" on main menu
  if (logoY > 265 || logoY < 235) {
    speedOfLogo *= -1;
  }
}

void playGame() {
  textFont(flap20);
  for (int a = 0; a < pipes.length; a++) {
    pipes[a].drawPipe();
    if (pipeMove && jumped) {
      pipes[a].movePipe();
      pipes[a].checkPipe();
    }
  }
  image(tomceji, width/2, tomY); //Tom's swaggin' face
  if (goUp) {      //Lets Tom fly when space bar is pressed
    speed -= grav;
    if (!jumped)
      jumped = true;
  }
  else {
    speed += grav;
  }
  if (speed <= 0) {
    goUp = false;
  }
  checkFlappy();
  textFont(flap48);
  fill(255);
  text(score.getScore(), width/2 - 10, 1*width/4);
  if (jumped)
    tomY+=speed;
  if (!jumped) {
    textFont(flap20);
    tomY += speedOfLogo;
    if (tomY > 265 || tomY < 235)
      speedOfLogo*=-1;
    text("Press space to flap!", 210, 350);
  }
}

void drawScoreMenu() {
  fill(255);
  for (int z = 0; z < table.getRowCount(); z++) { //Gets data from table of scores and names and prints them on screen on separate rows
    textAlign(RIGHT);                             //Score
    text(table.getInt(z, 1), 500, y + z * 35);    //z*35 works because of the size of the font (sets y pos of each score)
    textAlign(LEFT);
    text(table.getString(z, 0), 100, y + z * 35);
  }
  fill(111, 206, 255);
  noStroke();
  rect(0, 0, 600, 160); //This rectangle covers the text if it moves above a high point (aesthetics yeh)
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
  if (keyPressed && key == CODED) { //Allows user to navigate scores (scroll thru them)
    if (keyCode == DOWN) {
      y -= 2;
    }
    if (keyCode == UP) {
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
  text("YOU LOST WITH A SCORE OF:\n" + score.getScore(), 300, 150);
  text("Press your tilde key to continue\nOR type your name:", 300, 350);
  text(in + "\nPress the return key when you are done...", 300, 400);
  image(tomceji, width/2, logoY); //Tom's swaggin' face
  logoY += speedOfLogo; //Lets Tom's face "levitate" but also "bounce" on main menu
  if (logoY > 265 || logoY < 235) {
    speedOfLogo *= -1;
  }
}


void keyPressed() {
  if (gameOver) {
    if (key == '\n') {                      //Enter/return key (newline character)
      if (in.length() >= 1) {               //Can't have blank entry
        out = in;                           //"Out" is a String meant to carry entered name to file
        int rows = table.getRowCount();     //Checks numer of entries in scores file
        table.setString(rows, 0, out);      //Adds name to new row
        table.setInt(rows, 1, score.getScore());     //Adds score to new row
        saveTable(table, "data/scores.csv");//Saves table of entries to CSV file
        gameOver = false;
        mainMenu = true;
      }
    }
    if (key != '\n' && key != BACKSPACE && key != '`' && key != '~') {//If key isn't meant for special operation, add it to name entry
      in += key;
    }                                                                 
    if (key == BACKSPACE && in.length() > 0) {//If backspace and there is a character available
      in = in.substring(0, in.length() - 1);  //Delete rightmost character
    }                                         
    if (key == '`' || key == '~') {
      resetGame();
    }
  }
  if (play && pipeMove) {
    if (key == ' ') {
      speed = -5;
      goUp = true;
    }
  }
}

void backgroundFlappy() { //Draws background (ground, sky, etc.)
  textFont(flap20);
  noStroke();
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
    if (mouseX >= 5 && mouseX <= 105 && mouseY <= 595 && mouseY >= 580) { //
      fill(54, 188, 2);
      text("main menu", 5, 595);
      if (mousePressed) {
        y = 185;
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
      resetGame();
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
  //floor hitbox
  if (tomY + 27 >= 480 && pipeMove) {
    pipeMove = false;
    speed = -10;
    tomY -= 5;
  }
  if (tomY + 27 >= 490 && !pipeMove) {
    gameOver = true;
    play = false;
  }
}
void resetGame() {
  jumped = false;
  score = new Score(0);
  for (int a = 0; a < pipes.length; a++) { //remake all pipes
    pipes[a] = new Pipe(a*300+700, (int)random(50, 250));
  }
  pipeMove = true;
  play = true;
  mainMenu = false;
  gameOver = false;
  tomY = 2*height/5;
  in="";
  out="";
  speed = 0;
}

