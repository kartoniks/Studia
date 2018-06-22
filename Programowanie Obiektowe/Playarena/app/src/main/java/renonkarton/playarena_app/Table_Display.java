package renonkarton.playarena_app;

import android.content.Context;
import android.content.Intent;
import android.view.View;
import android.widget.Button;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;

//paczaj koment w league activity
public class Table_Display {

    public static TableLayout setlayout(Context mycontext, Team[] data)
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
            tableRow.addView(button);

            button = new Button(mycontext);
            button.setText(data[i].points.toString());
            tableRow.addView(button);

            tableLayout.addView(tableRow);
        }
        return tableLayout;
    }
}
