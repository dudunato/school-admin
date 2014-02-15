package br.com.eng.controllers;

import static br.com.caelum.vraptor.view.Results.json;
import br.com.caelum.vraptor.Consumes;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.eng.beans.Timetable;
import br.com.eng.services.TimetableService;

@Resource
public class TimetableController {

	private Result result;
	private TimetableService service;

	public TimetableController(Result result, TimetableService service) {
		this.result = result;
		this.service = service;
	}

	public void managertimetable() {

	}

	public void gridtimetable() {
		result.include("listTimetable", service.list());
	}

	@Consumes("application/json")
	public void save(Timetable timetable) {
		this.result.use(json()).from(service.insert(timetable)).serialize();
	}
	
	@Consumes("application/json")
	public void del(Timetable timetable) {
		this.result.use(json()).from(service.delete(timetable)).serialize();
	}

}
