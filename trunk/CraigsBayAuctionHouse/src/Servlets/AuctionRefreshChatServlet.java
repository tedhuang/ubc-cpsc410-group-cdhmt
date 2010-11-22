package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Managers.DBManager;

/**
 * Servlet implementation class AuctionRefreshChatServlet
 */
public class AuctionRefreshChatServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DBManager dbm;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AuctionRefreshChatServlet() {
        super();
       dbm = new DBManager();
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
		
		int auctionID 	= Integer.parseInt( request.getParameter("auctionID").toString() );
		
		String chatLog = dbm.getTextFromAuctionChatLog(auctionID);
		if(chatLog == null)
		{
			chatLog = "";
		}
		
		StringBuffer XMLResponse = new StringBuffer();	
		XMLResponse.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
		XMLResponse.append("<response>\n");
		XMLResponse.append("\t<chatLog>" + chatLog + "</chatLog>");
		XMLResponse.append("</response>\n");
		response.setContentType("application/xml");
		response.getWriter().println(XMLResponse);
	}

}
