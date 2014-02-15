package br.com.eng.daos;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.com.caelum.vraptor.ioc.ApplicationScoped;
import br.com.caelum.vraptor.ioc.Component;
import br.com.eng.beans.Contract;
import br.com.eng.connections.Connection;
import br.com.eng.interfaces.IGenericBean;
import br.com.eng.utils.GenericOperations;
import br.com.eng.utils.Queries;

@Component
@ApplicationScoped
public class ContractDAO extends GenericOperations {

	private Connection connection;

	public ContractDAO() {
		this.connection = Connection.getInstance();
	}

	public List<IGenericBean> list(Long schoolId) {
		List<IGenericBean> contractSet = new ArrayList<IGenericBean>();
		java.sql.Connection cnn = connection.getConnection(1);
		PreparedStatement pstmt = null;

		try {
			pstmt = cnn.prepareStatement(Queries.getQuery("contract-list"));
			pstmt.setLong(1, schoolId);
			contractSet = (List<IGenericBean>) connection.getTransactions().selectBeanList(pstmt, Contract.class, ArrayList.class);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			freeDBResources(cnn, pstmt);
		}
		return contractSet;
	}
	
	public IGenericBean select(Integer studentId){
		
		java.sql.Connection cnn = connection.getConnection(1);
		PreparedStatement pstmt = null;
		IGenericBean contract = null;

		try {
			pstmt = cnn.prepareStatement(Queries.getQuery("contract-select"));
			pstmt.setInt(1, studentId);
			contract = connection.getTransactions().select(pstmt, Contract.class);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			freeDBResources(cnn, pstmt);
		}
		
		return contract;
	}

	public boolean insertOrUpdate(Contract contract, boolean isInsert) {
		java.sql.Connection cnn = connection.getConnection(1);
		PreparedStatement pstmt = null;
		try {
			if (isInsert) {
				pstmt = cnn.prepareStatement(Queries.getQuery("contract-insert"));
			} else {
				pstmt = cnn.prepareStatement(Queries.getQuery("contract-update"));
				pstmt.setLong(8, contract.getId());
			}
			pstmt.setLong(1, contract.getStudentID());
			pstmt.setString(2, contract.getTotalValue());
			pstmt.setString(3, contract.getEntryValue());
			pstmt.setString(4, contract.getBeginDate());
			pstmt.setString(5, contract.getEndDate());
			pstmt.setString(6, contract.getMonthlyPaymentValue());
			pstmt.setString(7, contract.getAlternativePaymentValue());
			return connection.getTransactions().genericTransaction(pstmt) == 1;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			freeDBResources(cnn, pstmt);
		}
		
		return false;
	}
}