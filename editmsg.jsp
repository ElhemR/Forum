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
<div class="content" style="top:100px;">
     
      <%String param=request.getParameter("msgid"); 
int mid=Integer.parseInt(param);%>
 
	<h1 style="text-align:center;color:RGB(220,92,40);">Edit your message 
         
         </h1><br>
				  <form action="/forum/servlet/Editmsg"  method ="post">
					<b>Title:</b> <br>
                      
                     <input type="hidden" name="messageid" value='<%= mid%>'><br>
                      
                    <input type="text" name="title" ><br>
                   <b>Content:</b><br>
                   <textarea rows="5" cols="100" name="content">
                      
                      
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
     
     
     
     
     </div>
 </body>
     </html>
    
    

     

