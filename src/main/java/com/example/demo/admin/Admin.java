package com.example.demo.admin;


/**
 * 관리자(=admin)에 대한 DTO입니다.
 * @author 김평기
 * @version main 1
 */
public class Admin {
	/**
	 * 고유 ID값입니다. [PK]
	 */
	private String id;
	
	/**
	 * 관리자 비밀번호입니다. [NOT NULL]
	 */
	private String password;
	
	/**
	 * 기본 생성자입니다. 
	 */
	public Admin() {
		super();
	}

	/**
	 * 모든 필드를 매개변수로 갖는 생성자입니다.
	 * @param id 
	 * @param password  
	 */
	public Admin(String id, String password) {
		super();
		this.id = id;
		this.password = password;
	}
	
	/**
	 * id의 getter입니다.
	 * @return id
	 */
	public String getId() {
		return id;
	}
	
	/**
	 * id의 setter입니다.
	 * @param id
	 */
	public void setId(String id) {
		this.id = id;
	}
	
	/**
	 * password의 getter입니다.
	 * @return password
	 */
	public String getPassword() {
		return password;
	}
	
	/**
	 * password의 setter입니다.
	 * @param password
	 */
	public void setPassword(String password) {
		this.password = password;
	}

	/**
	 * @see Object.toString()
	 */
	@Override
	public String toString() {
		return "admin\n" + "id, password\n" + id + "," + password;
	}
	
	
}
