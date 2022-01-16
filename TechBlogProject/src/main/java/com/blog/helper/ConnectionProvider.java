package com.blog.helper;
import java.sql.*;
public class ConnectionProvider {
	//create connection variable as private 
	private static Connection con;
	
	public static Connection getConnection() {
		String url ="jdbc:mysql://localhost:3306?user=root&password=server";
		
		try {
			if(con == null) //if no connection has been established
			{
				//load driver
				Class.forName("com.mysql.jdbc.Driver");
				//create a connection
				con = DriverManager.getConnection(url);
			}
		} 
		
		catch (ClassNotFoundException e) {
			// exception generated by forName()
			e.printStackTrace();
		} catch (SQLException e) {
			// generated by driverManager
			e.printStackTrace();
		}
		
		return con;
	}
}