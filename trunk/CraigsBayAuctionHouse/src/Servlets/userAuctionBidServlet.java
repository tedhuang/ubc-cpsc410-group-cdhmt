package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Managers.DBManager;

import com.mysql.jdbc.DatabaseMetaData;

/**
 * Servlet implementation class userAuctionBidServlet
 */
public class userAuctionBidServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public userAuctionBidServlet() {
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
		
		String auctionID = request.getParameter("auctionID").toString();
		String bidAmount = request.getParameter("amount").toString(); 
		String credential = request.getParameter("userCred").toString(); 
		
		DBManager dbm = new DBManager();
		int userID = dbm.userCredentialCheck(credential);
		int result=0;
		
		if(userID <= 0)
		{
			System.out.println("error on credential check in userAuctionBidServlet");
		}
		else
		{
			result = dbm.bidOnAuction(userID, Integer.parseInt(auctionID), Double.parseDouble(bidAmount)) ;
			
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
