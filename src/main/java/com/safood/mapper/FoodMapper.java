package com.safood.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.mysql.cj.conf.ConnectionUrlParser.Pair;
import com.safood.vo.Allergy;
import com.safood.vo.Food;
import com.safood.vo.User;

public interface FoodMapper {
	public List<Food> searchAll();
	public Food searchCode(String code);
	public List<Food> searchAllByPage(int page, int numOfItems);
	public List<Food> searchName(String name);
	public List<Food> searchMaker(String maker);
	public List<Food> searchMaterial(String material);
	
	public Food confirmFood(int code);
	public List<Allergy> getAllergies();
	public List<Food> searchBest();
	public List<Food> searchBestIndex();

	public void insertFoodLog(String id, String code);
	public ArrayList<Food> getEatenFoodList(String id);

	public void insertWishFood(String id, String code);

	public void deleteWishFood(String wishFoodId);

	public void deleteEatenFood(String foodLogId);
	public void insertSearchLog(String keyword);
	public void insertSearchLog(String keyword, String userName);
	public List<String> searchLog();
	public List<Food> searchLowCal(String string, String cal_number);
	public List<Pair> bestEaten(String userid);
	public List<Pair> bestAllEaten();
	public List<Allergy> getAllergyList(String foodCode);
	public List<Food> detailSearch(String calory_min, String calory_max, String carbo_min, String carbo_max,
			String protein_min, String protein_max, String fat_min, String fat_max, String sugar_min, String sugar_max,
			String natrium_min, String natrium_max, String chole_min, String chole_max, String fattyacid_min,
			String fattyacid_max, String transfat_min, String transfat_max,String keyword);
	public List<Food> mainPageSearch(HashMap hm);
}
