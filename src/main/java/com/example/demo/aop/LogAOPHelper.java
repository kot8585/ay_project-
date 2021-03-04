package com.example.demo.aop;


import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import com.example.demo.admin.Admin;
import com.example.demo.board.Board;
import com.example.demo.member.Member;
import com.example.demo.order.Order;
import com.example.demo.product.Product;
import com.example.demo.reply.Reply;
import com.example.demo.review.Review;
import com.example.demo.shoppingcart.Shoppingcart;

/**
 * 2021-03-04
 * AOP를 이용하여 로그를 찍는 Aspect 클래스입니다.
 * 무엇을 실행할 것인가?
 * 메소드 실행 전 ( Before )
 * 메소드 종료 후 정상적으로 리턴 시 ( AfterReturning )
 * 메소드 익셉션 발생 시 ( AfterThrowing )
 * 메소드 실행 후 ( After )
 * 메소드 실행 전후 ( Around )
 * @author 김평기
 */
@Aspect
@Component
public class LogAOPHelper {
	/* 해당 메소드의 매개변수(=parameter)를 가져옵니다. 
	/ 그 예로 String login(Member m, HttpServletRequest req)의 경우 Member m과 HttpServletRequest req를 가져옵니다.
	 */
	private final Logger log = LoggerFactory.getLogger(this.getClass());

	
	@Pointcut("@annotation(org.springframework.web.bind.annotation.RequestMapping)")
	public void RequestMapping() {}
	
	@Pointcut("@annotation(org.springframework.web.bind.annotation.GetMapping)")
	public void GetMapping() {}
	
	@Pointcut("@annotation(org.springframework.web.bind.annotation.PostMapping)")
	public void PostMapping() {}
	
	/**
	 * 타겟 메소드가 정상적으로 실행된 후에 실행되는 Advice
	 */
	@AfterReturning(pointcut = "RequestMapping()", returning = "returnValue")
	public Object RequestLog(JoinPoint joinPoint, Object returnValue) {
		Member m;
		Admin ad;
		Board b;
		Order o;
		Product p;
		Reply rep;
		Review rev;
		Shoppingcart s;
		Object [] paraValues = joinPoint.getArgs();
		StringBuilder msg = new StringBuilder();
		msg.append("\n["+ joinPoint.getSignature().toShortString()+"]\n");
		for (int i = 0; i < paraValues.length; i++) {
			if (paraValues[i] instanceof Member) {
				m = (Member) paraValues[i];
				msg.append(m.toString() + "\n");
			}
			else if (paraValues[i] instanceof Admin) {
				ad = (Admin) paraValues[i];
				msg.append(ad.toString() + "\n");
			}
			else if (paraValues[i] instanceof Board) {
				b = (Board) paraValues[i];
				msg.append(b.toString() + "\n");
			}
			else if (paraValues[i] instanceof Order) {
				o = (Order) paraValues[i];
				msg.append(o.toString() + "\n");
			}
			else if (paraValues[i] instanceof Product) {
				p = (Product) paraValues[i];
				msg.append(p.toString() + "\n");
			}
			else if (paraValues[i] instanceof Reply) {
				rep = (Reply) paraValues[i];
				msg.append(rep.toString() + "\n");
			}
			else if (paraValues[i] instanceof Review) {
				rev = (Review) paraValues[i];
				msg.append(rev.toString() + "\n");
			}
			else if (paraValues[i] instanceof Shoppingcart) {
				s = (Shoppingcart) paraValues[i];
				msg.append(s.toString() + "\n");
			}
			else if (paraValues[i] instanceof String) {
				msg.append("String : " + paraValues[i].toString() + "\n");
			}
			else if (paraValues[i] instanceof Integer) {
				msg.append("int : " + paraValues[i].toString() + "\n");
			}
			else {
				msg.append("명시되지 않은 속성 : " + paraValues[i].toString() + "\n");
			}
		}
		if (returnValue == null) {
			log.info(msg.toString() + "\n");
		} else {
			log.info(msg.toString() + "\n"+"returnValue = " + returnValue + "\n");
		}
		return returnValue;
	}


	/**
	 * 타겟 메소드가 정상적으로 실행된 후에 실행되는 Advice
	 */
	@AfterReturning(pointcut = "PostMapping()", returning = "returnValue")
	public Object PostLog(JoinPoint joinPoint, Object returnValue) {
		Member m;
		Admin ad;
		Board b;
		Order o;
		Product p;
		Reply rep;
		Review rev;
		Shoppingcart s;
		Object [] paraValues = joinPoint.getArgs();
		StringBuilder msg = new StringBuilder();
		msg.append("\n["+ joinPoint.getSignature().toShortString()+"]\n");
		for (int i = 0; i < paraValues.length; i++) {
			if (paraValues[i] instanceof Member) {
				m = (Member) paraValues[i];
				msg.append(m.toString() + "\n");
			}
			else if (paraValues[i] instanceof Admin) {
				ad = (Admin) paraValues[i];
				msg.append(ad.toString() + "\n");
			}
			else if (paraValues[i] instanceof Board) {
				b = (Board) paraValues[i];
				msg.append(b.toString() + "\n");
			}
			else if (paraValues[i] instanceof Order) {
				o = (Order) paraValues[i];
				msg.append(o.toString() + "\n");
			}
			else if (paraValues[i] instanceof Product) {
				p = (Product) paraValues[i];
				msg.append(p.toString() + "\n");
			}
			else if (paraValues[i] instanceof Reply) {
				rep = (Reply) paraValues[i];
				msg.append(rep.toString() + "\n");
			}
			else if (paraValues[i] instanceof Review) {
				rev = (Review) paraValues[i];
				msg.append(rev.toString() + "\n");
			}
			else if (paraValues[i] instanceof Shoppingcart) {
				s = (Shoppingcart) paraValues[i];
				msg.append(s.toString() + "\n");
			}
			else if (paraValues[i] instanceof String) {
				msg.append("String : " + paraValues[i].toString() + "\n");
			}
			else if (paraValues[i] instanceof Integer) {
				msg.append("int : " + paraValues[i].toString() + "\n");
			}
			else {
				msg.append("명시되지 않은 속성 : " + paraValues[i].toString() + "\n");
			}
		}
		if (returnValue == null) {
			log.info(msg.toString() + "\n");
		} else {
			log.info(msg.toString() + "\n" + "returnValue = " + returnValue + "\n");
		}
		return returnValue;
	}

	/**
	 * 타겟 메소드가 정상적으로 실행된 후에 실행되는 Advice
	 */
	@AfterReturning(pointcut = "GetMapping()", returning = "returnValue")
	public Object getLog(JoinPoint joinPoint, Object returnValue) {
		Member m;
		Admin ad;
		Board b;
		Order o;
		Product p;
		Reply rep;
		Review rev;
		Shoppingcart s;
		Object [] paraValues = joinPoint.getArgs();
		StringBuilder msg = new StringBuilder();
		msg.append("\n["+ joinPoint.getSignature().toShortString()+"]\n");
		for (int i = 0; i < paraValues.length; i++) {
			if (paraValues[i] instanceof Member) {
				m = (Member) paraValues[i];
				msg.append(m.toString() + "\n");
			}
			else if (paraValues[i] instanceof Admin) {
				ad = (Admin) paraValues[i];
				msg.append(ad.toString() + "\n");
			}
			else if (paraValues[i] instanceof Board) {
				b = (Board) paraValues[i];
				msg.append(b.toString() + "\n");
			}
			else if (paraValues[i] instanceof Order) {
				o = (Order) paraValues[i];
				msg.append(o.toString() + "\n");
			}
			else if (paraValues[i] instanceof Product) {
				p = (Product) paraValues[i];
				msg.append(p.toString() + "\n");
			}
			else if (paraValues[i] instanceof Reply) {
				rep = (Reply) paraValues[i];
				msg.append(rep.toString() + "\n");
			}
			else if (paraValues[i] instanceof Review) {
				rev = (Review) paraValues[i];
				msg.append(rev.toString() + "\n");
			}
			else if (paraValues[i] instanceof Shoppingcart) {
				s = (Shoppingcart) paraValues[i];
				msg.append(s.toString() + "\n");
			}
			else if (paraValues[i] instanceof String) {
				msg.append("String : " + paraValues[i].toString() + "\n");
			}
			else if (paraValues[i] instanceof Integer) {
				msg.append("int : " + paraValues[i].toString() + "\n");
			}
			else {
				msg.append("명시되지 않은 속성 : " + paraValues[i].toString() + "\n");
			}
		}
		if (returnValue == null) {
			log.info(msg.toString() + "\n");
		} else {
			log.info(msg.toString() + "\n"+"returnValue = " + returnValue + "\n");
		}
		return returnValue;
	}

	
}
