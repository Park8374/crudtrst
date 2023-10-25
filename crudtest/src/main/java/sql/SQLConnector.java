package sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SQLConnector {
	static final String URL = "jdbc:mariadb://localhost:3306/gdj72";
	static final String USER = "root";
	static final String PW = "java1234";
	
	Connection conn;
	public SQLConnector() {
		try {
			this.conn = DriverManager.getConnection(URL, USER, PW);			
		} catch (Exception e) {
			this.conn = null;
		}
	}
	
	public ResultSet execQuery(String sql, Object... args) throws SQLException {
		var stmt = getSTMT(sql, args);
		ResultSet result = stmt.executeQuery();
		close(stmt);
		return result;
	}
	
	public int execUpdate(String sql, Object... args) throws SQLException {
		var stmt = getSTMT(sql, args);
		int result = stmt.executeUpdate();
		close(stmt);
		return result;
	}
	
	private void close(PreparedStatement stmt) throws SQLException {
		stmt.close();
		conn.close();
	}
	
	private PreparedStatement getSTMT(String sql, Object... args) throws SQLException {
		PreparedStatement stmt = conn.prepareStatement(sql);
		for(int i = 0; i < args.length; i++) {
			Object arg = args[i];
			if (arg instanceof String) {
				stmt.setString(i + 1, (String) arg);
			} else {
				stmt.setInt(i + 1, (int) arg);
			}
		}
		
		return stmt;
	}
}
