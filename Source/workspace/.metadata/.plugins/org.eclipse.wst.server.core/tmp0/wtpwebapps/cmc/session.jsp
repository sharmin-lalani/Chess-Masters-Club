
            
			<h1><a>CHESS MASTERS CLUB<span></span></a></h1>
			<hr />
            <div class="toplink">

            	<%
            	//session.setAttribute("username",null);
            	
            	String error=(String)session.getAttribute("Error");
            	/*if(error!=null)
            		{
            		out.print(error);
            		session.setAttribute("error",null);
            		}
            	*/
            	
            String username=(String)session.getAttribute("username");
            if(username!=null)
            {	
            %>
            	<p>
            	<span>Welcome 
            	<a style="font-weight: bold; font-size:16px;" href="profile.jsp?username=<% out.print(username); %>">
            	<% out.print(username); %></a>!</span>
            	<span><a href="logout.jsp">Logout</a></span>
            	</p>
            <%
            }
            else
            {
            %>
            <form action="verify" method="post">
            <span>Username: </span><span><input type="text" name="user"  required="required"/></span>
            <span>Password:</span><span><input type="password"  name="password"  required="required" /></span>
            <input id="button" type="submit" value="Login" />
        </form>
        <span>
        <a href="forgotpassword.jsp">Forgot password?Reset</a></span>
        <span>Not a member yet?
        <a href="signup.jsp">Signup</a></span>
            <%
            }
            %>

            </div>
			<hr />
