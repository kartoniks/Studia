import java.util.*;
public class Wyrazenie {
    Hashtable HT = new Hashtable();
    Wezel korzen;

    Wyrazenie(Wezel k) {
        korzen = k;
        korzen.Hashe = HT;
    }

    String wypisz() {
        return korzen.toString();
    }

    int oblicz() {
        return korzen.oblicz();
    }

    void dodajZmienna(char x, int val){
        HT.put(x, val);
    }
}