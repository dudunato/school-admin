package br.com.eng.services;

import java.util.List;

import br.com.caelum.vraptor.ioc.Component;
import br.com.eng.beans.Timetable;
import br.com.eng.beans.UserSession;
import br.com.eng.daos.TimetableDAO;
import br.com.eng.interfaces.IGenericBean;

@Component
public class TimetableService {
	
	private TimetableDAO dao;
	private UserSession session;
	
	public TimetableService (TimetableDAO dao, UserSession session) {
		this.dao = dao;
		this.session = session;
	}
	
	public List<IGenericBean> list() {
		return dao.list(session.getUser().getSchoolId());
	}
	
	public String insert(Timetable timetable) {
		return dao.insert(timetable) ? "success" : "error";
	}
	
	public String delete(Timetable timetable) {
		return dao.delete(timetable) ? "success" : "error";
	}
}
