package Servlets;

import java.io.IOException;
import java.util.ListIterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Classes.Auction;
import Classes.User;
import Managers.DBManager;

/**
 * Servlet implementation class userChangeInfo
 */
public class userEditInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public userEditInfo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)        
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		// retrieve credential and userID
		String userCred = request.getParameter("Credential");
		String message;
		User user = new User();
		
		DBManager dbm = new DBManager();
		int userID = dbm.userCredentialCheck(userCred);
		if( userID <= 0){
			System.out.println("ERROR");
			message = "\t<success>false</success>\n";
		}
		else{
			user = dbm.userGetByID(userID);
			message = "\t<success>true</success>\n" + user.toXMLContent();
		}
		
		//Write XML
		StringBuffer XMLResponse = new StringBuffer();	
		XMLResponse.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
		XMLResponse.append("<response>\n");
		XMLResponse.append(message);
		XMLResponse.append("</response>\n");
		response.setContentType("application/xml");
		response.getWriter().println(XMLResponse);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Map<String, String> parameterMap = request.getParameterMap();
		
		// retrieve credential and userID
		//String userCred = parameterMap.get("Credential").toString();
		String userCred = request.getParameter("Credential");
		boolean success;
		DBManager dbm = new DBManager();
		int userID = dbm.userCredentialCheck( userCred );
		
		if(userID <= 0){
			success = false;
		}
		else{
			String Password = request.getParameter("Password");
			String PhoneNumber = request.getParameter("PhoneNumber");
			String PhoneCarrier = request.getParameter("PhoneCarrier");
			String EmailAddress = request.getParameter("EmailAddress");
			
			// remove credential from Map
			//parameterMap.remove("Credential");
			
			// pass map to function
			success = dbm.userEditInfo( userID,Password ,PhoneNumber,PhoneCarrier, EmailAddress);
		}
		
		// Write XML to response if DB has return message
		StringBuffer XMLResponse = new StringBuffer();	
		XMLResponse.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
		XMLResponse.append("<response>\n");
		XMLResponse.append("\t<success>" + success + "</success>\n");
		XMLResponse.append("</response>\n");
		response.setContentType("application/xml");
		response.getWriter().println(XMLResponse);
		
		
	}

}
