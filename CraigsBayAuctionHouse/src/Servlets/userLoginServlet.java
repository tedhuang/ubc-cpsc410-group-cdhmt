package Servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Classes.Credential;

import Managers.DBManager;

public class userLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public userLoginServlet() {
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
		
		System.out.println("user="+ userName+ "Password="+ password);

		
		DBManager dbm = new DBManager();
		
		
		Credential userCred = new Credential(userName, password);
		
		dbm.userLogin(userName, password);
		
		// Write XML to response if DB has return message
//		StringBuffer XMLResponse = new StringBuffer();	
//		XMLResponse.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
//		XMLResponse.append("<response>\n");
//		XMLResponse.append("\t<toAddress>" + toAddress + "</toAddress>\n");
//		XMLResponse.append("\t<subject>" + subject + "</subject>\n");
//		XMLResponse.append("\t<body>" + body + "</body>\n");
//		XMLResponse.append("</response>\n");
//			
//		response.setContentType("application/xml");
//		response.getWriter().println(XMLResponse);
	}

}