import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.HttpSession;
public class Logout extends HttpServlet {
   public void doGet(HttpServletRequest req,  HttpServletResponse res)
throws ServletException, IOException
   {

HttpSession session = req.getSession(false);
     session.invalidate();
 res.sendRedirect("/forum/index.jsp");


}
}
