package br.com.eng.beans;

import br.com.eng.annotations.Database;
import br.com.eng.interfaces.IGenericBean;

public class User implements IGenericBean {
	
	@Database(columnName = "user_id")
	private Long id;
	
	@Database(columnName = "user_name")
	private String name;
	
	@Database(columnName = "user_pass")
	private String pass;
	
	@Database(columnName = "user_perfil")
	private Long perfil;
	
	@Database(columnName = "school_id")
	private Long schoolId;
	
	public User() {
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

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public Long getPerfil() {
		return perfil;
	}

	public void setPerfil(Long perfil) {
		this.perfil = perfil;
	}

	public Long getSchoolId() {
		return schoolId;
	}

	public void setSchoolId(Long schoolId) {
		this.schoolId = schoolId;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", pass=" + pass
				+ ", perfil=" + perfil + ", schoolId=" + schoolId + "]";
	}

	@Override
	public int compareTo(IGenericBean o) {
		// TODO Auto-generated method stub
		return 0;
	}
	
}
