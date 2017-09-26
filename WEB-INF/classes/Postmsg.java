import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
public class Postmsg extends HttpServlet {
   public void doPost(HttpServletRequest req,  HttpServletResponse res)
throws ServletException, IOException
   {
    HttpSession session = req.getSession();
    String title= req.getParameter ("title");
    String content = req.getParameter("content");
    String category = req.getParameter("category");
    String author=(String)session.getAttribute("username");

    Cnx c = new Cnx();
    c.driver();
    c.OpenConnexion();
    String query = "Insert into message(author,title,idc,content,category) values("+"'"+author+"', '"+title+"',0, '" +content+"', '"+category+"')";
    int n=c.updateExec(query);

    res.setContentType("text/html");
    PrintWriter out = res.getWriter();
    out.println("<script type=\"text/javascript\">");
     out.println("alert('Your message has been added successfully');");
     out.println("window.location='/forum/user.jsp';");
     out.println("</script>");

     c.closeStatement();
   c.closeResultSet();
   c.closeConnection();

}
}
