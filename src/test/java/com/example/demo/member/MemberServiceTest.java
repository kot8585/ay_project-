package com.example.demo.member;

import javax.servlet.http.HttpSession;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mybatis.spring.boot.test.autoconfigure.MybatisTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.example.demo.member.Member;
import com.example.demo.member.MemberMapper;


@ExtendWith(SpringExtension.class)
@MybatisTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
public class MemberServiceTest {

	@Autowired
	private MemberMapper mapper;

	@Test
	public void loginTest() {
		Member m = new Member();
		m.setId("a");
		m.setPassword("a");
		Member m2 = mapper.getMember(m.getId());
		if (m2 == null || !m2.getPassword().equals(m.getPassword())) {
			System.out.println("member/loginForm");
		
		} else {
			System.out.println("member/main");
		}
	}
}
