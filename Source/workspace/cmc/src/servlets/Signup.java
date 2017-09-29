package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Properties;

import javax.mail.AuthenticationFailedException;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import authentication.hash;
import databasepools.c3p0pooledconnection;
/**
 * Servlet implementation class for Servlet: Signup
 *
 */
@WebServlet("/Signup")
 public class Signup extends HttpServlet 
 {
   static final long serialVersionUID = 1L;
   
    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public Signup() {
		super();
	}   	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}  	
	
	

	private class SMTPAuthenticator extends Authenticator 
	{

        private PasswordAuthentication authentication;

        public SMTPAuthenticator(String login, String password) {
            authentication = new PasswordAuthentication(login, password);
        }

        protected PasswordAuthentication getPasswordAuthentication() {
            return authentication;
        }

	}
	

	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		c3p0pooledconnection c  = new c3p0pooledconnection() ;
		Connection conn = c.create() ;
		response.setContentType("text/html");
		//PrintWriter out = response.getWriter();
		int rs=0,res=0;
		Integer act=(int)(101010*Math.random());
		String key=act.toString();
		String from="chessmastersclub123@gmail.com";
		
		
		HttpSession se=request.getSession(false);
		String key1=(String)se.getAttribute("key");
		String number = request.getParameter("number");
	
		if(key1.compareTo(number)==0)			
		{
		
			
			String u=request.getParameter("uname");
			String f=request.getParameter("fname");
			String l=request.getParameter("lname");
			String pw=request.getParameter("password");
			String e=request.getParameter("email");
			String ph=request.getParameter("phone");
			String cy=request.getParameter("country");
			String s=request.getParameter("sex");
			String d=request.getParameter("desc");
			String dob1=request.getParameter("dob1");
			String dob2=request.getParameter("dob2");
			String dob3=request.getParameter("dob3");
			String dob=dob1+"-"+dob2+"-"+dob3;
			String r="1200";
			if(dob1=="" || dob2=="" || dob3 =="") dob=null;
			/*out.println(u);
			out.println(f);
			out.println(l);
			out.println(e);
			out.println(pw);
			out.println(ph);
			out.println(cy);
			out.println(s);
			out.println(d);
			out.println(dob);
			*/
			try
			{
				String pass = hash.hashme(pw);
				
				String query1="insert into user (username, email, password, fname, lname, mobile_no ,country, gender,dob,desc,rating) values(?,?,?,?,?,?,?,?,?,?,?)";
				String query2="insert into activation (username, activation) values(?,?)";
				 try {
						PreparedStatement stmt  = conn.prepareStatement(query1) ;
						stmt.setString(1,u) ; 
						stmt.setString(2,e) ;
						stmt.setString(3,pass) ;
						stmt.setString(4,f) ;
						stmt.setString(5,l) ;
						stmt.setString(6,ph) ;
						stmt.setString(7,cy) ;
						stmt.setString(8,s) ;
						stmt.setString(9,dob) ;
						stmt.setString(10,d) ;
						stmt.setString(11,r) ;
						
						rs=stmt.executeUpdate();	
						
						PreparedStatement stmt2  = conn.prepareStatement(query2) ;
						stmt2.setString(1,u) ; 
						stmt2.setString(2,key) ;
					
						
						res=stmt2.executeUpdate();	
				 	}
					 catch(Exception ex)
					 {
						 ex.printStackTrace() ;
					 }
					 
				}
				catch(Exception exc)
				{
					exc.printStackTrace();
				}
				
		
						if(rs>0 && res>0)
						{
							 try {
						            Properties props = new Properties();
						            props.setProperty("mail.host", "smtp.gmail.com");
						            props.setProperty("mail.smtp.port", "587");
						            props.setProperty("mail.smtp.auth", "true");
						            props.setProperty("mail.smtp.starttls.enable", "true");

						            Authenticator auth = new SMTPAuthenticator("chessmastersclub123@gmail.com", "cmccmccmc");

						            Session session = Session.getInstance(props, auth);
						            
						            MimeMessage message = new MimeMessage(session);
						            
						            // Set From: header field of the header.
						            message.setFrom(new InternetAddress(from));
						            
						            // Set To: header field of the header.
						            message.addRecipient(Message.RecipientType.TO,
						                                     new InternetAddress(e));
						            
						            // Set Subject: header field
						            message.setSubject("Activation link for your cmc account");
						            
						            String msgtext="username : " +
						            				u + " password : " + pw +
						            				" Follow this link to activate your account : " +
						            				"localhost:8080/cmc/Activate?username="+u+"&key="+key;

						            // Send the actual HTML message, as big as you like
						            message.setContent(msgtext,"text/html" );
						            // Send message
						          
						            
						            message.addRecipient(Message.RecipientType.TO, new InternetAddress(e));
						            Transport.send(message);
						     


						        } catch (AuthenticationFailedException ex) {
						            request.setAttribute("ErrorMessage", "Authentication failed");

						            RequestDispatcher dispatcher = request.getRequestDispatcher("/status.jsp");
						            dispatcher.forward(request, response);

						        } catch (AddressException ex) {
						            request.setAttribute("ErrorMessage", "Wrong email address");

						            RequestDispatcher dispatcher = request.getRequestDispatcher("/status.jsp");
						            dispatcher.forward(request, response);

						        } catch (MessagingException ex) {
						            request.setAttribute("ErrorMessage", ex.getMessage());

						            RequestDispatcher dispatcher = request.getRequestDispatcher("/status.jsp");
						            dispatcher.forward(request, response);
						        }
								String message="Activation link has been sent to "+e+".";
						        request.setAttribute("message", message);
						        RequestDispatcher dispatcher = request.getRequestDispatcher("/status.jsp");
						            dispatcher.forward(request, response);

					    }
			
			
		}
		else{
		//System.out.print("You have entered wrong verification code!! <br> Please go back and enter proper value.");
		request.setAttribute("error","You have entered wrong verification code!! <br> Please go back and enter proper value.");
		 RequestDispatcher dispatcher = request.getRequestDispatcher("/signup.jsp");
         dispatcher.forward(request, response);
		}
		
		
		
		
		
		 
	}
 }