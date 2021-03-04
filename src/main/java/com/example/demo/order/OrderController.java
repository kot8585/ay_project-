package com.example.demo.order;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.example.demo.member.Member;
import com.example.demo.member.MemberService;
import com.example.demo.product.Product;
import com.example.demo.product.ProductService;

/**
 * 구매 창 띄우기, 구매 등의 기능을 제공하는 컨트롤러, 여기서 로그가 찍힌다.
 * 2021-03-03 수정 : order 메소드 실행시 메인 페이지로 갔음에도 url에 /order/order가 남아있는 문제 해결
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
	 * 로그 : ,나이,성별,고객ID,상품번호,상품명,상품가격,상품원산지,상품원재료,카테고리1,카테고리2,이벤트번호,주문수량,주문액
	 * @param o : 구매 관련 정보  
	 * @return 메인으로 되돌아감.
	 */
	@RequestMapping("/order/order")
	public String order(Order o) {
		// 시퀀스로부터 구매번호 값 가져오기.
		int num = orderService.getNum();
		// 구매번호 세팅
		o.setNum(num);
		
		// 로그 작성용
		Member m = memberService.getMember(o.getM_id()); 
		
		// 로그 작성용
		Product p = productService.getProductByNum(o.getP_num());
		
		// 주문한 수량만큼 재고 수량 감소
		productService.decreaseProduct(o);
		// 구매 DB에 구매 정보 추가.
		orderService.addOrder(o);

		// 실제 나이 구하기.
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		String birth = m.getBirth().toString().substring(0,4);
		String now = sdf.format(new Date());
		int age = Integer.parseInt(now) - Integer.parseInt(birth);
		
		// 로그 남기기.
		log.info("," + age + "," + m.getGender()  + "," +  m.getId() 
		 			+ "," + p.content() + "," + o.getQuantity()  + "," +  o.getCost());
		// 리턴 메인
		return "redirect:/";
	}
	
}
