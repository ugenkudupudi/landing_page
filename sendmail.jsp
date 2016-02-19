<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%

/*
* Add this to web.xml 

  <!-- SMTP settings -->
    <context-param>
        <param-name>host</param-name>
        <param-value>smtpauth.net4india.com</param-value>
    </context-param>
 
    <context-param>
        <param-name>port</param-name>
        <param-value>587</param-value>
    </context-param>
 
    <context-param>
        <param-name>user</param-name>
        <param-value>ugen@resonous.com</param-value>
    </context-param>
 
    <context-param>
        <param-name>pass</param-name>
        <param-value>PASSWORD</param-value>
    </context-param>

        <context-param>
        <param-name>touser</param-name>
        <param-value>ugen@kudupudi.com</param-value>
    </context-param>

    <context-param>
        <param-name>fromuser</param-name>
        <param-value>ugen@resonous.com</param-value>
    </context-param>
 
*/
   String result = new String();
   //ServletContext context = getServletContext();

   // Recipient's email ID needs to be mentioned.
   //final String to = context.getInitParameter("touser");
   final String to = "ugen@kudupudi.com";

   // Sender's email ID needs to be mentioned
   //final String from = context.getInitParameter("fromuser");
   final String from = "hcpfeedback@hirecloud.net";

   //final String host = context.getInitParameter("host");
   final String host = "smtpauth.net4india.com";

   //final String password = context.getInitParameter("pass");
   final String password = "hcpfeedback$2015";

   //final String port = context.getInitParameter("port");
   final String port = "587";

   if (request.getParameter("email") == null || request.getParameter("message") == null)
   {
      result = "mesg.htm?type=success&message=Invalid inputs";
   }
   else
   {
   // Get system properties object
   Properties properties = System.getProperties();

   // Setup mail server
   properties.setProperty("mail.smtp.host", host);
   properties.put("mail.smtp.auth", "true"); //enable authentication

   //create Authenticator object to pass in Session.getInstance argument
   Authenticator auth = new Authenticator() {
   //override the getPasswordAuthentication method
   protected PasswordAuthentication getPasswordAuthentication() {
   return new PasswordAuthentication(from, password);
   }
   };

   // Get the default Session object.
   Session mailSession = Session.getInstance(properties, auth);

   try {
   // Create a default MimeMessage object.
   MimeMessage message = new MimeMessage(mailSession);
   // Set From: header field of the header.
   message.setFrom(new InternetAddress(from));
   // Set To: header field of the header.
   message.addRecipient(Message.RecipientType.TO,
   new InternetAddress(to));
   // Set Subject: header field
   message.setSubject("HCP contact message");
   // Now set the actual message
   String msgtxt = "Customer eMail: " + request.getParameter("email") + "\n\nCustomer Message: \n\n"+ request.getParameter("message");
   message.setText(msgtxt);
   // Send message
   Transport.send(message);
   result = "mesg.htm?type=success&message=We have received your message. Will revert back in 48 hrs.";
   }catch (MessagingException mex) {
   //mex.printStackTrace();
   result = "mesg.htm?type=success&message=Unable to send message";
   }
   }
%>
<html>
<head>
<title>hire, cloud pro - TCaaS</title>
</head>
<body>
<script language="javascript">
window.location.href = "<%out.print(result);%>";
</script>
</body>
</html>
