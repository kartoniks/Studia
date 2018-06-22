package renonkarton.playarena_app;

public class Team {

    String name;
    Integer position;
    Integer points;
    String url;

    public Team()
    {
        name = "";
        position = 0;
        points = 0;
        url = "";
    }

    public Team(String name, int position, int points, String url)
    {
        this.name = name;
        this.position = position;
        this.points = points;
        this.url = url;
    }

    public String toString()
    {
        return   position.toString() + " " + name + " " + points.toString(); //+ "\n" + url;
    }
}
