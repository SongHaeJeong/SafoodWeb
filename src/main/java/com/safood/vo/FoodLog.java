package com.safood.vo;

public class FoodLog {
	private String foodLogId, userId, foodCode;

	public FoodLog(String foodLogId, String userId, String foodCode) {
		super();
		this.foodLogId = foodLogId;
		this.userId = userId;
		this.foodCode = foodCode;
	}

	public String getFoodLogId() {
		return foodLogId;
	}

	public void setFoodLogId(String foodLogId) {
		this.foodLogId = foodLogId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getFoodCode() {
		return foodCode;
	}

	public void setFoodCode(String foodCode) {
		this.foodCode = foodCode;
	}
	
	
	
	
	
	
}
