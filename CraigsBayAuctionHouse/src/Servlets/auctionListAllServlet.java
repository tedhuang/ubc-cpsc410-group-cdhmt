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
 * Servlet implementation class listAuctionsServlet
 */
public class auctionListAllServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public auctionListAllServlet() {
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
		
		ArrayList<Auction> auctionList = new ArrayList<Auction>();
		
		DBManager dbm = new DBManager();
		
		//Check whether the request is for all auctions or a search
		if( request.getParameter("SearchTitle") == null){
			auctionList = dbm.auctionListAll();
		}
		else{
			String SearchTitle = request.getParameter("SearchTitle");
			String SearchCategory = request.getParameter("SearchCategory");
			String SearchOwner = request.getParameter("SearchOwner");
			auctionList = dbm.searchAuctionResults(SearchTitle, SearchCategory, SearchOwner);
		}
		
		
		
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
