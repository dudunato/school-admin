package br.com.eng.controllers;

import static br.com.caelum.vraptor.view.Results.json;
import br.com.caelum.vraptor.Consumes;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.eng.beans.Group;
import br.com.eng.services.GroupService;

@Resource
public class GroupController {

	private Result result;
	private GroupService service;

	public GroupController(Result result, GroupService service) {
		this.result = result;
		this.service = service;
	}

	public void managergroup() {

	}

	public void gridgroup() {
		result.include("listGroup", service.list());
	}

	@Consumes("application/json")
	public void save(Group group) {
		this.result.use(json()).from(service.insert(group)).serialize();
	}

	@Consumes("application/json")
	public void edit(Group group) {
		this.result.use(json()).from(service.update(group)).serialize();
	}

	@Consumes("application/json")
	public void del(Long id) {
		this.result.use(json()).from(service.delete(id)).serialize();
	}

	public void list() {
		result.include("listGroup", service.list());
	}
}
