<%@page import="Efficient.Ftpcon1"%>
<%@page import="databaseconnection.databasecon"%>
<%@page import="Efficient.Ftpcon"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.*"%>
<%@ page session="true" %>
<%
    String filename = request.getParameter("filename");
    String owner = request.getParameter("owner");
    String cipher = request.getParameter("cipher");
    String node = request.getParameter("node");

    String server = "cloud";
    Connection co = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        co = databasecon.getconnection();

        // Step 1: Write file locally
        File f = new File("C:\\Users\\Chetan\\Desktop\\input\\" + filename);
        FileWriter fw = new FileWriter(f);
        fw.write(cipher);
        fw.close();

        // Step 2: Upload to DriveHQ
        Ftpcon ftpcon = new Ftpcon();
        ftpcon.upload(f, filename, server);

        // Step 3: Get current node_value
        pst = co.prepareStatement("SELECT node_value FROM node WHERE username = ?");
        pst.setString(1, node);
        rs = pst.executeQuery();

        int currentValue = 0;
        if (rs.next()) {
            currentValue = rs.getInt("node_value");
        }
        rs.close();
        pst.close();

        // Step 4: Decrease node_value by 1 (minimum 0)
        int newValue = (currentValue > 0) ? currentValue - 1 : 0;

        pst = co.prepareStatement("UPDATE node SET node_value = ? WHERE username = ?");
        pst.setInt(1, newValue);
        pst.setString(2, node);
        pst.executeUpdate();
        pst.close();

        // Step 5: Update node_data status to 'sent'
        pst = co.prepareStatement("UPDATE node_data SET status='sent' WHERE filename=? AND owner=? AND node=?");
        pst.setString(1, filename);
        pst.setString(2, owner);
        pst.setString(3, node);
        pst.executeUpdate();
        pst.close();

        // Step 6: Redirect to success page
        response.sendRedirect("sc.jsp?success=File uploaded and node value decreased");

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("sc.jsp?error=" + java.net.URLEncoder.encode(e.toString(), "UTF-8"));
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (pst != null) try { pst.close(); } catch (Exception e) {}
        if (co != null) try { co.close(); } catch (Exception e) {}
    }
%>
