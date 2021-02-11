package com.example.demo.qna;

import java.sql.Date;
import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import com.example.demo.reply.Reply;

public class Qna {
	private int num; 
	private String writer;
	private int o_history ; //주문 내역 
	private String q_cate; //문의 종류
	private String pwd;
	private String title;
	private String content;
	private String state; //답변상태(답변대기, 답변완료) 처음에 db에 넣을때는 답변대기로 넣고 가져올때 다시 set하기, 
	private Date regdate;
	private Date updatedate;
	private String path;
	private MultipartFile file1;
	private MultipartFile file2;
	private MultipartFile file3;
	
	public Qna() {}

	public Qna(int num, String writer, int o_history, String q_cate, String pwd, String title, String content, String state,
			Date regdate, Date updatedate) {
		super();
		this.num = num;
		this.writer = writer;
		this.o_history = o_history;
		this.q_cate = q_cate;
		this.pwd = pwd;
		this.title = title;
		this.content = content;
		this.state = state;
		this.regdate = regdate;
		this.updatedate = updatedate;
	}

	public Qna(int num, String writer, int o_history, String q_cate, String pwd, String title, String content, String state,
			Date regdate, Date updatedate, String path, MultipartFile file1, MultipartFile file2, MultipartFile file3) {
		super();
		this.num = num;
		this.writer = writer;
		this.o_history = o_history;
		this.q_cate = q_cate;
		this.pwd = pwd;
		this.title = title;
		this.content = content;
		this.state = state;
		this.regdate = regdate;
		this.updatedate = updatedate;
		this.path = path;
		this.file1 = file1;
		this.file2 = file2;
		this.file3 = file3;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public int getO_history() {
		return o_history;
	}

	public void setO_history(int o_history) {
		this.o_history= o_history;
	}

	public String getQ_cate() {
		return q_cate;
	}

	public void setQ_cate(String q_cate) {
		this.q_cate = q_cate;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
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

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
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

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public MultipartFile getFile1() {
		return file1;
	}

	public void setFile1(MultipartFile file1) {
		this.file1 = file1;
	}

	public MultipartFile getFile2() {
		return file2;
	}

	public void setFile2(MultipartFile file2) {
		this.file2 = file2;
	}

	public MultipartFile getFile3() {
		return file3;
	}

	public void setFile3(MultipartFile file3) {
		this.file3 = file3;
	}

	@Override
	public String toString() {
		return "Qna [num=" + num + ", writer=" + writer + ", o_history=" + o_history + ", q_cate=" + q_cate + ", pwd=" + pwd
				+ ", title=" + title + ", content=" + content + ", state=" + state + ", regdate=" + regdate
				+ ", updatedate=" + updatedate + ", path=" + path + ", file1=" + file1 + ", file2=" + file2 + ", file3="
				+ file3 + "]";
	}

	
	
}
