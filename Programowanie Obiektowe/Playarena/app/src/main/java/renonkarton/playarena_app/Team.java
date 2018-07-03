package renonkarton.playarena_app;

public class Team extends League{

    String name;
    Integer position;
    Integer points;
    String teamUrl;
    String logoUrl;

    public Team()
    {
        name = "";
        position = 0;
        points = 0;
        teamUrl = "";
    }

    public Team(String name, int position, int points, String url, String logoUrl)
    {
        this.name = name;
        this.position = position;
        this.points = points;
        this.teamUrl = url;
        this.logoUrl = logoUrl;
    }

    public Team(String name)
    {
        this.name = name;
    }

    public String toString()
    {
        return   position.toString() + " " + name + " " + points.toString(); //+ "\n" + url;
    }

    public static String IdCutter(String url) {
        Integer i = 1;
        StringBuilder bd = new StringBuilder("");
        while (true)
        {
            char c = url.charAt(i);
            if('0' <= c && '9' >= c)
            {
                bd.append(c);
                i++;
                continue;
            }
            break;
        }
        return bd.toString();
    }
}
