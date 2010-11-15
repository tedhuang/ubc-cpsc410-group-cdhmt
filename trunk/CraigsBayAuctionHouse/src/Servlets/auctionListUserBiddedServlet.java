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
 * Servlet implementation class auctinListUserBiddedServlet
 */
public class auctionListUserBiddedServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public auctionListUserBiddedServlet() {
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
		
		ArrayList<Auction> auctionList = new ArrayList<Auction>();
		
		DBManager dbm = new DBManager();

		int userID = dbm.userCredentialCheck( userCred );
		
		auctionList = dbm.auctionListBiddedByUser( userID );
		
		
		//Write XML
		StringBuffer XMLResponse = new StringBuffer();	
		XMLResponse.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
		XMLResponse.append("<response>\n");
		
		
		XMLResponse.append("\t<auctionsList>\n");
		
		ListIterator<Auction> auctionListIterator = auctionList.listIterator();
		
		//TODO: make each auctiontable entry different element
		while( auctionListIterator.hasNext() ) {
			String thisXML = auctionListIterator.next().toXMLContent();
			XMLResponse.append( thisXML );
		}
		
		//TODO: XMLResponse.append();
		XMLResponse.append("\t</auctionsList>\n");
		XMLResponse.append("</response>\n");
		response.setContentType("application/xml");
		response.getWriter().println(XMLResponse);
	}

}
