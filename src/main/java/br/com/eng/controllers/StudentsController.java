package br.com.eng.controllers;

import static br.com.caelum.vraptor.view.Results.json;
import br.com.caelum.vraptor.Consumes;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.eng.beans.Student;
import br.com.eng.services.StudentService;

@Resource
public class StudentsController {

	private Result result;
	private StudentService service;
	private Student activator;

	public StudentsController(Result result, StudentService service) {
		this.result = result;
		this.service = service;
		this.activator = null;
	}

	public void managerstudents() {
		if (activator != null) {
			this.result.include("activate", activator);
		}

	}

	public void managerstudentse() {

	}

	public void list() {
		result.include("listStudent", service.list());
	}

	@Consumes("application/json")
	public void save(Student student) {
		this.result.use(json()).from(service.insert(student)).serialize();
	}

	@Consumes("application/json")
	public void edit(Student student) {
		this.result.use(json()).from(service.update(student)).serialize();
	}

	@Consumes("application/json")
	public void delete(Long id) {
		this.result.use(json()).from(service.delete(id)).serialize();
	}

	public void gridstudents() {
		list();
	}

	public void gridstudentse() {
		this.result.include("listPossible", service.listPossible());

	}

	public void activating(Student student) {
		this.activator = student;
		this.result.forwardTo(this).managerstudents();
	}
	
	@Consumes("application/json")
	public void activatingInactive(Long id) {
		this.result.use(json()).from(service.activating(id)).serialize();
	}

	public void listStudents() {
		list();
	}
	
	public void listPossibleStudents(){
		result.include("listStudent", service.listPossible());
	}

	public void listprof() {
		this.result.include("listProf", service.listProf());
	}

    @Consumes("application/json")
    public void updatePass(String newPass) {
        this.result.use(json()).from(service.updatePass(newPass)).serialize();
    }
}
