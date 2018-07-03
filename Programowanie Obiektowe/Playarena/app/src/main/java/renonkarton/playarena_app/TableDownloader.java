package renonkarton.playarena_app;


import android.os.AsyncTask;
import android.util.Log;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import java.io.IOException;
import java.net.URL;

//AsyncTask ma 3 parametry - wejscie, cos drugiego, co tam w miedzyczasie zwraca czy co, niewazne no i trzecie czyli wyjscie
public class TableDownloader extends AsyncTask<String,Void,Document>{

    //funckja glowna
    protected Document doInBackground(String... urls) {
        try {

            URL url = new URL(urls[0]);
            return Jsoup.connect(url.toString()).get();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}