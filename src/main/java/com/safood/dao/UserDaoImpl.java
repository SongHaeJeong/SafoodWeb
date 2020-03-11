package com.safood.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.safood.mapper.UserMapper;
import com.safood.vo.Allergy;
import com.safood.vo.Food;
import com.safood.vo.User;

@Controller
public class UserDaoImpl implements UserDao {

	@Autowired
	UserMapper mapper;
	
	
	@Override
	public void userAdd(User u) {
		mapper.userAdd(u);
	}

	@Override
	public void userUpdate(User user) {
		mapper.userUpdate(user);
		
	}

	@Override
	public void userDelete(String id) {
		mapper.userDelete(id);
	}

	@Override
	public int userLogin(String id, String pass) {
		// TODO Auto-generated method stub
		return mapper.userLogin(id, pass);
	}

	@Override
	public User userConfirm(String id) {
		// TODO Auto-generated method stub
		return mapper.userConfirm(id);
	}

	@Override
	public ArrayList<Food> getEatenFoodList(String id) {
		// TODO Auto-generated method stub
		return mapper.getEatenFoodList(id);
	}

	@Override
	public ArrayList<Food> getWishFoodList(String id) {
		return mapper.getWishFoodList(id);
	}
	//회원 알레르기 관리
	@Override
	public void addAllergy(String id, String allergy) {
		mapper.addAllergy(id, allergy);
	}
	

	@Override
	public void deleteAllergy(String id) {
		mapper.deleteAllergy(id);
	}

	@Override
	public List<Allergy> getAllergyList(String id) {
		return mapper.getAllergyList(id);
	}
	
}
