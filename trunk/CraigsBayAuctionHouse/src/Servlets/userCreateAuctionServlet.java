package Servlets;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

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
	
	//Method to calculate expiry date
    private String expiryDate(int auctionLength){
    	DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
    	Calendar cal = Calendar.getInstance();
    	cal.add(Calendar.DATE, auctionLength);
    	return dateFormat.format(cal.getTime());
    	
    }
    
    private String getDate(){
    	DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
    	Calendar cal = Calendar.getInstance();
    	return dateFormat.format(cal.getTime());
    }
       
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
		
		
		
		//Data for new auction
		String AuctionTitle = request.getParameter("AuctionTitle").toString();
		int OwnerID = userID;
		String MinPrice = request.getParameter("MinPrice").toString();
		String AuctionStatus = "Open";
		String CreationDate = getDate();
		String ExpiryDate = expiryDate(Integer.parseInt(request.getParameter("ExpiryDate")));
		String Category = request.getParameter("Category").toString();
		
		boolean success = dbm.createNewAuction(AuctionTitle, Category, AuctionStatus, CreationDate, ExpiryDate, Double.parseDouble(MinPrice), OwnerID, "flickr album");;
		
		if(!success){
			System.out.println("Error: createNewAuction in userCreateAuctionServlet failed");
		}
		
	}

}
