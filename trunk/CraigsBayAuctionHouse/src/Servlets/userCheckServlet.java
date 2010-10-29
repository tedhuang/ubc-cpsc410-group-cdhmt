package Servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Managers.DBManager;

public class userCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public userCheckServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String userName = request.getParameter("userName").toString();
		String password = request.getParameter("password").toString();
		
		DBManager dbm = new DBManager();
		int checkResult = dbm.userLoginCheck(userName, password);
		
		// Write XML to response if DB has return message
		StringBuffer XMLResponse = new StringBuffer();	
		XMLResponse.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");

		XMLResponse.append("\t<result>" + checkResult + "</result>\n");
		
		if ( checkResult == -1 ) {
			XMLResponse.append("\t<message>Invalid User Credential</message>\n");
		}
		if ( checkResult == 0 ) {
			XMLResponse.append("\t<message>User "+ userName +" not logged in</message>\n");
		}
		if ( checkResult == 1 ) {
			XMLResponse.append("\t<message>User "+ userName +" is logged in</message>\n");
		}

		XMLResponse.append("</response>\n");
			
		response.setContentType("application/xml");
		response.getWriter().println(XMLResponse);
	}
}
