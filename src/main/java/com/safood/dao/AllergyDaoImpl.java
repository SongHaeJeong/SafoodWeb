package com.safood.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.safood.mapper.AllergyMapper;
import com.safood.vo.Allergy;

@Controller
public class AllergyDaoImpl implements AllergyDao {
	
	@Autowired
	AllergyMapper mapper;
	
	
	@Override
	public List<Allergy> getAllergyList(int foodCode) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Allergy> getWholeAllergies() {
		return mapper.getWholeAllergies();
	}
}
