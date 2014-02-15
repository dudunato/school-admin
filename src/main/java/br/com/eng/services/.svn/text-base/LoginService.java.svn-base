package br.com.eng.services;


import br.com.caelum.vraptor.ioc.Component;
import br.com.eng.beans.User;
import br.com.eng.beans.UserSession;
import br.com.eng.connections.Init;
import br.com.eng.daos.LoginDAO;

@Component
public class LoginService {
	
	//private LoginDAO dao;
	private Init init;
	private UserSession userSession;
	
	public LoginService(LoginDAO dao, Init init, UserSession userSession) {
		//this.dao = dao;
		this.init = init;
		this.userSession = userSession;
	}
	
	public String validate(User user){
		
		if (checkLogin(user)){
			if (checkPass(user)){
				userSession.setUser(init.getUsers().get(user.getName()));
				return "success"; 
			}
			return "error";
		} else {
			updateUsers();
			if (checkLogin(user)){
				if (checkPass(user)){
					userSession.setUser(init.getUsers().get(user.getName()));
					return "success"; 
				}
				return "error";
			}
		}
		return "error";
	}
	
	private boolean checkLogin(User user){
		return init.getUsers().containsKey(user.getName());
	}
	
	private boolean checkPass(User user){
		return init.getUsers().get(user.getName()).getPass().equals(user.getPass());
	}
	
	public void updateUsers(){
		init.contextInitialized();
	}
	
	public void logoff(){
		userSession.removeSession();
	}
}
