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
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;

import java.io.InputStream;

public class LeagueNextMachesActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_leaguenextmatches);

        try {
            Bundle b = getIntent().getExtras();
            String url = "";
            String cityId = "";
            if (b != null) {
                url = b.getString("url");
                cityId = b.getString("cityId");
            }
            Match[] matches_array = NextMatchesExtractor.getMatches("http://playarena.pl/branch/ajaxMeetings/branch_id/" + cityId + "/league_season_id/" + url);
            Context baseContext = getApplicationContext();

            new TableDisplay().setlayout(baseContext, matches_array);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private class TableDisplay {

        private void setlayout(Context mycontext, Match[] data) {

            TableLayout tableLayout = findViewById(R.id.main_table);
            for (int i = 0; i < 4; i++) {
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
            text3.setText("Drużyna B");
            tableRow.addView(text3);

            TextView text4 = new Button(mycontext);
            text4.setText("Wynik");
            tableRow.addView(text4);

            tableLayout.addView(tableRow);

            for (Match m:
                 data) {
                tableRow = new TableRow(mycontext);

                Button button = new Button(mycontext);
                button.setText(m.data);
                tableRow.addView(button);

                button = new Button(mycontext);
                button.setText(m.left.name);
                tableRow.addView(button);

                button = new Button(mycontext);
                button.setText(m.right.name);
                tableRow.addView(button);

                button = new Button(mycontext);
                button.setText(m.score);
                tableRow.addView(button);


                tableLayout.addView(tableRow);
            }
        }
    }

}
