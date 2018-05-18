package renonkarton.playarena_app;

import android.content.Context;
import android.widget.Button;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;

public class TableDisplay {

    public static TableLayout setlayout(Context mycontext, Team[] data)
    {
        TableLayout tableLayout = new TableLayout(mycontext);

        TableRow tableRow = new TableRow(mycontext);
        TextView text = new Button(mycontext);
        text.setText("Ala ma kota");
        tableRow.addView(text);
        tableLayout.addView(tableRow);

        for (int i = 0; i < 10; i++) {
            tableRow = new TableRow(mycontext);
            Button button = new Button(mycontext);
            button.setText("1");
            tableRow.addView(button);

            button = new Button(mycontext);
            button.setText("2");
            tableRow.addView(button);

            button = new Button(mycontext);
            button.setText("3");
            tableRow.addView(button);

            tableLayout.addView(tableRow);
        }
        return tableLayout;
    }
}
