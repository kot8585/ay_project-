package com.example.demo.shoppingcart;

import java.sql.Date;

public class Shoppingcart {
	private String m_id;
	private int p_num;
	private String p_name;
	private int cost;
	private Date o_date;
	private String imgPath;
	
	public Shoppingcart() {
		super();
	}

	public Shoppingcart(String m_id, int p_num, String p_name, int cost, Date o_date) {
		super();
		this.m_id = m_id;
		this.p_num = p_num;
		this.p_name = p_name;
		this.cost = cost;
		this.o_date = o_date;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public int getP_num() {
		return p_num;
	}

	public void setP_num(int p_num) {
		this.p_num = p_num;
	}

	public String getP_name() {
		return p_name;
	}

	public void setP_name(String p_name) {
		this.p_name = p_name;
	}

	public int getCost() {
		return cost;
	}

	public void setCost(int cost) {
		this.cost = cost;
	}

	public Date getO_date() {
		return o_date;
	}

	public void setO_date(Date o_date) {
		this.o_date = o_date;
	}

	public String getImgPath() {
		return imgPath;
	}

	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}

	@Override
	public String toString() {
		return "Shoppingcart [m_id=" + m_id + ", p_num=" + p_num + ", p_name=" + p_name + ", cost=" + cost + ", o_date="
				+ o_date + ", p_name=" + p_name + "]";
	}

	public String category() {
		return "m_id,p_num,cost,o_date,name,methodName\n";
	}

	public String content() {
		return  m_id + "," + p_num + "," + cost + "," + o_date + "," + p_name;
	}   
	
}
