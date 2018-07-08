package renonkarton.playarena_app;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;

import java.io.InputStream;

public class TeamActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        try {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_teamactivity);

            Bundle b = getIntent().getExtras();
            String logoUrl = "";
            if(null != b)
            {
                logoUrl = b.getString("logoUrl");
            }
            ImageView logoImage = (ImageView) findViewById(R.id.team_logo);
            String pathToFile = "http://playarena.pl" + logoUrl;
            logoImage.setImageBitmap((new ImageDownloader().execute(pathToFile)).get());
            configureButtons(b);
        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }

    private void configureButtons(final Bundle b)
    {

        Button newButton = (Button)findViewById(R.id.squad_button);
        newButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent squad = new Intent(TeamActivity.this,TeamSquadActivity.class);
                squad.putExtras(b);
                startActivity(squad);
            }
        });

        Button newButton2 = (Button)findViewById(R.id.matches_button);
        newButton2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent matches = new Intent(TeamActivity.this,TeamLastMatchesActivity.class);
                matches.putExtras(b);
                startActivity(matches);
            }
        });
    }

}
