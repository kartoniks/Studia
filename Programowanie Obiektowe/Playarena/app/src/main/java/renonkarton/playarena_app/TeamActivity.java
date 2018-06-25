package renonkarton.playarena_app;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ScrollView;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;

import java.io.InputStream;


public class TeamActivity extends AppCompatActivity
{
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_team);

        try {
            Bundle b = getIntent().getExtras();
            String url = "";
            if(b != null)
            {
                url = b.getString("url");
            }

            ImageView logoImage = (ImageView) findViewById(R.id.team_logo);
            String pathToFile = "http://playarena.pl" + b.getString("logo_url");
            logoImage.setImageBitmap((new DownloadImageWithURLTask().execute(pathToFile)).get());

            Player[] players_array = PlayersExtractor.getPlayers("http://playarena.pl/team/ajaxTeamMembers/team_id/" + Team.IdCutter(url));
            Context baseContext = getApplicationContext();
            new TableDisplay().setlayout(baseContext, players_array);


        } catch (Exception e) {
            e.printStackTrace();
        }

    }



    //zeby dobrze te buttony konfigurowac ta klasa musi byc tu
    protected class TableDisplay {

        public  TableLayout setlayout(Context mycontext, Player[] data)
        {
            TableLayout tableLayout = findViewById(R.id.main_table);
            for(int i = 0; i < 8; i++) {
                tableLayout.setColumnShrinkable(i, true);
                tableLayout.setColumnStretchable(i, true);
            }
            TableRow tableRow = new TableRow(mycontext);

            TextView text = new Button(mycontext);
            text.setText("Pozycja");
            tableRow.addView(text);

            TextView text2 = new Button(mycontext);
            text2.setText("Numer");
            tableRow.addView(text2);

            TextView text3 = new Button(mycontext);
            text3.setText("Imie i nazwisko");
            tableRow.addView(text3);

            TextView text4 = new Button(mycontext);
            text4.setText("Wiek");
            tableRow.addView(text4);

            TextView text5 = new Button(mycontext);
            text5.setText("Mecze");
            tableRow.addView(text5);

            TextView text6 = new Button(mycontext);
            text6.setText("Punkty");
            tableRow.addView(text6);

            TextView text7 = new Button(mycontext);
            text7.setText("Gw");
            tableRow.addView(text7);

            TextView text8 = new Button(mycontext);
            text8.setText("GO");
            tableRow.addView(text8);

            tableLayout.addView(tableRow);

            for (int i = 0; i < data.length; i++) {
                tableRow = new TableRow(mycontext);
                Button button = new Button(mycontext);

                button.setText(data[i].position.toString());
                tableRow.addView(button);

                button = new Button(mycontext);
                button.setText(data[i].number.toString());
                tableRow.addView(button);

                button = new Button(mycontext);
                button.setText(data[i].name.toString());
                tableRow.addView(button);

                button = new Button(mycontext);
                button.setText(data[i].age.toString());
                tableRow.addView(button);

                button = new Button(mycontext);
                button.setText(data[i].matches.toString());
                tableRow.addView(button);

                button = new Button(mycontext);
                button.setText(data[i].points.toString());
                tableRow.addView(button);

                button = new Button(mycontext);
                button.setText(data[i].stars.toString());
                tableRow.addView(button);

                button = new Button(mycontext);
                button.setText(data[i].goals.toString());
                tableRow.addView(button);

                tableLayout.addView(tableRow);
            }
            return tableLayout;
        }
    }
    private class DownloadImageWithURLTask extends AsyncTask<String, Void, Bitmap> {

        protected Bitmap doInBackground(String... urls) {
            String pathToFile = urls[0];
            Bitmap bitmap = null;
            try {
                InputStream in = new java.net.URL(pathToFile).openStream();
                bitmap = BitmapFactory.decodeStream(in);
            } catch (Exception e) {
                Log.e("Error", e.getMessage());
                e.printStackTrace();
            }
            return bitmap;
        }
    }
}
