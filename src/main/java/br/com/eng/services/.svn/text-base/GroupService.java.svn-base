package br.com.eng.services;

import java.util.List;

import br.com.caelum.vraptor.ioc.Component;
import br.com.eng.beans.Group;
import br.com.eng.beans.UserSession;
import br.com.eng.daos.GroupDAO;
import br.com.eng.interfaces.IGenericBean;

@Component
public class GroupService {
	
	private GroupDAO dao;
	private UserSession session;
	
	public GroupService (GroupDAO dao, UserSession session) {
		this.dao = dao;
		this.session = session;
	}
	
	public List<IGenericBean> list() {
		return dao.list(session.getUser().getSchoolId());
	}
	
	public String insert(Group timetable) {
		return dao.insertOrUpdate(timetable, true) ? "success" : "error";
	}
	
	public String update(Group timetable) {
		return dao.insertOrUpdate(timetable, false) ? "success" : "error";
	}
	
	public String delete(Long id) {
		return dao.delete(id) ? "success" : "error";
	}
}
