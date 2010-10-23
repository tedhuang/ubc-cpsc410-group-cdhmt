package DBConnection;

import java.sql.*;


public class DBConn {
	
	 public static void main(String args[]){
		 Connection conn;
		 
		 try{
				Class.forName("com.mysql.jdbc.Driver").newInstance();
			
				conn = DriverManager.getConnection("jdbc:mysql://70.79.38.90:3306/craigsbay",
				        "root", "");
				
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
		 
	 
	 }
/*
	public static Connection conn;

	public DBConn() throws InstantiationException, IllegalAccessException, ClassNotFoundException{
		try{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		
			conn = DriverManager.getConnection("jdbc:mysql:70.79.38.90:3306",
			        "root", "secret");
			
			System.out.println("Succesfully Connected");
		}
		catch(SQLException e){
			System.out.println(e.getMessage());
		}
	
	}
*/
}  