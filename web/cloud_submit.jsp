<%@page import="Efficient.NetworkAttackPredictor"%>
<%@page import="java.sql.*"%>
<%@page import="databaseconnection.databasecon"%>
<%@ page session="true" %>
<%
String filename = request.getParameter("filename");
String owner = request.getParameter("owner");
String cipher = request.getParameter("cipher");
String skey = request.getParameter("skey");

try {
    int duration_sec = Integer.parseInt(request.getParameter("duration_sec"));
    int packet_count = Integer.parseInt(request.getParameter("packet_count"));
    int bytes_transferred = Integer.parseInt(request.getParameter("bytes_transferred"));
    int flow_rate = Integer.parseInt(request.getParameter("flow_rate"));
    int failed_logins = Integer.parseInt(request.getParameter("failed_logins"));
    int syn_packets = Integer.parseInt(request.getParameter("syn_packets"));
    int udp_packets = Integer.parseInt(request.getParameter("udp_packets"));
    int tcp_retransmissions = Integer.parseInt(request.getParameter("tcp_retransmissions"));
    double avg_packet_size = Double.parseDouble(request.getParameter("avg_packet_size"));
    int connection_hour = Integer.parseInt(request.getParameter("connection_hour"));

    String prediction = NetworkAttackPredictor.predictAttack(
            duration_sec, packet_count, bytes_transferred, flow_rate,
            failed_logins, syn_packets, udp_packets, tcp_retransmissions,
            avg_packet_size, connection_hour);

    Connection co = databasecon.getconnection();
    PreparedStatement pst2 = co.prepareStatement(
        "insert into clouddata(filename,owner,cipher,skey,status,status1,"
        + "duration_sec,packet_count,bytes_transferred,flow_rate,"
        + "failed_logins,syn_packets,udp_packets,tcp_retransmissions,"
        + "avg_packet_size,connection_hour,prediction) "
        + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
    pst2.setString(1, filename);
    pst2.setString(2, owner);
    pst2.setString(3, cipher);
    pst2.setString(4, skey);
    pst2.setString(5, "pending");
    pst2.setString(6, "pending");
    pst2.setInt(7, duration_sec);
    pst2.setInt(8, packet_count);
    pst2.setInt(9, bytes_transferred);
    pst2.setInt(10, flow_rate);
    pst2.setInt(11, failed_logins);
    pst2.setInt(12, syn_packets);
    pst2.setInt(13, udp_packets);
    pst2.setInt(14, tcp_retransmissions);
    pst2.setDouble(15, avg_packet_size);
    pst2.setInt(16, connection_hour);
    pst2.setString(17, prediction);

    int i = pst2.executeUpdate();

    if (i > 0) {
        String redirectUrl = "mf1.jsp?m1=success" +
            "&filename=" + java.net.URLEncoder.encode(filename, "UTF-8") +
            "&owner=" + java.net.URLEncoder.encode(owner, "UTF-8") +
            "&cipher=" + java.net.URLEncoder.encode(cipher, "UTF-8") +
            "&skey=" + java.net.URLEncoder.encode(skey, "UTF-8") +
            "&prediction=" + java.net.URLEncoder.encode(prediction, "UTF-8");
        response.sendRedirect(redirectUrl);
    } else {
        response.sendRedirect("mf1.jsp?m2=failed");
    }
} catch (Exception e) {
    out.print(e.getMessage());
}
%>
