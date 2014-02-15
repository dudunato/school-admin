package br.com.eng.controllers;



import static br.com.caelum.vraptor.view.Results.json;
import br.com.caelum.vraptor.Consumes;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.eng.beans.User;
import br.com.eng.services.LoginService;

@Resource
public class LoginController {
	
	private Result result;
	private LoginService service;
	
	public LoginController(Result result, LoginService service) {
		this.result = result;
		this.service = service;
	}
	
	public void signin(){
		
	}
	
	@Consumes("application/json")
	public void authenticate(User user){
		this.result.use(json()).from(service.validate(user)).serialize();
	}
	
	public void signout(){
		service.logoff();
		result.redirectTo(this).signin();
	}
	
}
