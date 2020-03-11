package com.safood.vo;

public class Question {
	private String qid;
	private String userid;
	private String title; 
	private String wdate;
	private String content;
	public Question() {
		super();
	}
	public Question(String qid, String title, String wdate, String content) {
		super();
		this.qid = qid;
		this.title = title;
		this.wdate = wdate;
		this.content = content;
	}
	
	
	public Question(String qid, String userid, String title, String wdate, String content) {
		super();
		this.qid = qid;
		this.userid = userid;
		this.title = title;
		this.wdate = wdate;
		this.content = content;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getQid() {
		return qid;
	}
	public void setQid(String qid) {
		this.qid = qid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	
}
