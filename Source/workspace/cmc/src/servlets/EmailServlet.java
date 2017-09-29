package servlets;


import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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

import authentication.hash;
import databasepools.c3p0pooledconnection;

@WebServlet("/EmailServlet")

public class EmailServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void processRequest(HttpServletRequest request, 
                                  HttpServletResponse response)
                   throws IOException, ServletException, NoSuchAlgorithmException {

		String to = null;
		String from="chessmastersclub123@gmail.com";
		Integer newpass;
		int rs=0;
		
	
		
		newpass=(int)(1010101*Math.random());
		String pass1 = newpass.toString();
		String pass= hash.hashme(pass1);
        
        c3p0pooledconnection c = new c3p0pooledconnection() ;
		 Connection conn = c.create() ;

        String user = request.getParameter("uname");
        
        String q="update user set password='"+pass+"'"+" where username='"+user+"'";
        try {
			Statement stmt  = conn.createStatement() ;
			rs  = stmt.executeUpdate(q);
			
			}
        catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		//	System.out.println("username incorrect");
		}
		
        if(rs>0)
        {
        String query="select email from user where username=" +"'"+user+"'and is_verified='1'";
        try {
			Statement state  = conn.createStatement() ;
			ResultSet res  = state.executeQuery(query);
			
			if(res.next()){
				to = res.getString(1) ; 
				
			}
			
		
        }
        catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("username incorrect");
		}
			
        

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
                                     new InternetAddress(to));
            // Set Subject: header field
            message.setSubject("Password for your cmc account");
            
            String msgtext="Username:"+user+"<br>New Password:"+newpass;

            // Send the actual HTML message, as big as you like
            message.setContent(msgtext,"text/html" );
            // Send message
          
            
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
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
		String message="New password has been sent to "+to+".";
        request.setAttribute("message", message);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/status.jsp");
            dispatcher.forward(request, response);

    }
	}

    private class SMTPAuthenticator extends Authenticator {

        private PasswordAuthentication authentication;

        public SMTPAuthenticator(String login, String password) {
            authentication = new PasswordAuthentication(login, password);
        }

        protected PasswordAuthentication getPasswordAuthentication() {
            return authentication;
        }
    }

    protected void doGet(HttpServletRequest request, 
                         HttpServletResponse response)
                   throws ServletException, IOException {
        try {
			processRequest(request, response);
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

    protected void doPost(HttpServletRequest request, 
                          HttpServletResponse response)
                   throws ServletException, IOException {
        try {
			processRequest(request, response);
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
}