package br.com.eng.services;

import java.util.Collections;
import java.util.List;

import br.com.caelum.vraptor.ioc.Component;
import br.com.eng.daos.CitySateDAO;
import br.com.eng.interfaces.IGenericBean;

@Component
public class CityStateService {

	private CitySateDAO dao;

	public CityStateService(CitySateDAO dao) {
		this.dao = dao;
	}

	public List<IGenericBean> states() {
		List<IGenericBean> list = dao.listState();
		Collections.sort(list);
		return list;
	}

	public List<IGenericBean> cities(Long stateId) {
		List<IGenericBean> list = dao.listCity(stateId);
		Collections.sort(list);
		return list;

	}

}
