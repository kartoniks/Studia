package renonkarton.playarena_app;

public class Match {
    Team left;
    Team right;
    String score;
    String star;
    String data;

    public Match(String data, Team left, Team right, String score, String star)
    {
        this.data = data;
        this.left = left;
        this.right = right;
        this.score = score;
        this.star = star;
    }

    public Match(String data, Team left, Team right, String score)
    {
        this.data = data;
        this.left = left;
        this.right = right;
        this.score = score;
    }

    public Match(String data, Team left, Team right)
    {
        this.data = data;
        this.left = left;
        this.right = right;
        this.score = null;
    }

    public String toString()
    {
        return data + " " + score;
    }
}
