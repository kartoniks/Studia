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

            Bundle b = getIntent().getExtras();
            String url = "";
            if(b != null)
            {
                url = b.getString("url");
            }
            //pobiera tabele druzyn
            Team[] teams_array = TeamExtractor.getTeams("http://playarena.pl/leagueSeason/ajaxTable?league_season_id=" + url);
            //wyswietla tabele
            Context baseContext = getApplicationContext();
            new TableDisplay().setlayout(baseContext, teams_array);


        } catch (Exception e) {
            e.printStackTrace();
        }


    }
        //zeby dobrze te buttony konfigurowac ta klasa musi byc tu
    protected class TableDisplay {

        public  TableLayout setlayout(Context mycontext, Team[] data)
        {
            TableLayout tableLayout = findViewById(R.id.main_table);
            for(int i = 1; i < 2; i++) {
                tableLayout.setColumnShrinkable(i, true);
                tableLayout.setColumnStretchable(i, true);
            }
            TableRow tableRow = new TableRow(mycontext);

            TextView text = new Button(mycontext);
            text.setText("");
            tableRow.addView(text);

            TextView text2 = new Button(mycontext);
            text2.setText("Druzyna");
            tableRow.addView(text2);

            TextView text3 = new Button(mycontext);
            text3.setText("Pkt");
            tableRow.addView(text3);

            tableRow.setMinimumHeight(text2.getHeight());

            tableLayout.addView(tableRow);

            for (int i = 0; i < data.length; i++) {
                tableRow = new TableRow(mycontext);
                Button button = new Button(mycontext);
                button.setText(data[i].position.toString());
                tableRow.addView(button);

                button = new Button(mycontext);
                button.setText(data[i].name.toString());
                tableRow.setMinimumHeight(button.getHeight());
                final String url = data[i].teamUrl;
                final String logo_url = data[i].logoUrl;
                button.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                     Intent intent = new Intent(LeagueActivity.this,TeamChooserActivity.class);
                     Bundle b = new Bundle();
                     b.putString("url",url);
                     b.putString("logo_url",logo_url);
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
