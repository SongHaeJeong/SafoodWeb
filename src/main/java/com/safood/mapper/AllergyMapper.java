package com.safood.mapper;

import java.util.List;

import com.safood.vo.Allergy;

public interface AllergyMapper {
	List<Allergy> getAllergyList(int foodCode);
	List<Allergy> getWholeAllergies();
}
