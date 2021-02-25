package com.example.demo.member;

import java.sql.Date;

public class Member {
	private String id;
	private String password;
	private String name;
	private Date birth;
	private String gender;
	private String postalCode;
	private String roadAddress;
	private String address;
	private String tel;
	private String email;
	
	public Member() {
		super();
	}

	public Member(String id, String password) {
		super();
		this.id = id;
		this.password = password;
	}
	
	public Member(String id, String password, String name, Date birth, String gender, String postalCode,
			String roadAddress, String address, String tel, String email) {
		super();
		this.id = id;
		this.password = password;
		this.name = name;
		this.birth = birth;
		this.gender = gender;
		this.postalCode = postalCode;
		this.roadAddress = roadAddress;
		this.address = address;
		this.tel = tel;
		this.email = email;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getBirth() {
		return birth;
	}

	public void setBirth(Date birth) {
		this.birth = birth;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPostalCode() {
		return postalCode;
	}

	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}

	public String getRoadAddress() {
		return roadAddress;
	}

	public void setRoadAddress(String roadAddress) {
		this.roadAddress = roadAddress;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "Member [id=" + id + ", password=" + password + ", name=" + name + ", birth=" + birth + ", gender="
				+ gender + ", postalCode=" + postalCode + ", roadAddress=" + roadAddress + ", address=" + address
				+ ", tel=" + tel + ", email=" + email + "]";
	}
	
	public String category() {
		return "id,password,name,birth,gender,address,tel,email,methodName\n";
	}

	// 로그를 위한 세팅
	public String content() {
		return id + "," + password + "," + name + "," + birth 
				+ "," + gender + "," + address + "," + tel + "," + email;
	}

}