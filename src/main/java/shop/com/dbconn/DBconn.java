package shop.com.dbconn;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.DriverManager;

public class DBconn {

	public static Connection getConnection(){
		
		Connection conn=null;
		try{
			Class.forName("com.mysql.jdbc.Driver"); 
			String url = "jdbc:mysql://localhost:3306/shopDB";
			String user = "root";
			String password = "111111";
			conn = DriverManager.getConnection(url,user,password);		
		}catch(SQLException sqle){
			System.out.println("DBConnection:SQLException");
			throw new RuntimeException(sqle.getMessage());
		}catch(ClassNotFoundException cnfe){
			System.out.println("DBConnection:ClassNotFoundException");
			throw new RuntimeException(cnfe.getMessage());
		}
		return conn; 

	}
}
