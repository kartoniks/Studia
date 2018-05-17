package renonkarton.playarena_app;

public class Team {
    String name;
    Integer position;
    public Team(String name, int position)
    {
        this.name = name;
        this.position = position;
    }

    public String toString()
    {
        return   position.toString() + " " + name;
    }
}
