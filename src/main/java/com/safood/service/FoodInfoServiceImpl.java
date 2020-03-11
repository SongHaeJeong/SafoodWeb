package com.safood.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.safood.dao.AllergyDao;
import com.safood.dao.FoodDao;
import com.safood.vo.Allergy;
import com.safood.vo.Food;

@Controller
public class FoodInfoServiceImpl implements FoodInfoService {
	@Autowired
	FoodDao dao;
	@Autowired
	AllergyDao adao;
	
	@Override
	public List<Food> searchAll() {
		return dao.searchAll();
	}
	
	@Override
	public List<Food> searchAllByPage(int page, int numOfItems) {
		return dao.searchAllByPage(page, numOfItems);
	}

	@Override
	public Food selectOneByCode(String foodCode) {
		// TODO Auto-generated method stub
		return dao.searchCode(foodCode);
	}

	@Override
	public boolean addFood(Food food) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<Food> searchByName(String name) {
		// TODO Auto-generated method stub
		return dao.searchName(name);
	}
	@Override
	public List<Food> detailSearch(String str1, String str2, String str3, String string) {
		return dao.detailSearch(str1, str2, str3, string);
	}

	@Override
	public List<Food> searchByAllergy(String allergy) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Food> searchByBrand(String brand) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Food> searchByMaterial(String material) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Food> searchBest() {
		return null;
	}

	@Override
	public List<Food> searchBestIndex() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Allergy> getAllergyList(String foodCode) {
		return dao.getAllergyList(foodCode);
	}

	@Override
	public List<Allergy> getWholeAllergies() {
		
		return adao.getWholeAllergies();
	}

	@Override
	public void insertSearchLog(String keyword, String userName) {
		dao.insertSearchLog(keyword,userName);
	}

	@Override
	public List<String> searchLog() {
		return dao.searchLog();
	}

	@Override
	public List<Food> searchLowCal(String string, String cal_number) {
		return dao.searchLowCal(string, cal_number);
	}

	@Override
	public List<Food> mainPageSearch(HashMap hm) {
		return dao.mainPageSearch(hm);
	}



	
}
