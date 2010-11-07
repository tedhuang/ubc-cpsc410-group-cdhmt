package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Managers.DBManager;

/**
 * Servlet implementation class userCreateAuctionServlet
 */
public class userCreateAuctionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public userCreateAuctionServlet() {
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
		
		String Credential = request.getParameter("Credential");
		
		DBManager dbm = new DBManager();
		
		int userID = dbm.userCredentialCheck( Credential );
		
		if( userID == -1 ) {
			//TODO: user does not exist - exit condition
			System.out.println("Error: User does not exist");
			return;
		}
		if( userID == 0 ) {
			//TODO: user is not logged in - exit condition
			System.out.println("Error: User is not logged in");
			return;
		}
		
		
		String AuctionTitle = request.getParameter("AuctionTitle").toString();
		Double MinPrice = new Double( request.getParameter("MinPrice").toString() );
		
		
		boolean success = dbm.createNewAuction(AuctionTitle, "test", MinPrice, userID, "random");
		
		if(!success){
			System.out.println("Error: createNewAuction in userCreateAuctionServlet failed");
		}
		
	}

}
