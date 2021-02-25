package com.example.demo.member;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mybatis.spring.boot.test.autoconfigure.AutoConfigureMybatis;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;

import com.example.demo.member.Member;
import com.example.demo.member.MemberController;
import com.example.demo.member.MemberService;


// MVC를 위한 테스트
@WebMvcTest(controllers = MemberController.class)
@AutoConfigureMockMvc
@AutoConfigureMybatis
public class MemberControllerTest {

	private final Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private MockMvc mockMvc;
	
	@MockBean
	private MemberService service;
	
	@Test
	@DisplayName("Member Root")
	public void root() throws Exception {
		mockMvc.perform(get("/")) 
		/* 요청을 전송하는 역할, 결과로  ResultActions 객체를 받으며, 
		ResultActions 객체는 리턴 값을 검증하고 
		확인할 수 있는 andExcpect() 메소드를 제공 */
			.andExpect(status().isOk())
			/*
			 * 응답을 검증하는 역할을 합니다.
				상태 코드 ( status() )
				메소드 이름 : 상태코드
				isOk() : 200
				isNotFound() : 404
				isMethodNotAllowed() : 405
				isInternalServerError() : 500
				is(int status) : status 상태 코드
				뷰 ( view() )
				리턴하는 뷰 이름을 검증합니다.
				ex. view().name("blog") : 리턴하는 뷰 이름이 blog인가?
				리다이렉트 ( redirect() )
				리다이렉트 응답을 검증합니다.
				ex. redirectUrl("/blog") : '/blog'로 리다이렉트 되었는가?
				모델 정보 ( model() )
				컨트롤러에서 저장한 모델들의 정보 검증
				응답 정보 검증 ( content() )
				응답에 대한 정보를 검증해줍니다.
			 */
			.andExpect(view().name("/member/main")) // return 으로 넘김.
			// 요청, 응답 전체 메시지를 확인
			.andDo(print());
	}
	
	@Test
	@DisplayName("member Main")
	public void main() throws Exception {
		mockMvc.perform(get("/member/main"))
		.andExpect(view().name("member/main")) // return이 아닌 그냥 RequestMapping만 있을 경우.
		.andDo(print());
	}
	
	@Test
	@DisplayName("member joinForm")
	public void joinForm() throws Exception {
		mockMvc.perform(get("/member/joinForm"))
		.andExpect(view().name("member/joinForm")) // return이 아닌 그냥 RequestMapping만 있을 경우.
		.andDo(print());
	}
	
	@Test
	@DisplayName("member login Fail")
	public void loginFail() throws Exception {
		Member m = new Member();
		m.setId("failed");
		m.setPassword("failed");
		
		when(service.getMember(m.getId())).thenReturn(null);
		mockMvc.perform(post("/member/login?id={id}&password={password}", m.getId(), m.getPassword()))
				.andExpect(status().isOk())
				.andExpect(view().name("member/loginForm"))
				.andDo(print());
		
	}
	
	@Test
	@DisplayName("member login Success")
	public void loginSucess() throws Exception {
		Member m = new Member();
		m.setId("a");
		m.setPassword("a");
		
//		Member member = mapper.getMember(m.getId());
//		
//		assertThat(member.getId()).isEqualTo("a");
//		assertThat(member.getPassword()).isEqualTo("a");
		
		when(service.getMember(m.getId())).thenReturn(new Member("a", "a"));
		mockMvc.perform(get("/member/login").param("id", m.getId()).param("password", m.getPassword()))
		.andExpect(status().isOk())
		.andExpect(view().name("member/main"))
		.andDo(print());
	}
}
