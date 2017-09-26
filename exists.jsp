<%@ page import ="java.sql.*" %>
<%@ page import="cx.Cx"%>

<%
Cx c = new Cx();
c.driver();
c.OpenConnexion();
String username = request.getParameter("username");


   
String query = "SELECT * from members where username="+"'"+username+"'";

ResultSet rs=c.selectExec(query); 

  if(rs.first()){
                out.print("User already exists");
            }else{
                out.print("User name is valid");
            }
   c.closeStatement();
   c.closeResultSet();
   c.closeConnection();
%>