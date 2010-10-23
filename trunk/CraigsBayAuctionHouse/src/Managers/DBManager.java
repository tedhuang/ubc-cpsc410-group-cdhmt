package Managers;

import java.sql.*;

import DBConnection.DBConn;

public class DBManager {
	
	private Connection m_conn;
	
	protected ResultSet rs;
	protected Statement stm;
	
	public DBManager()
	{
		
		//NOTE: Right now DB connections only work on the server (You CANNOT access the DB from your local computer)
		//You will need to commit your code, and run it on the server.
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
			String query = "INSERT INTO AuctionsTable(AuctionTitle, Category, " +
								"OwnerID, MinPrice, FlickerAlbumID) VALUES" +
								"(" + auctionName + ", " + category + ", " + ownerID + ", " +
								minPrice + ", " + flickrAlbumID + ")"; 
			
			System.out.println("Creating new auction : " + query);
			
			rs = stm.executeQuery(query);
			return true;
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		
		return false;
	}

	
}
