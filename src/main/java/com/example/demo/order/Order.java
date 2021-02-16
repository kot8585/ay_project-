package com.example.demo.order;

import java.sql.Date;

import com.example.demo.member.Member;
import com.example.demo.product.Product;

public class Order {
	private int num;
	private String m_id;
	private int p_num;
	private int quantity;
	private Date o_date;
	private String address;
	private String tel;
	private int cost;
	private int state;
	private String imgPath;
	private Product p = new Product();
	private Member m = new Member();
	
	public Order() {
		super();
	}

	public Order(int num, String m_id, int p_num, int quantity, Date o_date, int state) {
		super();
		this.num = num;
		this.m_id = m_id;
		this.p_num = p_num;
		this.quantity = quantity;
		this.o_date = o_date;
		this.state = state;
	}

	public Order(int num, String m_id, int p_num, int quantity, Date o_date, int state, Product p, Member m) {
		super();
		this.num = num;
		this.m_id = m_id;
		this.p_num = p_num;
		this.quantity = quantity;
		this.o_date = o_date;
		this.state = state;
		this.p = p;
		this.m = m;
	}
	
	public Order(int num, String m_id, int p_num, int quantity, Date o_date, String address, String tel, int cost, int state,
			Product p, Member m) {
		super();
		this.num = num;
		this.m_id = m_id;
		this.p_num = p_num;
		this.quantity = quantity;
		this.o_date = o_date;
		this.address = address;
		this.tel = tel;
		this.cost = cost;
		this.state = state;
		this.p = p;
		this.m = m;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
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

	

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public Date getO_date() {
		return o_date;
	}

	public void setO_date(Date o_date) {
		this.o_date = o_date;
	}

	
	
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}
	
	public int getCost() {
		return cost;
	}

	public void setCost(int cost) {
		this.cost = cost;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public Product getP() {
		return p;
	}

	public void setP(Product p) {
		this.p = p;
	}

	public Member getM() {
		return m;
	}

	public void setM(Member m) {
		this.m = m;
	}

	public String getImgPath() {
		return imgPath;
	}

	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}

	@Override
	public String toString() {
		return "Order [num=" + num + ", m_id=" + m_id + ", p_num=" + p_num + ", quantity=" + quantity + ", o_date="
				+ o_date + ", address=" + address + ", tel=" + tel + ", cost=" + cost + ", state=" + state
				+ ", imgPath=" + imgPath + ", p=" + p + ", m=" + m + "]";
	}

	public String category() {
		return "num,p_num,quantity,address,tel,cost,log_date\n";
	}

	public String content() {
		return num + "," + m.getGender() + "," + m.getBirth() + "," +  address + "," + tel 
				+ "," + m_id + "," + p_num + "," + quantity + "," + cost + ",";
	}

}
