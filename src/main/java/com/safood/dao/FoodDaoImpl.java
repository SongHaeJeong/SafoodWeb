package com.safood.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.mysql.cj.conf.ConnectionUrlParser.Pair;
import com.safood.mapper.FoodMapper;
import com.safood.vo.Allergy;
import com.safood.vo.Food;
import com.safood.vo.User;

@Controller
public class FoodDaoImpl implements FoodDao {
	@Autowired
	FoodMapper mapper;
	
	@Override
	public List<Food> searchAll() {
		return mapper.searchAll();
	}
	@Override
	public List<Food> searchAllByPage(int page, int numOfItems) {
		return mapper.searchAllByPage((page-1) * numOfItems, numOfItems);
	}

	@Override
	public List<Food> searchName(String name) {
		// TODO Auto-generated method stub
		return mapper.searchName(name);
	}
	@Override
	public List<Food> detailSearch(String str1, String str2, String str3, String string) {
		StringTokenizer st = new StringTokenizer(str1, " ");
		StringTokenizer st2 = new StringTokenizer(str2, " ");
		StringTokenizer st3 = new StringTokenizer(str3, " ");
		String calory_min = st2.nextToken();
		String carbo_min = st2.nextToken();
		String protein_min = st2.nextToken();
		String fat_min = st2.nextToken();
		String sugar_min = st2.nextToken();
		String natrium_min = st2.nextToken();
		String chole_min = st2.nextToken();
		String fattyacid_min = st2.nextToken();
		String transfat_min = st2.nextToken();
		String calory_max = st.nextToken();
		String carbo_max = st.nextToken();
		String protein_max = st.nextToken();
		String fat_max = st.nextToken();
		String sugar_max = st.nextToken();
		String natrium_max = st.nextToken();
		String chole_max = st.nextToken();
		String fattyacid_max = st.nextToken();
		String transfat_max = st.nextToken();
		String keyword = string;
		return mapper.detailSearch(calory_min,calory_max, carbo_min, carbo_max
				,protein_min, protein_max, fat_min, fat_max,sugar_min, sugar_max, natrium_min, natrium_max,
				chole_min, chole_max,fattyacid_min,fattyacid_max, transfat_min, transfat_max,keyword);
				
	}
	
	
	@Override
	public Food confirmFood(int code) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Food searchCode(String code) {
		// TODO Auto-generated method stub
		return mapper.searchCode(code);
	}

	@Override
	public List<Allergy> getAllergies() { //모든 음식에 대한 알러지 정보
		return mapper.getAllergies();
	}

	@Override
	public List<Food> searchBest() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Food> searchBestIndex() {
		// TODO Auto-generated method stub
		return null;
	}



	@Override
	public ArrayList<Food> getEatenFoodList(String id) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public void insertFoodLog(String id, String code) {
		mapper.insertFoodLog(id, code);
		
	}

	@Override
	public void insertWishFood(String id, String code) {
		mapper.insertWishFood(id,code);
	}

	@Override
	public void deleteWishFood(String wishFoodId) {
		mapper.deleteWishFood(wishFoodId);
	}

	@Override
	public void deleteEatenFood(String foodLogId) {
		mapper.deleteEatenFood(foodLogId);
	}
	@Override
	public void insertSearchLog(String keyword, String userName) {
		mapper.insertSearchLog(keyword, userName);
	}
	
	//음식검색어 순위
	@Override
	public List<String> searchLog() {
		return mapper.searchLog();
	}
	@Override
	public List<Food> searchLowCal(String string, String cal_number) {
		return mapper.searchLowCal(string, cal_number);
	}
	@Override
	public List<Pair> bestEaten(String userid) {
		return mapper.bestEaten(userid);
	}
	@Override
	public List<Pair> bestAllEaten() {
		return mapper.bestAllEaten();
	}
	@Override
	public List<Allergy> getAllergyList(String foodCode) {
		return mapper.getAllergyList(foodCode);
	}
	@Override
	public List<Food> mainPageSearch(HashMap hm) {
		return mapper.mainPageSearch(hm);
	}

	
	
}
