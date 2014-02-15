package br.com.eng.daos;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.com.caelum.vraptor.ioc.ApplicationScoped;
import br.com.caelum.vraptor.ioc.Component;
import br.com.eng.beans.City;
import br.com.eng.beans.State;
import br.com.eng.connections.Connection;
import br.com.eng.interfaces.IGenericBean;
import br.com.eng.utils.GenericOperations;
import br.com.eng.utils.Queries;

@Component
@ApplicationScoped
public class CitySateDAO extends GenericOperations {
	
	private Connection connection;
	
	public CitySateDAO() {
		this.connection = Connection.getInstance();
	}
	
	public List<IGenericBean> listCity(Long stateId) {
		List<IGenericBean> citySet = new ArrayList<IGenericBean>();
		java.sql.Connection cnn = connection.getConnection(1);
		PreparedStatement pstmt = null;

		try {
			pstmt = cnn.prepareStatement(Queries.getQuery("city-state-list"));
			pstmt.setLong(1, stateId);
			citySet = (List<IGenericBean>) connection.getTransactions().selectBeanList(pstmt, City.class, ArrayList.class);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			freeDBResources(cnn, pstmt);
		}
		return citySet;
	}
	
	public List<IGenericBean> listState() {
		List<IGenericBean> citySet = new ArrayList<IGenericBean>();
		java.sql.Connection cnn = connection.getConnection(1);
		PreparedStatement pstmt = null;

		try {
			pstmt = cnn.prepareStatement(Queries.getQuery("state-list"));
			citySet = (List<IGenericBean>) connection.getTransactions().selectBeanList(pstmt, State.class, ArrayList.class);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			freeDBResources(cnn, pstmt);
		}
		return citySet;
	}
	
	
	
	
}
