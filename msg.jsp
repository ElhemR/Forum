
<%@ page import ="java.sql.*" %>
<%@ page import="cx.Cx"%>
<html>
  <head>
<link rel="stylesheet" type="text/css" href="style/style.css">
<meta charset="UTF-8">
<title>#El_Forum</title>
 </head>
 <body>
    <div class="header" > <h1 class="title">#El_Forum
        </h1>
        <div class="menud"><button id="logIn">Go back to messages</button>  <button id="signUp" style="display:none;">f</button></div>
     </div> 

<%
Cx c = new Cx();
c.driver();
c.OpenConnexion();  
String param=request.getParameter("msgid");
int mid=Integer.parseInt(param);
String query = "SELECT * from message where id="+mid;
ResultSet rs=c.selectExec(query);  
String queryc = "SELECT count(*) from message where idc="+mid;
ResultSet rsc=c.selectExec(queryc);  
String querycmnt = "SELECT * from message where idc="+mid+" order by id desc";

ResultSet rscmnt=c.selectExec(querycmnt); 
   
   
   
%>
<div class="content" style="top:120px">
    <br>

    
<%
   if(rs.next()){%>
<span class="titlem" style="margin-left: 1cm;">  
   <% out.println(rs.getString(3));
      String nom=(String)session.getAttribute("username");
     %>
      <br>
 
          
    
       
        
   </span>  
    <hr><p >
     <% out.println(rs.getString(5));%>
     </p>
    <p class="info">
    <i>posted by:</i> <a class="mauthor"><%out.println(rs.getString(2));%></a>
                , <span class="mtime"><%out.println(rs.getTimestamp(7));%> </%out.println(rs.getTimestamp(7));%></span><br><i>Category: </i><span class="mauthor" style="color:grey"><%out.println(rs.getString(6));%></span>
    
    
    </p> 
        <%if(nom!=null){
      %>
         <button id="editMsge" style="margin-left:1cm" > Comment  </button>
        <% }%>
    <hr>
    
    <span class="mauthor" style="color:RGB(213,112,0);margin-left:1cm;">Comments(    
    <% 
      
       if(rsc.next())
       
       out.println(rsc.getInt(1));%>
        )
        </span>
        
<table style="width:100%">
    <% while(rscmnt.next()){%>  
        
        
  <tr>
    
  
        <td>
          
            <p> 
     
          <%out.println(rscmnt.getString(5));%>
            <br>
            <i>posted by:</i> <a class="mauthor"><%out.println(rscmnt.getString(2));%></a>
                , <span class="mtime"><%out.println(rscmnt.getTimestamp(7));%> </span><br>
            </p>
     </td>
        </tr>
          
      <% 
	}%>  
        
        
        
        
        
        
        
        
        
<% }%>
     </div>

         <div id="loginBoxe" class="modale">

  <!-- Modal content -->
  <div class="modal-content">
      <span class="closee">&times;</span>
     <div class="log-sections" id="postmsg">
  	<h1 style="text-align:center;color:RGB(220,92,40);">Add your comment 
         
         </h1><br>
				  <form action="addcomment.jsp" method ="post">
					
                     <input type="hidden" name="messageid" value="<%=rs.getInt(1)%>"><br>
                    <input type="hidden" name="authorm" value="<%=rs.getString(2)%>"><br>
                   <b>Content:</b><br>
                   <textarea rows="5" cols="100" name="content">
                      Add your comment here 
                      </textarea><br>
                      
                      
                      
					<center><input  type="submit" name="login" class="login loginmodal-submit" value="Add"><br>
                     </center>
                      
                      
                      
                      
                      
				  </form>
 
         <br>
         <br>
      
      
      </div>
    
  </div>

</div>  
          
          
          


<div id="loginBox" class="modale">

  <!-- Modal content -->
  <div class="modal-content">
      <span class="close">&times;</span>
     <div class="log-section">
  	<h1>Login to Your Account</h1><br>
				  <form action="/forum/servlet/Login" method ="post">
					<input type="text" name="user" placeholder="Username"><br>
					<input type="password" name="pass" placeholder="Password"><br>
					<input type="submit" name="login" class="login loginmodal-submit" value="Login"><br>
				  </form>
      
      
      </div>
    
  </div>

</div>
<div id="signupBox" class="modal">

  <!-- Modal content -->
  <div class="modal-content">
      <span class="close2">&times;</span>
     <div class="log-section">
  	<h1>Sign up for a new account</h1><br>
				  <form method="post" action="/forum/servlet/Register" name="signupform" >
					<input type="text" name="user" placeholder="Username" onfocus="checkExist()" onblur="checkExist()"><br><span id="isE"></span><br>
                      <input type="text" name="email" placeholder="Email" onblur="validEmail()"><br> <span class="msgEmail">  </span><br>
					<input type="password" name="pass" placeholder="Password"  onblur="validPassword()" >
                      <br>
                      <span class="msgPwd"></span>
                     
                      <br>
					<input type="submit" id ="submitBtn" name="login" class="login loginmodal-submit" value="Sign up" ><br>
				  </form>
      
      
      </div>
    
  </div>

</div>    
<%
    c.closeStatement();
   c.closeResultSet();
   c.closeConnection();
   %>
   
<script>
// Get the modal
var modal = document.getElementById('loginBox');
var modal2 = document.getElementById('signupBox');
// Get the button that opens the modal
var btn = document.getElementById("logIn");
    var btnn = document.getElementById("signUp");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];
var span2 = document.getElementsByClassName("close2")[0];

// When the user clicks the button, open the modal 
btn.onclick = function() {
     location.href = "/forum/user.jsp";
}
btnn.onclick = function() {
    modal2.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
    modal.style.display = "none";
}
span2.onclick = function() {
    modal2.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
function validEmail() {
       var x = document.forms["signupform"]["email"].value;
        var span = document.getElementsByClassName("msgEmail")[0];
    var atpos = x.indexOf("@");
    var dotpos = x.lastIndexOf(".");
    if (atpos<1 || dotpos<atpos+2 || dotpos+2>=x.length) {
        span.innerHTML="Please enter a valid email";
        span.style.color="red";
       
        return false;
       
    }
    else{ span.innerHTML="Your email looks good!";
           span.style.color="green";
        return true;
        }
 
}
    
function validPassword() {
       var x = document.forms["signupform"]["pass"].value;
        var span = document.getElementsByClassName("msgPwd")[0];
 
    if (x.length<6) {
        span.innerHTML="Your password should contain at least six characters";
        span.style.color="red";
        
        return false;
       
    }
    else{ span.innerHTML="Your password looks good!";
           span.style.color="green";
        return true;
        }

}
  var modale = document.getElementById('loginBoxe');
var btne = document.getElementById("editMsge");
var spane = document.getElementsByClassName("closee")[0];
    btne.onclick = function() {
    modale.style.display = "block";
}



spane.onclick = function() {
    modale.style.display = "none";
}




// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {

     if (event.target == modale) {
        modale.style.display = "none";
        
    }
}


   
    
    
</script>         
</body>
</html>