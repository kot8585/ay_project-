package com.example.demo.shoppingcart;

import java.sql.Date;

public class Shoppingcart {
	private String m_id;
	private int p_num;
	private int cost;
	private Date o_date;
	private String name;
	
	public Shoppingcart() {
		super();
	}

	public Shoppingcart(String m_id, int p_num, int cost, Date o_date, String name) {
		super();
		this.m_id = m_id;
		this.p_num = p_num;
		this.cost = cost;
		this.o_date = o_date;
		this.name = name;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "Shoppingcart [m_id=" + m_id + ", p_num=" + p_num + ", cost=" + cost + ", o_date=" + o_date + ", name="
				+ name + "]";
	}

	public String category() {
		return "m_id,p_num,cost,o_date,name,methodName\n";
	}

	public String content() {
		return  m_id + "," + p_num + "," + cost + "," + o_date + "," + name;
	}   
	
}
