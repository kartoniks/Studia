package main;

import java.util.Comparator;

public class Zad4 implements Comparator<Integer> {

    int IntComparer(int o1, int o2) {
        return o1-o2;
    }

    @Override
    public int compare(Integer o1, Integer o2) {
        return IntComparer(o1,o2);
    }

}
