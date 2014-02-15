package br.com.eng.daos;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.com.caelum.vraptor.ioc.ApplicationScoped;
import br.com.caelum.vraptor.ioc.Component;
import br.com.eng.beans.TimetableExp;
import br.com.eng.connections.Connection;
import br.com.eng.interfaces.IGenericBean;
import br.com.eng.utils.GenericOperations;
import br.com.eng.utils.Queries;

@Component
@ApplicationScoped
public class TimetableExpDAO extends GenericOperations {
	
	private Connection connection;
	
	public TimetableExpDAO() {
		this.connection = Connection.getInstance();
	}
	
	public List<IGenericBean> list(Long schoolId) {
		List<IGenericBean> contractSet = new ArrayList<IGenericBean>();
		java.sql.Connection cnn = connection.getConnection(1);
		PreparedStatement pstmt = null;

		try {
			pstmt = cnn.prepareStatement(Queries.getQuery("timetableExp-list"));
			pstmt.setLong(1, schoolId);
			contractSet = (List<IGenericBean>) connection.getTransactions().selectBeanList(pstmt, TimetableExp.class, ArrayList.class);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			freeDBResources(cnn, pstmt);
		}
		return contractSet;
	}
	
	public boolean insertOrUpdate(TimetableExp timetable, boolean isInsert) {
		java.sql.Connection cnn = connection.getConnection(1);
		PreparedStatement pstmt = null;
		try {
			if (isInsert) {
				pstmt = cnn.prepareStatement(Queries.getQuery("timetableExp-insert"));
			} else {
				pstmt = cnn.prepareStatement(Queries.getQuery("timetableExp-update"));
				pstmt.setLong(6, timetable.getId());
			}
			pstmt.setLong(1, timetable.getStudentId());
			pstmt.setLong(2, timetable.getTeacherId());
			pstmt.setString(3, timetable.getDay());
			pstmt.setString(4, timetable.getStartTime());
			pstmt.setString(5, timetable.getEndTime());

			return connection.getTransactions().genericTransaction(pstmt) == 1;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			freeDBResources(cnn, pstmt);
		}

		return false;
	}
	
	public boolean delete(Long id) {

		java.sql.Connection conn = connection.getConnection(1);
		PreparedStatement pstmt = null;

		try {
			pstmt = conn.prepareStatement(Queries.getQuery("timetableExp-delete"));
			pstmt.setLong(1, id);

			return connection.getTransactions().genericTransaction(pstmt) == 1;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			freeDBResources(conn, pstmt);
		}

		return false;
	}
	
}
