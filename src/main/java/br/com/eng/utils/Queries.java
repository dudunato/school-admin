package br.com.eng.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

public class Queries {
	
	
	public static String getQuery(String name){
		return loadResource(name);
	}
	
	private static String loadResource(String name) {
		
		return readAsString(classloader().getResourceAsStream("queries/" + name + ".sql"));
	}
	
	private static ClassLoader classloader() {
		return Thread.currentThread().getContextClassLoader();
	}
	
	private static String readAsString(InputStream stream) {
		try {
			BufferedReader in = new BufferedReader(new InputStreamReader(stream));

			String line = null;
			StringBuffer strBuffer = new StringBuffer();
			while ((line = in.readLine()) != null) {
				strBuffer.append(line);
				strBuffer.append('\n');
			}

			String contentStr = strBuffer.toString();
			return contentStr;
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}  
}
