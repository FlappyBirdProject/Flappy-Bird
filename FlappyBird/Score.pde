public class Score {
  private int score;
  public Score(int s) {
    score = s;
  }
  public void incScore(int n) {
   score += n; 
  }
  public int getScore() {
   return score/2; 
  }
}

