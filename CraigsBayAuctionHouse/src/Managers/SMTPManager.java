package Managers;

import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.Authenticator;

import java.sql.Array;
import java.util.*;

public class SMTPManager {
	
	private static final String CRAIGSBAY_EMAIL = "craigsbayauctionhouse@gmail.com";
	private static final String CRAIGSBAY_EMAIL_PW = "craigsbayrocks";
	private static final String GMAIL_SMTP_HOST = "smtp.gmail.com";
	private static final String GMAIL_PORT = "465";
	
	
	
	public SMTPManager()
	{
		//don't singleton manager classes as each user will need to make their own instance
	}
	
	public boolean sendMail(String UserName, String subject, String body)
	{
		DBManager dbm = new DBManager();
		String[] info = dbm.userGetPhoneInfo(UserName);
		String toAddress = "";
		
		if(info[0] != null && info[1] != null)
		{
			String number = info[0];
			String carrier = info[1];
			toAddress = constructAddress(number,carrier);
		}
		else
		{
			return false;
		}
		
		
		
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
		
		return true;
		
	}
	
	public String constructAddress(String number, String carrier)
	{
		if (carrier.equalsIgnoreCase("Fido"))
		{
			return number + "@fido.ca";
		}
		else if (carrier.equalsIgnoreCase("Rogers") )
		{
			return number + "@pcs.rogers.com";
		}
		else if (carrier.equalsIgnoreCase("Telus") )
		{
			return number + "@msg.telus.com";
		}
		else if (carrier.equalsIgnoreCase("Bell") )
		{
			return number + "@txt.bell.ca";
		}
		else if (carrier.equalsIgnoreCase("Virgin Mobile") )
		{
			return number + "@vmobile.ca";
		}
		else if (carrier.equalsIgnoreCase("PC Mobile") )
		{
			return number + "@mobiletxt.ca";
		}
		else if (carrier.equalsIgnoreCase("Koodo") )
		{
			return number + "@msg.koodomobile.com";
		}
		else if (carrier.equalsIgnoreCase("SaskTel") )
		{
			return number + "@sms.sasktel.com";
		}
		else if (carrier.equalsIgnoreCase("Manitoba Telecom") )
		{
			return number + "@text.mts.net";
		}
		
		return "";
	}
	
	private class SMTPAuthenticator extends javax.mail.Authenticator {
		@Override
		public PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(CRAIGSBAY_EMAIL, CRAIGSBAY_EMAIL_PW);
		}
	}
	
}
