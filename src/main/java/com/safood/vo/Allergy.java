package com.safood.vo;

public class Allergy {
	private int aid;
	private String name;
	
	public int getAid() {
		return aid;
	}
	public void setAid(int aid) {
		this.aid = aid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public Allergy() {}
	
	public Allergy(int aid, String name) {
		this.aid = aid;
		this.name = name;
	}
	
	@Override
	public String toString() {
		return "Allergy [aid=" + aid + ", name=" + name + "]";
	}
}
