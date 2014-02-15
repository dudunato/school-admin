package br.com.eng.daos;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.com.caelum.vraptor.ioc.ApplicationScoped;
import br.com.caelum.vraptor.ioc.Component;
import br.com.eng.beans.Timetable;
import br.com.eng.connections.Connection;
import br.com.eng.interfaces.IGenericBean;
import br.com.eng.utils.GenericOperations;
import br.com.eng.utils.Queries;

@Component
@ApplicationScoped
public class TimetableDAO extends GenericOperations {

	private Connection connection;

	public TimetableDAO() {
		connection = Connection.getInstance();
	}
	
	public List<IGenericBean> list(Long schoolId) {
		List<IGenericBean> list = new ArrayList<IGenericBean>();
		java.sql.Connection cnn = connection.getConnection(1);
		PreparedStatement pstmt = null;

		try {
			pstmt = cnn.prepareStatement(Queries.getQuery("timetable-list"));
			pstmt.setLong(1, schoolId);
			list = (List<IGenericBean>) connection.getTransactions().selectBeanList(pstmt, Timetable.class, ArrayList.class);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			freeDBResources(cnn, pstmt);
		}
		return list;
	}

	public boolean insert(Timetable timetable) {
		java.sql.Connection cnn = connection.getConnection(1);
		PreparedStatement pstmt = null;

		try {
			pstmt = cnn.prepareStatement(Queries.getQuery("timetable-insert"));
			pstmt.setLong(1, timetable.getGroupId());
			pstmt.setLong(2, timetable.getStudentId());

			return connection.getTransactions().genericTransaction(pstmt) == 1;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			freeDBResources(cnn, pstmt);
		}

		return false;
	}
	
	public boolean delete(Timetable timetable) {

		java.sql.Connection conn = connection.getConnection(1);
		PreparedStatement pstmt = null;

		try {
			pstmt = conn.prepareStatement(Queries.getQuery("timetable-delete"));
			pstmt.setLong(1, timetable.getGroupId());
			pstmt.setLong(2, timetable.getStudentId());

			return connection.getTransactions().genericTransaction(pstmt) == 1;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			freeDBResources(conn, pstmt);
		}

		return false;
	}
}
