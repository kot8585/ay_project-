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
 * @author 김평기
 * @version sub-project
 * @since sub-project
 * MyPage.jsp에서 실행되는 기능을 구현한 컨트롤러입니다.
 * 마이페이지 이동 및 구매이력과 문의내역에 대한 리스트를 받아오는 기능을 제공하고 있습니다.
 */
@Controller
public class MyPageController {

	/** 
	 * 장바구니 기능과 관련된 서비스입니다. 
	 */
	@Autowired
	private CartService cartService;
	
	/** 
	 * 주문 기능과 관련된 서비스입니다. 
	 */
	@Autowired
	private OrderService orderService;
	
	/** 
	 * 공지사항 기능과 관련된 서비스입니다. 
	 */
	@Autowired
	private BoardService boardService;
	
	/**
	 * 댓글 기능과 관련된 서비스입니다.
	 */
	@Autowired
	private RepService repService;
	
	/**
	 * 1:1문의 기능과 관련된 서비스입니다.
	 */
	@Autowired
	private QnaService qnaService;
	
	/**
	 * 마이페이지 이동시 호출되는 메소드입니다.
	 * 세션이 null인지 체크하고 null이 아니라면 마이페이지로 이동합니다. 
	 * null이라면 로그인 화면으로 이동합니다. 
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
	 * 장바구니 화면을 호출하는 동시에 Cart DB로부터 list를 받아와 jsp에서 list를 출력할 수 있도록 함.
	 * 
	 * @param req 세션을 받아오기 위한 HttpServletRequest입니다.
	 * @return 해당 jsp의 위치 및 list 객체가 담긴 ModelAndView입니다.
	 */
	@RequestMapping("/mypage/shoppingcartForm")
	public ModelAndView shoppingcartForm(HttpServletRequest req) {
		
		// ModelAndView 생성
		ModelAndView mav = new ModelAndView("mypage/shoppingcartForm");
		
		// 세션 받아오기.
		HttpSession session = req.getSession(false);
		
		// 세션 id 받아오기	
		String id = (String) session.getAttribute("id");
		
		// id가 공백이거나 null 일 경우.
		if (id.isBlank() || id == null) {
			// mav의 ViewName을 로그인으로 변경한다.
			mav.setViewName("member/login");
		}
		
		// 장바구니 리스트를 받아오고 이를 mav에 담아 리턴한다.
		ArrayList<Shoppingcart> list = cartService.getShoppingcartById(id);
		mav.addObject("list", list);
		return mav;
	}
	
	/**
	 * 주문내역 화면을 호출하는 동시에 Order DB로부터 list를 받아와 jsp에서 list를 출력할 수 있도록 함.
	 * 
	 * @param req 세션을 받아오기 위한 HttpServletRequest입니다.
	 * @return 해당 jsp의 위치 및 list 객체가 담긴 ModelAndView입니다.
	 */
	@RequestMapping("/mypage/myOrderForm")
	public ModelAndView myOrderForm(HttpServletRequest req) {
		// ModelAndView 생성
		ModelAndView mav = new ModelAndView("mypage/myOrderForm");
		
		// 세션 받아오기.
		HttpSession session = req.getSession(false);
		
		// 세션 id 받아오기	
		String id = (String) session.getAttribute("id");
		
		// 주문내역 리스트를 받아오고 이를 mav에 담아 리턴한다.
		ArrayList<Order> list = orderService.getMyOrderListById(id);
		mav.addObject("list", list);
		return mav;
	}
	
	/**
	 * 문의내역 화면을 호출하는 동시에 board DB 및 reply DB로부터 list를 받아와 jsp에서 list를 출력할 수 있도록 함.
	 * 
	 * @param req 세션을 받아오기 위한 HttpServletRequest입니다.
	 * @return 해당 jsp의 위치 및 list 객체가 담긴 ModelAndView입니다.
	 */
	@RequestMapping("/mypage/myQuestionForm")
	public ModelAndView myQuestionForm(HttpServletRequest req) {
		// ModelAndView 생성
		ModelAndView mav = new ModelAndView("mypage/myQuestionForm");
		
		// 세션 받아오기.
		HttpSession session = req.getSession(false);
		
		// 세션 id 받아오기	
		String id = (String) session.getAttribute("id");

		// 문의내역 리스트를 받아오고, foreach 문을 활용해 각 문의내역에 달린 댓글 또한 받아와 set함.  
		ArrayList<Qna> list = qnaService.getMyQnaListByWriter(id);
//		for (Qna qna : list) {
//			ArrayList<Reply> reply = repService.getReplyByBoardNum(qna.getNum());
//			qna.setReps(reply);
//		}
		
		// 문의내역 리스트를 mav에 담아 리턴한다.
		mav.addObject("list", list);
		return mav;
	}
	
}
