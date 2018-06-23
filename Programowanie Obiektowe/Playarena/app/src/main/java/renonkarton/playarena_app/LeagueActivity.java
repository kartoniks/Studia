package renonkarton.playarena_app;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Button;
import android.widget.ScrollView;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;

public class LeagueActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_league);

        try {
            //pobiera tabele druzyn
            Team[] teams_array = TeamExtractor.getTeams("http://playarena.pl/leagueSeason/ajaxTable?league_season_id=15681");
            //wyswietla tabele
            Context baseContext = getApplicationContext();
            TableLayout tableLayout = new TableDisplay().setlayout(baseContext, teams_array);
            //setContentView(tableLayout);

            ScrollView scroll = new ScrollView(this);
            scroll.addView(tableLayout);
            this.setContentView(scroll);

        } catch (Exception e) {
            e.printStackTrace();
        }


    }
        //zeby dobrze te buttony konfigurowac ta klasa musi byc tu
    protected class TableDisplay {

        public  TableLayout setlayout(Context mycontext, Team[] data)
        {
            TableLayout tableLayout = new TableLayout(mycontext);
            for(int i = 0; i < 3; i++) {
                tableLayout.setColumnShrinkable(i, true);
                tableLayout.setColumnStretchable(i, true);
            }
            TableRow tableRow = new TableRow(mycontext);

            TextView text = new Button(mycontext);
            text.setText("Pozycja");
            tableRow.addView(text);

            TextView text2 = new Button(mycontext);
            text2.setText("Druzyna");
            tableRow.addView(text2);

            TextView text3 = new Button(mycontext);
            text3.setText("Pkt");
            tableRow.addView(text3);


            tableLayout.addView(tableRow);

            for (int i = 0; i < 14; i++) {
                tableRow = new TableRow(mycontext);
                Button button = new Button(mycontext);
                button.setText(data[i].position.toString());
                tableRow.addView(button);

                button = new Button(mycontext);
                button.setText(data[i].name.toString());
                final String url = data[i].teamUrl;
                button.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                     Intent intent = new Intent(LeagueActivity.this,TeamChooserActivity.class);
                     Bundle b = new Bundle();
                     b.putString("url",url);
                     intent.putExtras(b);
                     startActivity(intent);
                    }
                });
                tableRow.addView(button);

                button = new Button(mycontext);
                button.setText(data[i].points.toString());
                tableRow.addView(button);

                tableLayout.addView(tableRow);
            }
            return tableLayout;
        }
    }

}
