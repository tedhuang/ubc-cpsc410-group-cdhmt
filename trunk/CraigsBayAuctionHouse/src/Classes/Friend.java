package Classes;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Friend {
	
	public int		friendID;
	public String	friendName;
	
	public Friend() {
		friendID 	= -1;
		friendName 	= "";
	}

	
	//TODO: make sure null entry and null value could be processed for a certain field
	public String toXMLContent() {
		
		return "\t\t<friend" +
				" friendID=\"" + friendID + "\"" +
				" friendName=\"" + friendName + "\"" +
				"/>\n";
	}
}
