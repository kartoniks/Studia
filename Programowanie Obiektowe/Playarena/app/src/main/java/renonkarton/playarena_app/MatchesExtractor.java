package renonkarton.playarena_app;

import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;
import org.jsoup.Jsoup;

public class MatchesExtractor {

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
            String star = "";
            if(teams.size() == 8) star = teams.get(7).text();
            result.add(new Match(data,teamL,teamR,score,star));
        }
        return result.toArray(new Match[result.size()]);
    }
/*
    public static void main(String argv[]) throws IOException, InterruptedException, ExecutionException {
        Document doc = Jsoup.connect("http://playarena.pl/team/ajaxMeetings/team_id/32393").get();
        Elements matches_list = doc.getElementsByAttribute("id");
        List<Match> result = new ArrayList<Match>();
       /* for (int i = 0; i < matches_list.size(); i += 4)
        {
            if(matches_list.get(i).text().equals("więcej meczów")) break;
            String data = matches_list.get(i+1).text();
            Element e = matches_list.get(i);
            Elements teams = e.getElementsByAttribute("title");
            String score = teams.get(2).text() + ":" + teams.get(4).text();
            Team teamL = new Team(teams.get(0).text());
            Team teamR = new Team(teams.get(6).text());
            String star = "";
            if(teams.size() == 8) star = teams.get(7).text();
            result.add(new Match(data,teamL,teamR,score,star));
        }*/
       // System.out.println(matches_list.get(0).attr("class").toString());
    //}*/

}
