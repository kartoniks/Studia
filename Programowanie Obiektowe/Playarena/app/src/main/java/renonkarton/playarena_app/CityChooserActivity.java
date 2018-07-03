package renonkarton.playarena_app;

import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ScrollView;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;

import java.util.List;

public class CityChooserActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_citychooser);

        try {

            Context baseContext = getApplicationContext();
            TableLayout tableLayout = new TableDisplay().setlayout(baseContext);

            ScrollView scroll = new ScrollView(this);
            scroll.addView(tableLayout);
            this.setContentView(scroll);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private class TableDisplay {

        public TableLayout setlayout(Context mycontext) {

            TableLayout tableLayout = findViewById(R.id.main_table);
          //  for(int i = 0; i < 1; i++) {
                tableLayout.setColumnShrinkable(0, true);
                //tableLayout.setColumnStretchable(i, true);
            TableRow tableRow = new TableRow(mycontext);
            tableLayout.addView(tableRow);

            LeagueList cities = new LeagueList();

            for (int i = 0; i < cities.list.size(); i++) {
                tableRow = new TableRow(mycontext);

                List<String> list = cities.list.get(i);
                Button button = new Button(mycontext);
                button.setText(list.get(0));

                final int a = i;
                button.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        Intent intent = new Intent(CityChooserActivity.this,LeagueChooserActivity.class);
                        Bundle b = new Bundle();
                        b.putInt("index", a);
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
