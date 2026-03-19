/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
 
public class EmailUtils {
   public static void sendEmail(String to, String subject, String content) {
    try {
        final String fromEmail = "fgearweb.noreply@gmail.com";
        final String password = "ngnm hpfm pzfr xbcf";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(fromEmail));
        message.setRecipients(
                Message.RecipientType.TO,
                InternetAddress.parse(to)
        );

        message.setSubject(subject);
        message.setText(content);

        Transport.send(message);

    } catch (Exception e) {
        e.printStackTrace();
    }
}
}

