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
            TableLayout tableLayout = TableDisplay.setlayout(baseContext, teams_array);
            //setContentView(tableLayout);

            ScrollView scroll = new ScrollView(this);
            scroll.addView(tableLayout);
            this.setContentView(scroll);

        } catch (Exception e) {
            e.printStackTrace();
        }


    }

}
