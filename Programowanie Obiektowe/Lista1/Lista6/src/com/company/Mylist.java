package com.company;
import java.io.*;

public class Mylist<T> implements java.io.Serializable{
    Node<T> pointer;
    Node<T> last;
    int size=0;
    public void Add(T v)
    {
        Node temp = new Node();
        temp.val = v;
        if(pointer==null){
            last=temp;
            pointer=last;
        }
        else {
            last.next = temp;
            last = last.next;
        }
        size+=1;
    }

    public boolean Empty()
    {
        return pointer==null;
    }
    public T pop()
    {
        T temp=pointer.val;
        pointer=pointer.next;
        size-=1;
        return temp;
    }

    public void Write()
    {
        Node<T> iter=pointer;
        while(iter!=null)
        {
            System.out.println(iter.val);
            iter=iter.next;
        }
    }
    public void Serialize(String s)
    {
        try {//serializacja
            FileOutputStream fileOut =
                    new FileOutputStream("/tmp/"+s+".ser");
            ObjectOutputStream out = new ObjectOutputStream(fileOut);
            out.writeObject(this);
            out.close();
            fileOut.close();
            System.out.println("Serialized data is saved in /tmp/"+s+".ser");
        } catch (IOException i) {
            i.printStackTrace();
        }
    }
    public Mylist Deserialize(String s)
    {
        Mylist temp=null;   //can't return uninitialized variable
        try {//deserializacja
            FileInputStream fileIn = new FileInputStream("/tmp/"+s+".ser");
            ObjectInputStream in = new ObjectInputStream(fileIn);
            temp = (Mylist) in.readObject();
            in.close();
            fileIn.close();
            System.out.println("correctly deserialized data");
        } catch (IOException i) {
            i.printStackTrace();
        } catch (ClassNotFoundException c) {
            System.out.println("Mylist class not found");
            c.printStackTrace();
        }
        return temp;
    }
}

class Node<T> implements java.io.Serializable{
    T val;
    Node next;
}