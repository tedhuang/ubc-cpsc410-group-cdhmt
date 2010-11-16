package Servlets;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Managers.DBManager;

/**
 * Servlet implementation class auctionChangeStatusServlet
 */
public class auctionChangeStatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public auctionChangeStatusServlet() {
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
		// TODO Auto-generated method stub

		String auctionID = request.getParameter("auctionID").toString();
		String status = request.getParameter("auctionStatus").toString(); 
		String credential = request.getParameter("userCred").toString(); 
		
		//Check if status argument is valid
		if( !( status.equalsIgnoreCase( "CLOSED" ) ||
			   status.equalsIgnoreCase( "OPEN" )||
			   status.equalsIgnoreCase( "EXPIRED" ) ) )
		{
			System.out.println("Invalid state change");
		} 
		
		
		DBManager dbm = new DBManager();
		int userID = dbm.userCredentialCheck(credential);
		int result=0;
		
		if(userID <= 0)
		{
			System.out.println("error on credential check in userAuctionBidServlet");
		}
		else
		{
			//Handle the status change
			result = dbm.auctionChangeStatus(auctionID, status);
			
		}
		
		StringBuffer XMLResponse = new StringBuffer();	
		XMLResponse.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
		XMLResponse.append("<response>\n");
		
		XMLResponse.append("\t<success>" + result + "</success>\n");
		
		XMLResponse.append("</response>\n");
		response.setContentType("application/xml");
		response.getWriter().println(XMLResponse);
	
	
	}
}
