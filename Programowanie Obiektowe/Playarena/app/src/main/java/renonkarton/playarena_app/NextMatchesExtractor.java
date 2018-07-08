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
    public static Match[] getMatches(String cityId, String url) throws IOException, ExecutionException, InterruptedException {
        Document doc = (new TableDownloader()).execute("http://playarena.pl/branch/ajaxMeetings/branch_id/" + cityId + "/league_season_id/" + url).get();
        Elements matches_list = doc.getElementsByAttribute("id");
        List<Match> result = new ArrayList<Match>();
        boolean upcoming = false;
        if(matches_list.get(0).attr("class").equals("meetItem row meetUpcomming")) upcoming = true;
        for (int i = 0; i < matches_list.size(); i += 4)
        {
            //if(matches_list.get(i).attr("class").equals("meetItem row meetUpcomming")) continue;
            if(matches_list.get(i).text().equals("więcej meczów") &&  !upcoming) break;
            if(matches_list.get(i).text().equals("więcej meczów") && upcoming)
            {
                upcoming = false;
                i -= 3;
                continue;
            }
            if(upcoming)
            {
                String data = matches_list.get(i+1).text();
                Element e = matches_list.get(i);
                Elements teams = e.getElementsByAttribute("title");
                String teamUrl = url_cutter(teams.get(0).attr("href"));
                Team teamL = new Team(teams.get(0).text(), url, teamUrl);
                teamUrl = url_cutter(teams.get(4).attr("href"));
                Team teamR = new Team(teams.get(4).text(), url, teamUrl);
                result.add(new Match(data,teamL,teamR));
            }
            else
            {
                String data = matches_list.get(i+1).text();
                Element e = matches_list.get(i);
                Elements teams = e.getElementsByAttribute("title");
                String score = teams.get(2).text() + ":" + teams.get(4).text();
                String teamUrl = url_cutter(teams.get(0).attr("href"));
                Team teamL = new Team(teams.get(0).text(), url, teamUrl);
                teamUrl = url_cutter(teams.get(6).attr("href"));
                Team teamR = new Team(teams.get(6).text(), url, teamUrl);
                result.add(new Match(data,teamL,teamR,score));
            }
        }
        return result.toArray(new Match[result.size()]);
    }

    public static void main(String argv[]) throws IOException {
        Document doc = Jsoup.connect("http://playarena.pl/branch/ajaxMeetings/branch_id/6/league_season_id/15658").get();
        Elements matches_list = doc.getElementsByAttribute("id");
        String url = "a";
        List<Match> result = new ArrayList<Match>();
        boolean upcoming = false;
        if(matches_list.get(0).attr("class").equals("meetItem row meetUpcomming")) upcoming = true;
        for (int i = 0; i < matches_list.size(); i += 4)
        {
          //  if(matches_list.get(i).attr("class").equals("meetItem row meetUpcomming")) continue;
            if(matches_list.get(i).text().equals("więcej meczów") &&  !upcoming) break;
            if(matches_list.get(i).text().equals("więcej meczów") && upcoming)
            {
                upcoming = false;
                i -= 3;
                continue;
            }
            if(upcoming)
            {
                String data = matches_list.get(i+1).text();
                Element e = matches_list.get(i);
                Elements teams = e.getElementsByAttribute("title");
                String teamUrl = url_cutter(teams.get(0).attr("href"));
                Team teamL = new Team(teams.get(0).text(), url, teamUrl);
                teamUrl = url_cutter(teams.get(4).attr("href"));
                Team teamR = new Team(teams.get(4).text(), url, teamUrl);
                result.add(new Match(data,teamL,teamR));
            }
            else
            {
                String data = matches_list.get(i+1).text();
                Element e = matches_list.get(i);
                Elements teams = e.getElementsByAttribute("title");
                String score = teams.get(2).text() + ":" + teams.get(4).text();
                String teamUrl = url_cutter(teams.get(0).attr("href"));
                Team teamL = new Team(teams.get(0).text(), url, teamUrl);
                teamUrl = url_cutter(teams.get(6).attr("href"));
                Team teamR = new Team(teams.get(6).text(), url, teamUrl);
                result.add(new Match(data,teamL,teamR,score));
            }
        }
        System.out.println(result.toString());
        System.out.println(matches_list.get(0).attr("class").toString());
    }

    private static String url_cutter(String url) {
        String result = "";
        boolean p = false;
        StringBuilder bd = new StringBuilder(result);
        for (int i = 0; true; i++)
        {
            if(url.charAt(i) == ',') break;
            if(p)  bd.append(url.charAt(i));
            if(url.charAt(i) == '/') p = true;
        }
        return bd.toString();
    }

}
