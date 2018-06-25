package renonkarton.playarena_app;

import android.content.Context;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.widget.Button;
import android.widget.ScrollView;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;

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
            Log.d("Hohoh", url);

            Match[] matches_array = MatchesExtractor.getMatches("http://playarena.pl/team/ajaxMeetings/team_id/" + Team.IdCutter(url));
            Context baseContext = getApplicationContext();

            TableLayout tableLayout = new TableDisplay().setlayout(baseContext, matches_array);

            ScrollView scroll = new ScrollView(this);
            scroll.addView(tableLayout);
            this.setContentView(scroll);


        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    protected class TableDisplay {

        public TableLayout setlayout(Context mycontext, Match[] data) {

            TableLayout tableLayout = new TableLayout(mycontext);
            for(int i = 0; i < 5; i++) {
                tableLayout.setColumnShrinkable(i, true);
                tableLayout.setColumnStretchable(i, true);
            }
            TableRow tableRow = new TableRow(mycontext);

            TextView text = new Button(mycontext);
            text.setText("Data");
            tableRow.addView(text);

            TextView text2 = new Button(mycontext);
            text2.setText("Druzyna A");
            tableRow.addView(text2);

            TextView text3 = new Button(mycontext);
            text3.setText("Wynik");
            tableRow.addView(text3);

            TextView text4 = new Button(mycontext);
            text4.setText("Druzyna B");
            tableRow.addView(text4);

            TextView text5 = new Button(mycontext);
            text5.setText("Gwiazda");
            tableRow.addView(text5);


            tableLayout.addView(tableRow);

            for (int i = 0; i < data.length; i++) {
                tableRow = new TableRow(mycontext);

                Button button = new Button(mycontext);
                button.setText(data[i].data.toString());
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
            return tableLayout;
        }
    }
}
