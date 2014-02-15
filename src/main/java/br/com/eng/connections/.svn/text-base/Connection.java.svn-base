package br.com.eng.connections;

import java.io.IOException;

import br.com.eng.interfaces.IManagerConnection;
import br.com.eng.interfaces.ITransactions;
import br.com.eng.utils.FileManager;
import br.com.eng.utils.XMLConverter;

public class Connection {
	
	private static final String DATABASE_XML = "database.xml";
	private ITransactions transactions;
	private IManagerConnection managerConnection;
	private static Connection INSTANCE = new Connection();
	
	private Connection() {
		this.transactions = new TransactionsImpl();
		this.managerConnection = new ManagerConnectionImpl();
		try {
			this.managerConnection.initPool(XMLConverter.getInstance().fromDatabaseXML(FileManager.fileInputStreamFromClasspath(DATABASE_XML)));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static Connection getInstance(){
		return INSTANCE;
	}
	
	public ITransactions getTransactions(){
		return transactions;
	}
	
	public IManagerConnection getManagerConnection(){
		return managerConnection;
	}
	
	public java.sql.Connection getConnection(int id){
		return getManagerConnection().getConnection(id);
	}
	
}
