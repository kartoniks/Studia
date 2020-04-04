package main1;

import java.util.Random;

public class Main1 {
    public static void main(String[] args) {
        try {
            zad1SingletonTest();
            Thread.sleep(1000);
            zad1ThreadTest();
            Thread.sleep(1000);
            zad1TimeTest();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    public static void zad1SingletonTest() {
        Zad1 one = new Zad1().getInstance();
        Zad1 another = new Zad1().getInstance();
        one.id = 42;
        another.id = 99;
        System.out.println("Running test for singleton, ids should be equal:");
        System.out.println(one.debug());
        System.out.println(another.debug());
        System.out.println();
    }

    public static void zad1ThreadTest() {
        System.out.println("Running test for threads:");
        Thread thread = new ThreadLocalTest();
        thread.start();
        Thread thread2 = new ThreadLocalTest();
        thread2.start();
    }

    public static class ThreadLocalTest extends Thread {
        public void run() {
            Zad1 instance1 = Zad1.getThreadInstance();
            System.out.println(getThreadName() + instance1);
            sleep(100, 50); // sleep for some time
            Zad1 instance2 = Zad1.getThreadInstance();
            System.out.println(getThreadName() + instance2);
            boolean equal = instance1 == instance2;
            String message = equal ? "Both are equal" : "Not equal";
            System.out.println(getThreadName() + message);
            System.out.println();
        }

        private void sleep(int max, int min) {
            try {
                int time = new Random().nextInt(max - min + 1) + min;
                Thread.sleep(time);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        private String getThreadName() {
            return "[" + Thread.currentThread().getName() + "] - ";
        }
    }

    public static void zad1TimeTest() {
        try {
            System.out.println("Running test for new instance every second");
            Zad1 one = new Zad1().getTimedInstance();
            System.out.println("Timestamp:"+one.startMillis);
            Zad1 another = new Zad1().getTimedInstance();
            System.out.println("Timestamp:"+another.startMillis);
            System.out.println("Running constructor twice, instances are equal:" + (one == another));
            Thread.sleep(2000);
            Zad1 afterSleep = new Zad1().getTimedInstance();
            System.out.println("Timestamp:"+afterSleep.startMillis);
            System.out.println("Running constructor after sleep, instances are equal:" + (one == afterSleep));
            System.out.println();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

    }
}