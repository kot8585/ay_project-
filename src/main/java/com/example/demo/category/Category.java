package com.example.demo.category;

/**
 * 카테고리에 대한 DTO입니다.
 * @author 김평기
 * @version main 1
 */
public class Category {
	/**
	 * 고유 ID값입니다. [PK]
	 */
	private int id;
	/**
	 * 카테고리 이름값입니다. [NOT NULL]
	 */
	private String name;
	/**
	 * 카테고리의 상위 id값입니다. [NOT NULL]
	 */
	private int c_id;

	/**
	 * 기본 생성자입니다. 
	 */
	public Category() {
	}

	/**
	 * 모든 필드를 매개변수로 갖는 생성자입니다.
	 * @param id
	 * @param name
	 * @param c_id
	 */
	public Category(int id, String name, int c_id) {
		this.id = id;
		this.name = name;
		this.c_id = c_id;
	}

	/**
	 * 
	 * @return
	 */
	public int getId() {
		return id;
	}

	/**
	 * 
	 * @param id
	 */
	public void setId(int id) {
		this.id = id;
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
	public int getC_id() {
		return c_id;
	}

	/**
	 * 
	 * @param c_id
	 */
	public void setC_id(int c_id) {
		this.c_id = c_id;
	}

	/**
	 * 
	 */
	@Override
	public String toString() {
		return "Category [id=" + id + ", name=" + name + ", c_id=" + c_id + "]";
	}

}
