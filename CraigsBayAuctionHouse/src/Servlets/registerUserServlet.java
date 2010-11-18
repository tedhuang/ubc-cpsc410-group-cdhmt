package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Managers.DBManager;

/**
 * Servlet implementation class registerUserServlet
 */
public class registerUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public registerUserServlet() {
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
		boolean success;
		String Username = request.getParameter("Username");
		DBManager dbm = new DBManager();
		boolean uniqueUsername = dbm.usernameCheck(Username);
		
		if(uniqueUsername){
			String Password = request.getParameter("Password");
			String PhoneNumber = request.getParameter("PhoneNumber");
			String PhoneCarrier = request.getParameter("PhoneCarrier");
			String EmailAddress = request.getParameter("EmailAddress");

			success = dbm.userRegister(Username,Password ,PhoneNumber,PhoneCarrier, EmailAddress);
			System.out.println("Success is: "+success);
		}
		else{
			success = true;
			System.out.println("Hello Success is: "+success);
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
