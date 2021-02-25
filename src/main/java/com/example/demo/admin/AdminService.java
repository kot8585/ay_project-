package com.example.demo.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Admin Page에서 사용가능한 기능들을 구현한 Service 클래스입니다.
 * @author 김평기
 * @version main 1
 */
@Service
public class AdminService {
	
	@Autowired
	private AdminMapper mapper;

	/**
	 * 관리자 로그인 기능
	 * select * from 관리자DB where id=?
	 * @param id 입력한 id
	 * @return 입력한 id를 이용해 DB로부터 받은 Admin 객체
	 */
	public Admin getAdmin(String id) {
		return mapper.selectAdmin(id);
	}
	
	
}
