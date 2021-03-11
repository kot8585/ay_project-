package com.example.demo.pquestion;

import java.sql.Date;
import java.util.ArrayList;

import com.example.demo.pqreply.PqReply;

public class Pquestion {

	private int num;
	private int pnum;
	private String writer;
	private String title;
	private String content;
	private Date p_date;
	private ArrayList<PqReply> pqreply;

	
	public Pquestion() {
		super();
	}


	public Pquestion(int num, int pnum, String writer, String title, String content, Date p_date,
			ArrayList<PqReply> pqreply) {
		super();
		this.num = num;
		this.pnum = pnum;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.p_date = p_date;
		this.pqreply = pqreply;
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


	public ArrayList<PqReply> getPqreply() {
		return pqreply;
	}


	public void setPqreply(ArrayList<PqReply> pqreply) {
		this.pqreply = pqreply;
	}


	@Override
	public String toString() {
		return "Pquestion [num=" + num + ", pnum=" + pnum + ", writer=" + writer + ", title=" + title + ", content="
				+ content + ", p_date=" + p_date + ", pqreply=" + pqreply + "]";
	}


	

	
	
	
}
