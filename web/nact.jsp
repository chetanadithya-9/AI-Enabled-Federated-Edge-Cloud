<%@page import="java.sql.*"%>
<%@page import="databaseconnection.databasecon"%>
<%@page session="true"%>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String node = request.getParameter("node");

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        con = databasecon.getconnection();

        pst = con.prepareStatement("SELECT * FROM node WHERE username=? AND password=?");
        pst.setString(1, username);
        pst.setString(2, password);
        rs = pst.executeQuery();

        if (rs.next()) {
            session.setAttribute("username", username);
            session.setAttribute("node", node);

            // Redirect based on node
            if (node.equals("node1")) {
                response.sendRedirect("home1.jsp");
            } else if (node.equals("node2")) {
                response.sendRedirect("home2.jsp");
            } else if (node.equals("node3")) {
                response.sendRedirect("home3.jsp");
            } else if (node.equals("node4")) {
                response.sendRedirect("home4.jsp");
            } else {
                out.println("<script>alert('Invalid node selected');history.back();</script>");
            }

        } else {
            out.println("<script>alert('Invalid credentials or node');history.back();</script>");
        }

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (pst != null) try { pst.close(); } catch (Exception e) {}
        if (con != null) try { con.close(); } catch (Exception e) {}
    }
%>
