package Managers;

import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;

import Classes.Auction;
import Classes.Credential;
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
	
	public Boolean createNewAuction(String auctionName, String category, Double minPrice, int ownerID, String flickrAlbumID   )
	{
		try {
			stm = m_conn.createStatement();
			String query = "INSERT INTO AuctionsTable(AuctionTitle, Category, " +
								"OwnerID, MinPrice, FlickerAlbumID) VALUES" +
								"('" + auctionName + "' , '" + category + "' , " + ownerID + ", " +
								minPrice + ", '" + flickrAlbumID + "')"; 
			
			System.out.println("Creating new auction : " + query);
			
			boolean success = stm.execute(query);
			stm.close();
			return success;
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		
		
		
		return false;
	}
	
	

	public ArrayList<Auction> auctionList( )
	{
		ArrayList<Auction> auctionsList = new ArrayList<Auction>();
		
		try {
			stm = m_conn.createStatement();
			
			String listRange = "*";
			String query = "SELECT " + listRange + 
								" FROM AuctionsTable(AuctionTitle, Category, " +
								"OwnerID, MinPrice, FlickerAlbumID) VALUES"; 
			
			System.out.println("Retrieving Auctions List : " + query);
			
			//TODO: figure out if we need a success check here
			boolean success = stm.execute(query);
			
			ResultSet result = stm.getResultSet();
			
			while( result.next() ) {
				Auction tempAuction = new Auction();
				
				tempAuction.auctionTitle = result.getString("AuctionTitle");
				tempAuction.auctionID = result.getInt("AuctionID");

				tempAuction.expiryDate = result.getDouble("ExpiryDate");
				tempAuction.creationDate = result.getDouble("CreationDate");
				tempAuction.category = result.getString("Category");
				tempAuction.ownerID = result.getInt("OwnerID");
				tempAuction.lastBidder = result.getInt("lastBidder");
				tempAuction.minPrice = result.getDouble("MinPrice");
				tempAuction.lastestBidPrice = result.getDouble("LastestBidPrice");
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
			
			if (result == null ) {
				stm.close();

				return -1;
			}
			else {
				
				
				result.first();
				cred = result.getString("Credential");
				loginExpire = result.getLong("LoginExpireTime");
				      
				
				
				
				stm.close();
				result.close();
				
				if( cred == null || loginExpire == null || ( Calendar.getInstance().getTime().getTime() > loginExpire.longValue() ) ) {
					return 0;
				}

			}
		}
		catch (SQLException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
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
	
	
	// returns
	// [0] PhoneNumber
	// [1] PhoneCarrier
	public String[] getUserPhoneInfo(String userName)
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
	
}
