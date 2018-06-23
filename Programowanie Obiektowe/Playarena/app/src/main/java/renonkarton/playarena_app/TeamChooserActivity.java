package renonkarton.playarena_app;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;

public class TeamChooserActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_teamchooser);

        Bundle b = getIntent().getExtras();

        configureButtons(b);
    }


    private void configureButtons(final Bundle b)
    {

        Button newButton = (Button)findViewById(R.id.squad_button);
        newButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent squad = new Intent(TeamChooserActivity.this,TeamActivity.class);
                squad.putExtras(b);
                startActivity(squad);
            }
        });

        Button newButton2 = (Button)findViewById(R.id.matches_button);
        newButton2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent matches = new Intent(TeamChooserActivity.this,TeamActivity.class);
                matches.putExtras(b);
                startActivity(matches);
            }
        });
    }

}
