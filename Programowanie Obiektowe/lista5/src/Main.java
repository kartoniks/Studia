public class Main {

    public static void main(String[] args) {
        Wezel l1 = new Wezel(15);
        Wezel l2 = new Wezel(7);
        Wezel l3 = new Wezel(3);
        Wezel l4 = new Wezel('-', l1, new Wezel('+', l2, l3));
        System.out.println(l4.oblicz());
        System.out.println(l4.toString());
        //TEST 2
        l2.symbol = 'x';
        l1.symbol = 'y';
        l3 = new Wezel('+',l1,l2);
        Wyrazenie w = new Wyrazenie(l3);
        w.dodajZmienna('x', 22);
        w.dodajZmienna('y', 20);
        System.out.println(l3.Hashe);
        System.out.println(w.oblicz());

        //Zad. 2: liczenie pochodnej
        l1= new Wezel('x');
        l2= new Wezel('x');
        l3= new Wezel('*', l1, l2);
        l4= l3.pochodna();
        System.out.println(l4);
    }
}
