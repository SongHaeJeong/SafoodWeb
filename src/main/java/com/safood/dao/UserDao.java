package com.safood.dao;

import java.util.ArrayList;
import java.util.List;

import com.safood.vo.Allergy;
import com.safood.vo.Food;
import com.safood.vo.User;

public interface UserDao {
	
	//회원등록
	public void userAdd(User u);

//회원 수정
	public void userUpdate(User user);
	
//회원 삭제
	public void userDelete(String id);
	
//로그인
	public int userLogin(String id, String pass);

//유저 검색
	public User userConfirm(String id);
	
//회원 섭취 음식 확인
	public ArrayList<Food> getEatenFoodList(String id);

	public ArrayList<Food> getWishFoodList(String id);

//회원 Allergy 관련
	public void addAllergy(String id, String allergy);
	
	public void deleteAllergy(String id);

	public List<Allergy> getAllergyList(String id);
}
