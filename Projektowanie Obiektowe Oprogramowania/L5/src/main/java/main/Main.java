package main;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;

public class Main {

    public static void main(String[] args) {
        Zad4();
    }

    public static void Zad1() {
        String from = "my_email";
        String pass = "********";
        String to = "mock@gmail.com"; // list of recipient email addresses
        String subject = "Java send mail example";
        String body = "Welcome to JavaMail!";
        String attachment = "/directory/to/file";
        String fileName = "my_file.txt";

        Zad1.Send(from, pass, to, subject, body, attachment, fileName);
    }

    public static void Zad4() {
        ArrayList<Integer> nums = new ArrayList<>(Arrays.asList(1,7,2,4,3,6,9,8));
        Collections.sort(nums, new Zad4());
        System.out.println(nums);
    }
}
