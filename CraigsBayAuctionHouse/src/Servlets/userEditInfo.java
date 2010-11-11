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
		User user = new User();
		
		DBManager dbm = new DBManager();
		int userID = dbm.userCredentialCheck(userCred);
		if( userID <= 0){
			// TODO do error code
		}
		else{
			user = dbm.userGetByID(userID);
			
			//Write XML
			StringBuffer XMLResponse = new StringBuffer();	
			XMLResponse.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
			XMLResponse.append("<response>\n");
			XMLResponse.append(user.toXMLContent());
			XMLResponse.append("</response>\n");
			response.setContentType("application/xml");
			response.getWriter().println(XMLResponse);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Map<String, String> parameterMap = request.getParameterMap();
		
		// retrieve credential and userID
		String userCred = parameterMap.get("credential").toString();
		
		DBManager dbm = new DBManager();
		int userID = dbm.userCredentialCheck( userCred );
		
		// remove credential from Map
		parameterMap.remove("credential");
		
		// pass map to function
		dbm.userEditInfo( userID, parameterMap );
		
		
	}

}
