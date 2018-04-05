package com.company;

public class Main {

    public static void main(String[] args) {
	    //Zad1
        /*Mylist ll = new Mylist();
	    ll.Add(15);
	    ll.Add(42);
	    ll.Add(423);
	    ll.Serialize("lista");
	    ll=new Mylist();
	    ll=ll.Deserialize("lista");
	    ll.Write();*/
        //Zad3
        Buffer<String> buf = new Buffer<>(6);
        Producer prod = new Producer(buf);
        Consumer cons = new Consumer(prod);
        prod.start();
        cons.start();
    }
}
