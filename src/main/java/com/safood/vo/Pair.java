package com.safood.vo;

public class Pair {
	private String first;
	private String second;
	public String getFirst() {
		return first;
	}
	public void setFirst(String first) {
		this.first = first;
	}
	public String getSecond() {
		return second;
	}
	public void setSecond(String second) {
		this.second = second;
	}
	public Pair(String first, String second) {
		super();
		this.first = first;
		this.second = second;
	}
	public Pair() {
		super();
	}
	
	
}
