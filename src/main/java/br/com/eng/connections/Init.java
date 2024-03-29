package br.com.eng.connections;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.annotation.PostConstruct;

import br.com.caelum.vraptor.ioc.ApplicationScoped;
import br.com.caelum.vraptor.ioc.Component;
import br.com.eng.beans.Temp;
import br.com.eng.beans.User;
import br.com.eng.daos.LoginDAO;

@Component
@ApplicationScoped
public class Init {
	
	private LoginDAO loginDAO;
	private Set<User> usersSet;
	private Map<String, User> users;
	private Temp temp;
	
	public Init(LoginDAO loginDAO, Temp temp) {
		this.loginDAO = loginDAO;
		this.temp = temp;
	}
	
	@SuppressWarnings("unchecked")
	@PostConstruct
	public void contextInitialized() {
		usersSet = loginDAO.getListUser();
		toMap();
		temp.updateSchools();
		temp.updateTeachers();
		temp.updateStudents();
	}
	
	public void toMap(){
		
		Map<String, User> map = new HashMap<String, User>();
		
		for(br.com.eng.beans.User u : usersSet){
			map.put(u.getName(), u);
		}
		users = map;
	}

	public Map<String, User> getUsers() {
		return users;
	}

    public void updateUsers() {
        usersSet = loginDAO.getListUser();
        toMap();
    }

}
