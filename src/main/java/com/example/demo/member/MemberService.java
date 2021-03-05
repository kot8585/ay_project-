package com.example.demo.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {

	@Autowired
	private MemberMapper mapper;
	
	public Member getMember(String id) {
		return mapper.getMember(id);
	}
	
	public Member getMember1(String password) {
		return mapper.getMember(password);
	}

	public void addMember(Member m) {
		mapper.insert(m);
	}

	public void editMember(Member m) {
		// TODO Auto-generated method stub
		mapper.update(m);
	}
	public void delMember(String id) {
		mapper.delete(id);
	}
	public Member getIdPwd(String email, String name) {
		return mapper.getIdPwd(email, name);
	}
}
