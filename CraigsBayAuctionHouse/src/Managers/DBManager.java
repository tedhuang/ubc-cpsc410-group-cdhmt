package Managers;

import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.Map;

import Classes.Auction;
import Classes.Credential;
import Classes.User;
import DBConnection.DBConn;

public class DBManager {
	
	private Connection m_conn;
	
	protected ResultSet rs;
	protected Statement stm;
	
	// login will expire in 15 min with no action - milliseconds
	private final long loginExpireTime = 1000 * 60 * 15; 
	
	public DBManager()
	{
		
		try {
			m_conn = new DBConn().getDBConnection();
			
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public int createNewAuction(String auctionName, String category, String auctionStatus, String creationDate, String expiryDate, long expiryTime, Double minPrice, int ownerID, String flickrAlbumID   )
	{
		try {
			stm = m_conn.createStatement();
			String query = "INSERT INTO AuctionsTable(AuctionTitle, Category, AuctionStatus, " +
								"ExpiryDate, AuctionExpireTime, CreationDate, OwnerID, MinPrice, LatestBidPrice, FlickerAlbumID) VALUES" +
								"('" + auctionName + "' , '" + category + "' , '" + auctionStatus +
								"' , '"  + expiryDate + "' , '" + expiryTime + "' , '" + creationDate + 
								"' , '" + ownerID + "' , '" + minPrice + "' , '" + minPrice + "' , '" + flickrAlbumID + "')"; 
			
			System.out.println("Creating new auction : " + query);
			
			int success = stm.executeUpdate(query);
			stm.close();
			return success;
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		
		return -1;
	}
	
	public int auctionChangeStatus(String auctionID, String status){
		
		try{
			stm = m_conn.createStatement();
			
			String query = "UPDATE " + "AuctionsTable" +
							" SET auctionStatus='" + status +
							"' WHERE auctionID=" + auctionID;

			boolean success = stm.execute(query);
			if(success)
			{
				return 1;
			}
			
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		
		
		return 0;
	}
	
	public ArrayList<Auction> searchAuctionResults(String searchTitle, String searchCategory, String SearchOwner)
	{
		ArrayList<Auction> auctionList = new ArrayList<Auction>();
		
		try {
			stm = m_conn.createStatement();
			
			String query = "SELECT * FROM AuctionsTable "
							+ "WHERE AuctionTitle LIKE '" + searchTitle + "%' " +
							" AND AuctionExpireTime>" + Calendar.getInstance().getTimeInMillis(); 
							//+ "AND Category = '" + searchCategory + "' " + 
							//"AND OwnerID = (SELECT UserID FROM UserTable WHERE UserName = '" + SearchOwner + "')";
			
			boolean success = stm.execute(query);
			
			ResultSet result = stm.getResultSet();
			
			while( result.next() ) {
				Auction tempAuction = new Auction();
				
				tempAuction.auctionTitle = result.getString("AuctionTitle");
				tempAuction.auctionID = result.getInt("AuctionID");

				tempAuction.expiryDate = result.getString("ExpiryDate");
				tempAuction.creationDate = result.getString("CreationDate");
				tempAuction.category = result.getString("Category");
				tempAuction.ownerID = result.getInt("OwnerID");
				tempAuction.lastBidderID = result.getInt("lastBidderID");
				tempAuction.minPrice = result.getDouble("MinPrice");
				tempAuction.latestBidPrice = result.getDouble("LatestBidPrice");
				tempAuction.bidCounter = result.getInt("BidCounter");
				tempAuction.auctionStatus = result.getString("auctionStatus");
				tempAuction.flickerAlbumID = result.getString("flickerAlbumID");
				tempAuction.numberOfViews = result.getInt("numberOfViews");
				
				auctionList.add( tempAuction );
				
			}
			

			stm.close();
			
			System.out.println("Searched Auctions");
			return auctionList;
			
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		
		
		return null;
			
		}
	

	public ArrayList<Auction> auctionListAll() //TODO: change the name of this method to something like "makeAuctionList"
	{
		ArrayList<Auction> auctionsList = new ArrayList<Auction>();
		
		try {
			stm = m_conn.createStatement();
			
			String query = "SELECT *" + 
								" FROM AuctionsTable" +
								" WHERE AuctionStatus='OPEN'" +
								" AND AuctionExpireTime>" + Calendar.getInstance().getTimeInMillis(); //Only pull auctions that have status OPEN

			System.out.println("Retrieving Auctions List : " + query);
			
			//TODO: figure out if we need a success check here
			boolean success = stm.execute(query);
			
			ResultSet result = stm.getResultSet();
			
			while( result.next() ) {
				Auction tempAuction = new Auction();
				
				tempAuction.auctionTitle = result.getString("AuctionTitle");
				tempAuction.auctionID = result.getInt("AuctionID");
				
				
				tempAuction.expiryDate = result.getString("ExpiryDate");
				tempAuction.creationDate = result.getString("CreationDate");
				tempAuction.category = result.getString("Category");
				tempAuction.ownerID = result.getInt("OwnerID");
				tempAuction.lastBidderID = result.getInt("lastBidderID");
				tempAuction.minPrice = result.getDouble("MinPrice");
				tempAuction.latestBidPrice = result.getDouble("LatestBidPrice");
				tempAuction.bidCounter = result.getInt("BidCounter");
				tempAuction.auctionStatus = result.getString("auctionStatus");
				tempAuction.flickerAlbumID = result.getString("flickerAlbumID");
				tempAuction.numberOfViews = result.getInt("numberOfViews");
				//TODO do we need to extract AuctionExpiryTime
				
				auctionsList.add( tempAuction );
				
			}
			

			stm.close();
			
			return auctionsList;
			
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		
		
		return null;
		
		
	}
	
	public ArrayList<Auction> auctionListPostedByUser( int userID )
	{
		
		ArrayList<Auction> auctionsList = new ArrayList<Auction>();
		
		try {
			stm = m_conn.createStatement();
			
			String query = "SELECT  * FROM AuctionsTable" +
								" WHERE OwnerID=" + userID +
								" AND AuctionStatus<>'CLOSED'"; 
			
			System.out.println("Retrieving Auctions Owned by User : " + query);
			
			//TODO: figure out if we need a success check here
			boolean success = stm.execute(query);
			
			ResultSet result = stm.getResultSet();
			
			while( result.next() ) {
				Auction tempAuction = new Auction();
				
				tempAuction.auctionTitle = result.getString("AuctionTitle");
				tempAuction.auctionID = result.getInt("AuctionID");

				tempAuction.expiryDate = result.getString("ExpiryDate");
				tempAuction.creationDate = result.getString("CreationDate");
				tempAuction.category = result.getString("Category");
				tempAuction.ownerID = result.getInt("OwnerID");
				tempAuction.lastBidderID = result.getInt("lastBidderID");
				tempAuction.minPrice = result.getDouble("MinPrice");
				tempAuction.latestBidPrice = result.getDouble("LatestBidPrice");
				tempAuction.bidCounter = result.getInt("BidCounter");
				tempAuction.auctionStatus = result.getString("auctionStatus");
				tempAuction.flickerAlbumID = result.getString("flickerAlbumID");
				tempAuction.numberOfViews = result.getInt("numberOfViews");
				
				auctionsList.add( tempAuction );
				
			}
			

			stm.close();
			
			return auctionsList;
			
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		
		
		return null;
		
		
	}
	
	public ArrayList<Auction> auctionListBiddedByUser( int userID )
	{
		
		ArrayList<Auction> auctionsList = new ArrayList<Auction>();
		
		try {
			stm = m_conn.createStatement();
			
			String query = "SELECT  * FROM UserBidsTable, AuctionsTable" +
								" WHERE AuctionsTable.AuctionID=UserBidsTable.AuctionID" +
								" AND UserBidsTable.UserID=" + userID +
								" AND AuctionsTable.AuctionStatus<>'CLOSED'"; 
			
			System.out.println("Retrieving Bid History of User : " + query);
			
			//TODO: figure out if we need a success check here
			boolean success = stm.execute(query);
			
			ResultSet result = stm.getResultSet();
			
			while( result.next() ) {
				Auction tempAuction = new Auction();
				
				tempAuction.auctionTitle = result.getString("AuctionTitle");
				tempAuction.auctionID = result.getInt("AuctionID");

				tempAuction.expiryDate = result.getString("ExpiryDate");
				tempAuction.creationDate = result.getString("CreationDate");
				tempAuction.category = result.getString("Category");
				tempAuction.ownerID = result.getInt("OwnerID");
				tempAuction.lastBidderID = result.getInt("lastBidderID");
				tempAuction.minPrice = result.getDouble("MinPrice");
				tempAuction.latestBidPrice = result.getDouble("LatestBidPrice");
				tempAuction.bidCounter = result.getInt("BidCounter");
				tempAuction.auctionStatus = result.getString("auctionStatus");
				tempAuction.flickerAlbumID = result.getString("flickerAlbumID");
				tempAuction.numberOfViews = result.getInt("numberOfViews");
				
				auctionsList.add( tempAuction );
				
			}
			

			stm.close();
			
			return auctionsList;
			
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		
		
		return null;
		
		
	}
	
	public Auction auctionGetByID( int auctionID ) //TODO: change the name of this method to something like "makeAuctionList"
	{

		Auction auction = new Auction();
		
		try {
			stm = m_conn.createStatement();
			
			String query = "SELECT * FROM AuctionsTable" +
							" WHERE AuctionID=" + auctionID;
			
			System.out.println("Retrieving Auction " + auctionID + ": " + query);
			
			//TODO: figure out if we need a success check here
			boolean success = stm.execute(query);
			
			ResultSet result = stm.getResultSet();
			
			//TODO: Check if these conditons work
			if (  result.first() == false) {
				stm.close();
				return null;
			}
			else {

				auction.auctionTitle 	= result.getString("AuctionTitle");
				auction.auctionID 		= result.getInt("AuctionID");
				auction.expiryDate 		= result.getString("ExpiryDate");
				auction.creationDate 	= result.getString("CreationDate");
				auction.category 		= result.getString("Category");
				auction.ownerID 		= result.getInt("OwnerID");
				auction.lastBidderID 	= result.getInt("lastBidderID");
				auction.minPrice 		= result.getDouble("MinPrice");
				auction.latestBidPrice 	= result.getDouble("LatestBidPrice");
				auction.bidCounter 		= result.getInt("BidCounter");
				auction.auctionStatus 	= result.getString("auctionStatus");
				auction.flickerAlbumID 	= result.getString("flickerAlbumID");
				auction.numberOfViews 	= result.getInt("numberOfViews");
				
			}

			stm.close();
			
			return auction;
			
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		
		return null;
		
	}
	
	/*
	 * Takes the credential of the user and checks 
	 * @param: credential of the user
	 * @return: -1 if credential is invalid, 0 if user login expired
	 * @return: ownerID linked the credential if valid
	 */
	public int userCredentialCheck( String cred ){
		
		Long loginExpire = null;
		int userID = 0;
		ResultSet result;
		
		if (cred == "null" ) //might not need to check this but doing it just in case
			return -1;		
		
		try{
			stm = m_conn.createStatement();
			String query = "SELECT UserID, LoginExpireTime FROM UserTable " +
								"WHERE Credential='" + cred + "'"; 
			
			System.out.println("Checking User Credential: \n" + query);
			
			stm.executeQuery(query);
			result = stm.getResultSet();
			System.out.println("Result : " + result.first() );
			
			
			//TODO: Check if these conditons work
			if (  result.first() == false) {
				stm.close();
				System.out.println("Result : Failed to find Credential");
				return -1;
			}
			else {
				
				loginExpire = result.getLong("LoginExpireTime");
				userID = result.getInt("UserID");
				
				
				stm.close();
				result.close();
				
				if( loginExpire == null || ( Calendar.getInstance().getTime().getTime() > loginExpire.longValue() ) ) {
					System.out.println("Result : Credential Expired");
					return 0;
				}
				else {
					stm = m_conn.createStatement();
					String updateQuery =	"UPDATE UserTable" + 
											" SET LoginExpireTime=" + newExpireTime() +
											" WHERE Credential='" + cred + "'"; 
					
					System.out.println("Updating LoginExpireTime: \n" + updateQuery);
					
					stm.executeUpdate(updateQuery);
					//result = stm.getResultSet();
					
					stm.close();
					//result.close();
					
					return userID;
				}
				
				
			}
		
		}catch (SQLException e) {
			//TODO Auto-generated catch block
			//Credential not found
			System.out.println("Result : Failed to find credential");
			e.printStackTrace();
			return -1;
		}
			
	}
	
	
	
	public int userLoginCheck( String userName, String password ) {
		
		String cred = null;
		Long loginExpire = null;
		
		
		try {
			stm = m_conn.createStatement();
			String query = "SELECT Credential, LoginExpireTime FROM UserTable " +
								"WHERE UserName='" + userName + "' " +
								"&& Password='" + password + "'"; 
		

			System.out.println("Checking UserName/Password : \n" + query);
			
			stm.executeQuery(query);
			ResultSet result = stm.getResultSet();
			/*
			 * 3 possible return value
			 *  1 = user exists and is logged in
			 *  0 = user exists and is not logged in
			 *  -1 = user does not exist
			 */
			System.out.println("Result : " + result);
			
			//TODO: fix this, result is not null even if username/pass is wrong
			if (  result.first() == false) {
				stm.close();
				return -1;
			}
			else {
				
				cred = result.getString("Credential");
				loginExpire = result.getLong("LoginExpireTime");
				      
				stm.close();
				result.close();
				
				if( cred == null || loginExpire == 0 || ( Calendar.getInstance().getTime().getTime() > loginExpire.longValue() ) ) {
					return 0;
				}
			}
		}
		catch (SQLException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
			return -1;
		}

		return 1;

		
	}
	
	private String newExpireTime() {
		//java.util.Date expire = new java.util.Date( Calendar.getInstance().getTime().getTime() + loginExpireTime );
		Long expire = Calendar.getInstance().getTime().getTime() + loginExpireTime;
		
		
		return expire.toString();
	}
	
	
	
	
	public String userLogin(String userName, String password)
	{
		int loginStatus = userLoginCheck( userName, password );
		
		//System.out.println("loginStatus: " + loginStatus);
		
		if ( loginStatus == -1 ) {
			return null;
		}
		
		Credential userCred;
		
		if ( loginStatus == 1 ) {
			//TODO: pass back Credential in the future
		}
		
		userCred = new Credential( userName, password );
		
		// YYYY-MM-DD HH:MM:SS
		String expire = newExpireTime();
		
		try {
			stm = m_conn.createStatement();
					
			String query = "UPDATE UserTable" +
				" SET Credential='" + userCred.returnHash() + "'," +
				" LoginExpireTime=" + expire + " " +
				" WHERE UserName='" + userName + "' " +
				"AND Password='" + password + "'"; 
			
			System.out.println("Updating Credentials:" + query);
			boolean success = stm.execute(query);

			System.out.println("User " + userName + " logged in");
			stm.close();
			return  userCred.returnHash();
					
		}
		catch (SQLException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}
	
	public int userLogout( String credential )
	{
		try {
			stm = m_conn.createStatement();
					
			String query = "UPDATE UserTable" +
				" SET Credential=" + null + "," +
				" LoginExpireTime=" + Calendar.getInstance().getTimeInMillis() +
				" WHERE Credential='" + credential + "'"; 
			
			System.out.println("Logging Out:" + query);
			int success = stm.executeUpdate(query);
			
			stm.close();
			
			return success;
					
		}
		catch (SQLException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return 0;

	}
	
	
	// returns
	// [0] PhoneNumber
	// [1] PhoneCarrier
	public String[] userGetPhoneInfo(String userName)
	{
		try {
			stm = m_conn.createStatement();
			String query = "SELECT PhoneNumber, PhoneCarrier From UserTable " +
								"WHERE UserName='" + userName + "'";
								
		
			System.out.println("Getting Phone Info for User : \n" + query);
			
			ResultSet result = stm.executeQuery(query);
			result.beforeFirst();
			String[] ret = new String[2];
		
			 while (result.next()) {
				 	ret[0] =  result.getString("PhoneNumber") ;
				 	ret[1] =  result.getString("PhoneCarrier") ;
				 
			      }

			return ret;
		}
		catch (SQLException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;

	}
	
	public User userGetByID( int userID ) 
	{

		User user = new User();
		
		try {
			stm = m_conn.createStatement();
			
			String query = "SELECT * FROM UserTable" +
							" WHERE UserID=" + userID; 
			
			//System.out.println("Retrieving Auction " + auctionID + ": " + query);
			
			//TODO: figure out if we need a success check here
			boolean success = stm.execute(query);
			
			ResultSet result = stm.getResultSet();
			
			//TODO: Check if these conditons work
			if (  result.first() == false) {
				stm.close();
				return null;
			}
			else {
				// TODO: match up the names with names in database
				user.userID 	= result.getInt("UserID");
				user.password		= result.getString("Password");
				user.phoneNumber 		= result.getString("PhoneNumber");
				user.phoneCarrier 	= result.getString("PhoneCarrier");
				user.emailAddress		= result.getString("EmailAddress");
				user.userName = result.getString("UserName");
			}

			stm.close();
			
			return user;
			
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		
		return null;
		
	}
	
	//Returns UserID if valid username/password
	//Else returns -1
	public int userGetIDByUserNameAndPassword(String userName, String Password)
	{
		try {
			stm = m_conn.createStatement();
					
			String query = "SELECT UserID FROM UserTable WHERE " +
							"UserName='" + userName + "' AND " +
							"Password='" + Password +"'";
			
			System.out.println("Getting User Id: " + query);
			ResultSet result = stm.executeQuery(query);
			
			if(result.first())
			{
				int userID = result.getInt("UserID");
				stm.close();
				return userID;
			}
			
			stm.close();
			return -1;
			
					
		}
		catch (SQLException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return -1;
	}
	
	public boolean userEditInfo( int userID, String Password,String PhoneNumber,String PhoneCarrier,String EmailAddress ) {

		
		try {
			stm = m_conn.createStatement();
					
			String query = "UPDATE UserTable SET " +
			"Password='"+ Password + "'," +
			"PhoneNumber='" + PhoneNumber + "'," +
			"PhoneCarrier='" + PhoneCarrier + "'," +
			"EmailAddress='" + EmailAddress + "'";
				
			query +=	" WHERE UserID='" + userID + "'"; 
			
			System.out.println("Updating UserInfo:" + query);
			boolean success = stm.execute(query);

			stm.close();
			return  true;
					
		}
		catch (SQLException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}
		

		
		return false;
	}
	
	//returns 1 if success
	//returns -1 if bid amount isn't bigger then latestBid
	//returns -2 if error
	public int bidOnAuction(int userID, int auctionID, double amount)
	{
		try {
			stm = m_conn.createStatement();
					
			//double check that the latest bid hasn't been updated
			String query = "SELECT * FROM auctionsTable WHERE AuctionID =" + auctionID;
			
			ResultSet result = stm.executeQuery(query);
			
			if(result.first())
			{
				 double oldLatestBid = result.getDouble("LatestBidPrice");
				 
				 //update the bid
				 if(oldLatestBid < amount)
				 {
					  query = "UPDATE auctionsTable SET " +
					 		"LatestBidPrice=" + amount +
					 		", LastBidderID=" + userID +
					 		", BidCounter=BidCounter+1" +
					 		" WHERE AuctionID=" + auctionID;
					 		
					  System.out.println("New bid: " + query);
					  
					  int success = stm.executeUpdate(query);
					  
					  if(success==1)
					  {
						//insert in to userBids table
						//see if user has already bidded on this auction before, if yes, no need to do anything
						  query = "SELECT * FROM UserBidsTable WHERE " + 
						  		" AuctionID=" + auctionID + " AND UserID=" + userID + " LIMIT 1";
						  result = stm.executeQuery(query);
						  
						  if(result.first())
						  {
							  //no need to do anything
							  return success;
						  }
						  else
						  {
							  //first time bidding on this auction
							  query = "INSERT INTO UserBidsTable(AuctionID, UserID) VALUES " + 
							  		"('" + auctionID + "','" + userID +"')";
							  success = stm.executeUpdate(query);
							  
							  return success;
							  
						  }
						  
					  }
					  
					  stm.close();
					  
					  return success;
					 
				 }
				 else
				 {
					 return -1;
				 }
			
			}
		}
		catch (SQLException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return -2;
	}
	
	//return 1 if succesful
	//return -1 if fail
	public int auctionUpdateExpiryTime(int auctionID, String expiryDate, long expiryTime)
	{
		try {
			stm = m_conn.createStatement();
				
			String query = "UPDATE AuctionsTable SET " +
							"ExpiryDate='" + expiryDate +"'," +
							"AuctionExpireTime=" + expiryTime +
							" WHERE AuctionID=" + auctionID;
			
			System.out.println("Updating Expiry time : " + query);
			
			int success = stm.executeUpdate(query);
			stm.close();
			return success;
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		
		
		return -1;
	}
	
}
