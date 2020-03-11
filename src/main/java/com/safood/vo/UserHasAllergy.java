package com.safood.vo;

public class UserHasAllergy {
	private String uaid, userId, allergyId;

	public UserHasAllergy(String uaid, String userId, String allergyId) {
		super();
		this.uaid = uaid;
		this.userId = userId;
		this.allergyId = allergyId;
	}

	public String getUaid() {
		return uaid;
	}

	public void setUaid(String uaid) {
		this.uaid = uaid;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getAllergyId() {
		return allergyId;
	}

	public void setAllergyId(String allergyId) {
		this.allergyId = allergyId;
	}
	
	
	
}
