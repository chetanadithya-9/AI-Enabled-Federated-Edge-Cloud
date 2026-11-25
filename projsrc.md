# Complete Project Source Code for UML Diagram Generation

This document contains all core Java source files, classes, servlets, and database schema scripts for the project: **An AI-Enabled Federated Edge-Cloud Communication Framework for Dynamic Task Offloading and Network Anomaly Detection in IoT Systems**.

Use this source code file as reference input for LLMs or UML modeling tools (Visual Paradigm, Enterprise Architect, StarUML, PlantUML, Mermaid) to generate or update Class Diagrams, Sequence Diagrams, Activity Diagrams, Component Diagrams, and ER Diagrams.

---

## Table of Contents

1. [Database Schema (`db.sql`)](#1-database-schema-dbsql)
2. [Database Connection (`databasecon.java`)](#2-database-connection-databaseconjava)
3. [Network Attack Predictor (`NetworkAttackPredictor.java`)](#3-network-attack-predictor-networkattackpredictorjava)
4. [KNN Classifier (`KNNClassifier.java`)](#4-knn-classifier-knnclassifierjava)
5. [Network Record (`NetworkRecord.java`)](#5-network-record-networkrecordjava)
6. [Main Execution Harness (`Main.java`)](#6-main-execution-harness-mainjava)
7. [Upload Servlet (`Upload.java`)](#7-upload-servlet-uploadjava)
8. [Encryption Helper (`encryption.java`)](#8-encryption-helper-encryptionjava)
9. [Decryption Helper (`decryption.java`)](#9-decryption-helper-decryptionjava)
10. [Image Encryption (`encryptimg.java`)](#10-image-encryption-encryptimgjava)
11. [Blockchain Demo (`bcdemo.java`)](#11-blockchain-demo-bcdemojava)
12. [Mail Dispatcher (`mail.java`)](#12-mail-dispatcher-mailjava)
13. [FTP Connection 1 (`Ftpcon.java`)](#13-ftp-connection-1-ftpconjava)
14. [FTP Connection 2 (`Ftpcon1.java`)](#14-ftp-connection-2-ftpcon1java)

---

## 1. Database Schema (`db.sql`)

```sql
/*
SQLyog Community Edition- MySQL GUI v7.15 
MySQL - 5.5.29 : Database - alb
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;
/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`alb` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `alb`;

/*Table structure for table `cloud` */

DROP TABLE IF EXISTS `cloud`;

CREATE TABLE `cloud` (
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

insert  into `cloud`(`username`,`password`) values ('cloud','cloud');

/*Table structure for table `clouddata` */

DROP TABLE IF EXISTS `clouddata`;

CREATE TABLE `clouddata` (
  `filename` varchar(100) DEFAULT NULL,
  `owner` varchar(100) DEFAULT NULL,
  `cipher` varchar(100) DEFAULT NULL,
  `skey` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `status1` varchar(100) DEFAULT NULL,
  `duration_sec` INT DEFAULT 0,
  `packet_count` INT DEFAULT 0,
  `bytes_transferred` INT DEFAULT 0,
  `flow_rate` INT DEFAULT 0,
  `failed_logins` INT DEFAULT 0,
  `syn_packets` INT DEFAULT 0,
  `udp_packets` INT DEFAULT 0,
  `tcp_retransmissions` INT DEFAULT 0,
  `avg_packet_size` DOUBLE DEFAULT 0,
  `connection_hour` INT DEFAULT 0,
  `prediction` VARCHAR(100) DEFAULT 'Normal'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `node` */

DROP TABLE IF EXISTS `node`;

CREATE TABLE `node` (
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `node` varchar(100) DEFAULT NULL,
  `node_value` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

insert  into `node`(`username`,`password`,`node`,`node_value`) values ('node1','node1','node1',0),('node2','node2','node2',0),('node3','node3','node3',0),('node4','node4','node4',0);

/*Table structure for table `node_data` */

DROP TABLE IF EXISTS `node_data`;

CREATE TABLE `node_data` (
  `filename` varchar(100) DEFAULT NULL,
  `owner` varchar(100) DEFAULT NULL,
  `cipher` text,
  `skey` varchar(100) DEFAULT NULL,
  `node` varbinary(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `owner` */

DROP TABLE IF EXISTS `owner`;

CREATE TABLE `owner` (
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mobile` varchar(100) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `rec` */

DROP TABLE IF EXISTS `rec`;

CREATE TABLE `rec` (
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mobile` varchar(100) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `req` */

DROP TABLE IF EXISTS `req`;

CREATE TABLE `req` (
  `filename` varchar(100) DEFAULT NULL,
  `owner` varchar(100) DEFAULT NULL,
  `cipher` varchar(100) DEFAULT NULL,
  `node` varchar(100) DEFAULT NULL,
  `rec` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `upload` */

DROP TABLE IF EXISTS `upload`;

CREATE TABLE `upload` (
  `filename` varchar(100) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `content` text,
  `cipher` text,
  `skey` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `status1` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
```

---

## 2. Database Connection (`databasecon.java`)

```java
package databaseconnection;
import java.sql.*;

public class databasecon 
{
	static Connection co;
	public static Connection getconnection()
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");	
			co = DriverManager.getConnection("jdbc:mysql://localhost:3306/alb","root","root");
		}
		catch(Exception e)
		{
			System.out.println("Database Error"+e);
		}
		return co;
	}
}
```

---

## 3. Network Attack Predictor (`NetworkAttackPredictor.java`)

```java
package Efficient;

public class NetworkAttackPredictor {

    public static String predictAttack(
            int duration_sec,
            int packet_count,
            int bytes_transferred,
            int flow_rate,
            int failed_logins,
            int syn_packets,
            int udp_packets,
            int tcp_retransmissions,
            double avg_packet_size,
            int connection_hour) {

        // DDoS
        if (packet_count > 2000 &&
            syn_packets > 200 &&
            failed_logins >= 5) {

            return "DDoS";
        }

        // Botnet
        if (duration_sec > 30 &&
            packet_count > 1000 &&
            bytes_transferred > 20000 &&
            syn_packets < 50) {

            return "Botnet";
        }

        // PortScan
        if (packet_count >= 500 &&
            packet_count <= 2000 &&
            syn_packets >= 50 &&
            syn_packets <= 200 &&
            failed_logins >= 10) {

            return "PortScan";
        }

        return "Normal";
    }

    public static void main(String[] args) {

        String attack = predictAttack(
                111,      // duration_sec
                3859,     // packet_count
                75392,    // bytes_transferred
                20,       // flow_rate
                7,        // failed_logins
                49,       // syn_packets
                13,       // udp_packets
                10,       // tcp_retransmissions
                11.12,    // avg_packet_size
                12        // connection_hour
        );

        System.out.println("Predicted Attack: " + attack);
    }
}
```

---

## 4. KNN Classifier (`KNNClassifier.java`)

```java
package Efficient;
import java.util.*;

public class KNNClassifier {

    private List<NetworkRecord> trainingData;
    private int k;

    public KNNClassifier(List<NetworkRecord> trainingData, int k) {
        this.trainingData = trainingData;
        this.k = k;
    }

    private double distance(double[] a, double[] b) {
        double sum = 0;
        for(int i=0;i<a.length;i++) {
            sum += Math.pow(a[i]-b[i],2);
        }
        return Math.sqrt(sum);
    }

    public String predict(double[] input) {
        List<Neighbor> neighbors = new ArrayList<>();

        for(NetworkRecord record : trainingData) {
            double dist = distance(input, record.features);
            neighbors.add(
                new Neighbor(dist, record.label)
            );
        }

        Collections.sort(neighbors);

        Map<String,Integer> votes = new HashMap<>();

        for(int i=0;i<k;i++) {
            String label = neighbors.get(i).label;
            votes.put(
                label,
                votes.getOrDefault(label,0)+1
            );
        }

        String prediction = "";
        int maxVotes = 0;

        for(String label : votes.keySet()) {
            if(votes.get(label) > maxVotes) {
                maxVotes = votes.get(label);
                prediction = label;
            }
        }

        return prediction;
    }

    class Neighbor implements Comparable<Neighbor> {
        double distance;
        String label;

        Neighbor(double distance, String label) {
            this.distance = distance;
            this.label = label;
        }

        @Override
        public int compareTo(Neighbor o) {
            return Double.compare(this.distance, o.distance);
        }
    }
}
```

---

## 5. Network Record (`NetworkRecord.java`)

```java
package Efficient;

public class NetworkRecord {

    double[] features;
    String label;

    public NetworkRecord(double[] features, String label) {
        this.features = features;
        this.label = label;
    }
}
```

---

## 6. Main Execution Harness (`Main.java`)

```java
package Efficient;
import java.io.*;
import java.util.*;

public class Main {

    public static void main(String[] args) throws Exception {

        List<NetworkRecord> dataset = new ArrayList<>();

        BufferedReader br =
                new BufferedReader(
                new FileReader(
                "network_anomaly_dataset_records.csv"));

        String line;

        br.readLine(); // skip header

        while((line = br.readLine()) != null) {

            String[] data = line.split(",");

            double[] features = new double[10];

            for(int i=0;i<10;i++) {
                features[i] =
                        Double.parseDouble(data[i]);
            }

            String label = data[10];

            dataset.add(
                new NetworkRecord(
                        features,label));
        }

        br.close();

        KNNClassifier knn =
                new KNNClassifier(dataset,5);

        double[] testInput = {
                18,
                2712,
                204794,
                4,
                18,
                232,
                5,
                6,
                24.03,
                19
        };

        String result =
                knn.predict(testInput);

        System.out.println(
                "Predicted Attack Type : "
                + result);
    }
}
```

---

## 7. Upload Servlet (`Upload.java`)

```java
package Efficient;

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;
import databaseconnection.databasecon;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class Upload extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            String filename = "";
            String username = (String) request.getSession().getAttribute("username");

            try {
                boolean isMultipart = ServletFileUpload.isMultipartContent(request);
                if (!isMultipart) return;

                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List<FileItem> items = upload.parseRequest(request);
                Iterator<FileItem> iter = items.iterator();

                while (iter.hasNext()) {
                    FileItem item = iter.next();

                    if (item.isFormField()) {
                        String fieldName = item.getFieldName();
                        String value = item.getString();

                        switch (fieldName) {
                            case "filename":
                                filename = value;
                                break;
                        }
                    } else {
                        try (InputStream fileStream = item.getInputStream()) {
                            String content = getStringFromInputStream(fileStream);
                            long sizeInBytes = item.getSize();
                            String timeOnly = new SimpleDateFormat("HH:mm:ss").format(new Date());
                            
                            KeyGenerator keyGen = KeyGenerator.getInstance("AES");
                            keyGen.init(128);
                            SecretKey secretKey = keyGen.generateKey();
                             
                            byte[] be = secretKey.getEncoded();
                            String skey = Base64.encode(be);
                             
                            String cipher = new encryption().encrypt(content, secretKey);

                            try (Connection con = databasecon.getconnection()) {
                                PreparedStatement pst = con.prepareStatement(
                                    "INSERT INTO upload (filename, username, content, cipher, skey, status, status1) VALUES (?, ?, ?, ?, ?, ?, ?)"
                                );

                                pst.setString(1, filename);
                                pst.setString(2, username);
                                pst.setString(3, content);
                                pst.setString(4, cipher);
                                pst.setString(5, skey);
                                pst.setString(6, "pending");
                                pst.setString(7, "pending");

                                int inserted = pst.executeUpdate();

                                if (inserted == 1) {
                                    response.sendRedirect("upload.jsp?m1=success");
                                } else {
                                    response.sendRedirect("upload.jsp?msg1=failed");
                                }
                            } catch (Exception e) {
                                out.println("Database Error: " + e.getMessage());
                            }
                        }
                    }
                }

            } catch (FileUploadException ex) {
                out.println("Upload error: " + ex.getMessage());
            } catch (Exception ex) {
                Logger.getLogger(Upload.class.getName()).log(Level.SEVERE, null, ex);
                out.println("Unexpected error: " + ex.getMessage());
            }
        }
    }

    private static String getStringFromInputStream(InputStream is) {
        StringBuilder sb = new StringBuilder();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(is))) {
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line).append("\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return sb.toString();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        processRequest(request, response);
    }
}
```

---

## 8. Encryption Helper (`encryption.java`)

```java
package Efficient;

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import sun.misc.BASE64Encoder;

public class encryption {

    public String encrypt(String text, SecretKey secretkey) {
        String plainData = null, cipherText = null;
        try {
            plainData = text;

            Cipher aesCipher = Cipher.getInstance("AES");
            aesCipher.init(Cipher.ENCRYPT_MODE, secretkey);

            byte[] byteDataToEncrypt = plainData.getBytes();
            byte[] byteCipherText = aesCipher.doFinal(byteDataToEncrypt);

            cipherText = new BASE64Encoder().encode(byteCipherText);

        } catch (Exception e) {
            System.out.println(e);
        }
        return cipherText;
    }
}
```

---

## 9. Decryption Helper (`decryption.java`)

```java
package Efficient;

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import sun.misc.BASE64Decoder;

public class decryption {

    public String decrypt(String txt, String skey) {
        String decryptedtext = null;
        try {
            byte[] bs = Base64.decode(skey);
            SecretKey sec = new SecretKeySpec(bs, "AES");

            Cipher aesCipher = Cipher.getInstance("AES");
            aesCipher.init(Cipher.ENCRYPT_MODE, sec);

            byte[] byteCipherText = new BASE64Decoder().decodeBuffer(txt);
            aesCipher.init(Cipher.DECRYPT_MODE, sec, aesCipher.getParameters());

            byte[] byteDecryptedText = aesCipher.doFinal(byteCipherText);
            decryptedtext = new String(byteDecryptedText);

        } catch (Exception e) {
            System.out.println(e);
        }
        return decryptedtext;
    }
}
```

---

## 10. Image Encryption (`encryptimg.java`)

```java
package Efficient;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class encryptimg {
    
    private static final String ALGORITHM = "AES";
    private static final String TRANSFORMATION = "AES/CBC/PKCS5PADDING";

    public static byte[] encryptImage(InputStream imageInputStream, String secretKey, String initVector) throws Exception {
        IvParameterSpec iv = new IvParameterSpec(initVector.getBytes("UTF-8"));
        SecretKeySpec skeySpec = new SecretKeySpec(secretKey.getBytes("UTF-8"), ALGORITHM);

        Cipher cipher = Cipher.getInstance(TRANSFORMATION);
        cipher.init(Cipher.ENCRYPT_MODE, skeySpec, iv);

        ByteArrayOutputStream output = new ByteArrayOutputStream();
        byte[] buffer = new byte[1024];
        int bytesRead;

        while ((bytesRead = imageInputStream.read(buffer)) != -1) {
            byte[] encryptedBytes = cipher.update(buffer, 0, bytesRead);
            if (encryptedBytes != null) {
                output.write(encryptedBytes);
            }
        }

        byte[] encryptedBytes = cipher.doFinal();
        if (encryptedBytes != null) {
            output.write(encryptedBytes);
        }

        return output.toByteArray();
    }
}
```

---

## 11. Blockchain Demo (`bcdemo.java`)

```java
package Efficient;

import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.List;

public class bcdemo {

    static class Block {
        public String hash;
        private String data;

        public Block(String data) {
            this.data = data;
            this.hash = calculateHash();
        }

        public String calculateHash() {
            try {
                MessageDigest digest = MessageDigest.getInstance("SHA-256");
                byte[] hashBytes = digest.digest(data.getBytes());
                StringBuilder hashString = new StringBuilder();
                for (byte b : hashBytes) {
                    hashString.append(String.format("%02x", b));
                }
                return hashString.toString().substring(0, 10);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
    }

    private List<Block> blockchain;

    public bcdemo() {
        blockchain = new ArrayList<>();
    }

    public void addBlock(String data) {
        blockchain.add(new Block(data));
    }

    public String getLastBlockHash() {
        return blockchain.get(blockchain.size() - 1).hash;
    }

    public String getHashForData(String data) {
        Block tempBlock = new Block(data);
        return tempBlock.hash;
    }
}
```

---

## 12. Mail Dispatcher (`mail.java`)

```java
package Efficient;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class mail {

    public static boolean secretMail(String msg, String userid, String to) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");

        Session session = Session.getDefaultInstance(props,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                         return new PasswordAuthentication("moulalicce225@gmail.com", "yrvdvlpdoqhpcrhe");
                    }
                });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(userid));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(to));
            message.setSubject("Secret key ");
            message.setText(msg);

            Transport.send(message);
            return true;

        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}
```

---

## 13. FTP Connection 1 (`Ftpcon.java`)

```java
package Efficient;

import java.io.File;
import java.io.FileInputStream;
import org.apache.commons.net.ftp.FTPClient;

public class Ftpcon {

    FTPClient client = new FTPClient();
    FileInputStream fis = null;
    boolean status;

    public boolean upload(File file, String name, String server) {
        try {
            client.connect("ftp.drivehq.com");
            client.login("deepchoccy", "giri@2027");
            client.enterLocalPassiveMode();
            fis = new FileInputStream(file);
            if(server.equals("cloud")){
                status = client.storeFile("/cloud/" + name, fis);
            }
            client.logout();
            fis.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
}
```

---

## 14. FTP Connection 2 (`Ftpcon1.java`)

```java
package Efficient;

import java.io.File;
import java.io.FileInputStream;
import org.apache.commons.net.ftp.FTPClient;

public class Ftpcon1 {

    FTPClient client = new FTPClient();
    FileInputStream fis = null;
    boolean status;

    public boolean upload(File file, String name, String server) {
        try {
            client.connect("ftp.drivehq.com");
            client.login("deepchoccy", "giri@2027");
            client.enterLocalPassiveMode();
            fis = new FileInputStream(file);
            if(server.equals("cloud1")){
                status = client.storeFile("/cloud1/" + name, fis);
            }
            client.logout();
            fis.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }
}
```
