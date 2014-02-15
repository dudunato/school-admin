package br.com.eng.utils;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Properties;

public class FileManager {

	public FileManager() {
	}

	public static Properties propertiesFromClasspath(String filename)
			throws IOException {
		InputStream file = classloader().getResourceAsStream(filename);
		Properties props = new Properties();
		props.load(file);
		return props;
	}

	private static ClassLoader classloader() {
		return Thread.currentThread().getContextClassLoader();
	}

	public static File fileFromClasspath(String fileName) {
		URL resource = classloader().getResource(fileName);
		return resource == null ? null : new File(resource.getFile());
	}

	public static Properties readPropertiesFile(String fileName) {
		Properties prop = null;
		try {
			prop = new Properties();
			prop.load(classloader().getResourceAsStream(fileName));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return prop;
	}

	public static InputStream fileInputStreamFromClasspath(String fileName)
			throws IOException {
		URL resource = classloader().getResource(fileName);
		return resource == null ? null : resource.openStream();
	}
}