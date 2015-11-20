package db;

import java.sql.*;

/**
 * @author darkwizard
 */
public class DBConnector {

	private static DBConnector connector = null;
	private Connection conn = null;
	private DBConnector() {
	}

	public static DBConnector getInstance() {
		if (connector == null)
			connector = new DBConnector();
		return connector;
	}

	public void connect() {
		try {
			//Class.forName("postgresql.Driver");

			conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/dmdproject", "kittn", "1234");
			System.out.println(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public ResultSet getRawQueryResult(String rawSQLQuery) {
		try {
			Statement st = conn.createStatement();
			return st.executeQuery(rawSQLQuery);
		} catch (SQLException e) {
			e.printStackTrace();
			throw new Error("Please, check your params!");
		}

	}

	public int executeNonQuery(String rawSQLQuery){
		try{
			Statement st = conn.createStatement();
			return st.executeUpdate(rawSQLQuery);
		}
		catch (SQLException e){
			e.printStackTrace();
			throw new Error("Please, check your params!");
		}
	}

	public void closeConnection() {
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
