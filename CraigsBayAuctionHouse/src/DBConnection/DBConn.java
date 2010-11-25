package DBConnection;

import java.sql.*;


public class DBConn {
	

	private Connection m_conn=null;

	public DBConn() throws InstantiationException, IllegalAccessException, ClassNotFoundException{
		try{
			Class.forName("com.mysql.jdbc.Driver").newInstance();

			m_conn = DriverManager.getConnection("jdbc:mysql://70.79.38.90:3306/craigsbay",
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