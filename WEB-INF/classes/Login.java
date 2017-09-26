import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.net.URL;
import java.util.*;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import javax.servlet.http.HttpSession;
public class Login extends HttpServlet {
  
   public void doPost(HttpServletRequest req,  HttpServletResponse res)
throws ServletException, IOException
   {
    String un = req.getParameter("user");
    String uemail = req.getParameter("email");
    String mdp = req.getParameter("pass");

    if(checkExist(un,mdp)==true){

    //Establish a session
    HttpSession session = req.getSession();
    String fl=un.substring(0,1);

    session.setAttribute("username",un);
		session.setAttribute("email",uemail);
    session.setAttribute("fl",fl.toUpperCase());

    res.sendRedirect("/forum/user.jsp");


}
  else printPageF(req,res);
  }

  public void printPageF(HttpServletRequest request,
      HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
            PrintWriter out = response.getWriter();

            out.println("<script type=\"text/javascript\">");
             out.println("alert('Sorry! Invalid username or password!');");
             out.println("window.location='/forum/index.jsp';");
             out.println("</script>");
            out.close();

      }

      public void printPageS(HttpServletRequest request,
          HttpServletResponse response,String un) throws IOException {
            response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<html><body>");
                out.println("Done! Welcome <b>"+un+"</b> to our forum :)  Wanna login?<br>");
              out.println("<a href=\"/forum/index.jsp\">Go back</a>");
                out.println("</body></html>");
                out.close();

          }



  public static boolean checkExist(String cha,String chm) {
  Member member =new Member();
   try {

  SAXParserFactory factory = SAXParserFactory.newInstance();
  SAXParser saxParser = factory.newSAXParser();

  DefaultHandler handler;
    handler = new DefaultHandler() {

        boolean bfname = false;
        boolean bpass = false;
        public void startElement(String uri, String localName,String qName,
                Attributes attributes) throws SAXException {

            if (qName.equalsIgnoreCase("username")) {
                bfname = true;
            }
            if (qName.equalsIgnoreCase("password")) {
                bpass = true;
            }

        }

        public void endElement(String uri, String localName,
                String qName) throws SAXException {


        }

        public void characters(char ch[], int start, int length) throws SAXException {

            if (bfname) {

                String name=new String(ch, start, length);
                if(name.equals(cha)) member.ex=true;


                bfname = false;
            }
            if (bpass) {

                String name=new String(ch, start, length);
                if(name.equals(chm)) member.pw=true;


                bpass = false;
            }





        }

    };
      URL location = Login.class.getProtectionDomain().getCodeSource().getLocation();
      saxParser.parse(location+"members.xml", handler);

    } catch (Exception e) {
      e.printStackTrace();
    }
    return member.ex&&member.pw;

  }

  public static class Member {
      String username;
      String email;
      String password;
     public Boolean ex=false;
      public Boolean pw=false;
      }




}
