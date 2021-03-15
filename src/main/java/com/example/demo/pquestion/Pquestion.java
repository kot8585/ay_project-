package com.example.demo.pquestion;

import java.sql.Date;
import java.util.ArrayList;

import com.example.demo.pqreply.PqReply;

public class Pquestion {

	private int num;
	private int pnum;
	private String writer;
	private String content;
	private Date p_date;
	private String state; //답변상태(답변대기, 답변완료) 처음에 db에 넣을때는 답변대기로 넣고 가져올때 다시 set하기,
	private ArrayList<PqReply> pqreply;
	private Date updatedate;
	
	public Pquestion() {
		super();
	}

	public Pquestion(int num, int pnum, String writer, String content, Date p_date, String state,
			ArrayList<PqReply> pqreply, Date updatedate) {
		super();
		this.num = num;
		this.pnum = pnum;
		this.writer = writer;
		this.content = content;
		this.p_date = p_date;
		this.state = state;
		this.pqreply = pqreply;
		this.updatedate = updatedate;
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

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public ArrayList<PqReply> getPqreply() {
		return pqreply;
	}

	public void setPqreply(ArrayList<PqReply> pqreply) {
		this.pqreply = pqreply;
	}

	public Date getUpdatedate() {
		return updatedate;
	}

	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
	}

	@Override
	public String toString() {
		return "Pquestion [num=" + num + ", pnum=" + pnum + ", writer=" + writer + ", content=" + content + ", p_date="
				+ p_date + ", state=" + state + ", pqreply=" + pqreply + ", updatedate=" + updatedate + "]";
	}


	
	
	
	
}
