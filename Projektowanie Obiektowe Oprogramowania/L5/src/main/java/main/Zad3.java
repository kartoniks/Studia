package main;

import java.time.LocalDate;
import java.time.LocalTime;

public class Zad3 {
    static void SendProxyTime(String from, String pass, String to, String subject, String body, String filePath, String fileName) {
        try {
            LocalTime time = LocalTime.now();
            if (time.getHour() < 8 || time.getHour() > 22) {
                throw new Exception("Method only available during daytime.");
            }
            Zad1.Send(from, pass, to, subject, body, filePath, fileName);
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    static void SendProxyLogger(String from, String pass, String to, String subject, String body, String filePath, String fileName) {
        System.out.println(LocalDate.now() + " Sending email from:" + from + " to:" + to + " with subject:" + subject);
        try {
            Zad1.Send(from, pass, to, subject, body, filePath, fileName);
            System.out.println(LocalDate.now() + "Successfully sent email message");
        } catch(Exception e) {
            System.out.println("Failed with exception" + e);
        }
    }
}
