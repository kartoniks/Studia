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
        Elements matches_list = doc.getElementsByTag("tbody");
        List<Match> result = new ArrayList<Match>();
        return result.toArray(new Match[result.size()]);
    }

    public static void main(String argv[]) throws IOException, InterruptedException, ExecutionException {
        Document doc = Jsoup.connect("http://playarena.pl/team/ajaxMeetings/team_id/56088").get();
        Elements matches_list = doc.getElementsByAttribute("row");
        System.out.println(matches_list.toString());
    }

}
