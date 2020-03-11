package com.safood.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.mysql.cj.conf.ConnectionUrlParser.Pair;
import com.safood.vo.Allergy;
import com.safood.vo.Food;
import com.safood.vo.User;

public interface FoodDao {
	public List<Food> searchAll();
	public List<Food> searchAllByPage(int page, int numOfItems);
	
	public Food confirmFood(int code);
	/**
	 * 
	 */
	public Food searchCode(String foodCode);


	public List<Allergy> getAllergies();
	public List<Food> searchBest();
	public List<Food> searchBestIndex();
	public List<Food> searchName(String name);

	public void insertFoodLog(String id, String food);
	public ArrayList<Food> getEatenFoodList(String id);

	public void insertWishFood(String id, String code);

	public void deleteWishFood(String wishFoodId);

	public void deleteEatenFood(String foodLogId);
	public void insertSearchLog(String keyword, String userName);
	public List<String> searchLog();
	public List<Food> searchLowCal(String string, String cal_number);
	public List<Pair> bestEaten(String userid);
	public List<Pair> bestAllEaten();
	public List<Allergy> getAllergyList(String foodCode);
	public List<Food> detailSearch(String str1, String str2, String str3, String string);
	public List<Food> mainPageSearch(HashMap hm);
}
