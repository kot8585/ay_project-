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
 * TODO 추후, before 대신 afterReturning이나 around를 통해 보다 상세한 로그를 찍어야할 필요성이 있습니다.
 * AOP를 이용하여 로그를 찍는 Aspect 클래스입니다.
 * 다만, 구매와 로그인 이력을 찍는 부분은 여기서 이루어지지 않고 각 패키지의 컨트롤러에서 이루어집니다.
 * 포인트컷을 어노테이션 별로 다르게 찍도록 설정했으나, 사실 "똑같습니다".
 * 받아온 속성값에 따라 다르게 값이 찍히도록 했습니다. 
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
	public Object AfterReturning(JoinPoint joinPoint, Object returnValue) {
		if (returnValue == null) {
			log.info("[AfterReturning] Test returnValue : void Method");
		} else {
			log.info("[AfterReturning] Test returnValue : " + returnValue.toString());
		}
		return returnValue;
	}
	
	@Before("RequestMapping()")
	public void beforeRequest(JoinPoint joinPoint) {
		System.out.println("[RequestMapping]" + joinPoint.getSignature().toShortString());
		/* 해당 메소드의 매개변수(=parameter)를 가져옵니다. 
		/ 그 예로 String login(Member m, HttpServletRequest req)의 경우 Member m과 HttpServletRequest req를 가져옵니다.
		 */
		Object [] paraValues = joinPoint.getArgs();
		// String의 경우 += 등으로 문자열을 추가할 경우, 힙 메모리가 많이 소모되어 성능 저하를 유발할 수 있습니다.
				// 따라서 빈번하게 삽입이 이루어질 경우, StringBuilder나 StringBuffer를 사용하는 편이 좋습니다.
		StringBuilder values = new StringBuilder();
		// = String values += "[RequestMapping]...";
		values.append("[RequestMapping]" + joinPoint.getSignature().toShortString() + "\n");
		/* instanceof로 paraValues 값을 받아옵니다. 
		 * 본래 category 등 로그 작성을 위해 임의로 만든 메소드를 사용해서 썼으나
		 * 굳이 그 메소드를 쓸 필요가 없어서 소스만 길뿐 별 쓸모는 없습니다... 리팩토리가 필요합니다... 
		*/
		
		Member m;
		Admin ad;
		Board b;
		Order o;
		Product p;
		Reply rep;
		Review rev;
		Shoppingcart s;
		
		for (int i = 0; i < paraValues.length; i++) {
			if (paraValues[i] instanceof Member) {
				m = (Member) paraValues[i];
				values.append(m.toString());
			}
			else if (paraValues[i] instanceof Admin) {
				ad = (Admin) paraValues[i];
				values.append(ad.toString());
			}
			else if (paraValues[i] instanceof Board) {
				b = (Board) paraValues[i];
				values.append(b.toString());
			}
			else if (paraValues[i] instanceof Order) {
				o = (Order) paraValues[i];
				values.append(o.toString());
			}
			else if (paraValues[i] instanceof Product) {
				p = (Product) paraValues[i];
				values.append(p.toString());
			}
			else if (paraValues[i] instanceof Reply) {
				rep = (Reply) paraValues[i];
				values.append(rep.toString());
			}
			else if (paraValues[i] instanceof Review) {
				rev = (Review) paraValues[i];
				values.append(rev.toString());
			}
			else if (paraValues[i] instanceof Shoppingcart) {
				s = (Shoppingcart) paraValues[i];
				values.append(s.toString());
			}
			else {
				values.append("attr" + i +"\n");
				values.append(paraValues[i].toString() + "\n");
			}
		}
		log.info(values.toString());
	}

	@Before("GetMapping()")
	public void beforeGet(JoinPoint joinPoint) {
		System.out.println("[GetMapping]" + joinPoint.getSignature().toShortString());

		/* 해당 메소드의 매개변수(=parameter)를 가져옵니다. 
		/ 그 예로 String login(Member m, HttpServletRequest req)의 경우 Member m과 HttpServletRequest req를 가져옵니다.
		 */
		Object [] paraValues = joinPoint.getArgs();
		// String의 경우 += 등으로 문자열을 추가할 경우, 힙 메모리가 많이 소모되어 성능 저하를 유발할 수 있습니다.
				// 따라서 빈번하게 삽입이 이루어질 경우, StringBuilder나 StringBuffer를 사용하는 편이 좋습니다.
		StringBuilder values = new StringBuilder();
		// = String values += "[RequestMapping]...";
		values.append("[RequestMapping]" + joinPoint.getSignature().toShortString() + "\n");
		
		/* instanceof로 paraValues 값을 받아옵니다. 
		 * 본래 category 등 로그 작성을 위해 임의로 만든 메소드를 사용해서 썼으나
		 * 굳이 그 메소드를 쓸 필요가 없어서 소스만 길뿐 별 쓸모는 없습니다... 리팩토리가 필요합니다... 
		*/
		Member m;
		Admin ad;
		Board b;
		Order o;
		Product p;
		Reply rep;
		Review rev;
		Shoppingcart s;
		
		for (int i = 0; i < paraValues.length; i++) {
			if (paraValues[i] instanceof Member) {
				m = (Member) paraValues[i];
				values.append(m.toString());
			}
			else if (paraValues[i] instanceof Admin) {
				ad = (Admin) paraValues[i];
				values.append(ad.toString());
			}
			else if (paraValues[i] instanceof Board) {
				b = (Board) paraValues[i];
				values.append(b.toString());
			}
			else if (paraValues[i] instanceof Order) {
				o = (Order) paraValues[i];
				values.append(o.toString());
			}
			else if (paraValues[i] instanceof Product) {
				p = (Product) paraValues[i];
				values.append(p.toString());
			}
			else if (paraValues[i] instanceof Reply) {
				rep = (Reply) paraValues[i];
				values.append(rep.toString());
			}
			else if (paraValues[i] instanceof Review) {
				rev = (Review) paraValues[i];
				values.append(rev.toString());
			}
			else if (paraValues[i] instanceof Shoppingcart) {
				s = (Shoppingcart) paraValues[i];
				values.append(s.toString());
			}
			else {
				values.append("attr" + i +"\n");
				values.append(paraValues[i].toString() + "\n");
			}
		}
		log.info(values.toString());
	}
	
	@Before("PostMapping()")
	public void beforePost(JoinPoint joinPoint) {
		System.out.println("[PostMapping]" + joinPoint.getSignature().toShortString());

		/* 해당 메소드의 매개변수(=parameter)를 가져옵니다. 
		/ 그 예로 String login(Member m, HttpServletRequest req)의 경우 Member m과 HttpServletRequest req를 가져옵니다.
		 */
		Object [] paraValues = joinPoint.getArgs();
		// String의 경우 += 등으로 문자열을 추가할 경우, 힙 메모리가 많이 소모되어 성능 저하를 유발할 수 있습니다.
				// 따라서 빈번하게 삽입이 이루어질 경우, StringBuilder나 StringBuffer를 사용하는 편이 좋습니다.
		StringBuilder values = new StringBuilder();
		// = String values += "[RequestMapping]...";
		values.append("[RequestMapping]" + joinPoint.getSignature().toShortString() + "\n");
		
		/* instanceof로 paraValues 값을 받아옵니다. 
		 * 본래 category 등 로그 작성을 위해 임의로 만든 메소드를 사용해서 썼으나
		 * 굳이 그 메소드를 쓸 필요가 없어서 소스만 길뿐 별 쓸모는 없습니다... 리팩토리가 필요합니다... 
		*/
		Member m;
		Admin ad;
		Board b;
		Order o;
		Product p;
		Reply rep;
		Review rev;
		Shoppingcart s;
		
		for (int i = 0; i < paraValues.length; i++) {
			if (paraValues[i] instanceof Member) {
				m = (Member) paraValues[i];
				values.append(m.toString());
			}
			else if (paraValues[i] instanceof Admin) {
				ad = (Admin) paraValues[i];
				values.append(ad.toString());
			}
			else if (paraValues[i] instanceof Board) {
				b = (Board) paraValues[i];
				values.append(b.toString());
			}
			else if (paraValues[i] instanceof Order) {
				o = (Order) paraValues[i];
				values.append(o.toString());
			}
			else if (paraValues[i] instanceof Product) {
				p = (Product) paraValues[i];
				values.append(p.toString());
			}
			else if (paraValues[i] instanceof Reply) {
				rep = (Reply) paraValues[i];
				values.append(rep.toString());
			}
			else if (paraValues[i] instanceof Review) {
				rev = (Review) paraValues[i];
				values.append(rev.toString());
			}
			else if (paraValues[i] instanceof Shoppingcart) {
				s = (Shoppingcart) paraValues[i];
				values.append(s.toString());
			}
			else {
				values.append("attr" + i +"\n");
				values.append(paraValues[i].toString() + "\n");
			}
		}
		log.info(values.toString());
	}
}
