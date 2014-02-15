package br.com.eng.interfaces;

import java.sql.Connection;
import java.util.List;

import br.com.eng.beans.DatabaseConfiguration;


public interface IManagerConnection {
	
	public Connection getConnection(int connectionId);
	
	public void initPool(List<DatabaseConfiguration> confList);

	
}