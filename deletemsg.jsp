<%@ page import ="java.sql.*" %>
<%@ page import="cx.Cx"%>
<%
Cx c = new Cx();
c.driver();
c.OpenConnexion();     
String param=request.getParameter("msgid"); 
int mid=Integer.parseInt(param);
String query = "delete from message where id="+mid;
int n=c.updateExec(query);
out.println("<script type=\"text/javascript\">");
out.println("alert('Your message has been deleted successfully');");
out.println("window.location='/forum/user.jsp';");
 out.println("</script>");
   
    c.closeStatement();

   c.closeConnection();
%>