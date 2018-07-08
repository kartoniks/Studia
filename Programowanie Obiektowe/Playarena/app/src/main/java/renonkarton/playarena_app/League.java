package renonkarton.playarena_app;

public class League {

    Integer leagueId;
    String leagueUrl;

    public League()
    {
        leagueId = -1;
        leagueUrl = "";
    }

    public League(int num, String url)
    {
        leagueId = num;
        this.leagueUrl = url;
    }

    public String toString()
    {
        return leagueId.toString();
    }
}
