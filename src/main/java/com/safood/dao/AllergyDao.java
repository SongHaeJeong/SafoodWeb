package com.safood.dao;

import java.util.List;

import com.safood.vo.Allergy;

public interface AllergyDao {

	List<Allergy> getAllergyList(int foodCode);
	List<Allergy> getWholeAllergies();
}
