public class Pipe {
  private int xPos;
  private int randSize;
  boolean vinay;
  boolean josh;

  public Pipe(int x, int r) {
    xPos = x;
    randSize = r;
  }

  public void setX(int x) {
    xPos = x;
  }

  public void drawPipe() {
    fill(0, 255, 0);
    if (egg)
      fill(random(256), random(256), random(256)); 
    rect(xPos, -10, 60, randSize);
    rect(xPos - 20, randSize - 10, 100, 35);
    rect(xPos, randSize + 210, 60, height);
    rect(xPos - 20, randSize + 175, 100, 35);
    textFont(flap20);
    textAlign(LEFT);
    if (vinay){
      text("Vinay",xPos-);
    }

  }
  public void movePipe() {
    xPos -= 3;
  }
  public void checkPipe() {
    //top pipe hitbox
    if (xPos <= -100) {
      xPos = 800;
      randSize = (int)random(50, 250);
      if ((int)random(8)==0){
        vinay = true;
      }else if((int)random(7)==0){
        josh = true;
      }
    }
    if (yBot >= randSize - 7 && yTop <= randSize + 28 && xPos + 80 >= 274 && xPos - 20 <= 320 || yTop <= randSize - 10 && xPos <= 328 && xPos >= 320) {
      pipeMove = false;
      goUp = true;
      speed = -10;
    }
    //bottom pipe hitbox
    else if (yBot >= randSize + 170 && yTop <= randSize + 215 && xPos + 80 >= 274 && xPos - 20 <= 320 || yBot >= randSize + 210 && xPos <= 328 && xPos >= 320) {
      pipeMove = false;
      goUp = true;
      speed = -10;
    }
    //between pipes hitbox
    else if (xPos > 297 && xPos<= 300)
      score.incScore();
  }
}

