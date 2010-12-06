/****************************************************************************
 * Description:                                                             *
 * This is the core of our web app/program in terms of interaction with the *
 * database. Most functions related to the modification of databse are done *
 * through this manager.													*
 * The functions of many of the methods are trivial through their names     *
 ****************************************************************************/

package Managers;

import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import Classes.Auction;
import Classes.Credential;
import Classes.Friend;
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
	
	
	/*
	 * This method handles the creation of an auction in the database given the parameters listed
	 */
	public int createNewAuction(String auctionName, String category, String auctionStatus, String creationDate, String expiryDate, long expiryTime, Double minPrice, int ownerID, String flickrAlbumID, String auctionDescription   )
	{
		try {
			stm = m_conn.createStatement();
			//Parse user input into SQL acceptable format
			auctionName = auctionName.replace("\'", "\\\'");
			auctionName = auctionName.replace("\"", "\\\"");
			auctionName = auctionName.replace(";", "");
			auctionName = auctionName.replace("{", "");
			auctionName = auctionName.replace("}", "");
			auctionName = auctionName.replace("<", "");
			auctionName = auctionName.replace(">", "");
			auctionName = auctionName.replace("^", "");
			auctionDescription = auctionDescription.replace("\'", "\\\'");
			auctionDescription = auctionDescription.replace("\"", "\\\"");
			auctionDescription = auctionDescription.replace(";", "");
			auctionDescription = auctionDescription.replace("{", "");
			auctionDescription = auctionDescription.replace("}", "");
			auctionDescription = auctionDescription.replace("<", "");
			auctionDescription = auctionDescription.replace(">", "");
			auctionDescription = auctionDescription.replace("^", "");
			
			// create entry in DB
			String query = "INSERT INTO AuctionsTable(AuctionTitle, Category, AuctionStatus, " +
								"ExpiryDate, AuctionExpireTime, CreationDate, OwnerID, MinPrice, LatestBidPrice, FlickerAlbumID, AuctionDescription) VALUES" +
								"('" + auctionName + "' , '" + category + "' , '" + auctionStatus +
								"' , '"  + expiryDate + "' , '" + expiryTime + "' , '" + creationDate + 
								"' , '" + ownerID + "' , '" + minPrice + "' , '" + minPrice + "' , '" + flickrAlbumID + "' , '" + auctionDescription + "')"; 
			
			System.out.println("Creating new auction : " + query);
			
			stm.executeUpdate(query);
			
			query = "SELECT AuctionID FROM AuctionsTable WHERE "
				+ " AuctionTitle='" + auctionName + "'" + " AND ExpiryDate='" + expiryDate + "'" + 
						" AND AuctionExpireTime='" + expiryTime + "' AND ownerID='" + ownerID + "' AND creationDate='" + creationDate+"'"; 
			ResultSet result = stm.executeQuery(query);
			
			
			System.out.println("Debug Check " + query);
			
			//checks the result
			if( result.first() )
			{
				int AuctionID = result.getInt("AuctionID");
				System.out.println("Returned AuctionID: " + AuctionID);
				stm.close();
				return AuctionID;
			}
			else
			{
				System.out.println("Error: result.first() is false ");
				//TODO: implement handling fail creation
			}
			stm.close();
			
			
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		
		return -1;
	}
	
	
	
	
	/*
	 * This method changes the status of an auction to the status given based on the auctionID
	 */
	public int auctionChangeStatus(String auctionID, String status){
		
		try{
			stm = m_conn.createStatement();
			
			String query = "UPDATE " + "AuctionsTable" +
							" SET auctionStatus='" + status +
							"' WHERE auctionID=" + auctionID;
			System.out.println(query);
			
			stm.execute(query);

			return 1;
			
		
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		
		
		return 0;
	}
	
	
	/*
	 * This method returns an ArrayList with Friends of the user based on userID
	 */
	public ArrayList<Friend> getFriends(int userID){
		ArrayList<Friend> friendList = new ArrayList<Friend>();
		
		try	{
			stm = m_conn.createStatement();
			
			String query = "SELECT FT.FriendID,UT.UserName FROM FriendsTable FT "
				+ "INNER JOIN UserTable UT ON FT.FriendID = UT.UserID "
				+ "WHERE FT.UserID = '" + userID + "' ";
			
			boolean success = stm.execute(query);
			ResultSet result = stm.getResultSet();
			
			while( result.next() ) {
				Friend tempFriend = new Friend();
				
				System.out.println(result.getInt("FriendID"));
				System.out.println(result.getString("UserName"));
				tempFriend.friendID = result.getInt("FriendID");
				tempFriend.friendName = result.getString("UserName");				
				friendList.add( tempFriend );
			}
			
			stm.close();
			
			System.out.println("Searched Friends");
			return friendList;
			
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		
		
		return null;
	}
	

	// search the auction based on title and category
	/*
	 * This method searches auction results given the params provided
	 */
	public ArrayList<Auction> searchAuctionResults(String searchTitle, String searchCategory, String SearchOwner)
	{
		ArrayList<Auction> auctionList = new ArrayList<Auction>();
		String ownerQuery;
		
		try {
			stm = m_conn.createStatement();
			
			//Determine whether to search owner
			if(SearchOwner == ""){
				ownerQuery = "";
			}
			else
			{
				ownerQuery = "AND OwnerID = (SELECT UserID FROM UserTable WHERE UserName = '" + SearchOwner + "')";
			}

			String query = "SELECT * FROM AuctionsTable "
							+ "WHERE AuctionTitle LIKE '" + searchTitle + "%' " //+
							//" AND AuctionExpireTime>" + Calendar.getInstance().getTimeInMillis();
							+ " AND Category LIKE '" + searchCategory + "' " + 
							ownerQuery;
			
			System.out.println(query);
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
	

	/*
	 * This is the function that retrives the main auction list
	 */
	public ArrayList<Auction> auctionListAll()
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
				tempAuction.auctionDescription = result.getString("AuctionDescription");
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
	
	/*
	 * This function determines if a user is already friends with the owner of the auction they are viewing
	 */
	public boolean checkFriendExist(int ownerID, int userID){
		try {
			stm = m_conn.createStatement();

			String query = "SELECT * FROM FriendsTable " +
							"WHERE UserID='" + userID + "' " + 
							"AND FriendID = '" + ownerID + "' "; 
			
			stm.executeQuery(query);
			ResultSet result = stm.getResultSet();
			System.out.println("Result : " + result.first() );
			
			if ( result.first() != false) {
				stm.close();
				System.out.println("Result : User already friend");
				return true;
			}
			else {
				stm.close();
				result.close();
				return false;
			}
			
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		return true;
	}
	
	/*
	 * This function creates a new friend pair in the database
	 */
	public boolean addFriend(int ownerID,int userID){
		try {
			stm = m_conn.createStatement();
			
			String query = "INSERT INTO FriendsTable " +
							"VALUES (" + userID + ", " + ownerID + ")";
			System.out.println("Adding friend....");
			
			
			boolean success = stm.execute(query);
			stm.close();
			
			return success;
			
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		return true;
		
	}
	
	
	/*
	 * This auction deletes the specified friend from the database
	 */
	public boolean deleteFriend(int userID, int friendID ){
		
		try {
			stm = m_conn.createStatement();
			
			String query = "DELETE FROM FriendsTable " +
							"WHERE UserID= '" + userID + "' AND " +
							"FriendID = '" + friendID + "'";
			
			boolean success = stm.execute(query);
			stm.close();
			
			return success;
			
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		return true;
	}
	
	
	/*
	 * Flags a given auction for inappropriate content for admins to examine it
	 */
	public int flagAuction(String auctionID){
		try {
			stm = m_conn.createStatement();
			
			String query = "UPDATE AuctionsTable" +
							" SET Flag='1'" +
							" WHERE AuctionID=" + auctionID;
			
			System.out.println("Flagging Auction: " + query);
			
			stm.executeUpdate(query);
			stm.close();
			
			return 1;
			
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		
		
		return 0;
	}
	
	
	// Lists the auctions posted by the userID
	/*
	 * Retrieves a list of the current users auctions from the database
	 */
	public ArrayList<Auction> auctionListPostedByUser( int userID )
	{
		
		ArrayList<Auction> auctionsList = new ArrayList<Auction>();
		
		try {
			stm = m_conn.createStatement();
			
			String query = "UPDATE AuctionsTable" +
							" SET AuctionStatus='EXPIRED'" +
							" WHERE AuctionExpireTime<" + Calendar.getInstance().getTimeInMillis();
			
			System.out.println("Updating DB Expired Auctions: " + query);
			
			stm.executeUpdate(query);
			
			query = "SELECT  * FROM AuctionsTable" +
								" WHERE OwnerID=" + userID +
								" AND AuctionStatus<>'CLOSED'"; 
			
			System.out.println("Retrieving Auctions Owned by User : " + query);
			
			boolean success = stm.execute(query);
			
			ResultSet result = stm.getResultSet();
			
			// format the auction results into a list
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
	
	/*
	 * Retrieves the auctions the current user has bidded on
	 */
	public ArrayList<Auction> auctionListBiddedByUser( int userID )
	{
		
		ArrayList<Auction> auctionsList = new ArrayList<Auction>();
		
		try {
			stm = m_conn.createStatement();
			
			String query = "UPDATE AuctionsTable" +
			" SET AuctionStatus='EXPIRED'" +
			" WHERE AuctionExpireTime<" + Calendar.getInstance().getTimeInMillis();

			System.out.println("Updating DB Expired Auctions: " + query);

			stm.executeUpdate(query);
			
			query = "SELECT  * FROM UserBidsTable, AuctionsTable" +
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
				tempAuction.auctionDescription = result.getString("AuctionDescription");
				
				auctionsList.add( tempAuction );
				
			}
			

			stm.close();
			
			return auctionsList;
			
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		
		
		return null;
		
		
	}
	
	
	/*
	 * Returns the auction given its ID
	 */
	public Auction auctionGetByID( int auctionID )
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
				auction.auctionDescription = result.getString("AuctionDescription");
				
				double curTime = (System.currentTimeMillis());
				System.out.println(result.getDouble("AuctionExpireTime"));
				auction.millisecondsLeft =  result.getDouble("AuctionExpireTime") - curTime;
				if(auction.millisecondsLeft < 0)
				{
					auction.millisecondsLeft = 0;
				}
				
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
			
			
			// user may not exist
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
					// user exists but is not logged in or credential expired
					System.out.println("Result : Credential Expired");
					return 0;
				}
				else {
					// if user exist, return the correct user ID
					stm = m_conn.createStatement();
					String updateQuery =	"UPDATE UserTable" + 
											" SET LoginExpireTime=" + newExpireTime() +
											" WHERE Credential='" + cred + "'"; 
					
					System.out.println("Updating LoginExpireTime: \n" + updateQuery);
					
					stm.executeUpdate(updateQuery);
					
					stm.close();
					
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
	
	
	// same as userCredentialCheck() but without the constant update message
	public int userCredentialCheckNoUpdate( String cred ){
		
		Long loginExpire = null;
		int userID = 0;
		ResultSet result;
		
		if (cred == "null" ) //might not need to check this but doing it just in case
			return -1;		
		
		try{
			stm = m_conn.createStatement();
			String query = "SELECT UserID, LoginExpireTime FROM UserTable " +
								"WHERE Credential='" + cred + "'"; 

			stm.executeQuery(query);
			result = stm.getResultSet();

			// determine whether the user exists
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
				//if the user exists but not logged in
				if( loginExpire == null || ( Calendar.getInstance().getTime().getTime() > loginExpire.longValue() ) ) {
					System.out.println("Result : Credential Expired");
					return 0;
				}
				else {
					// user exists and is logged in
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
	
	/*
	 * This fuction queries the database to determine if the inputed user name is unique
	 */
	public boolean usernameCheck(String Username){
		ResultSet result;
		
		try{
			stm = m_conn.createStatement();
			String query = "SELECT UserID FROM UserTable " +
								"WHERE UserName='" + Username+ "'"; 
			
			System.out.println("Checking Username: \n" + query);
			
			stm.executeQuery(query);
			result = stm.getResultSet();
			System.out.println("Result : " + result.first() );
			
			
			//TODO: Check if these conditons work
			if ( result.first() == false) {
				stm.close();
				System.out.println("Result : Unique User");
				return true;
			}
			else {
				stm.close();
				result.close();
				return false;
			}
		}catch (SQLException e) {
			//TODO Auto-generated catch block
			//Credential not found
			System.out.println("Result : SQL EXCEPTION Failed to find user");
			e.printStackTrace();
			return false;
		}
		
	}
	
	
	// checks whether or not user is logged in
	/*
	 * 3 possible return value
	 *  1 = user exists and is logged in
	 *  0 = user exists and is not logged in
	 *  -1 = user does not exist
	 */
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
				
				if( cred == null || loginExpire == 0 || ( Calendar.getInstance().getTime().getTime() > loginExpire.longValue() + 10000 ) ) {
					return 0;
				}
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
			return -1;
		}

		return 1;

		
	}
	
	// calculates the expiry time for a login credential
	private String newExpireTime() {
		Long expire = Calendar.getInstance().getTime().getTime() + loginExpireTime;		
		
		return expire.toString();
	}
	
	
	// handles user login from checking, to assigning new credentials
	public String userLogin(String userName, String password)
	{
		
		// checks login status
		int loginStatus = userLoginCheck( userName, password );
		
		if ( loginStatus == -1 ) {
			return null;
		}
		
		try {
			stm = m_conn.createStatement();
			
			if ( loginStatus == 1 ) {

				String query = "SELECT Credential FROM UserTable " +
				"WHERE UserName='" + userName + "' " +
				"&& Password='" + password + "'"; 
				
				stm.executeQuery(query);
				ResultSet result = stm.getResultSet();
				
				if( result.first() ) {
					return result.getString("Credential");
				}
				else {
					return null;
				}

			}
			else {
				
				// assign a new credential
				Credential userCred;
				
				userCred = new Credential( userName, password );
				
				String expire = newExpireTime();
				
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

		}
		catch (SQLException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}
	
	// take the old credential and wipe it from database
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
	public String[] userGetPhoneInfo(int UserID)
	{
		try {
			stm = m_conn.createStatement();
			String query = "SELECT PhoneNumber, PhoneCarrier From UserTable " +
								"WHERE UserID=" + UserID ;
								
		
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
			
			boolean success = stm.execute(query);
			
			ResultSet result = stm.getResultSet();
			
			if (  result.first() == false) {
				stm.close();
				return null;
			}
			else {
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
	
	/*
	 * Updates the specified user's record in the table with new information
	 */
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
	
	/*
	 * Creates a new user in the database
	 */
	public boolean userRegister(String Username, String Password , String PhoneNumber,String PhoneCarrier,String EmailAddress){
		try {
			stm = m_conn.createStatement();
					
			String query = "INSERT INTO UserTable(UserName, Password, PhoneNumber, PhoneCarrier, EmailAddress) VALUES " + 
	  		"('" + Username + "','" + Password + "','" + PhoneNumber + "','" + PhoneCarrier + "','" + EmailAddress +"')";
			
			System.out.println("Creating User:" + query);
			boolean success = stm.execute(query);
			stm.close();
			return  success;
					
		}
		catch (SQLException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
		
	}
	
	
	//returns 1 if success
	//returns -1 if bid amount isn't bigger then latestBid
	//returns -2 if auction has expired
	//returns -3 if error
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
				 String auctionStatus = result.getString("AuctionStatus");
				 int origNumBids = result.getInt("BidCounter");
				 int ownerID = result.getInt("OwnerID");
				 String auctionTitle = result.getString("AuctionTitle");
				 
			     
			     if(auctionStatus.equalsIgnoreCase("EXPIRED") )
			     {
			    	 return -2;
			     }
				 
				 //update the bid
				 if(oldLatestBid < amount )
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
						  //first bid, send a text to the owner.
						  if(origNumBids == 0)
						  {
							  SMTPManager smtp = new SMTPManager();
							  smtp.sendMail(ownerID, 0, auctionTitle, false);
						  }
						  
						  
						  
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
		
		return -3;
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
	
	public void checkForExpiredAuctionSMSMessage()
	{	
		try {
			stm = m_conn.createStatement();
				
			String query = "SELECT AuctionID, AuctionTitle, OwnerID, LastBidderID FROM AuctionsTable WHERE " +
							" AuctionStatus='EXPIRED' AND SMSMessageSent=0";

			
			ResultSet rs = stm.executeQuery(query);
			rs.beforeFirst();
			
			List<Integer> auctionIDList = new ArrayList<Integer>();
			SMTPManager smtp = new SMTPManager();
			
			while (rs.next()) {
					auctionIDList.add(rs.getInt("AuctionID"));
					int ownerID = rs.getInt("OwnerID");
					int winnerID = rs.getInt("LastBidderID");
					String AuctionTitle = rs.getString("AuctionTitle");
					
					smtp.sendMail(ownerID, winnerID, AuctionTitle, true);
				 
			}
			
			for( int i = 0 ; i < auctionIDList.size() ; ++i)
			{
				query = "UPDATE AuctionsTable SET SMSMessageSent=1 WHERE "
					+   " AuctionID=" + auctionIDList.get(i).toString();
				
				stm.executeUpdate(query);
			}
			
			System.out.println(auctionIDList.size() + " SMS MESSAGES SENT" );
			

		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		
	}
	
	public int addTextToAuctionChatLog(int auctionID, String userName, String text)
	{
		try {
			stm = m_conn.createStatement();
				
			String query = "SELECT * FROM ChatLogTable WHERE " +
							" AuctionID=" + auctionID + " LIMIT 1";

			ResultSet rs = stm.executeQuery(query);
			
			//just appending chat
			if(rs.first())
			{
				query = "UPDATE ChatLogTable SET ChatHistory=CONCAT(ChatHistory,'" + text + "')" +
						" WHERE auctionID=" + auctionID;
				System.out.println(query);
				
				stm.executeUpdate(query);
				
			}
			else
			{
				//new entry in the table
				query = "INSERT INTO ChatLogTable(AuctionID, ChatHistory) VALUES " + 
					"(" + auctionID + ",'" + text + "')";
				System.out.println(query);
						
				stm.executeUpdate(query);
				
			}
			
			return 1;
			
			

		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		
	
	
	return -1;
	
	}
	
	public String getTextFromAuctionChatLog(int auctionID)
	{
		try {
			stm = m_conn.createStatement();
				
			String query = "SELECT * FROM ChatLogTable WHERE " +
							" AuctionID=" + auctionID;

			ResultSet rs = stm.executeQuery(query);
			
			
			if(rs.first())
			{
				String chatLog = rs.getString("ChatHistory");
				return chatLog;
			}

			
			return "";
			
			

		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		return "";
	}
	
	
}
