package br.com.eng.services;

import java.util.List;

import br.com.caelum.vraptor.ioc.Component;
import br.com.eng.beans.TimetableExp;
import br.com.eng.beans.UserSession;
import br.com.eng.daos.TimetableExpDAO;
import br.com.eng.interfaces.IGenericBean;

@Component
public class TimetableExpService {
	
	private TimetableExpDAO dao;
	private UserSession session;
	
	public TimetableExpService (TimetableExpDAO dao, UserSession session) {
		this.dao = dao;
		this.session = session;
	}
	
	public List<IGenericBean> list() {
		return dao.list(session.getUser().getSchoolId());
	}
	
	public String insert(TimetableExp timetable) {
		return dao.insertOrUpdate(timetable, true) ? "success" : "error";
	}
	
	public String update(TimetableExp timetable) {
		return dao.insertOrUpdate(timetable, false) ? "success" : "error";
	}
	
	public String delete(Long id) {
		return dao.delete(id) ? "success" : "error";
	}
}
