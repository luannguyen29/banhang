package model;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseConnection {
	public static Connection getConnection() {
		Connection connection = null;
		String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		String url = "jdbc:sqlserver://localhost:1433;databaseName=LUAN";
		String user ="sa";
		String pass="2901";
		try {
		Class.forName(driver);
		connection = DriverManager.getConnection(url,user,pass);
		} catch (Exception e) {
			// Orther err
			e.printStackTrace();
		}
		return connection;
	}

	public static void main(String[] args) {
		Connection connection = DatabaseConnection.getConnection();
		if (connection != null) {
			System.out.println("Success");
		} else {
			System.out.println("Failed");
		}
	}
}
