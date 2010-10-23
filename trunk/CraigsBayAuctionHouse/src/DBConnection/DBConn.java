package DBConnection;

import java.sql.*;


public class DBConn {
	
	/*
	 public static void main(String args[]){
		 Connection conn;
		 
		 try{
				Class.forName("com.mysql.jdbc.Driver").newInstance();
			
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/craigsbay",
				        "root", "cpsc410");
				
				System.out.println("Succesfully Connected");
			}
			catch(SQLException e){
				System.out.println(e.getMessage());
				e.printStackTrace();
			} catch (InstantiationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		 
	 
	 }*/

	private Connection m_conn=null;

	public DBConn() throws InstantiationException, IllegalAccessException, ClassNotFoundException{
		try{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		
			m_conn = DriverManager.getConnection("jdbc:mysql:localhost:3306",
			        "root", "cpsc410");
			
			System.out.println("Succesfully Connected");
		}
		catch(SQLException e){
			System.out.println(e.getMessage());
		}
	
	}
	
	public Connection getDBConnection()
	{
		return m_conn;
	}

}  