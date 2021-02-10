package com.example.demo.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;



@Controller
public class MemberController {

	/**
	 * @author 김평기
	 * 로그 찍는 용
	 */
	private final Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private MemberService service;
	
	@RequestMapping("/")
	public String root() throws Exception {
		//main페이지를 첫화면으로 설정한다. 
		return "redirect:/member/main";
	}
	
	@RequestMapping("/member/main")
	public void main() {
		//main.jsp를 불러와 화면에 보여준다.
	}
	

	@RequestMapping("/member/joinForm")
	public void joinForm(HttpServletRequest req) {
		//joinForm.jsp를 불러와 화면에 보여준다.
		HttpSession session = req.getSession();
		session.setAttribute("idCheck", false);
		}
	
	@RequestMapping(value = "/member/idCheck")
	public ModelAndView idCheck(HttpServletRequest req, 
		@RequestParam(value = "id") String id) {
		System.out.println("MemController.idCheck() id : " + id);
		HttpSession session = req.getSession(false);
		ModelAndView mav = new ModelAndView("member/idCheck");
		String result = "";
		Member m = service.getMember(id);
		if (m == null) {
			result = "사용가능"; // joinForm.jsp의 div(id=idResult)에 텍스트 채워줄 용
			session.setAttribute("idCheck", true);
		} else {
			result = "사용불가능"; // joinForm.jsp의 div(id=idResult)에 텍스트 채워줄 용
			session.setAttribute("idCheck", false);
		}
		System.out.println(session.getAttribute("idCheck"));
		mav.addObject("result", result);
		return mav;
	}
	@RequestMapping("/member/join")
	public String join(Member m) {
		//joinForm에서 입력받은 값을 m에 담고 db에 저장한다.
		service.addMember(m);
		return "member/loginForm";
	}
	
	@RequestMapping("/member/loginForm")
	public void loginForm() {
		//loginForm.jsp를 불러와 화면에 보여준다
	}
	
	@RequestMapping("/member/login")
	public String login(Member m, HttpServletRequest req) {
		//loginForm에서 입력받은 값을 m에 담고 해당하는 아이디에 대한 db 값을 m2에 담는다 
		Member m2 = service.getMember(m.getId());
		// DB로부터 받아온 값이 없고, 받아온 비밀번호가 입력한 비밀번호값과 일치하지않으면 로그인 실패 -> loginForm으로 되돌린다.
		if (m2 == null || !m2.getPassword().equals(m.getPassword())) {
			return "member/loginForm";
		// 로그인 성공시 session을 통해 id 값을 저장한다.
		} else {
			HttpSession session = req.getSession();
			session.setAttribute("id", m2.getId());
			log.info(m2.getId()+",login,");
			return "/member/main";
		}
	}
	
	/**
	 * findForm.jsp로 이동하기 위한 메소드
	 */
	@RequestMapping("/member/findForm")
	public void findForm() {
		
	}
	
	/**
	 * 
	 * @param email 회원정보를 찾기 위해 입력 받은 email
	 * @param name 회원정보를 찾기 위해 입력 받은 name
	 * @return 회원찾기 폼에서 입력받은 정보로 회원정보를 찾아 findResult.jsp로 전달
	 */
	@RequestMapping("/member/find")
	public ModelAndView find(@RequestParam("email")String email, @RequestParam("name")String name) {
		// 폼에서 입력받은 email과 name을 통해 DB에서 Id와 Pwd를 불러와 객체에 해당 정보를 저장한다.
		Member m = service.getIdPwd(email, name);
	
		// 입력 받은 정보와 DB의 정보를 매칭하여 일치하지 않다면 경고 메시지를 findResult.jsp에 보내고, 일치하면 해당 정보를 findResult.jsp에 보낸다.
		ModelAndView mav = new ModelAndView("member/findResult");
		String result="";
		if(m == null) {
			result = "이메일 또는 이름이 등록되지 않았습니다.";
			mav.setViewName("member/failResult");
			mav.addObject("result", result);
			System.out.println(result);
		} else {
			mav.addObject("m", m);
		}
		return mav;
	}
	
	@RequestMapping(value="/member/editForm")
	public ModelAndView editForm(HttpServletRequest req) {
		HttpSession session = req.getSession();
		//로그인된 아이디 값을 session을 통해 받아온다.
		ModelAndView mav = new ModelAndView("/member/editForm");
		//세션에 저장된 id값을 새로 지정한다.
		String id = (String)session.getAttribute("id");
		Member m = service.getMember(id);
		mav.addObject("m", m);
		return mav;
	}
	
	@RequestMapping(value="/member/edit")
	public String edit(HttpServletRequest req, Member m) {
		//로그인된 아이디 값을 session을 통해 받아온다.
		HttpSession session = req.getSession();
		service.editMember(m);
		return "/mypage/mypage";
	}
	
	@RequestMapping(value = "/member/logout")
	public String logout(HttpServletRequest req) {
		//로그인된 아이디 값을 session을 통해 받아온다.
		HttpSession session = req.getSession(false);
		// 세션이 말소되기 전 id를 가져오고
				String id = (String) session.getAttribute("id");
				// 그 id를 이용해 로그를 찍습니다. , 뒤에는 로그 시간이 찍힙니다. 
				log.info(id+",logout,");
		session.removeAttribute("id");
		//id에 대한 세션을 지운다.
		session.invalidate();
		return "member/loginForm";
	}

	@RequestMapping(value = "/member/out")
	public String out(HttpServletRequest req) {
		//로그인된 아이디 값을 session을 통해 받아온다.
		HttpSession session = req.getSession(false);
		//세션에 저장된 id값을 새로 지정한다.
		String id = (String) session.getAttribute("id");
		//새로 지정한 id값을 통해 db에 저장된 id에 대한 정보들을 삭제한다.
		service.delMember(id);
		session.removeAttribute("id");
		session.invalidate();
		return "member/loginForm";
	}
}