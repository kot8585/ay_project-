package com.example.demo.order;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.example.demo.member.Member;
import com.example.demo.member.MemberService;
import com.example.demo.product.Product;
import com.example.demo.product.ProductService;

/**
 * 구매 창 띄우기, 구매 등의 기능을 제공하는 컨트롤러, 여기서 로그가 찍힌다.
 * @author 김평기
 * @version 2021-02-09 
 */
@Controller
public class OrderController {
	
	/**
	 * 로그 찍는 용.
	 */
	private final Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private MemberService memberService;
	
	/**
	 * 구매 창 띄우기, 여기서 구매 창이 미리 받아두어야할 값들을 넘긴다.
	 * @param o : 구매 관련 정보 
	 * @return ModelAndView ( getObj : Order:o )
	 */
	@RequestMapping("/order/orderForm")
	public ModelAndView orderForm(Order o) {
		// 구매 관련 정보를 저장할 mav 객체 생성
		ModelAndView mav = new ModelAndView("order/orderForm");
		// 보내진 구매 정보의 상품번호를 이용하여 Product DB로부터 해당 Product를 받아옴.
		Product p = productService.getProductByNum(o.getP_num());
		// 보내진 구매 정보의 고객ID를 이용하여 Member DB로부터 해당 Member를 받아옴.
		Member m = memberService.getMember(o.getM_id()); 
		// o에다 Product 세팅
		o.setP(p);
		// o에다 Member 세팅
		o.setM(m);
		// mav에 구매 정보 담기
		mav.addObject("order", o);
		// 리턴
		return mav;
	}
	
	/**
	 * 구매하기, 주소와 전화번호를 입력하는 것으로 상품을 구매한다. 이때 로그가 남는다.
	 * 로그 : order.num, member.gender, member.birth, order.address, order.tel, order.id, order.p_num, order.quantity, order.cost, log_date
	 * @param o : 구매 관련 정보  
	 * @return 메인으로 되돌아감.
	 */
	@RequestMapping("/order/order")
	public String order(Order o) {
		// 시퀀스로부터 구매번호 값 가져오기.
		int num = orderService.getNum();
		// 구매번호 세팅
		o.setNum(num);
		// 없어도 되나 불안하니 한 번 더 세팅 
		Member m = memberService.getMember(o.getM_id()); 
		o.setM(m);
		// 주문한 수량만큼 재고 수량 감소
		productService.decreaseProduct(o);
		// 구매 DB에 구매 정보 추가.
		orderService.addOrder(o);
		// 로그 남기기.
		log.info(o.content());
		// 리턴 메인
		return "/member/main";
	}
	
}
