
            
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
            	
            String admin_id=(String)session.getAttribute("admin_id");
            if(admin_id!=null)
            {	
            %>
            	<p>
            	<span>Welcome 
            	<% out.print(admin_id); %>!</span>
            	<span><a href="logout.jsp">Logout</a></span>
            	</p>
            <%
            }
            else
            {
            %>
            <form action="verify" method="post">
            <span>Admin Id: </span><span><input type="text" name="user"/></span>
            <span>Password:</span><span><input type="password" name="password" /></span>
            <input type="hidden" name="admin" value="true" />
            <input id="button" type="submit" value="Login" />
        </form>
            <%
            }
            %>

            </div>
			<hr />
