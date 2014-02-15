package br.com.eng.connections;

import java.beans.PropertyVetoException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import br.com.eng.beans.DatabaseConfiguration;
import br.com.eng.interfaces.IManagerConnection;

import com.mchange.v2.c3p0.ComboPooledDataSource;

public class ManagerConnectionImpl implements IManagerConnection {
	
	
	private Map<Integer, ComboPooledDataSource> poolController = new HashMap<Integer, ComboPooledDataSource>();

	public ManagerConnectionImpl() {
	}

	@Override
	public Connection getConnection(int connectionId) {
		if (poolController.containsKey(connectionId)) {
			try {
				return poolController.get(connectionId).getConnection();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	@Override
	public void initPool(List<DatabaseConfiguration> confList) {
		if (confList != null && !confList.isEmpty()) {
			for (DatabaseConfiguration conf : confList) {
				ComboPooledDataSource cpds = new ComboPooledDataSource();
				try {
					cpds.setDriverClass(conf.getDriver());
					cpds.setJdbcUrl(conf.getUrl());
					cpds.setUser(conf.getUsername());
					cpds.setPassword(conf.getPassword());
					cpds.setMinPoolSize(conf.getMinPoolSize());
					cpds.setMaxPoolSize(conf.getMaxPoolSize());
					cpds.setCheckoutTimeout(conf.getCheckTimeout());
					cpds.setAutomaticTestTable(conf.getAutomaticTestTable());
					cpds.setTestConnectionOnCheckin(conf.isTestConnectionOnCheckin());
					cpds.setIdleConnectionTestPeriod(conf.getIdleConnectionTestPeriod());
					poolController.put(conf.getId(), cpds);
				} catch (PropertyVetoException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
}
