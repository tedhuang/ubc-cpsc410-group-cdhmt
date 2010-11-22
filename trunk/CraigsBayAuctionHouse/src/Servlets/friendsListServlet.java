package Servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.ListIterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Classes.Auction;
import Classes.Friend;
import Managers.DBManager;

/**
 * Servlet implementation class friendsList
 */
public class friendsListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public friendsListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userCred = request.getParameter("Credential");
		boolean success;
		ArrayList<Friend> friendList = new ArrayList<Friend>();
		DBManager dbm = new DBManager();
		int userID = dbm.userCredentialCheck( userCred );
		
		if(userID <= 0){
			success = false;
		}
		else{
			friendList = dbm.getFriends(userID);
			success = true;
		}
		
		//Write XML
		StringBuffer XMLResponse = new StringBuffer();	
		XMLResponse.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
		XMLResponse.append("<response>\n");
		XMLResponse.append("\t<success>" + success + "</success>\n");
		XMLResponse.append("\t<friendList>\n");
		
		ListIterator<Friend> friendListIterator = friendList.listIterator();
		
		while( friendListIterator.hasNext() ) {
			String thisXML = friendListIterator.next().toXMLContent();
			XMLResponse.append( thisXML );
		}
		XMLResponse.append("\t</friendList>\n");
		XMLResponse.append("</response>\n");
		response.setContentType("application/xml");
		response.getWriter().println(XMLResponse);
	}

}
