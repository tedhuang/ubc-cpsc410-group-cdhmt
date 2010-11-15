package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.*;

import Managers.DBManager;

/**
 * Servlet implementation class chatRelayServlet
 */
public class chatRelayServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	int aggregatingCounter = 0;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public chatRelayServlet() {
        super();
        
        DBManager dbm = new DBManager();
        // Statement stm = dbm.createStatement();
        
        //TODO use statment without disconnecting
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
		// TODO Auto-generated method stub
		
		String addThis = request.getParameter("addThis").toString();
		
		aggregatingCounter += Integer.parseInt(addThis);
 
		System.out.println(aggregatingCounter);
		// Write XML to response if DB has return message
		StringBuffer XMLResponse = new StringBuffer();	
		XMLResponse.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
		XMLResponse.append("<response>\n");
		
		XMLResponse.append("\t<result>" + aggregatingCounter + "</result>\n");
		
		XMLResponse.append("</response>\n");
		response.setContentType("application/xml");
		response.getWriter().println(XMLResponse);
		
		
	}

}
