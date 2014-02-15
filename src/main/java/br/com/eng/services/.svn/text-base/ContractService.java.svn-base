package br.com.eng.services;

import java.util.List;

import br.com.caelum.vraptor.ioc.Component;
import br.com.eng.beans.Contract;
import br.com.eng.beans.Student;
import br.com.eng.beans.UserSession;
import br.com.eng.daos.ContractDAO;
import br.com.eng.interfaces.IGenericBean;

@Component
public class ContractService {

	private ContractDAO dao;
	private StudentService studentService;
	private UserSession session;
	
	public ContractService(ContractDAO dao, StudentService studentService, UserSession session) {
		this.dao = dao;
		this.studentService = studentService;
		this.session = session;
	}
	
	public List<IGenericBean> list() {
		return dao.list(session.getUser().getSchoolId());
	}
	
	public IGenericBean select(Integer studentId) {
		return dao.select(studentId);
	}
	
	public Student getStudent(Integer studentId) {
		
		for (Student s : studentService.list()) {
			if (studentId.equals(Integer.valueOf(s.getId().toString()))) {
				return s;
			}
		}
		
		return null;
	}
	
	public String update(Contract contract) {
		return dao.insertOrUpdate(contract, false) ? "success" : "error";
	}

	public String insert(Contract contract) {
		return dao.insertOrUpdate(contract, true) ? "success" : "error";
	}
}