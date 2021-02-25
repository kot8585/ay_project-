package com.example.demo.event;

import org.springframework.web.multipart.MultipartFile;
/**
 * 
 * @author KPK
 * @since 2021-02-23 
 * Event DB로부터 값을 저장할 DTO class
 */
public class Event {
	private int num; // 이벤트 번호, PRIMARY KEY
	private String name; // 이벤트 명
	private float sale; // 할인률
	private String imgPath; // DB에는 없다. 이미지 경로를 저장하여 이벤트 이미지를 getImg()로 띄울 때 사용한다.
	private MultipartFile file; // DB에는 없다. saveEventImg() 메소드 실행시 사용한다.
	
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
