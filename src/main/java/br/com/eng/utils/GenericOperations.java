package br.com.eng.utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import br.com.eng.interfaces.IGenericOperations;


public class GenericOperations implements IGenericOperations {

	@Override
	public void freeDBResources(Connection conn, PreparedStatement pstmt) {
		try {
			if (conn != null) {
				conn.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
