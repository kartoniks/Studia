package renonkarton.playarena_app;

public class Team extends League{

    String name;
    Integer position;
    Integer points;
    String teamUrl;

    public Team()
    {
        name = "";
        position = 0;
        points = 0;
        teamUrl = "";
    }

    public Team(String name, int position, int points, String url)
    {
        this.name = name;
        this.position = position;
        this.points = points;
        this.teamUrl = url;
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
        String id = "";
        Integer i = 1;
        while (true)
        {
            char c = url.charAt(i);
            if('0' <= c && '9' >= c)
            {
                id += c;
                i++;
                continue;
            }
            break;
        }
        return id;
    }
}
