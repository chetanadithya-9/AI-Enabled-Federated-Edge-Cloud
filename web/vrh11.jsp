<%@page import="Efficient.mail"%>
<%@page import="java.sql.*"%>
<%@page import="databaseconnection.databasecon"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Send Key</title>
</head>
<body>
<%
    Connection co = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String filename = request.getParameter("filename");
    String owner = request.getParameter("owner");
    String node = request.getParameter("node");
    String rec = request.getParameter("rec");

    String email = "";
    String skey = "";

    try {
        co = databasecon.getconnection();

        // Fetch recipient email
        ps = co.prepareStatement("SELECT email FROM rec WHERE username = ?");
        ps.setString(1, rec);
        rs = ps.executeQuery();
        if (rs.next()) {
            email = rs.getString("email");
        }
        rs.close();
        ps.close();

        // Fetch file secret key
        ps = co.prepareStatement("SELECT skey FROM upload WHERE filename = ? AND username = ?");
        ps.setString(1, filename);
        ps.setString(2, owner);
        rs = ps.executeQuery();
        if (rs.next()) {
            skey = rs.getString("skey");
        }
        rs.close();
        ps.close();

        // Update request status
        ps = co.prepareStatement("UPDATE req SET status = 'key sent' WHERE filename = ? AND owner = ? AND rec = ?");
        ps.setString(1, filename);
        ps.setString(2, owner);
        ps.setString(3, rec);

        int i = ps.executeUpdate();
        if (i > 0) {
            // Send key to email
            mail m = new mail();
            String msg = "File Key is: " + skey;
            m.secretMail(msg, email, email);  // to and from are same

            response.sendRedirect("vr.jsp?m1=Success");
        } else {
            response.sendRedirect("vr.jsp?m2=Failed");
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("vr.jsp?m3=Error");
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (co != null) co.close(); } catch (Exception e) {}
    }
%>
</body>
</html>
