package com.safood.service;

import java.util.HashMap;
import java.util.List;

import com.safood.vo.Allergy;
import com.safood.vo.Food;
import com.safood.vo.Notice;
import com.safood.vo.User;

public interface FoodInfoService {
	public List<Food> searchAll();
	public Food selectOneByCode(String foodCode);	
	public List<Food> searchAllByPage(int page, int numOfItems);
	
	public boolean addFood(Food food);
	public List<Food> searchByName(String name);
	public List<Food> searchByAllergy(String allergy);
	public List<Food> searchByBrand(String brand);
	public List<Food> searchByMaterial(String material);
	
	public List<Food> searchBest();
	public List<Food> searchBestIndex();
	
	public List<Allergy> getAllergyList(String foodcode);
	public List<Allergy> getWholeAllergies();
	public void insertSearchLog(String keyword, String userName);
	public List<String> searchLog();
	public List<Food> searchLowCal(String string, String cal_number);
	public List<Food> detailSearch(String str1, String str2, String str3, String string);
	public List<Food> mainPageSearch(HashMap hm);
}
