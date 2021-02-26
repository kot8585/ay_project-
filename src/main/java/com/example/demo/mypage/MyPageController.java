package com.example.demo.mypage;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.board.BoardService;
import com.example.demo.order.Order;
import com.example.demo.order.OrderService;
import com.example.demo.qna.Qna;
import com.example.demo.qna.QnaService;
import com.example.demo.reply.RepService;
import com.example.demo.reply.Reply;
import com.example.demo.shoppingcart.CartService;
import com.example.demo.shoppingcart.Shoppingcart;

/**
 * myPage에서 사용가능한 기능들을 구현한 Controller 클래스입니다.
 * @author 김평기
 * @version main 1
 */
@Controller
public class MyPageController {

	@Autowired
	private CartService cartService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private RepService repService;
	
	@Autowired
	private QnaService qnaService;
	
	/**
	 * 마이페이지(/mypage/mypage) 이동
	 * @param req 세션
	 * @return Redirect할 Url
	 */
	@RequestMapping("/mypage/mypage")
	public String mypage(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		if (session == null) {
			return "/member/loginForm";
		} else {
			return "/mypage/mypage";
		}
	}
	
	/**
	 * c:import되는 장바구니 화면(/mypage/shoppingcartForm)을 호출할때 Cart DB로부터 list를 받아오는 기능
	 * @param req 세션	 
	 * @return 해당 jsp의 위치 및 list 객체가 담긴 ModelAndView입니다.
	 */
	@RequestMapping("/mypage/shoppingcartForm")
	public ModelAndView shoppingcartForm(HttpServletRequest req) {
		
		// ModelAndView 생성
		ModelAndView mav = new ModelAndView("mypage/shoppingcartForm");
		HttpSession session = req.getSession(false);
		String id = (String) session.getAttribute("id");;
		// 세션 받아오기.
		
		sessionCheck(mav, id, session);
		
		// 장바구니 리스트를 받아오고 이를 mav에 담아 리턴한다.
		ArrayList<Shoppingcart> list = cartService.getShoppingcartById(id);
		mav.addObject("list", list);
		return mav;
	}
	
	/**
	 * c:import되는 주문목록 화면(/mypage/myOrderForm)을 호출할때 Order DB로부터 list를 받아오는 기능
	 * @param req 세션
	 * @return Redirect할 Url 및 받아온 리스트
	 */
	@RequestMapping("/mypage/myOrderForm")
	public ModelAndView myOrderForm(HttpServletRequest req) {
		// ModelAndView 생성
		ModelAndView mav = new ModelAndView("mypage/myOrderForm");
		// 세션 받아오기.
		HttpSession session = req.getSession(false);
		String id = (String) session.getAttribute("id");;
		
	
		
		sessionCheck(mav, id, session);
		
		// 주문내역 리스트를 받아오고 이를 mav에 담아 리턴한다.
		ArrayList<Order> list = orderService.getMyOrderListById(id);
		mav.addObject("list", list);
		return mav;
	}
	
	/**
	 * c:import되는 문의내역 화면(/mypage/myQuestionForm)을 호출할때 QnA DB로부터 list를 받아오는 기능
	 * @param req 세션을 받아오기 위한 HttpServletRequest입니다.
	 * @return Redirect할 Url 및 받아온 리스트
	 */
	@RequestMapping("/mypage/myQuestionForm")
	public ModelAndView myQuestionForm(HttpServletRequest req) {
		// ModelAndView 생성
		ModelAndView mav = new ModelAndView("mypage/myQuestionForm");
		
		String id = "";
		
		// 세션 받아오기.
		HttpSession session = req.getSession(false);
		id= (String) session.getAttribute("id");
		
		sessionCheck(mav, id, session);
		
		// 문의내역 리스트를 받아오고, foreach 문을 활용해 각 문의내역에 달린 댓글 또한 받아와 set함.  
		ArrayList<Qna> list = qnaService.getMyQnaListByWriter(id);
//		for (Qna qna : list) {
//			ArrayList<Reply> reply = repService.getReplyByBoardNum(qna.getNum());
//			qna.setReps(reply);
//		}
		
		// 문의내역 리스트를 mav에 담아 리턴한다.
		mav.addObject("list", list);
		System.out.println("list에 담긴것을 출력하자: " + list);
		return mav;
	}
	
	/**
	 * 세션 여부 확인, 세션이 없으면 ModelAndView가 로그인 페이지로 가게 함.
	 * @param mav 해당 ModelAndView가 Redirect할 Url
	 * @param id 해당 메소드의 id에 세션 id를 할당.
	 * @param session 세션
	 */
	private void sessionCheck(ModelAndView mav, String id, HttpSession session) {
		if (session == null) {
			System.out.println("session null");
			mav.setViewName("member/login");
		} else {
			id = (String) session.getAttribute("id");
		}
		if (id.isBlank()) {
			mav.setViewName("member/login");
		}
	}
}
