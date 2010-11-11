package Classes;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class User {
	
	public int userID;
	public String password;
	public String telephone;
	public String phoneCarrier;
	public String emailAddress;
	
	public User() {
		userID 		= -1;
		password = "";
		telephone	= "";
		phoneCarrier		= "";
		emailAddress	= "";
	}

	
	//TODO: make sure null entry and null value could be processed for a certain field
	public String toXMLContent() {
		
		return "\t\t<user" +
				" userID=\"" + userID + "\"" +
				" password=\"" + password + "\"" +
				" telephone=\"" + telephone + "\"" +
				" phonecarrier=\"" + phoneCarrier  + "\"" +
				" emailAddress=\"" + emailAddress + "\"" +
				"/>\n";
				
	}
}
