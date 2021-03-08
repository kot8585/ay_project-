package com.example.demo.review;

import java.sql.Date;
import java.util.Arrays;

import org.springframework.web.multipart.MultipartFile;

class ddd{
	
}

public class Review {

	private int num;
	private int pnum;
	private int rnum;
	private String title;
	private String writer;
	private String content;
	private String stars;
	private String likey;
	private MultipartFile[] uploadFile;
	private String path;
	private String path2;
	private Date pdate;
	private String id;
	private String pname;
	private String what;
	   
	public Review() {
		super();
	}


	 
	 

	public Review(int num, int pnum, int rnum, String title, String writer, String content, String stars, String likey,
			MultipartFile[] uploadFile, String path, String path2, Date pdate, String id, String pname, String what) {
		super();
		this.num = num;
		this.pnum = pnum;
		this.rnum = rnum;
		this.title = title;
		this.writer = writer;
		this.content = content;
		this.stars = stars;
		this.likey = likey;
		this.uploadFile = uploadFile;
		this.path = path;
		this.path2 = path2;
		this.pdate = pdate;
		this.id = id;
		this.pname = pname;
		this.what = what;
	}





	public String getPname() {
		return pname;
	}





	public void setPname(String pname) {
		this.pname = pname;
	}





	public String getWhat() {
		return what;
	}





	public void setWhat(String what) {
		this.what = what;
	}





	public String getPath2() {
		return path2;
	}

	public void setPath2(String path2) {
		this.path2 = path2;
	}

	public MultipartFile[] getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(MultipartFile[] uploadFile) {
		this.uploadFile = uploadFile;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getLikey() {
		return likey;
	}
	public void setLikey(String likey) {
		this.likey = likey;
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
		return "Review [num=" + num + ", pnum=" + pnum + ", rnum=" + rnum + ", title=" + title + ", writer=" + writer
				+ ", content=" + content + ", stars=" + stars + ", likey=" + likey + ", uploadFile="
				+ Arrays.toString(uploadFile) + ", path=" + path + ", pdate=" + pdate + ", id=" + id + "]";
	}

	public String category() {
		return "num,pnum,title,writer,content,pdate,methodName\n";
	}

	public String content() {
		return num + "," + pnum + "," + title + "," + writer + "," + content + "," + pdate;
	}      
	   
}
