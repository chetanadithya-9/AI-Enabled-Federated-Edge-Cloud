<%@page import="java.sql.*" %>
<%@page import="databaseconnection.databasecon" %>
<%@page import="java.util.*" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String filename = request.getParameter("filename");
    String owner = request.getParameter("owner");
    String cipher = request.getParameter("cipher");
    String skey = request.getParameter("skey");

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        con = databasecon.getconnection();

        // Step 1: Fetch all nodes and their values
        pst = con.prepareStatement("SELECT username, node_value FROM node");
        rs = pst.executeQuery();

        Map<String, Integer> nodeMap = new LinkedHashMap<>();
        while (rs.next()) {
            nodeMap.put(rs.getString("username"), rs.getInt("node_value"));
        }

        String selectedNode = "";

        if (!nodeMap.isEmpty()) {
            Collection<Integer> values = nodeMap.values();
            Set<Integer> uniqueValues = new HashSet<>(values);

            if (uniqueValues.size() == 1) {
                // All node_values are equal → pick randomly
                List<String> nodes = new ArrayList<>(nodeMap.keySet());
                Collections.shuffle(nodes);
                selectedNode = nodes.get(0);
            } else {
                // Pick node with the lowest value
                int minValue = Collections.min(values);
                for (Map.Entry<String, Integer> entry : nodeMap.entrySet()) {
                    if (entry.getValue() == minValue) {
                        selectedNode = entry.getKey();
                        break;
                    }
                }
            }
        }

        if (!selectedNode.isEmpty()) {
            // Step 2: Insert file into node_data table
            pst = con.prepareStatement("INSERT INTO node_data (filename, owner, cipher, skey, node, status) VALUES (?, ?, ?, ?, ?, ?)");
            pst.setString(1, filename);
            pst.setString(2, owner);
            pst.setString(3, cipher);
            pst.setString(4, skey);
            pst.setString(5, selectedNode);
            pst.setString(6, "pending");
            pst.executeUpdate();

            // Step 3: Increment the node_value of the selected node
            pst = con.prepareStatement("UPDATE node SET node_value = node_value + 1 WHERE username = ?");
            pst.setString(1, selectedNode);
            pst.executeUpdate();

            // ✅ Redirect to cvf.jsp with success
            response.sendRedirect("cvf.jsp?success=File sent to " + selectedNode);

        } else {
            // No available node found
            response.sendRedirect("cvf.jsp?error=NoAvailableNode");
        }

    } catch (Exception e) {
        e.printStackTrace(); // for console debug
        session.setAttribute("cvf_error", e.toString());
        response.sendRedirect("cvf.jsp?error=" + java.net.URLEncoder.encode(e.toString(), "UTF-8"));
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (pst != null) try { pst.close(); } catch (Exception e) {}
        if (con != null) try { con.close(); } catch (Exception e) {}
    }
%>
