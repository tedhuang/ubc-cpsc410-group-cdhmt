package Servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.ListIterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Classes.Friend;
import Managers.DBManager;

/**
 * Servlet implementation class friendDeleteServlet
 */
public class friendDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public friendDeleteServlet() {
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
		int friendID = Integer.parseInt(request.getParameter("FriendID"));
		boolean success;
		DBManager dbm = new DBManager();
		int userID = dbm.userCredentialCheck( userCred );
		
		//Return error if user credential has run out or invalid user.
		if(userID <= 0){
			success = true;
		}
		else{
			success = dbm.deleteFriend(userID, friendID );
		}
		
		//Write XML
		StringBuffer XMLResponse = new StringBuffer();	
		XMLResponse.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
		XMLResponse.append("<response>\n");
		XMLResponse.append("\t<success>" + success + "</success>\n");
		XMLResponse.append("</response>\n");
		response.setContentType("application/xml");
		response.getWriter().println(XMLResponse);
	}

}
