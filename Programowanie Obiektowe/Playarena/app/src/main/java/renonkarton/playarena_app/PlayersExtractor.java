package renonkarton.playarena_app;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import java.util.ArrayList;
import java.util.List;
import java.io.IOException;
import java.util.concurrent.ExecutionException;
import java.lang.String;

public class PlayersExtractor {

    //url docelowo ma byc podawane w argumencie, zeby wiecej tabeli moznabylo przerobic
    public static Player[] getPlayers(String url) throws IOException, ExecutionException, InterruptedException {
        //exectute tworzy ten watek w oparciu o ten link, a potem get wywala wartosc
        Document doc = (new TableDownloader()).execute(url).get();
        Elements player_list = doc.getElementsByTag("tbody");
        List<Player> result = new ArrayList<Player>();
        for(int i = 0; i < 4; i++)
        {
            Element position_list = player_list.get(i);
            Elements data = position_list.getElementsByTag("tr");
            for (Element e:
                 data) {
                Player p = new Player(e);
                switch(i)
                {
                    case 0:
                        p.setPosition("Bramkarz");
                        break;
                    case 1:
                        p.setPosition("Obronca");
                        break;
                        case 2:
                        p.setPosition("Pomocnik");
                        break;
                        case 3:
                        p.setPosition("Napastnik");
                        break;
                }
                result.add(p);
            }
        }
        return result.toArray(new Player[result.size()]);
    }

/*
    public static void main(String argv[]) throws IOException, InterruptedException, ExecutionException {
        //     Team[] teams_array = TeamExtractor.getTeams("http://playarena.pl/leagueSeason/ajaxTable?league_season_id=15681");
        Document doc = Jsoup.connect("http://playarena.pl/team/ajaxTeamMembers/team_id/52576").get();
        Elements player_list = doc.getElementsByTag("tbody");
        List<Player> result = new ArrayList<Player>();
        for(int i = 0; i < 4; i++)
        {
            Element position_list = player_list.get(i);
            Elements data = position_list.getElementsByTag("tr");
            for (Element e:
                    data) {
                Player p = new Player(e);
                switch(i)
                {
                    case 0:
                        p.setPosition("Bramkarz");
                    case 1:
                        p.setPosition("Obronca");
                    case 2:
                        p.setPosition("Pomocnik");
                    case 3:
                        p.setPosition("Napastnik");
                }
                result.add(p);
            }
        }
        System.out.println(result.toString());
    }*/

}
