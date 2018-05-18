package renonkarton.playarena_app;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Element;

import java.io.IOException;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

public class TeamExtractor {

    private static int StringToInt(String enter) //with dot!
    {
        int x = 0;
        for(int j = 0; true; j++)
        {
            if(enter.length() == j || enter.charAt(j) == '.') break;
            x *= 10;
            x += enter.charAt(j) - '0';
        }
        return x;
    }

    //url docelowo ma byc podawane w argumencie, zeby wiecej tabeli moznabylo przerobic
    public static Team[] getTeams(String url) throws IOException
    {
        Document doc = Jsoup.connect("http://playarena.pl/leagueSeason/ajaxTable?league_season_id=15681").get();
        Elements team_list = doc.getElementsByTag("tr");
        Team[] result = new Team[16];
        //  System.out.print(team_list.toString());
        for(int i = 1; i < 17; i++)
        {
            //Tu mamy caly html dotyczacy jednego klubu
            Element team_data = team_list.get(i);
            // System.out.print(team_data.toString());
            //Wszystkie rzeczy z atrybutem class to te rzeczy, ktore chcemy - pozycja w tabeli/nazwa/punkty i bramki
            Elements important_data = team_data.getElementsByAttribute("class");
            //a no ciekawostka jest tez taka, ze jest to dwukrotnie xD
            //System.out.println(important_data.text());

            //pozycja w tabeli jest pierwsza
            String position_text = important_data.get(1).text();
            //nazwa jest trzecia
            String name = important_data.get(3).text();
            //punkty sa dziewiate
            int points = StringToInt(important_data.get(9).text());
            //szybki konwerter
            int position = StringToInt(position_text);
            result[i-1] = new Team(name,position, points);
        }
        return result;
    }


    public static void main(String argv[]) throws IOException
    {
        Team[] teams_array = TeamExtractor.getTeams("hohoh");
        for (Team x : teams_array) {
            System.out.println(x.toString());

        }

    }
}
