<%@page import="java.util.Random"%>

<%@page import="java.sql.*"%>
<%@page import="databaseconnection.databasecon"%>
<%@ page session="true" %>

<html>
<body>
<%
   Connection co = null;
            String filename=request.getParameter("filename");
            String owner=request.getParameter("owner");
            String cipher=request.getParameter("cipher");
            String node=request.getParameter("node");
            String rec=session.getAttribute("username").toString();
          
		try
		{
         co = databasecon.getconnection();
                    
        PreparedStatement pst2=co.prepareStatement("insert into req(filename,owner,cipher,node,rec,status) values(?,?,?,?,?,?)");
        pst2.setString(1,filename);
	pst2.setString(2,owner);
        pst2.setString(3,cipher); 
        pst2.setString(4,node);   
        pst2.setString(5,rec);
        pst2.setString(6,"sentreq"); 
       
       
      
        
	int i= pst2.executeUpdate();
      
      if(i>0){
       response.sendRedirect("rvf.jsp?m1=success"); 
      }
      else{
          response.sendRedirect("rvf.jsp?m2=success"); 
      }
       }
	  
	catch(SQLException e)
        {
		out.print(e.getMessage());
	    }  
           %>
</body>
</html>

