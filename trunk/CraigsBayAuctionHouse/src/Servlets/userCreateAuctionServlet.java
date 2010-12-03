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
    private String expiryDate(int expiryWeek,int expiryDay, int expiryHour){
    	long expireTime = expiryTime(expiryWeek, expiryDay, expiryHour);
    	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    	Calendar cal = Calendar.getInstance();
    	cal.setTimeInMillis(expireTime);
    	return dateFormat.format(cal.getTime());
    	
    }
    
    //Method to calculate the expiry time
    private long expiryTime(int expiryWeek, int expiryDay, int expiryHour){
    	Calendar cal = Calendar.getInstance();
    	long currentTime = cal.getTimeInMillis();
    	
    	long expireTime = expiryDay + ( expiryWeek * 7);
    	expireTime = expiryHour + ( expireTime * 24 );
    	
    	expireTime = expireTime * 60 * 60 * 1000;
    	
    	return expireTime + currentTime;
    }
    
    private String getDate(){
    	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
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
		String ExpiryDate = expiryDate(Integer.parseInt(request.getParameter("ExpiryWeek")),
										Integer.parseInt(request.getParameter("ExpiryDay")),
										Integer.parseInt(request.getParameter("ExpiryHour")));
		long ExpiryTime = expiryTime(Integer.parseInt(request.getParameter("ExpiryWeek")),
										Integer.parseInt(request.getParameter("ExpiryDay")),
										Integer.parseInt(request.getParameter("ExpiryHour")));
		String Category = request.getParameter("Category").toString();
		String Description = request.getParameter("Description").toString();
		
		int auctionID = dbm.createNewAuction(AuctionTitle, Category, AuctionStatus, CreationDate, ExpiryDate, ExpiryTime, Double.parseDouble(MinPrice), OwnerID, "flickr album", Description);
		
		if(auctionID == -1){
			System.out.println("Error: createNewAuction in userCreateAuctionServlet failed");
		}
		
		// Write XML to response if DB has return message
		StringBuffer XMLResponse = new StringBuffer();
		XMLResponse.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
		XMLResponse.append("<response>\n");
		XMLResponse.append("\t<success>" + auctionID + "</success>\n");
		XMLResponse.append("</response>\n");
		response.setContentType("application/xml");
		response.getWriter().println(XMLResponse);
		
	}

}
