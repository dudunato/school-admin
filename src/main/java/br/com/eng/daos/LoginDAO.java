package br.com.eng.daos;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;

import br.com.caelum.vraptor.ioc.ApplicationScoped;
import br.com.caelum.vraptor.ioc.Component;
import br.com.eng.beans.User;
import br.com.eng.connections.Connection;
import br.com.eng.interfaces.IGenericBean;
import br.com.eng.utils.GenericOperations;
import br.com.eng.utils.Queries;

@Component
@ApplicationScoped
public class LoginDAO extends GenericOperations {
	
	private Connection connection;
	
	public LoginDAO() {
		connection = Connection.getInstance();
	}

	
	@SuppressWarnings("rawtypes")
	public Set getListUser(){
		
		Set<IGenericBean> list = new HashSet<IGenericBean>();
		
		java.sql.Connection conn = connection.getConnection(1);
		PreparedStatement pstmt = null;
		
		try {
			pstmt = conn.prepareStatement(Queries.getQuery("user-list"));
			
			list = (Set<IGenericBean>) connection.getTransactions().selectBeanList(pstmt, User.class, HashSet.class);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			freeDBResources(conn, pstmt);
		}
		
		return list;
	}
}
