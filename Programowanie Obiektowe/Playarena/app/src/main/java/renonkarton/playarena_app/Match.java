package renonkarton.playarena_app;

public class Match {
    Team left;
    Team right;
    String score;
    String star;

    public Match(Team left, Team right, String score, String star)
    {
        this.left = left;
        this.right = right;
        this.score = score;
        this.star = star;
    }
}
