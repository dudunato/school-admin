package br.com.eng.controllers;

import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.eng.services.CityStateService;

@Resource
public class CityStateController {
	
	private Result result;
	private CityStateService service;
	
	public CityStateController(Result result, CityStateService service) {
		this.result = result;
		this.service = service;
	}
	
	public void states() {
		result.include("listState", service.states());
	}
	
	public void cities(Long stateId) {
		result.include("listCity", service.cities(stateId));
	}

}
