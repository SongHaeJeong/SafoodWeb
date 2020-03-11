package com.safood.vo;

public class Notice {
	private String nid;
	private String title;
	private String content;
	private String ndate;
	private int count;
	private String img;
	public Notice(String nid, String title, String content, String ndate, int count, String img) {
		super();
		this.nid = nid;
		this.title = title;
		this.content = content;
		this.ndate = ndate;
		this.count = count;
		this.img = img;
	}
	public String getNid() {
		return nid;
	}
	public void setNid(String nid) {
		this.nid = nid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getNdate() {
		return ndate;
	}
	public void setNdate(String ndate) {
		this.ndate = ndate;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	
	
}
