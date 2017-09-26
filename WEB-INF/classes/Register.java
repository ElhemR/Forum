import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import java.net.URL;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;
public class Register extends HttpServlet {
   public void doPost(HttpServletRequest req,  HttpServletResponse res)
throws ServletException, IOException
   {
    String un = req.getParameter ("user");
    String uemail = req.getParameter("email");
    String mdp = req.getParameter("pass");
    Checker ck;
    if(checkExist(un)==false){

     ck= new Checker(un,uemail,mdp);


}
  else printPageF(req,res);
  printPageS(req,res,un);
  }

  public void printPageF(HttpServletRequest request,
      HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
            PrintWriter out = response.getWriter();

                out.println("<script type=\"text/javascript\">");
                 out.println("alert('Sorry! The username you entered is already taken!');");
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



  public static boolean checkExist(String cha) {
  Member member =new Member();
   try {

  SAXParserFactory factory = SAXParserFactory.newInstance();
  SAXParser saxParser = factory.newSAXParser();

  DefaultHandler handler;
    handler = new DefaultHandler() {

        boolean bfname = false;
        boolean blname = false;
        boolean bnname = false;
        boolean bsalary = false;

        public void startElement(String uri, String localName,String qName,
                Attributes attributes) throws SAXException {

            if (qName.equalsIgnoreCase("username")) {
                bfname = true;
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
        }

    };

    URL location = Register.class.getProtectionDomain().getCodeSource().getLocation();
    saxParser.parse(location+"members.xml", handler);

    } catch (Exception e) {
      e.printStackTrace();
    }
    return member.ex;

  }

  public static class Member {
      String username;
      String email;
      String password;
     public Boolean ex=false;
      }




}
