package br.com.eng.interfaces;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;

public interface ITransactions {
	
	public IGenericBean select(PreparedStatement pstmt, Class<? extends IGenericBean> beanClass);
	
	public Collection<IGenericBean> selectBeanList(PreparedStatement pstmt, Class<? extends IGenericBean> beanClass, Class<?> clazz);
	
	public Collection<Object> selectFieldList(PreparedStatement pstmt, String field, Class<?> clazz);
	
	public int genericTransaction(PreparedStatement pstmt);
	
	public ResultSet genericTransactionRS(PreparedStatement pstmt);
	
	public IGenericBean genericTransactionResp(PreparedStatement pstmt, Class<? extends IGenericBean> beanClass);
	
}
