package sample;
import java.io.*;

public class Pojazd implements java.io.Serializable{
    public int moc;
    public String marka;
    public void serialize(String nazwa){
        try {
            FileOutputStream fileOut =
                    new FileOutputStream("/tmp/"+nazwa);
            ObjectOutputStream out = new ObjectOutputStream(fileOut);
            out.writeObject(this);
            out.close();
            fileOut.close();
            System.out.println("Serialized data is saved in /tmp/"+nazwa);
        } catch (IOException i) {
            i.printStackTrace();
        }
    }
    public static Pojazd deserialize(String nazwa){
        Pojazd temp = new Pojazd();
        try {
            File f = new File("/tmp/"+nazwa);
            if(f.exists() && !f.isDirectory()) {
                FileInputStream fileIn = new FileInputStream("/tmp/"+nazwa);
                ObjectInputStream in = new ObjectInputStream(fileIn);
                temp = (Pojazd) in.readObject();
                in.close();
                fileIn.close();
            }
        } catch (IOException i) {
            i.printStackTrace();
        } catch (ClassNotFoundException c) {
            System.out.println("File not found");
            c.printStackTrace();
        }
    return temp;
    }
}

class Samochod extends Pojazd{
    public Samochod(String r, String mar, int m){
        rejestracja=r;
        marka=mar;
        moc=m;
    }
    public String rejestracja;
    public String toString() {
        return "Rejestracja:" + rejestracja + ", " + "Marka:" + marka + ", " + "Moc:" + Integer.toString(moc);
    }
}

class Tramwaj extends Pojazd{
    public Tramwaj(int n, String mar, int m){
        moc=m;
        marka=mar;
        numer=n;
    }
    public int numer;

}
