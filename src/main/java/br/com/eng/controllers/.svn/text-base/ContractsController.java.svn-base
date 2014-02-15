package br.com.eng.controllers;

import static br.com.caelum.vraptor.view.Results.json;
import br.com.caelum.vraptor.Consumes;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.eng.beans.Contract;
import br.com.eng.services.ContractService;

@Resource
public class ContractsController {

	private Result result;
	private ContractService service;

	public ContractsController(Result result, ContractService service) {
		this.result = result;
		this.service = service;
	}

	public void managercontracts() {

	}

	@Consumes("application/json")
	public void save(Contract contract) {
		this.result.use(json()).from(service.insert(contract)).serialize();
	}

	@Consumes("application/json")
	public void edit(Contract contract) {
		this.result.use(json()).from(service.update(contract)).serialize();
	}

	public void gridcontracts() {
		result.include("listContract", service.list());
	}
	
	@Path("/contracts/printcontract/{studentId}")
	public void printcontract(Integer studentId) {
		result.include("contract", service.select(studentId));
		result.include("student", service.getStudent(studentId));
	}

}
