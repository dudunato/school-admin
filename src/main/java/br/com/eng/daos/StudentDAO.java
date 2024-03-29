package br.com.eng.daos;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import br.com.caelum.vraptor.ioc.ApplicationScoped;
import br.com.caelum.vraptor.ioc.Component;
import br.com.eng.beans.Prof;
import br.com.eng.beans.Student;
import br.com.eng.connections.Connection;
import br.com.eng.interfaces.IGenericBean;
import br.com.eng.utils.GenericOperations;
import br.com.eng.utils.Queries;

@Component
@ApplicationScoped
public class StudentDAO extends GenericOperations {

	private Connection connection;

	public StudentDAO() {
		this.connection = Connection.getInstance();
	}

	public Set<IGenericBean> getListStudent() {

		Set<IGenericBean> list = new HashSet<IGenericBean>();

		java.sql.Connection conn = connection.getConnection(1);
		PreparedStatement pstmt = null;

		try {
			pstmt = conn.prepareStatement(Queries.getQuery("student-list"));

			list = (Set<IGenericBean>) connection.getTransactions().selectBeanList(pstmt, Student.class, HashSet.class);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			freeDBResources(conn, pstmt);
		}

		return list;
	}
	
	public List<IGenericBean> listProf() {
		List<IGenericBean> list = new ArrayList<IGenericBean>();

		java.sql.Connection conn = connection.getConnection(1);
		PreparedStatement pstmt = null;

		try {
			pstmt = conn.prepareStatement(Queries.getQuery("prof-list"));

			list = (List<IGenericBean>) connection.getTransactions().selectBeanList(pstmt, Prof.class, ArrayList.class);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			freeDBResources(conn, pstmt);
		}
		
		return list;
		
	}

	public boolean insertStudent(Student student) {

		java.sql.Connection conn = connection.getConnection(1);
		PreparedStatement pstmt = null;

		try {
			pstmt = conn.prepareStatement(Queries.getQuery("student-insert"));
			pstmt.setString(1, student.getName());
			pstmt.setString(2, student.getRg());
			pstmt.setString(3, student.getCpf());
			pstmt.setString(4, student.getBirthDate());
			pstmt.setString(5, student.getSchooling());
			pstmt.setObject(6, student.getProfId());
			pstmt.setString(7, student.getEmail());
			pstmt.setString(8, student.getTel());
			pstmt.setString(9, student.getCel());
			pstmt.setString(10, student.getCep());
			pstmt.setString(11, student.getAddress());
			pstmt.setString(12, student.getNumberHouse());
			pstmt.setString(13, student.getNeighborhood());
			pstmt.setString(14, student.getMedia());
			pstmt.setString(15, student.getObs());
			pstmt.setObject(16, student.getSchoolId());
			pstmt.setString(17, student.getType());
			pstmt.setObject(18, student.getCityId());
			pstmt.setString(19, student.getComplement());
			pstmt.setString(20, student.getFiliation());
			pstmt.setString(21, student.getStatus());

			return connection.getTransactions().genericTransaction(pstmt) == 1;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			freeDBResources(conn, pstmt);
		}

		return false;
	}

	public boolean updateStudent(Student student) {

		java.sql.Connection conn = connection.getConnection(1);
		PreparedStatement pstmt = null;

		try {
			pstmt = conn.prepareStatement(Queries.getQuery("student-update"));
			pstmt.setString(1, student.getName());
			pstmt.setString(2, student.getRg());
			pstmt.setString(3, student.getCpf());
			pstmt.setString(4, student.getBirthDate());
			pstmt.setString(5, student.getSchooling());
			pstmt.setLong(6, student.getProfId());
			pstmt.setString(7, student.getEmail());
			pstmt.setString(8, student.getTel());
			pstmt.setString(9, student.getCel());
			pstmt.setString(10, student.getCep());
			pstmt.setString(11, student.getAddress());
			pstmt.setString(12, student.getNumberHouse());
			pstmt.setString(13, student.getNeighborhood());
			pstmt.setString(14, student.getMedia());
			pstmt.setString(15, student.getObs());
			pstmt.setString(16, student.getType());
			pstmt.setLong(17, student.getCityId());
			pstmt.setString(18, student.getComplement());
			pstmt.setString(19, student.getFiliation());
			pstmt.setString(20, student.getStatus());
			pstmt.setLong(21, student.getId());

			return connection.getTransactions().genericTransaction(pstmt) == 1;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			freeDBResources(conn, pstmt);
		}

		return false;
	}

	public boolean deleteStudent(Long id) {

		java.sql.Connection conn = connection.getConnection(1);
		PreparedStatement pstmt = null;

		try {
			pstmt = conn.prepareStatement(Queries.getQuery("student-delete"));
			pstmt.setLong(1, id);

			return connection.getTransactions().genericTransaction(pstmt) == 1;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			freeDBResources(conn, pstmt);
		}

		return false;
	}
	
	public boolean activating(Long id) {

		java.sql.Connection conn = connection.getConnection(1);
		PreparedStatement pstmt = null;

		try {
			pstmt = conn.prepareStatement(Queries.getQuery("student-activate"));
			pstmt.setLong(1, id);

			return connection.getTransactions().genericTransaction(pstmt) == 1;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			freeDBResources(conn, pstmt);
		}

		return false;
	}

    public boolean updatePass(Long id, String newPass) {

        java.sql.Connection conn = connection.getConnection(1);
        PreparedStatement pstmt = null;

        try {
            pstmt = conn.prepareStatement(Queries.getQuery("pass-update"));
            pstmt.setString(1, newPass);
            pstmt.setLong(2, id);

            return connection.getTransactions().genericTransaction(pstmt) == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            freeDBResources(conn, pstmt);
        }

        return false;
    }

}
