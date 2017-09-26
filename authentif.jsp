<%@ page import ="java.sql.*" %>
<%@ page import="cx.Cx"%>

<%
Cx c = new Cx();
c.driver();
c.OpenConnexion();
String username = request.getParameter("user");
String password = request.getParameter("pass");
if(username.equals("admin")&&password.equals("admin")){
	    	  response.sendRedirect("index.html"); }
else{
   String sql = "select * from members where username='"+username+"' and  password='"+password+"'";
		 ResultSet  rst=c.selectExec(sql);
		if(rst.next()){
		  	String user = rst.getString(1);
            String email =rst.getString(2);
            String pwd= rst.getString(3);
			HttpSession sess = request.getSession();
			sess.setAttribute("username",user);
			sess.setAttribute("email",email);
			sess.setAttribute("password",pwd);
			response.sendRedirect("member.jsp");
   }
   }
%>
