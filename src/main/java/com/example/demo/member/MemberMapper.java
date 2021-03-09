package com.example.demo.member;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {
	
	Member getMember(String id);
	
	void insert(Member m);

	void update(Member m);
	
	void addMember(Member m);
	
	void delete(String id);
	
	Member getIdPwd(String email, String name);
	
}
