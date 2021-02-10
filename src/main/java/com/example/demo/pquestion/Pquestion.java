package com.example.demo.pquestion;

import java.sql.Date;

public class Pquestion {

	private int num;
	private int p_num;
	private String writer;
	private String title;
	private String content;
	private Date p_date;
	private String path;
	public Pquestion() {
		super();
	}
	public Pquestion(int num, int p_num, String writer, String title, String content, Date p_date, String path) {
		super();
		this.num = num;
		this.p_num = p_num;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.p_date = p_date;
		this.path = path;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getP_num() {
		return p_num;
	}
	public void setP_num(int p_num) {
		this.p_num = p_num;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
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
	public Date getP_date() {
		return p_date;
	}
	public void setP_date(Date p_date) {
		this.p_date = p_date;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	@Override
	public String toString() {
		return "Pquestion [num=" + num + ", p_num=" + p_num + ", writer=" + writer + ", title=" + title + ", content="
				+ content + ", p_date=" + p_date + ", path=" + path + "]";
	}

	
}
