package com.example.demo.board;

import java.sql.Date;
import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import com.example.demo.reply.Reply;

public class Board {
	 private int num;
	 private String type; //faq / notice
	 private String writer;
	 private String title;
	 private String content;
	 private Date regdate;
	 private Date updatedate;
	 
	public Board() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	public Board(String type, String title, String content) {
		super();
		this.type = type;
		this.title = title;
		this.content = content;
	}


	public Board(int num, String type, String writer, String title, String content, Date regdate, Date updatedate) {
		super();
		this.num = num;
		this.type = type;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.regdate = regdate;
		this.updatedate = updatedate;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public Date getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
	}
	@Override
	public String toString() {
		return "Board [num=" + num + ", type=" + type + ", writer=" + writer + ", title=" + title + ", content="
				+ content + ", regdate=" + regdate + ", updatedate=" + updatedate + "]";
	}
	 
	 


	
	


	
	
}
