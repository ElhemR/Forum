import java.io.*;
import java.util.*;
import java.net.URL;
import javax.xml.transform.*;
import javax.xml.transform.stream.*;
import javax.xml.transform.dom.*;
import org.w3c.dom.*;
import javax.xml.parsers.*;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

public class Checker {
  public boolean ex=false;

   public Checker(String ch,String ch2,String ch3)

   {

       try {

         DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
      DocumentBuilder documentBuilder = documentBuilderFactory.newDocumentBuilder();
      URL location = Checker.class.getProtectionDomain().getCodeSource().getLocation();
      Document document = documentBuilder.parse(location+"members.xml");
      Element root = document.getDocumentElement();

      Collection<Member> members = new ArrayList<Member>();
      members.add(new Member());

      for (Member member : members) {
          // server elements
          Element newMember = document.createElement("member");

          Element username = document.createElement("username");
          username.appendChild(document.createTextNode(ch));
          newMember.appendChild(username);

          Element email = document.createElement("email");
          email.appendChild(document.createTextNode(ch2));
          newMember.appendChild(email);

          Element pwd = document.createElement("password");
          pwd.appendChild(document.createTextNode(ch3));
          newMember.appendChild(pwd);

          root.appendChild(newMember);
      }

      DOMSource source = new DOMSource(document);

      TransformerFactory transformerFactory = TransformerFactory.newInstance();
      Transformer transformer = transformerFactory.newTransformer();
      StreamResult result = new StreamResult(location+"members.xml");
      transformer.transform(source, result);



       } catch (Exception e) {
           e.printStackTrace();
       }


}
public static class Member {
    String username;
    String email;
    String password;
   public Boolean ex=false;
    }
}
