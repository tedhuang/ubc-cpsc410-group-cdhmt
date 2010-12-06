package Managers;

import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.Authenticator;

import java.sql.Array;
import java.util.*;

/*
 * This class deals with authenticating with Gmail's SSL and sending text messages to specific phone carriers
 * Sends SMS message with source CraigsBayAuctionHouse@Gmail.com
 * Currently sends a message for auctions expiring, and the initial bid for all auctions.
 */
public class SMTPManager {
	
	private static final String CRAIGSBAY_EMAIL = "craigsbayauctionhouse@gmail.com";
	private static final String CRAIGSBAY_EMAIL_PW = "craigsbayrocks";
	private static final String GMAIL_SMTP_HOST = "smtp.gmail.com";
	private static final String GMAIL_PORT = "465";
	
	private DBManager dbm = null;
	
	public SMTPManager()
	{
		 dbm = new DBManager();
	}
	
	//if winnerID = 0, means nobody won the auction (no bids)
	public boolean sendMail(int ownerID, int winnerID, String auctionTitle, boolean isExpiredAuction)
	{
		
		String[] ownerinfo = dbm.userGetPhoneInfo(ownerID);
		String[] winnerInfo = null;
		
		if(winnerID != 0)
		{
			winnerInfo = dbm.userGetPhoneInfo(winnerID);
		}
		
		String toOwnerAddress = "";
		
		if(ownerinfo[0] != null && ownerinfo[1] != null)
		{
			String number = ownerinfo[0];
			String carrier = ownerinfo[1];
			toOwnerAddress = constructAddress(number,carrier);
		}

		String toWinnerAddress = "";
		
		if(winnerInfo != null && winnerInfo[0] != null && winnerInfo[1] != null)
		{
			String number = winnerInfo[0];
			String carrier = winnerInfo[1];
			toWinnerAddress = constructAddress(number,carrier);
		}
		
		if(isExpiredAuction)
		{
			String body="";
			if(toOwnerAddress.length()>0)
			{
				if(winnerInfo == null)
				{
					body = "CraigsBay - Auction Expired without any bidders: " + auctionTitle;
				}
				else
				{
					body = "CraigsBay - A winner been found for your auction of: " + auctionTitle;
				}
					
				send(toOwnerAddress, auctionTitle, body );
			}
			
			
			if(toWinnerAddress.length() > 0)
			{
				body = "CraigsBay - You have succesfully won: " + auctionTitle;
				send(toWinnerAddress, auctionTitle, body);
			}
			
			
		}
		else //a text to owner for a new bid
		{
			if(toOwnerAddress.length() > 0)
			{
				String body = "Craigs Bay - New bid for your auction of : " + auctionTitle;
				send(toOwnerAddress, auctionTitle, body );
			}
			
		}
		
		return true;

	}
	
	private boolean send(String address, String title, String body)
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
			msg.setSubject(title);
			msg.setFrom(new InternetAddress(address));
			msg.addRecipient(Message.RecipientType.TO,
					new InternetAddress(address));
			Transport.send(msg);
			System.out.println("done");
		} catch (Exception mex) {
			mex.printStackTrace();
		}
		
		return true;
		
	}
	
	//Dependant on the user's phone carrier
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
