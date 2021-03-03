package com.example.demo.review;

public class ReviewLike {
	
	private int rnum;
	private int num;
	private String id;
	public ReviewLike(int rnum, int num, String id) {
		super();
		this.rnum = rnum;
		this.num = num;
		this.id = id;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	@Override
	public String toString() {
		return "ReviewLike [rnum=" + rnum + ", num=" + num + ", id=" + id + "]";
	}
	
	

}
