<%

 String filename = request.getParameter("filename"); 
// String oemail = request.getParameter("oemail"); 
 String fname = filename.concat(".txt"); 
 String cloud1content = request.getParameter("content1");

 String content = cloud1content;
 
 response.setHeader("Content-Disposition", "attachment;filename=\"" + fname + "\"");
 out.write(content); 

%>
