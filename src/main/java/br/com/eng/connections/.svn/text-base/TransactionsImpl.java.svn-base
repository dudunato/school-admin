package br.com.eng.connections;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;

import br.com.eng.interfaces.IGenericBean;

public class TransactionsImpl extends TransactionCommons {
	
	
	public TransactionsImpl(){
		
	}
	
	@Override
	public IGenericBean select(PreparedStatement pstmt, Class<? extends IGenericBean> beanClass) {
		if (pstmt != null && beanClass != null) {
			try {
				return convert(pstmt.executeQuery(), beanClass);
			} catch (SQLException e) {
//				log.error("TransactionsImpl[select] SQLException - " + e.getLocalizedMessage());
				e.printStackTrace();
			}
		}
		return null;
	}
	
	@Override
	public Collection<IGenericBean> selectBeanList(PreparedStatement pstmt, Class<? extends IGenericBean> beanClass, Class<?> clazz) {
		if (pstmt != null && beanClass != null) {
			try {
				return convertBeanList(pstmt.executeQuery(), beanClass, clazz);
			} catch (SQLException e) {
//				log.error("TransactionsImpl[selectList] SQLException - " + e.getLocalizedMessage());
				e.printStackTrace();
			} catch (InstantiationException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
		}
		return null;
	} 

	@Override
	public Collection<Object> selectFieldList(PreparedStatement pstmt, String field, Class<?> clazz) {
		if (pstmt != null && field != null) {
			try {
				return convertFieldList(pstmt.executeQuery(), field, clazz);
			} catch (SQLException e) {
//				log.error("TransactionsImpl[selectList] SQLException - " + e.getLocalizedMessage());
				e.printStackTrace();
			} catch (InstantiationException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	@Override
	public int genericTransaction(PreparedStatement pstmt) {
		if (pstmt != null) {
			try {
				return pstmt.executeUpdate();
			} catch (SQLException e) {
//				log.error("TransactionsImpl[genericTransaction] SQLException - " + e.getLocalizedMessage());
				e.printStackTrace();
			}
		}
		return 0;
	}
	
	@Override
	public ResultSet genericTransactionRS(PreparedStatement pstmt) {
		if (pstmt != null) {
			try {
				return pstmt.executeQuery();
			} catch (SQLException e) {
//				log.error("TransactionsImpl[genericTransaction] SQLException - " + e.getLocalizedMessage());
				e.printStackTrace();
			}
		}
		return null;
	}

	@Override
	public IGenericBean genericTransactionResp(PreparedStatement pstmt, Class<? extends IGenericBean> beanClass) {
		if (pstmt != null && beanClass != null) {
			try {
				return convert(pstmt.executeQuery(), beanClass);
			} catch (SQLException e) {
//				log.error("TransactionsImpl[genericTransactionResp] SQLException - " + e.getLocalizedMessage());
				e.printStackTrace();
			}
		}
		return null;
	}

	
}
