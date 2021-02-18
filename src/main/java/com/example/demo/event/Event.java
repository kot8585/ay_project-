package com.example.demo.event;

import org.springframework.web.multipart.MultipartFile;

public class Event {
	private int num;
	private String name;
	private float sale;
	private String imgPath;
	private MultipartFile file;
	
	public Event() {
		super();
	}

	public Event(int num, String name, float sale, String imgPath, MultipartFile file) {
		super();
		this.num = num;
		this.name = name;
		this.sale = sale;
		this.imgPath = imgPath;
		this.file = file;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public float getSale() {
		return sale;
	}

	public void setSale(float sale) {
		this.sale = sale;
	}

	public String getImgPath() {
		return imgPath;
	}

	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	@Override
	public String toString() {
		return "Event [num=" + num + ", name=" + name + ", sale=" + sale + ", imgPath=" + imgPath + ", file=" + file
				+ "]";
	}
	
	
}
