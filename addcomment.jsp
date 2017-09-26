<%@ page import ="java.sql.*" %>
<%@ page import="cx.Cx"%>
<%
Cx c = new Cx();
c.driver();
c.OpenConnexion();     
String nom=(String)session.getAttribute("username");
String param=request.getParameter("messageid"); 
String authorm=request.getParameter("authorm"); 
int mid=Integer.parseInt(param);       
String content=request.getParameter("content");
String title="comment";
String category="other";
String query = "Insert into message(author,title,idc,content,category) values("+"'"+nom+"', '"+title+"',"+mid+ ",'" +content+"', '"+category+"')";
int n=c.updateExec(query); 

if(!authorm.equals(nom)){
String queryc = "Insert into notification(idmsg,authorcmnt,authormsg) values("+"'"+mid+"', '"+nom+"','"+authorm+"')";
int nb=c.updateExec(queryc); }

response.sendRedirect("/forum/msg.jsp?msgid="+mid);
c.closeStatement();
c.closeConnection();
%>