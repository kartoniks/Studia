package renonkarton.playarena_app;

import org.jsoup.select.Elements;
import org.jsoup.nodes.Element;

import renonkarton.playarena_app.Team;

public class Player extends Team {
    String name;
    Integer age;
    String position;
    Integer matches;
    Integer points;
    Integer number;
    Integer stars;
    Integer goals;

    public Player()
    {
        super();
    }

    public Player(String name, String position, Integer age, Integer number, Integer matches, Integer points, Integer stars, Integer goals)
    {
        this.name = name;
        this.age = age;
        this.position = position;
        this.number = number;
        this.matches = matches;
        this.points = points;
        this.stars = stars;
        this.goals = goals;
    }

    public Player(Element data)
    {
        Elements player_data = data.getElementsByTag("td");
        this.name = player_data.get(2).text();
        this.age = StringToInt(player_data.get(3).text());
        this.number = StringToInt(player_data.get(0).text());
        this.matches = StringToInt(player_data.get(4).text());
        this.stars = StringToInt(player_data.get(6).text());
        this.points = StringToInt(player_data.get(5).text());
        this.goals = StringToInt(player_data.get(7).text());
    }


    @Override
    public String toString()
    {
        return  number.toString() + " " + name;
    }

    public void setPosition(String position)
    {
        this.position = position;
    }


    private static int StringToInt(String enter) //with dot!
    {
        int x = 0;
        for (int j = 0; true; j++) {
            if (enter.length() == j || enter.charAt(j) == '.') break;
            x *= 10;
            x += enter.charAt(j) - '0';
        }
        return x;
    }
}
