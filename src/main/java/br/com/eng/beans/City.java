package br.com.eng.beans;

import br.com.eng.annotations.Database;
import br.com.eng.interfaces.IGenericBean;

public class City implements IGenericBean {
	
	@Database(columnName = "cidade_id")
	public Long id;
	
	@Database(columnName = "cidade_nome")
	public String name;
	
	@Database(columnName = "estado_id")
	public Long stateId;
	
	@Database(columnName = "estado_uf")
	public String stateUF;
	
	public City() {
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

	public Long getStateId() {
		return stateId;
	}

	public void setStateId(Long stateId) {
		this.stateId = stateId;
	}

	public String getStateUF() {
		return stateUF;
	}

	public void setStateUF(String stateName) {
		this.stateUF = stateName;
	}

	@Override
	public int compareTo(IGenericBean o) {
		return 0;
	}
	
}
