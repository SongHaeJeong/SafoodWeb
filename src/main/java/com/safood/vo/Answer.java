package com.safood.vo;

public class Answer {
	private String aid;
	private String acontent;
	private String awdate;
	private String qaid;
	public Answer() {
		super();
	}
	public Answer(String aid, String acontent, String awdate, String qaid) {
		super();
		this.aid = aid;
		this.acontent = acontent;
		this.awdate = awdate;
		this.qaid = qaid;
	}
	public String getAid() {
		return aid;
	}
	public void setAid(String aid) {
		this.aid = aid;
	}
	public String getAcontent() {
		return acontent;
	}
	public void setAcontent(String acontent) {
		this.acontent = acontent;
	}
	public String getAwdate() {
		return awdate;
	}
	public void setAwdate(String awdate) {
		this.awdate = awdate;
	}
	public String getQaid() {
		return qaid;
	}
	public void setQaid(String qaid) {
		this.qaid = qaid;
	}
	
	

	
	
	
}
