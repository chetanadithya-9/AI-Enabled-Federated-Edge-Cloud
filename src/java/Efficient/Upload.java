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
            String node = "";
            String bckey = "";
            String nroute = "";
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
                        // File content and size
                        try (InputStream fileStream = item.getInputStream()) {
                            String content = getStringFromInputStream(fileStream);
                            long sizeInBytes = item.getSize();
                            String timeOnly = new SimpleDateFormat("HH:mm:ss").format(new Date());
                            
                            
                            KeyGenerator keyGen = KeyGenerator.getInstance("AES");
                            keyGen.init(128);
                             SecretKey secretKey = keyGen.generateKey();
                             System.out.println("secret key:" + secretKey);
                             
                             byte[] be = secretKey.getEncoded();//encoding secretkey
                             String skey = Base64.encode(be);
                             
                              String cipher = new encryption().encrypt(content, secretKey);

                            try (Connection con = databasecon.getconnection()) {
                                PreparedStatement pst = con.prepareStatement(
                                    "INSERT INTO upload (filename, username, content, cipher, skey,  status,status1) VALUES (?, ?, ?, ?, ?, ?, ?)"
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

    @Override
    public String getServletInfo() {
        return "Handles file upload with time, route, node and bckey.";
    }
}
