package renonkarton.playarena_app;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.ScrollView;
import android.widget.TableLayout;
import android.widget.TableRow;

import java.util.List;

public class LeagueChooserActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_leaguechooser);

        try {
            Bundle b = getIntent().getExtras();
            int bundle_value = b.getInt("index");

            Context baseContext = getApplicationContext();
            TableLayout tableLayout = new TableDisplay().setlayout(baseContext,bundle_value);
            ScrollView scroll = new ScrollView(this);
            scroll.addView(tableLayout);
            this.setContentView(scroll);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }


    private class TableDisplay {

        private TableLayout setlayout(Context mycontext, int b) {

            TableLayout tableLayout = findViewById(R.id.main_table);
            tableLayout.setColumnShrinkable(0, true);
            tableLayout.setColumnStretchable(0, true);

            TableRow tableRow = new TableRow(mycontext);
            tableLayout.addView(tableRow);

            List<String> list =  new LeagueList().list.get(b);

            final String cityId = list.get(1);
            for (int i = 2; i < list.size(); i++) {
                tableRow = new TableRow(mycontext);

                Button button = new Button(mycontext);
                button.setText("Liga " + (i-1));

                final String url = list.get(i);
                final int cityIndex = b;
                button.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        Intent intent = new Intent(LeagueChooserActivity.this,LeagueActivity.class);
                        Bundle b = new Bundle();
                        b.putString("url", url);
                        b.putInt("cityIndex",cityIndex);
                        b.putString("cityId",cityId);
                        intent.putExtras(b);
                        startActivity(intent);
                    }
                });

                tableRow.addView(button);
                tableLayout.addView(tableRow);
            }
            return tableLayout;
        }
    }
}
