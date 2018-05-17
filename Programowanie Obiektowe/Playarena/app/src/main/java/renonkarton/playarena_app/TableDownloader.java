package renonkarton.playarena_app;


import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import java.io.IOException;


import javax.net.ssl.HttpsURLConnection;
import java.io.IOException;

class xhtmlConverter{
    public String toXHTML( String html ) {
        final Document document = Jsoup.parse(html);
        document.outputSettings().syntax(Document.OutputSettings.Syntax.xml);
        return document.html();
    }
}

public class TableDownloader {

    public static Document  downloader(String url) throws IOException  {
        Document doc = Jsoup.connect(url).get();
        String myhtml = doc.toString();
        return doc;
        // xhtmlConverter toXML = new xhtmlConverter();
        // String myxhtml = toXML.toXHTML(myhtml);
        // System.out.println(myhtml);
    }
}