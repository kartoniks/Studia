package renonkarton.playarena_app;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

public class NextMatchesExtractor {

    //url docelowo ma byc podawane w argumencie, zeby wiecej tabeli moznabylo przerobic
    public static Match[] getMatches(String url) throws IOException, ExecutionException, InterruptedException {
        Document doc = (new TableDownloader()).execute(url).get();
        Elements matches_list = doc.getElementsByAttribute("id");
        List<Match> result = new ArrayList<Match>();
        for (int i = 0; i < matches_list.size(); i += 4)
        {
            if(matches_list.get(i).attr("class").equals("meetItem row meetUpcomming")) continue;
            if(matches_list.get(i).text().equals("więcej meczów")) break;
            String data = matches_list.get(i+1).text();
            Element e = matches_list.get(i);
            Elements teams = e.getElementsByAttribute("title");
            String score = teams.get(2).text() + ":" + teams.get(4).text();
            Team teamL = new Team(teams.get(0).text());
            Team teamR = new Team(teams.get(6).text());
            result.add(new Match(data,teamL,teamR,score));
        }
        return result.toArray(new Match[result.size()]);
    }

    public static void main(String argv[]) throws IOException, InterruptedException, ExecutionException {
        Document doc = Jsoup.connect("http://playarena.pl/branch/ajaxMeetings/branch_id/6/league_season_id/15654").get();
        Elements matches_list = doc.getElementsByAttribute("id");
        List<Match> result = new ArrayList<Match>();
        for (int i = 0; i < matches_list.size(); i += 4)
        {
            if(matches_list.get(i).text().equals("więcej meczów")) break;
            String data = matches_list.get(i+1).text();
            Element e = matches_list.get(i);
            Elements teams = e.getElementsByAttribute("title");
            String score = teams.get(2).text() + ":" + teams.get(4).text();
            Team teamL = new Team(teams.get(0).text());
            Team teamR = new Team(teams.get(6).text());
            result.add(new Match(data,teamL,teamR,score));
        }
        System.out.println(matches_list);
    }

}
