package com.safood.vo;

import java.util.ArrayList;

public class User {
	String id;
	String pass;
	String name;
	String email;
	String allergie;
	ArrayList<Food> eatenFood;
	ArrayList<Food> wishFood;
	
	
	
	
	public User() {
		super();
	}
	public User(String id, String pass) {
		super();
		this.id = id;
		this.pass = pass;
	}
	public User(String id, String pass, String name, String email) {
		super();
		this.id = id;
		this.pass = pass;
		this.name = name;
		this.email = email;
		eatenFood = new ArrayList<>();
		wishFood = new ArrayList<>();
	}
	public User(String id, String pass, String name, String email, String allergie) {
		super();
		this.id = id;
		this.pass = pass;
		this.name = name;
		this.email = email;
		this.allergie = allergie;
		eatenFood = new ArrayList<>();
		wishFood = new ArrayList<>();
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAllergie() {
		return allergie;
	}
	public void setAllergie(String allergie) {
		this.allergie = allergie;
	}
	
	public ArrayList<Food> getEatenFood() {
		return eatenFood;
	}
	
	
	public ArrayList<Food> getWishFood() {
		return wishFood;
	}
	public void addEatenFood(Food food) {
		eatenFood.add(food);
	}
	
	
	
}
