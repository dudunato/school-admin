package br.com.eng.services;

import java.util.Collections;
import java.util.List;
import java.util.Set;

import br.com.caelum.vraptor.ioc.Component;
import br.com.eng.beans.Student;
import br.com.eng.beans.Temp;
import br.com.eng.beans.UserSession;
import br.com.eng.connections.Init;
import br.com.eng.daos.StudentDAO;
import br.com.eng.interfaces.IGenericBean;

@Component
public class StudentService {

	private StudentDAO dao;
	private Temp temp;
	private UserSession userSession;
    private Init init;

	public StudentService(UserSession userSession, StudentDAO dao, Temp temp, Init init) {
		this.dao = dao;
		this.userSession = userSession;
		this.temp = temp;
        this.init = init;
	}

	public Set<Student> list() {
		return temp.getStudents(userSession.getUser().getSchoolId());
	}

	public Set<Student> listPossible() {
		return temp.getPossibleStudents(userSession.getUser().getSchoolId());
	}

	public List<IGenericBean> listProf() {
		List<IGenericBean> list = dao.listProf();
		Collections.sort(list);

		return list;
	}

	public String insert(Student student) {
		student.setSchoolId(userSession.getUser().getSchoolId());

		try {
			return (dao.insertStudent(student)) ? "success" : "error";
		} finally {
			temp.updateStudents();
		}
	}

	public String update(Student student) {

		try {
			return (dao.updateStudent(student)) ? "success" : "error";
		} finally {
			temp.updateStudents();
		}
	}

	public String delete(Long id) {

		try {
			return (dao.deleteStudent(id)) ? "success" : "error";
		} finally {
			temp.updateStudents();
		}
	}

	public String activating(Long id) {
		try {
			return (dao.activating(id)) ? "success" : "error";
		} finally {
			temp.updateStudents();
		}
	}

    public String updatePass(String newPass) {
        try {
            return (dao.updatePass(this.userSession.getUser().getId(), newPass)) ? "success" : "error";
        } finally {
            init.updateUsers();
        }
    }

}
