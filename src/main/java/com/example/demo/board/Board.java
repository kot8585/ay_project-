package com.example.demo.board;

import java.sql.Date;
import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import com.example.demo.reply.Reply;

public class Board {
	private int num;
	private String pwd;
	private String writer;
	private String title;
	private String content;
	private Date b_date;
	private String path;
	private ArrayList<Reply> reps;
	private MultipartFile file1;
	private MultipartFile file2;
	private MultipartFile file3;
	
	

	public Board() {
		super();
	}
	
	
	public Board(int num, String pwd, String writer, String title, String content, Date b_date, String path) {
		super();
		this.num = num;
		this.pwd = pwd;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.b_date = b_date;
		this.path = path;
	}


	public Board(int num, String pwd, String writer, String title, String content, Date b_date, String path,
			ArrayList<Reply> reps, MultipartFile file1, MultipartFile file2, MultipartFile file3) {
		super();
		this.num = num;
		this.pwd = pwd;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.b_date = b_date;
		this.path = path;
		this.reps = reps;
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


	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
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

	public Date getB_date() {
		return b_date;
	}

	public void setB_date(Date b_date) {
		this.b_date = b_date;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public ArrayList<Reply> getReps() {
		return reps;
	}

	public void setReps(ArrayList<Reply> reps) {
		this.reps = reps;
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
		return "Board [num=" + num + ", pwd=" + pwd + ", writer=" + writer + ", title=" + title + ", content=" + content
				+ ", b_date=" + b_date + ", path=" + path + ", reps=" + reps + ", file1=" + file1 + ", file2=" + file2
				+ ", file3=" + file3 + "]";
	}

	
	public String category() {
		return "num,pwd,writer,title,content,b_date,path,reqs,file1,file2,file3,methodName\n";
	}

	public String content() {
		return num + "," + pwd + "," + writer + "," + title 
				+ "," + content + "," + b_date + "," + path + "," + "reps" + "," 
				+ file1.getName() + "," + file2.getName() + "," +  file3.getName();
	}
	
	
}
