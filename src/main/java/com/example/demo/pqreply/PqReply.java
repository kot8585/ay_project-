package com.example.demo.pqreply;

import java.sql.Date;

public class PqReply {
	private int num;
	private int pqnum;
	private String writer;
	private String content;
	private Date pq_date;
	public PqReply() {
		super();
	}
	public PqReply(int num, int pqnum, String writer, String content, Date pq_date) {
		super();
		this.num = num;
		this.pqnum = pqnum;
		this.writer = writer;
		this.content = content;
		this.pq_date = pq_date;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getPqnum() {
		return pqnum;
	}
	public void setPqnum(int pqnum) {
		this.pqnum = pqnum;
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
	public Date getPq_date() {
		return pq_date;
	}
	public void setPq_date(Date pq_date) {
		this.pq_date = pq_date;
	}
	@Override
	public String toString() {
		return "PqReply [num=" + num + ", pqnum=" + pqnum + ", writer=" + writer + ", content=" + content + ", pq_date="
				+ pq_date + "]";
	}

	
}