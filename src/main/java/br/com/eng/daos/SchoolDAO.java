package br.com.eng.daos;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;

import br.com.caelum.vraptor.ioc.ApplicationScoped;
import br.com.caelum.vraptor.ioc.Component;
import br.com.eng.connections.Connection;
import br.com.eng.utils.GenericOperations;
import br.com.eng.utils.Queries;


@Component
@ApplicationScoped
public class SchoolDAO extends GenericOperations {
	
	private Connection connection;
	
	public SchoolDAO() {
		this.connection = Connection.getInstance();
	}
	
	public Set<Object> getListShcool(){
		
		Set<Object> list = new HashSet<Object>();

		java.sql.Connection conn = connection.getConnection(1);
		PreparedStatement pstmt = null;

		try {
			pstmt = conn.prepareStatement(Queries.getQuery("school-list"));

			list = (Set<Object>) connection.getTransactions().selectFieldList(pstmt, "school_id", HashSet.class);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			freeDBResources(conn, pstmt);
		}

		return list;
	}
	
}
