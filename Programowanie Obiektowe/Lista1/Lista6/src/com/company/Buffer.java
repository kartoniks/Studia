package com.company;
import java.util.Random;
import static java.lang.Thread.sleep;

public class Buffer<T> {
    Mylist<T> queue;
    int maxsize;
    Buffer(int arg)
    {
        queue = new Mylist<T>();
        maxsize = arg;
    }

}
class Producer implements Runnable {
    private Thread t;
    Buffer buf;
    Producer( Buffer b) {
        buf = b;
    }

    public void run() {
        try {
            while(true)
                FillBuffer();
        } catch (InterruptedException e) {
        }
    }

    public synchronized void FillBuffer() throws InterruptedException {
        while (buf.queue.size>=buf.maxsize)
            wait();
        while(buf.queue.size<buf.maxsize){
            String random = randomString();
            buf.queue.Add(random);
        }
        notify();
    }
    public synchronized void Printbuffer() throws InterruptedException{
        while (buf.queue.size<buf.maxsize)
            wait();
        sleep(2000);
        System.out.println("Iteracja konsumenta:");
        while(!buf.queue.Empty())
        {
            System.out.println(buf.queue.pop());
        }
        notify();
    }

    public void start () {
        t = new Thread (this);
        t.start();
    }
    public String randomString() {//https://stackoverflow.com/questions/20536566/creating-a-random-string-with-a-z-and-0-9-in-java
        String SALTCHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        StringBuilder salt = new StringBuilder();
        Random rnd = new Random();
        while (salt.length() < 10) { // length of the random string.
            int index = (int) (rnd.nextFloat() * SALTCHARS.length());
            salt.append(SALTCHARS.charAt(index));
        }
        String saltStr = salt.toString();
        return saltStr;
    }
}

class Consumer implements Runnable {
    private Thread t;
    Producer prod_ref;
    Consumer( Producer p) {
        prod_ref = p;
    }

    public void run() {
        try {
            while (true) {
                prod_ref.Printbuffer();
            }
        } catch (InterruptedException e) {
        }
    }

    public void start () {
        t = new Thread (this);
        t.start();
    }
}