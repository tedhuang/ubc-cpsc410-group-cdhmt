package Classes;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class User {
	
	public int userID;
	public String password;
	public String phoneNumber;
	public String phoneCarrier;
	public String emailAddress;
	
	public User() {
		userID 		= -1;
		password = "";
		phoneNumber	= "";
		phoneCarrier		= "";
		emailAddress	= "";
	}

	
	//TODO: make sure null entry and null value could be processed for a certain field
	public String toXMLContent() {
		
		return "\t\t<user" +
				" userID=\"" + userID + "\"" +
				" password=\"" + password + "\"" +
				" phoneNumber=\"" + phoneNumber + "\"" +
				" phonecarrier=\"" + phoneCarrier  + "\"" +
				" emailAddress=\"" + emailAddress + "\"" +
				"/>\n";
				
	}
}
