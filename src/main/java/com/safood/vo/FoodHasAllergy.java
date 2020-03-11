package com.safood.vo;

public class FoodHasAllergy {
	private String faId, foodCode, allergyId;

	public FoodHasAllergy(String faId, String foodCode, String allergyId) {
		super();
		this.faId = faId;
		this.foodCode = foodCode;
		this.allergyId = allergyId;
	}

	public String getFaId() {
		return faId;
	}

	public void setFaId(String faId) {
		this.faId = faId;
	}

	public String getFoodCode() {
		return foodCode;
	}

	public void setFoodCode(String foodCode) {
		this.foodCode = foodCode;
	}

	public String getAllergyId() {
		return allergyId;
	}

	public void setAllergyId(String allergyId) {
		this.allergyId = allergyId;
	}
	
	
}
