package com.example.demo.pqreply;

import java.sql.Date;

public class PqReply {
	private int num;
	private int pqnum;
	private String writer;
	private String content;
	private Date pqdate;
	
	public PqReply() {
		super();
	}
	public PqReply(int num, int pqnum, String writer, String content, Date pqdate) {
		super();
		this.num = num;
		this.pqnum = pqnum;
		this.writer = writer;
		this.content = content;
		this.pqdate = pqdate;
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
	public Date getPqdate() {
		return pqdate;
	}
	public void setPqdate(Date pqdate) {
		this.pqdate = pqdate;
	}
	@Override
	public String toString() {
		return "PqReply [num=" + num + ", pqnum=" + pqnum + ", writer=" + writer + ", content=" + content + ", pqdate="
				+ pqdate + "]";
	}
	
	
	
}