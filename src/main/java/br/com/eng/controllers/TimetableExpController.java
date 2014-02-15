package br.com.eng.controllers;

import static br.com.caelum.vraptor.view.Results.json;
import br.com.caelum.vraptor.Consumes;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.eng.beans.TimetableExp;
import br.com.eng.services.TimetableExpService;

@Resource
public class TimetableExpController {
	
	private Result result;
	private TimetableExpService service;
	
	public TimetableExpController(Result result, TimetableExpService service) {
		this.result = result;
		this.service = service;
	}

	public void managertimetableexp() {

	}

	public void gridtimetableexp() {
		result.include("listTimetable", service.list());
	}
	
	@Consumes("application/json")
	public void save(TimetableExp timetableExp) {
		this.result.use(json()).from(service.insert(timetableExp)).serialize();
	}
	
	@Consumes("application/json")
	public void edit(TimetableExp timetableExp) {
		this.result.use(json()).from(service.update(timetableExp)).serialize();
	}
	
	@Consumes("application/json")
	public void delete(Long id) {
		this.result.use(json()).from(service.delete(id)).serialize();
	}
}
