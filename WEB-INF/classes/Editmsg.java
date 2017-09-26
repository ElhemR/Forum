import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
public class Editmsg extends HttpServlet {
   public void doPost(HttpServletRequest req,  HttpServletResponse res)
throws ServletException, IOException
   {
   int n=0;
    String title= req.getParameter ("title");
    String content = req.getParameter("content");
    String category = req.getParameter("category");
    String param=req.getParameter("messageid");
    int mid=Integer.parseInt(param);

    Cnx c = new Cnx();
    c.driver();
    c.OpenConnexion();

if(title!=null){
   String query="update message set title="+"'"+title+"'"+"where id="+mid;
   n=c.updateExec(query);
   }
if(content!=null){
   String query="update message set content="+"'"+content+"'"+"where id="+mid;
   n=c.updateExec(query);
}

  if(category!=null){
   String query="update message set category="+"'"+category+"'"+"where id="+mid;
   n=c.updateExec(query);
}

if(n==1){
    res.setContentType("text/html");
    PrintWriter out = res.getWriter();
    out.println("<script type=\"text/javascript\">");
     out.println("alert('Your message has been edited successfully');");
     out.println("</script>");
}
String urlm="/forum/msg.jsp?msgid="+mid;
res.sendRedirect(urlm);
     c.closeStatement();
   c.closeResultSet();
   c.closeConnection();

}
}
