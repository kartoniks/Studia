package renonkarton.playarena_app;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.util.Pair;
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
            Match[] matches_array = NextMatchesExtractor.getMatches(cityId,url);
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

                Button buttonL = new Button(mycontext);
                buttonL.setText(m.left.name);


                Button buttonR = new Button(mycontext);
                buttonR.setText(m.right.name);

                if(null == m.score)
                {
                    button = new Button(mycontext);
                    button.setText(m.score);
                    boolean t =false;
                    t = is_favorite(m.left, m.right);
                    if(t)
                    {
                        buttonL.setBackgroundColor(Color.BLUE);
                    }
                    else
                    {
                        buttonR.setBackgroundColor(Color.BLUE);
                    }
                }
                else {
                    button = new Button(mycontext);
                    button.setText(m.score);
                }

                tableRow.addView(buttonL);
                tableRow.addView(buttonR);
                tableRow.addView(button);

                tableLayout.addView(tableRow);
            }
        }
    }


    private boolean is_favorite(Team a, Team b)
    {
        double chances = 0;
        try {
            Team[] leagueTable = TeamExtractor.getTeams(a.url);

            for (Team t:
                 leagueTable) {
                if(a.name.equals(t.name))
                {
                    a.position = t.position;
                    a.points = t.points;
                }
                if(b.name.equals(t.name))
                {
                    b.position = t.position;
                    b.points = t.points;
                }
            }
            chances = 1.0*(a.points - b.points);
            chances /= 1.0*(a.points + b.points);
            Match[] aMatches = MatchesExtractor.getMatches(a.teamUrl);
            int i = 1;
            for (Match m:
                 aMatches) {
                Pair<Integer,Integer> p = Score_cutter(m.score);
                if(p.first > p.second && m.left.name.equals(a.name))
                {
                    chances += 1.0*1/1.0*(i+2);
                }
                i++;
            }
            Match[] bMatches = MatchesExtractor.getMatches(b.teamUrl);
            for (Match m:
                    bMatches) {
                Pair<Integer,Integer> p = Score_cutter(m.score);
                if(p.first > p.second && m.left.name.equals(b.name))
                {
                    chances -= 1.0*1/1.0*(i+2);
                }
                i++;
            }
            if(chances > 0) return true;
            return false;
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return true;
    }

    private Pair<Integer,Integer> Score_cutter(String score)
    {
        int f = 0;
        int t = 0;
        for(int i = 0; i < score.length(); i++)
        {
            if(score.charAt(i) == ':')
            {
                f = t;
                t = 0;
                continue;
            }
            t =  t*10 + score.charAt(i) - '0';
        }
        return new Pair<Integer, Integer>(f,t);
    }

}
