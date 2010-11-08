package Servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.ListIterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Classes.Auction;
import Managers.DBManager;

/**
 * Servlet implementation class userViewAuctionServlet
 */
public class userViewAuctionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public userViewAuctionServlet() {
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
		
		int auctionID 		= Integer.parseInt( request.getParameter("auctionID").toString() );
		String credential	= request.getParameter("userCred").toString();
		
		DBManager dbm = new DBManager();
		
		//Get Auction
		Auction auction = dbm.auctionGetByID( auctionID );
		
		//Identify User
		int userID = dbm.userCredentialCheck( credential );
		
		//Write XML
		StringBuffer XMLResponse = new StringBuffer();	
		XMLResponse.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
		XMLResponse.append("<response>\n");
		
		
		XMLResponse.append("\t<auctionView ");
		
		if( userID == auction.ownerID ) {
			
			XMLResponse.append("owner=\"true\" bid=\"false\"");
			
		}
		else {
			if( userID <= 0 ) {
				XMLResponse.append("owner=\"false\" bid=\"false\"");
			}
			else {
				XMLResponse.append("owner=\"false\" bid=\"true\"");
			}
			
		}
				
		XMLResponse.append(">\n");

		String thisXML = auction.toXMLContent();
		XMLResponse.append( thisXML );
		
		XMLResponse.append("\t</auctionView>\n");
		XMLResponse.append("</response>\n");
		response.setContentType("application/xml");
		response.getWriter().println(XMLResponse);
		
	}

}
