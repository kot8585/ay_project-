package com.example.demo.reply;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class Reply {
	private int num;
	private int qna_num;
	private String writer;
	private String content;
	private Date r_date;

	public Reply() {}

	public Reply(int num, int qna_num, String writer, String content, Date r_date) {
		super();
		this.num = num;
		this.qna_num = qna_num;
		this.writer = writer;
		this.content = content;
		this.r_date = r_date;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getQna_num() {
		return qna_num;
	}

	public void setQna_num(int qna_num) {
		this.qna_num = qna_num;
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

	public Date getR_date() {
		return r_date;
	}

	public void setR_date(Date r_date) {
		this.r_date = r_date;
	}


	@Override
	public String toString() {
		return "Reply [num=" + num + ", qna_num=" + qna_num + ", writer=" + writer + ", content=" + content
				+ ", r_date=" + r_date +  "]";
	}

	public String category() {
		return "num,qna_num,writer,content,methodName\n";
	}

	public String content() {
		return num + "," + qna_num + "," + writer + "," + content + "," + r_date;
	}
}