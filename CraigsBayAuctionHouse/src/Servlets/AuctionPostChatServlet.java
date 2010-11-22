package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Managers.DBManager;

/**
 * Servlet implementation class AuctionPostChatServlet
 */
public class AuctionPostChatServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private DBManager dbm;;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AuctionPostChatServlet() {
    	super();
    	dbm = new DBManager();
       
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
		
		
		int auctionID = Integer.parseInt(request.getParameter("auctionID") );
		String userName = request.getParameter("userName");
		String text = request.getParameter("text").toString();
		
		text = userName + ": " + text + "\\n";
		
		dbm.addTextToAuctionChatLog(auctionID, userName, text);
		
	}

}
