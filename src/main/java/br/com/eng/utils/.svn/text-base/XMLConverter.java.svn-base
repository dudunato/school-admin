package br.com.eng.utils;

import java.io.InputStream;
import java.util.List;

import br.com.eng.beans.DatabaseConfiguration;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

public class XMLConverter {

	private static XStream xStream;
	private static XMLConverter INSTANCE = new XMLConverter();
	
	public XMLConverter() {
		xStream = new XStream(new DomDriver());
		xStream.autodetectAnnotations(true);
	}
	
	public static XMLConverter getInstance() {
		return INSTANCE;
	}
	
	public String getDatabaseXML(List<DatabaseConfiguration> list) {
		return xStream.toXML(list);
	}
	
	@SuppressWarnings("unchecked")
	public List<DatabaseConfiguration> fromDatabaseXML(InputStream input) {
		xStream.alias("database-configuration", List.class);
		xStream.alias("configuration", DatabaseConfiguration.class);
		return (List<DatabaseConfiguration>) xStream.fromXML(input);
	}
	
}