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

            return null;
        }
    }
}
