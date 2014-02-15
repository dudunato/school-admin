package br.com.eng.daos;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.com.caelum.vraptor.ioc.ApplicationScoped;
import br.com.caelum.vraptor.ioc.Component;
import br.com.eng.beans.Group;
import br.com.eng.connections.Connection;
import br.com.eng.interfaces.IGenericBean;
import br.com.eng.utils.GenericOperations;
import br.com.eng.utils.Queries;

@Component
@ApplicationScoped
public class GroupDAO extends GenericOperations {

	private Connection connection;

	public GroupDAO() {
		this.connection = Connection.getInstance();
	}
	
	public List<IGenericBean> list(Long schoolId) {
		List<IGenericBean> list = new ArrayList<IGenericBean>();
		java.sql.Connection cnn = connection.getConnection(1);
		PreparedStatement pstmt = null;

		try {
			pstmt = cnn.prepareStatement(Queries.getQuery("group-list"));
			pstmt.setLong(1, schoolId);
			list = (List<IGenericBean>) connection.getTransactions().selectBeanList(pstmt, Group.class, ArrayList.class);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			freeDBResources(cnn, pstmt);
		}
		return list;
	}

	public boolean insertOrUpdate(Group group, boolean isInsert) {
		java.sql.Connection cnn = connection.getConnection(1);
		PreparedStatement pstmt = null;
		try {
			if (isInsert) {
				pstmt = cnn.prepareStatement(Queries.getQuery("group-insert"));
			} else {
				pstmt = cnn.prepareStatement(Queries.getQuery("group-update"));
				pstmt.setLong(9, group.getId());
			}
			pstmt.setString(1, group.getName());
			pstmt.setLong(2, group.getTeacherId());
			pstmt.setString(3, group.getDay1());
			pstmt.setString(4, group.getStartTime1());
			pstmt.setString(5, group.getEndTime1());
			pstmt.setString(6, group.getDay2());
			pstmt.setString(7, group.getStartTime2());
			pstmt.setString(8, group.getEndTime2());

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
			pstmt = conn.prepareStatement(Queries.getQuery("group-delete"));
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
