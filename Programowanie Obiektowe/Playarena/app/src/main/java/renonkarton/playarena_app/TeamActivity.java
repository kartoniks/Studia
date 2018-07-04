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

            ImageView logoImage = (ImageView) findViewById(R.id.team_logo);
            String pathToFile = "http://playarena.pl" + b.getString("logo_url");
            logoImage.setImageBitmap((new DownloadImageWithURLTask().execute(pathToFile)).get());
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

    private static class DownloadImageWithURLTask extends AsyncTask<String, Void, Bitmap> {

        protected Bitmap doInBackground(String... urls) {
            String pathToFile = urls[0];
            Bitmap bitmap = null;
            try {
                InputStream in = new java.net.URL(pathToFile).openStream();
                bitmap = BitmapFactory.decodeStream(in);
            } catch (Exception e) {
                Log.e("Error", e.getMessage());
                e.printStackTrace();
            }
            return bitmap;
        }
    }


}
