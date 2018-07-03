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

public class TeamLastMatchesActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_team);

        try {
            Bundle b = getIntent().getExtras();
            String url = "";
            if (b != null) {
                url = b.getString("url");
            }
            ImageView logoImage = (ImageView) findViewById(R.id.team_logo);
            String pathToFile = "http://playarena.pl" + b.getString("logo_url");
            logoImage.setImageBitmap((new DownloadImageWithURLTask().execute(pathToFile)).get());

            Match[] matches_array = MatchesExtractor.getMatches("http://playarena.pl/team/ajaxMeetings/team_id/" + Team.IdCutter(url));
            Context baseContext = getApplicationContext();

            new TableDisplay().setlayout(baseContext, matches_array);


        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private class TableDisplay {

        private void setlayout(Context mycontext, Match[] data) {

            TableLayout tableLayout = findViewById(R.id.main_table);
            for (int i = 0; i < 5; i++) {
               // tableLayout.setColumnShrinkable(i, true);
                tableLayout.setColumnStretchable(i, true);
            }
            TableRow tableRow = new TableRow(mycontext);

            TextView text = new Button(mycontext);
            text.setText("Data");
            tableRow.addView(text);

            TextView text2 = new Button(mycontext);
            text2.setText("Drużyna A");
            tableRow.addView(text2);

            TextView text3 = new Button(mycontext);
            text3.setText("Wynik");
            tableRow.addView(text3);

            TextView text4 = new Button(mycontext);
            text4.setText("Drużyna B");
            tableRow.addView(text4);

            TextView text5 = new Button(mycontext);
            text5.setText("MVP");
            tableRow.addView(text5);


            tableLayout.addView(tableRow);

            for (int i = 0; i < data.length; i++) {
                tableRow = new TableRow(mycontext);

                Button button = new Button(mycontext);
                button.setText(data[i].data);
                tableRow.addView(button);

                button = new Button(mycontext);
                button.setText(data[i].left.name);
                tableRow.addView(button);

                button = new Button(mycontext);
                button.setText(data[i].score);
                tableRow.addView(button);

                button = new Button(mycontext);
                button.setText(data[i].right.name);
                tableRow.addView(button);

                button = new Button(mycontext);
                button.setText(data[i].star);
                tableRow.addView(button);


                tableLayout.addView(tableRow);
            }
        }
    }

    private static class DownloadImageWithURLTask extends AsyncTask<String, Void, Bitmap> {

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
