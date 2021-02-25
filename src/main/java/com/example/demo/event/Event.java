package com.example.demo.event;

import org.springframework.web.multipart.MultipartFile;

/**
 * Event에 대한 DTO입니다.
 * @author KPK
 * @version main 1
 */
public class Event {
	/**
	 * 고유 num값입니다. [PK]
	 */
	private int num; // 이벤트 번호, PRIMARY KEY
	/**
	 * 이벤트 이름값입니다. [NOT NULL]
	 */
	private String name; // 이벤트 명
	/**
	 * 이벤트 할인율입니다. [NOT NULL]
	 */
	private float sale; // 할인률
	/**
	 * 이벤트 이미지가 저장된 디렉토리의 경로값입니다. [DB에는 없는 컬럼]
	 */
	private String imgPath; // DB에는 없다. 이미지 경로를 저장하여 이벤트 이미지를 getImg()로 띄울 때 사용한다.
	/**
	 * 이벤트 이미지입니다. [DB에는 없는 컬럼]
	 */
	private MultipartFile file; // DB에는 없다. saveEventImg() 메소드 실행시 사용한다.
	
	/**
	 * 기본 생성자
	 */
	public Event() {
		super();
	}

	/**
	 * 모든 필드를 매개변수로 갖는 생성자입니다.
	 * @param num
	 * @param name
	 * @param sale
	 * @param imgPath
	 * @param file
	 */
	public Event(int num, String name, float sale, String imgPath, MultipartFile file) {
		super();
		this.num = num;
		this.name = name;
		this.sale = sale;
		this.imgPath = imgPath;
		this.file = file;
	}

	/**
	 * 
	 * @return
	 */
	public int getNum() {
		return num;
	}

	/**
	 * 
	 * @param num
	 */
	public void setNum(int num) {
		this.num = num;
	}

	/**
	 * 
	 * @return
	 */
	public String getName() {
		return name;
	}

	/**
	 * 
	 * @param name
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * 
	 * @return
	 */
	public float getSale() {
		return sale;
	}

	/**
	 * 
	 * @param sale
	 */
	public void setSale(float sale) {
		this.sale = sale;
	}

	/**
	 * 
	 * @return
	 */
	public String getImgPath() {
		return imgPath;
	}

	/**
	 * 
	 * @param imgPath
	 */
	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}

	/**
	 * 
	 * @return
	 */
	public MultipartFile getFile() {
		return file;
	}

	/**
	 * 
	 * @param file
	 */
	public void setFile(MultipartFile file) {
		this.file = file;
	}

	/**
	 * 
	 */
	@Override
	public String toString() {
		return "Event [num=" + num + ", name=" + name + ", sale=" + sale + ", imgPath=" + imgPath + ", file=" + file
				+ "]";
	}
	
}
