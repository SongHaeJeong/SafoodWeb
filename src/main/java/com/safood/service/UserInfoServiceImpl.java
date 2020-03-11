package com.safood.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mysql.cj.conf.ConnectionUrlParser.Pair;
import com.safood.dao.FoodDao;
import com.safood.dao.UserDao;
import com.safood.vo.Allergy;
import com.safood.vo.Food;
import com.safood.vo.User;

@Service
public class UserInfoServiceImpl implements UserInfoService {

	@Autowired
	UserDao dao;
	@Autowired 
	FoodDao Fdao;
	
	
	
	@Override
	public int loginUser(String id, String pw) {
		// TODO Auto-generated method stub
		return dao.userLogin(id, pw);
	}

	@Override
	public void registerUser(User user) {
		// TODO Auto-generated method stub
		dao.userAdd(user);
	}

	@Override
	public void deleteUser(String id) {
		dao.userDelete(id);
	}

	@Override
	public void updateUser(User user) {
		// TODO Auto-generated method stub
		dao.userUpdate(user);
	}


	@Override
	public List<Food> getEatenFoodList(String id) {
		// TODO Auto-generated method stub
		return dao.getEatenFoodList(id);
	}

	@Override
	public List<Food> getWishFoodList(String id) {
		return dao.getWishFoodList(id); 
	}

	@Override
	public User userConfirm(String id) {
		// TODO Auto-generated method stub
		return dao.userConfirm(id);
	}

	@Override
	public void addEatenFood(String id, String code) {
		Fdao.insertFoodLog(id, code);
	}
	@Override
	public void addWishFood(String id, String code) {
		Fdao.insertWishFood(id, code);
	}

	@Override
	public void deleteWishFood(String wishFoodId) {
		Fdao.deleteWishFood(wishFoodId);
	}

	@Override
	public void deleteEatenFood(String foodLogId) {
		// TODO Auto-generated method stub
		Fdao.deleteEatenFood(foodLogId);
	}	
	

	@Override
	public List<Pair> bestEaten(String userid) {
		return Fdao.bestEaten(userid); 
	}

	@Override
	public List<Pair> bestAllEaten() {
		return Fdao.bestAllEaten();
	}

	
	
	
	
	
	@Override
	public void addAllergy(String id, String allergy) {
		dao.addAllergy(id, allergy);
	}
	
	@Override
	public List<Allergy> getAllergyList(String id) {
		return dao.getAllergyList(id);
	}
	@Override
	public void deleteAllergy(String id) {
		dao.deleteAllergy(id);
	}


	
	
	
}
