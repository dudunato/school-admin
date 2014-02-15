package br.com.eng.services;

import java.util.Set;

import br.com.caelum.vraptor.ioc.Component;
import br.com.eng.beans.Teacher;
import br.com.eng.beans.Temp;
import br.com.eng.beans.UserSession;
import br.com.eng.daos.TeacherDAO;

@Component
public class TeacherService {

	private TeacherDAO dao;
	private UserSession userSession;
	private Temp temp;
	
	public TeacherService(UserSession userSession, TeacherDAO dao, Temp temp) {
		this.userSession = userSession;
		this.dao = dao;
		this.temp = temp;
	}
	
	public Set<Teacher> list(){
		return temp.getTeachers(userSession.getUser().getSchoolId());
	}
	
	public String insert(Teacher teacher){
		teacher.setSchoolId(userSession.getUser().getSchoolId());
		
		try {
			return (dao.insertTeacher(teacher)) ? "success" : "error";
		} finally {
			temp.updateTeachers();
		}
	}
	
	public String update(Teacher teacher){
		
		try {
			return (dao.updateTeacher(teacher)) ? "success" : "error";
		} finally {
			temp.updateTeachers();
		}
	}
	
	public String delete(Long id){
		
		try {
			return (dao.deleteTeacher(id)) ? "success" : "error";
		} finally {
			temp.updateTeachers();
		}
	}
}
