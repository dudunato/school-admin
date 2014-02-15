package br.com.eng.controllers;

import static br.com.caelum.vraptor.view.Results.json;
import br.com.caelum.vraptor.Consumes;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.eng.beans.Teacher;
import br.com.eng.services.TeacherService;

@Resource
public class TeacherController {
	
	private Result result;
	private TeacherService service;
	
	public TeacherController(Result result, TeacherService service) {
		this.result = result;
		this.service = service;
	}
	
	public void managerteachers(){
		
	}
	
	public void list(){
		result.include("listTeacher", service.list());
	}
	
	@Consumes("application/json")
	public void save(Teacher teacher){
		this.result.use(json()).from(service.insert(teacher)).serialize();
	}
	
	@Consumes("application/json")
	public void edit(Teacher teacher){
		this.result.use(json()).from(service.update(teacher)).serialize();
	}
	
	@Consumes("application/json")
	public void delete(Long id){
		this.result.use(json()).from(service.delete(id)).serialize();
	}
	
	public void gridteachers(){
		list();
	}
	
	public void listTeachers() {
		list();
	}
	
}
