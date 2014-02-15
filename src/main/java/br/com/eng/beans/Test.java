package br.com.eng.beans;

import java.text.Normalizer;

public class Test {
	
	
	public static void main(String[] args) {
		
		String input = "Péricôtìlando";  
		input = Normalizer.normalize(input, Normalizer.Form.NFD);  
		input = input.replaceAll("[^\\p{ASCII}]", "");  
		
		System.out.println(input); 
		
	}

}
