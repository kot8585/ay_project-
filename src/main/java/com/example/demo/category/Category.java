package com.example.demo.category;

public class Category {
	private int id;
	private String name;
	private int c_id;

	public Category() {
	}

	public Category(int id, String name, int c_id) {
		this.id = id;
		this.name = name;
		this.c_id = c_id;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getC_id() {
		return c_id;
	}

	public void setC_id(int c_id) {
		this.c_id = c_id;
	}

	@Override
	public String toString() {
		return "Category [id=" + id + ", name=" + name + ", c_id=" + c_id + "]";
	}

}
