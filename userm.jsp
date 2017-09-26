<%@ page import ="java.sql.*" %>
<%@ page import="cx.Cx"%> 
<%@ page import ="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat"%> 
<%@ page import ="java.util.Date" %>
<%@ page import ="java.text.ParseException" %>
<%
Cx c = new Cx();
c.driver();
c.OpenConnexion();   
   
       
%>
<html>
    <head>
    <link rel="stylesheet" type="text/css" href="style/style.css">
    <meta charset="UTF-8">
    <title>#El_Forum</title>
    </head>
    <body>
        <div class="menu"> llll</div>
        <div class="header" > <h1 class="title">#El_Forum </h1>
         </div> 
    <div class="menu">
        <br>
        <button id="logIn"> Post a message</button>
        <button id="allmsgs"> View all messages</button>
        
            <% String nom=(String)session.getAttribute("username");
              
          String query = "SELECT * from message where author="+"'"+nom+"'";
            ResultSet rs=c.selectExec(query);   

               
               String fl=(String)session.getAttribute("fl");
               String querynotif="SELECT * from notification where authormsg='"+nom+"' order by id desc;" ;
               ResultSet rsnotif=c.selectExec(querynotif);  
   
                 int nombrenotif=0;
               Date dat = new Date(session.getCreationTime());
            String datestr= dat.toString();
            DateFormat readFormat = new SimpleDateFormat( "EEE MMM dd HH:mm:ss z yyyy");
            DateFormat writeFormat = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss");
                   
             Date date = null;
                try {
                   date = readFormat.parse( datestr );
                } catch ( ParseException e ) {
                    e.printStackTrace();
                }

                String formattedDate = "";
                if( date != null ) {
                formattedDate = writeFormat.format( date );
                }
               
                String querynbnotif="SELECT count(*) from notification where authormsg='"+nom+"'"+"and time>'"+formattedDate+"'" ;
            
               ResultSet nbnotif=c.selectExec(querynbnotif); 
                   if(nbnotif.next()){
    
               nombrenotif=nbnotif.getInt(1);
               }
               out.println("<a href=\"javascript:void(0)\" class=\"dropbtn\" id=\"icnxt\" >"); 
                  out.println(fl);
               out.println("</a>");
            
            
               if(nombrenotif==0){
                  
               out.println("<div class=\"notif\" style=\"display:none;\">" );
                 
             out.println("</div>" );
               
               }   
               else {
               
                  
               out.println("<div class=\"notif\" style=\"display:block;\">" );
                 out.println(nombrenotif);
             out.println("</div>" );
               
               }
               
            
               out.println("<div class=\"dropdown-content\">" );
                 out.println("<center>");
               out.println(nom);
               out.println("</center>");
                 out.println("<br>");
               out.println("<center><a href=\"/forum/servlet/Logout\">");
                out.println("<br>");
             out.println("Logout");
             
               out.println("</a></center>");
    
                  out.println("<hr><br>");
               while(rsnotif.next()){
             
                out.println(rsnotif.getString(3)+" commented on a message you posted");
             
                
                %>
                 <%  String urlm="msg.jsp?msgid="+rsnotif.getInt(2);%> 
                     <a href='<%=urlm%>' style="color:RGB(203,22,30); font-weight:bold;"> Check</a>
                <%
               out.println("<br>");
               out.println("___________________________");
               out.println("<br>");
               }
            
                   
                   
                   
                   out.println("<i>You've been connected since:</i><br> "+formattedDate);
                   
            out.println("</div>");
            %>
         </div>


     
     

<div class="content" >
   
    <br><br>    
<table style="width:100%" >
    <% while(rs.next()){
       if(rs.getInt(4)==0){
       %>    
        
        
  <tr>
    
   
        <td>
           
            <%  String url="msg.jsp?msgid="+rs.getInt(1);%> 
            <a href='<%=url%>'class="titlem"> 
  
          <%out.println(rs.getString(3));%></a> <br>
          <%   String urll="deletemsg.jsp?msgid="+rs.getInt(1);
               String urle="editmsg.jsp?msgid="+rs.getInt(1);
               if(nom.equals(rs.getString(2))){
               %>
                
                
             <a id="editMsge" href='<%=urle%>'> Edit  </a><a href='<%=urll%>'> Remove</a> <br>
            
                
  <div id="loginBoxe" class="modale">

  <!-- Modal content -->
  <div class="modal-content">
      <span class="closee">&times;</span>
     <div class="log-sections" id="postmsg">
  	<h1 style="text-align:center;color:RGB(220,92,40);">Edit your message 
         
         </h1><br>
				  <form action="editmsg.jsp" method ="post">
					<b>Title:</b> <br>
                     <input type="hidden" name="messageid" value="<%=rs.getInt(1)%>"><br>
                      
                    <input type="text" name="title" placeholder="<%=rs.getString(3)%>"><br>
                   <b>Content:</b><br>
                   <textarea rows="5" cols="100" name="content"><%=rs.getString(5)%>
                      
                      
                      </textarea><br>
                       <b>Category:</b><br>
                        <select name="category" >
                         <option value="technology">Technology</option>
                         <option value="science">Sciences</option>
                         <option value="arts">Arts</option>
                         <option value="society">Society</option>
                          <option value="politics">Politics</option>
                          <option value="sports">Sports</option>
                            <option value="other">Other</option>
                          </select>
                      <br>
                    
					<center><input  type="submit" name="login" class="login loginmodal-submit" value="Edit"><br>
                     </center>  
				  </form>
 
         <br>
         <br>
      
      
      </div>
    
  </div>

</div>
   <% } else if(nom.equals("admin")){%>
                         <a href='<%=urll%>'>Remove</a> <br>
                             <% }%>
        
            <br><i>posted by:</i> <a class="mauthor"><%out.println(rs.getString(2));%></a>
                , <span class="mtime"><%out.println(rs.getTimestamp(7));%> </%out.println(rs.getTimestamp(7));%></span><br><i>Category: </i><span class="mauthor" style="color:grey"><%out.println(rs.getString(6));%></span>
            
     </td>
            
                
                
                 
     <td class="ccmnt" >

        <% 
      String queryc = "SELECT count(*) from message where idc="+rs.getInt(1);
      ResultSet rsc=c.selectExec(queryc);  
                         if(rsc.next())
       
       out.println(rsc.getInt(1));%>
               </td>
       
            
         
        </tr>
          
      <% 
	}}%>

      
  
  

</table>
                                
<%
   c.closeStatement();
   c.closeResultSet();
   c.closeConnection();
%>
    
    
<div id="loginBox" class="modal">

  <!-- Modal content -->
  <div class="modal-content">
      <span class="close">&times;</span>
     <div class="log-sections" id="postmsg">
  	<h1 style="text-align:center;color:RGB(220,92,40);">Post a message</h1><br>
         
         
				  <form action="/forum/servlet/Postmsg" method ="post">
					<b>Title:</b> <br>
                    <input type="text" name="title" placeholder="Title of your message"><br>
                   <b>Content:</b><br>
                   <textarea rows="5" cols="100" name="content">Enter text here...</textarea><br>
                       <b>Category:</b><br>
                        <select name="category">
                         <option value="technology">Technology</option>
                         <option value="science">Sciences</option>
                         <option value="arts">Arts</option>
                         <option value="society">Society</option>
                          <option value="politics">Politics</option>
                          <option value="sports">Sports</option>
                            <option value="other">Other</option>
                          </select>
                      <br>
                      
                      
					<center><input  type="submit" name="login" class="login loginmodal-submit" value="Post"><br>
                     </center>
                      
                      
                      
                      
                      
				  </form>
 
         <br>
         <br>
      
      
      </div>
    
  </div>

</div>

    
    
    

    
      
    
    
    
     </div>


<script>
    var modall = document.getElementsByClassName('dropdown-content')[0];
    var modalnotif = document.getElementsByClassName('notif')[0];
    var btnn = document.getElementsByClassName("dropbtn")[0];


    btnn.onclick = function() {
        
        if( modall.style.display == "none")
        modall.style.display = "block";
        else  modall.style.display = "none";
        
        modalnotif.style.display = "none";
    }


   


var modal = document.getElementById('loginBox');
var btn = document.getElementById("logIn");


var span = document.getElementsByClassName("close")[0];
var spane = document.getElementsByClassName("closee")[0];
btn.onclick = function() {
    modal.style.display = "block";
}



// When the user clicks on <span> (x), close the modal
span.onclick = function() {
    modal.style.display = "none";
}




// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
        
    }

        document.getElementById("allmsgs").onclick = function () {
        location.href = "/forum/user.jsp";
    };
    
}


    
    
    
    
    </script>


    </body>
    </html>