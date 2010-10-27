package Managers;

import java.sql.*;

import DBConnection.DBConn;

public class DBManager {
	
	private Connection m_conn;
	
	protected ResultSet rs;
	protected Statement stm;
	
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

	public int userCheck( String userName, String password ) {
		
		try {
			stm = m_conn.createStatement();
			String query = "SELECT LoginStatus From UserTAble " +
								"WHERE UserName='" + userName + "' " +
								"&& Password='" + password + "'"; 
		
			System.out.println("Checking UserName/Password : \n" + query);
			
			stm.executeQuery(query);
			ResultSet result = stm.getResultSet();
		
			/*
			 * 3 possible return value
			 *  true = user exists and is logged in
			 *  false = user exists and is not logged in
			 *  null = user does not exist
			 */

			if (result == null ) {
				stm.close();
				result.close();
				return -1;
			}
			else {
				stm.close();
				return result.getInt("LoginStatus");
			}
		}
		catch (SQLException e) {
			//TODO Auto-generated catch block
			e.printStackTrace();
		}

		return -1;
	}
	
	public Boolean userLogin(String userName, String password)
	{
		int loginStatus = userCheck( userName, password );
				
		if ( loginStatus == -1 ) {
		
			return false;
		}
				
		try {
			stm = m_conn.createStatement();
					
			String query = "UPDATE UserTAble " +
				"SET LoginStatus=true " +
				"WHERE UserName='" + userName + "' " +
				"&& Password='" + password + "'"; 

			boolean success = stm.execute(query);

			System.out.println("User " + userName + " logged in");
			stm.close();
			return success;
					
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
