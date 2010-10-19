package classes;

import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.Authenticator;
import java.util.*;

public class SMTPManager {
	
	private static final String CRAIGSBAY_EMAIL = "craigsbayauctionhouse@gmail.com";
	private static final String CRAIGSBAY_EMAIL_PW = "craigsbayrocks";
	private static final String GMAIL_SMTP_HOST = "smtp.gmail.com";
	private static final String GMAIL_PORT = "465";
	
	private static SMTPManager m_instance = null;
	
	
	public SMTPManager()
	{
	}
	
	public static SMTPManager getInstance()
	{
		if(m_instance == null)
		{
			m_instance = new SMTPManager();
		}
		
		return m_instance;
	}
	
	public void sendMail(String toAddress, String subject, String body)
	{
		
		Properties props = new Properties();
		props.put("mail.smtp.user", CRAIGSBAY_EMAIL);
		props.put("mail.smtp.host", GMAIL_SMTP_HOST);
		props.put("mail.smtp.port", GMAIL_PORT);
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.debug", "true");
		props.put("mail.smtp.socketFactory.port", GMAIL_PORT);
		props.put("mail.smtp.socketFactory.class",
				"javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.socketFactory.fallback", "false");

		SecurityManager security = System.getSecurityManager();

		try {
			Authenticator auth = new SMTPAuthenticator();
			Session session = Session.getInstance(props, auth);
			 session.setDebug(true);

			MimeMessage msg = new MimeMessage(session);
			msg.setText(body);
			msg.setSubject(subject);
			msg.setFrom(new InternetAddress(toAddress));
			msg.addRecipient(Message.RecipientType.TO,
					new InternetAddress(toAddress));
			Transport.send(msg);
			System.out.println("done");
		} catch (Exception mex) {
			mex.printStackTrace();
		}
		
	}
	
	private class SMTPAuthenticator extends javax.mail.Authenticator {
		@Override
		public PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(CRAIGSBAY_EMAIL, CRAIGSBAY_EMAIL_PW);
		}
	}
	
}
