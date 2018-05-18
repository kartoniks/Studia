package renonkarton.playarena_app;


import android.os.AsyncTask;
import android.util.Log;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import java.io.IOException;
import java.net.URL;


class xhtmlConverter{
    public String toXHTML( String html ) {
        final Document document = Jsoup.parse(html);
        document.outputSettings().syntax(Document.OutputSettings.Syntax.xml);
        return document.html();
    }
}

//AsyncTask ma 3 parametry - wejscie, cos drugiego, co tam w miedzyczasie zwraca czy co, niewazne no i trzecie czyli wyjscie
public class TableDownloader extends AsyncTask<String,Void,Document>{

    private Exception exception;

    /*public static Document  downloader(String url) throws IOException  {
        Document doc = Jsoup.connect(url).get();
        return doc;
        String myhtml = doc.toString();
         xhtmlConverter toXML = new xhtmlConverter();
         String myxhtml = toXML.toXHTML(myhtml);
         System.out.println(myhtml);
    }*/

    //funckja glowna
    protected Document doInBackground(String... urls) {
        try {

            URL url = new URL(urls[0]);
            Document doc = Jsoup.connect(url.toString()).get();
            return doc;
        } catch (Exception e) {
            this.exception = e;
            return null;
        }
        }

    protected void onPostExecute(Document doc) {
        return;
    }

}