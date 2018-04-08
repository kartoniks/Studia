package sample;

import javafx.application.Application;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;
import java.io.File;

public class Controller extends Application {


    public void start(Stage stage) {
        Samochod s = (Samochod)Pojazd.deserialize("auto");//new Samochod("OKL20503", "mar", 85);
        Tramwaj t = (Tramwaj)Pojazd.deserialize("tram"); //new Tramwaj(17, "Skoda", 380);
        File f = new File("/tmp/auto");
        //Creating User Interface for car
        Label carlabel1 = new Label("Rejestracja:");
        TextField cartf1 = new TextField ();
        cartf1.setText(s.rejestracja);
        Label carlabel2 = new Label("Marka:");
        TextField cartf2 = new TextField ();
        cartf2.setText(s.marka);
        Label carlabel3 = new Label("Moc:");
        TextField cartf3 = new TextField ();
        cartf3.setText(Integer.toString(s.moc));
        VBox carvb = new VBox();
        carvb.getChildren().addAll(carlabel1, cartf1, carlabel2, cartf2, carlabel3, cartf3);
        carvb.setSpacing(20);

        //Creating a Group object
        GridPane root = new GridPane();
        root.setHgap(100);
        root.setVgap(80);
        //Retrieving the observable list object
        ObservableList list = root.getChildren();

        GridPane.setConstraints(carvb, 0, 0);
        list.add(carvb);

        Label tramlabel1 = new Label("Numer tramwaja:");
        TextField tramtf1 = new TextField (Integer.toString(t.numer));
        Label tramlabel2 = new Label("Marka:");
        TextField tramtf2 = new TextField (t.marka);
        Label tramlabel3 = new Label("Moc:");
        TextField tramtf3 = new TextField (Integer.toString(t.moc));
        VBox tramvb = new VBox();
        tramvb.getChildren().addAll(tramlabel1, tramtf1, tramlabel2, tramtf2, tramlabel3, tramtf3);
        tramvb.setSpacing(20);

        GridPane.setConstraints(tramvb, 1, 0);
        list.add(tramvb);

        //Buttons
        Button savebutton = new Button("Zapisz");
        Button loadbutton = new Button("Wczytaj");
        GridPane.setConstraints(savebutton, 0,1);
        GridPane.setConstraints(loadbutton, 1,1);
        list.addAll(loadbutton,savebutton);

        savebutton.setOnAction(new EventHandler<ActionEvent>() {
            @Override public void handle(ActionEvent e) {
                s.rejestracja=cartf1.getText();
                s.marka=cartf2.getText();
                s.moc=Integer.parseInt(cartf3.getText());
                s.serialize("auto");

                t.numer=Integer.parseInt(tramtf1.getText());
                t.marka=tramtf2.getText();
                t.moc=Integer.parseInt(tramtf3.getText());
                t.serialize("tram");
            }
        });

        loadbutton.setOnAction(new EventHandler<ActionEvent>() {
            @Override public void handle(ActionEvent e) {
                Samochod s=(Samochod)Pojazd.deserialize("auto");
                cartf1.setText(s.rejestracja);
                cartf2.setText(s.marka);
                cartf3.setText(Integer.toString(s.moc));

                Tramwaj t=(Tramwaj)Pojazd.deserialize("tram");
                tramtf1.setText(Integer.toString(t.numer));
                tramtf2.setText(t.marka);
                tramtf3.setText(Integer.toString(t.moc));
            }
        });

        //Creating a scene object
        Scene scene = new Scene(root, 600, 500);

        //Setting title to the Stage
        stage.setTitle("Samochód i tramwaj");

        //Adding scene to the stage
        stage.setScene(scene);

        //Displaying the contents of the stage
        stage.show();
    }

}
