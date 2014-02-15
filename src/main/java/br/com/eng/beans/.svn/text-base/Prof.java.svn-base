package br.com.eng.beans;

import br.com.eng.annotations.Database;
import br.com.eng.interfaces.IGenericBean;

public class Prof implements IGenericBean {
	
	@Database(columnName="id_prof")
	private Long id;
	
	@Database(columnName="nome_prof")
	private String name;
	
	public Prof() {
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public int compareTo(IGenericBean o) {
		// TODO Auto-generated method stub
		return 0;
	}

}
