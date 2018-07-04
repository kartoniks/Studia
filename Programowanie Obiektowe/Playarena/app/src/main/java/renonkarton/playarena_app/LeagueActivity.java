package renonkarton.playarena_app;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;

public class LeagueActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_league);

        try
        {
            Bundle b = getIntent().getExtras();
            configureLeagueButton(b);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void configureLeagueButton(Bundle b)
    {
        Button newButton = (Button)findViewById(R.id.table_button);
        final Bundle bd = new Bundle(b);
        newButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(LeagueActivity.this,LeagueTableActivity.class);
                intent.putExtras(bd);
                startActivity(intent);
            }
        });
        newButton = (Button)findViewById(R.id.next_matches_button);
        newButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(LeagueActivity.this,LeagueNextMachesActivity.class);
                intent.putExtras(bd);
                startActivity(intent);
            }
        });
    }
}
