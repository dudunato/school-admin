package br.com.eng.daos;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;

import br.com.caelum.vraptor.ioc.ApplicationScoped;
import br.com.caelum.vraptor.ioc.Component;
import br.com.eng.beans.Teacher;
import br.com.eng.connections.Connection;
import br.com.eng.interfaces.IGenericBean;
import br.com.eng.utils.GenericOperations;
import br.com.eng.utils.Queries;

@Component
@ApplicationScoped
public class TeacherDAO extends GenericOperations {
	
	private Connection connection;
	
	public TeacherDAO(){
		this.connection = Connection.getInstance();
	}
	
	public Set<IGenericBean> getListTeacher(){
		
		Set<IGenericBean> list = new HashSet<IGenericBean>();
		
		java.sql.Connection conn = connection.getConnection(1);
		PreparedStatement pstmt = null;
		
		try {
			pstmt = conn.prepareStatement(Queries.getQuery("teacher-list"));
			
			list = (Set<IGenericBean>) connection.getTransactions().selectBeanList(pstmt, Teacher.class, HashSet.class);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			freeDBResources(conn, pstmt);
		}
		
		return list;
	}
	
	public boolean insertTeacher(Teacher teacher){
		
		java.sql.Connection conn = connection.getConnection(1);
		PreparedStatement pstmt = null;
		
		try {
			pstmt = conn.prepareStatement(Queries.getQuery("teacher-insert"));
			pstmt.setString(1, teacher.getName());
			pstmt.setString(2, teacher.getRg());
			pstmt.setString(3, teacher.getCpf());
			pstmt.setString(4, teacher.getBirthDate());
			pstmt.setString(5, teacher.getSpecialty());
			pstmt.setString(6, teacher.getMei());
			pstmt.setString(7, teacher.getEmail());
			pstmt.setString(8, teacher.getTel());
			pstmt.setString(9, teacher.getCel());
			pstmt.setString(10, teacher.getCep());
			pstmt.setString(11, teacher.getAddress());
			pstmt.setString(12, teacher.getNumberHouse());
			pstmt.setString(13, teacher.getObs());
			pstmt.setString(14, teacher.getNeighborhood());
			pstmt.setLong(15, teacher.getSchoolId());
			
			return connection.getTransactions().genericTransaction(pstmt) == 1;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			freeDBResources(conn, pstmt);
		}
		
		return false;
	}
	
	public boolean updateTeacher(Teacher teacher){
		
		java.sql.Connection conn = connection.getConnection(1);
		PreparedStatement pstmt = null;
		
		try {
			pstmt = conn.prepareStatement(Queries.getQuery("teacher-update"));
			pstmt.setString(1, teacher.getName());
			pstmt.setString(2, teacher.getRg());
			pstmt.setString(3, teacher.getCpf());
			pstmt.setString(4, teacher.getBirthDate());
			pstmt.setString(5, teacher.getSpecialty());
			pstmt.setString(6, teacher.getMei());
			pstmt.setString(7, teacher.getEmail());
			pstmt.setString(8, teacher.getTel());
			pstmt.setString(9, teacher.getCel());
			pstmt.setString(10, teacher.getCep());
			pstmt.setString(11, teacher.getAddress());
			pstmt.setString(12, teacher.getNumberHouse());
			pstmt.setString(13, teacher.getObs());
			pstmt.setString(14, teacher.getNeighborhood());
			pstmt.setLong(15, teacher.getId());
			
			return connection.getTransactions().genericTransaction(pstmt) == 1;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			freeDBResources(conn, pstmt);
		}
		
		return false;
	}
	
	public boolean deleteTeacher(Long id){
		
		java.sql.Connection conn = connection.getConnection(1);
		PreparedStatement pstmt = null;
		
		try {
			pstmt = conn.prepareStatement(Queries.getQuery("teacher-delete"));
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
