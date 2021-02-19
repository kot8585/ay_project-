package com.example.demo.review;

import java.sql.Date;

public class Review {

	 private int num;
	 private int pnum;
	 private String title;
	 private String writer;
	 private String content;
	 private String stars;


	private Date pdate;
	   
	public Review() {
		super();
	}
	public Review(int num, int pnum, String title, String writer, String content, Date pdate, String stars) {
		super();
		this.num = num;
		this.pnum = pnum;
		this.title = title;
		this.writer = writer;
		this.content = content;
		this.pdate = pdate;
		this.stars = stars;
	}
	 public String getStars() {
		return stars;
	}
	public void setStars(String stars) {
		this.stars = stars;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getPdate() {
		return pdate;
	}
	public void setPdate(Date pdate) {
		this.pdate = pdate;
	}
	@Override
	public String toString() {
		return "Review [num=" + num + ", pnum=" + pnum + ", title=" + title + ", writer=" + writer + ", content="
				+ content + ", pdate=" + pdate + "]";
	}
	
	public String category() {
		return "num,pnum,title,writer,content,pdate,methodName\n";
	}

	public String content() {
		return num + "," + pnum + "," + title + "," + writer + "," + content + "," + pdate;
	}      
	   
}
