package com.example.demo.shoppingcart;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.member.Member;
import com.example.demo.member.MemberService;
import com.example.demo.product.Product;
import com.example.demo.product.ProductService;

@Controller
public class CartController {

	/**
	 * 로그 찍는 용.
	 */
	private final Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private CartService service;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/cart/addCart")
	public void addCart(HttpServletRequest req) {
		System.out.println("CartController.addCart()");
		//  java.sql.SQLIntegrityConstraintViolationException: ORA-00001: unique constraint (HR.SYS_C007378) violated : 기본 키 두 개 생성 https://moonong.tistory.com/48 
		String m_id = req.getParameter("m_id");
		int p_num = Integer.parseInt(req.getParameter("p_num"));
		int cost = Integer.parseInt(req.getParameter("cost"));
		Shoppingcart cart = new Shoppingcart();
		cart.setM_id(m_id);
		cart.setP_num(p_num);
		cart.setCost(cost);
		
		// 로그 작성용
		Member m = memberService.getMember(m_id); 
		
		// 로그 작성용
		Product p = productService.getProductByNum(p_num);
		
		// 실제 나이 구하기.
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
				String birth = m.getBirth().toString().substring(0,4);
				String now = sdf.format(new Date());
				int age = Integer.parseInt(now) - Integer.parseInt(birth);
		
		// 로그 남기기.
		log.info("," + age + "," + m.getGender()  + "," +  m.getId() 
				 + "," + p.content() + ",0");
		
		service.addCart(cart);
	}
}
