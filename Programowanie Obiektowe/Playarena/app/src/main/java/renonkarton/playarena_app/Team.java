package renonkarton.playarena_app;

public class Team {
    String name;
    Integer position;
    Integer points;
    public Team(String name, int position, int points)
    {
        this.name = name;
        this.position = position;
        this.points = points;
    }

    public String toString()
    {
        return   position.toString() + " " + name + " " + points.toString();
    }
}
