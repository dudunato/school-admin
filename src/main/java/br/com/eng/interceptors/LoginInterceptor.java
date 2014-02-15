package br.com.eng.interceptors;

import java.util.Arrays;

import br.com.caelum.vraptor.InterceptionException;
import br.com.caelum.vraptor.Intercepts;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.core.InterceptorStack;
import br.com.caelum.vraptor.interceptor.Interceptor;
import br.com.caelum.vraptor.ioc.RequestScoped;
import br.com.caelum.vraptor.resource.ResourceMethod;
import br.com.eng.beans.UserSession;
import br.com.eng.controllers.LoginController;
import br.com.eng.controllers.MessagesController;

@Intercepts
@RequestScoped
public class LoginInterceptor implements Interceptor {

	private  Result result;
	private  UserSession userSession;
	
	public LoginInterceptor(Result result, UserSession userSession){
		this.result = result;
		this.userSession = userSession;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public boolean accepts(ResourceMethod method) {
		return !Arrays.asList(LoginController.class, MessagesController.class).contains(method.getMethod().getDeclaringClass());				
	}

	@Override
	public void intercept(InterceptorStack stack, ResourceMethod method,
			Object obj) throws InterceptionException {
			
		if(this.userSession.hasUserSession()){
			this.result.redirectTo(MessagesController.class).erroraccess();
		}else{
			this.result.include("user", this.userSession.getUser());
			stack.next(method, obj);
		}		
		
	}	
}
