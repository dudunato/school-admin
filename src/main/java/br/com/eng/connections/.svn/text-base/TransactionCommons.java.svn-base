package br.com.eng.connections;

import java.lang.reflect.Field;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import br.com.eng.annotations.Database;
import br.com.eng.interfaces.IGenericBean;
import br.com.eng.interfaces.ITransactions;

public abstract class TransactionCommons implements ITransactions {
	
	
	public TransactionCommons() {
	}
	
	public IGenericBean convert(ResultSet rs, Class<? extends IGenericBean> beanClass) throws SQLException {
		IGenericBean bean = newInstance(beanClass);
		if (rs != null && bean != null) {
			Set<String> columns = new HashSet<String>();
			for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
				columns.add(rs.getMetaData().getColumnName(i));
			}
			Field[] fields = bean.getClass().getDeclaredFields();
			while (rs.next()) {
				for (Field field : fields) {
					field.setAccessible(true);
					if (field.isAnnotationPresent(Database.class)) {
						try {
							String columnName = field.getAnnotation(Database.class).columnName();
							if (columns.contains(columnName)) {
								field.set(bean, rs.getObject(columnName));
							}
						} catch (IllegalArgumentException e) {
//							log.error("TransactionCommons[convert] IllegalArgumentException - " + e.getLocalizedMessage());
							e.printStackTrace();
						} catch (IllegalAccessException e) {
//							log.error("TransactionCommons[convert] IllegalAccessException - " + e.getLocalizedMessage());
							e.printStackTrace();
						}
					}
				}
			}
		}
		return bean;
	}
	
	@SuppressWarnings("unchecked")
	public Collection<IGenericBean> convertBeanList(ResultSet rs, Class<? extends IGenericBean> beanClass,  Class<?> clazz) throws SQLException, InstantiationException, IllegalAccessException {
		Collection<IGenericBean> beanList = (Collection<IGenericBean>) clazz.newInstance();
		if (rs != null) {
			Set<String> columns = new HashSet<String>();
			for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
				columns.add(rs.getMetaData().getColumnName(i));
			}
			while (rs.next()) {
				IGenericBean bean = newInstance(beanClass);
				if (bean != null) {
					Field[] fields = bean.getClass().getDeclaredFields();
					for (Field field : fields) {
						field.setAccessible(true);
						if (field.isAnnotationPresent(Database.class)) {
							try {
								String columnName = field.getAnnotation(Database.class).columnName();
								if (columns.contains(columnName)) {
									field.set(bean, rs.getObject(columnName));
								}
							} catch (IllegalArgumentException e) {
//								log.error("TransactionCommons[convertBeanList] IllegalArgumentException - " + e.getLocalizedMessage());
								e.printStackTrace();
							} catch (IllegalAccessException e) {
//								log.error("TransactionCommons[convertBeanList] IllegalAccessException - " + e.getLocalizedMessage());
								e.printStackTrace();
							}
						}
					}
					beanList.add(bean);
				}
			}
		}
		return beanList;
	}
	
	@SuppressWarnings("unchecked")
	public Collection<Object> convertFieldList(ResultSet rs, String field, Class<?> clazz) throws SQLException, InstantiationException, IllegalAccessException {
		Collection<Object> fieldList = (Collection<Object>) clazz.newInstance();
		if (rs != null) {
			while (rs.next()) {
				fieldList.add(rs.getObject(field));
			}
		}
		return fieldList;
	}
	
	private IGenericBean newInstance(Class<? extends IGenericBean> beanClass) {
		try {
			return beanClass.newInstance();
		} catch (InstantiationException e) {
//			log.error("TransactionCommon[newInstance] InstantiationException - " + e.getLocalizedMessage());
			e.printStackTrace();
		} catch (IllegalAccessException e) {
//			log.error("TransactionCommon[newInstance] IllegalAccessException - " + e.getLocalizedMessage());
			e.printStackTrace();
		}
		return null;
	}
}