package com.safood.service;

import java.util.List;

import com.mysql.cj.conf.ConnectionUrlParser.Pair;
import com.safood.vo.Allergy;
import com.safood.vo.Food;
import com.safood.vo.User;

public interface UserInfoService {
	public int loginUser(String id, String pw); //수정
	public User userConfirm(String id);  //수정
	public void registerUser(User user); //수정
	public void	deleteUser(String id); //수정
	public void updateUser(User user); //수정
	public void addEatenFood(String id, String code);
	public List<Food> getEatenFoodList(String id);
	public List<Food> getWishFoodList(String id);
	
	
	
	
	// 알러지 관련 작업
	List<Allergy> getAllergyList(String id); //유저가 가지고 있는 알레르기
	public void addAllergy(String id, String allergy);
	public void deleteAllergy(String id);
	
	
	
	
	// 섭취, 찜 목록
	public void addWishFood(String id, String code);
	public void deleteWishFood(String wishFoodId);
	public void deleteEatenFood(String foodLogId);
	public List<Pair> bestEaten(String userid);
	public List<Pair> bestAllEaten();
	
}
