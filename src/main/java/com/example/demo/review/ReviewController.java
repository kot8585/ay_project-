package com.example.demo.review;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.member.Member;
import com.example.demo.member.MemberService;
import com.example.demo.product.Product;
import com.example.demo.product.ProductService;
/**
 * 
 * @author Hyun Jin Kim
 * 2021.02.08
 * 기능 : 리뷰 작성 / 리스트 출력 / 수정 / 삭제
 *
 */
@Controller
public class ReviewController {

	@Autowired
	private ReviewService service;
	
	@Autowired
	private ProductService pservice;
	
	@Autowired
	private MemberService mservice;
	
	/**
	 * 
	 * @param req session값을 받아오기 위한 파라메터
	 * @param pnum 해당 상품에 대한 리뷰를 쓰기위해 상품번호를 받아우기 위한 파라메터
	 * @return 상품 번호를 jsp에서 사용하기 위해, 상품에 대한 정보를 리턴함.
	 */
	@RequestMapping("/review/reviewForm")
		public ModelAndView reviewForm(HttpServletRequest req, @RequestParam("pnum") int pnum) {
		// 로그인한 id를 리뷰작성 페이지의 작성자로 보내주기 위해 서버에서 session값을 받아온다.
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("id");
		// 선택한 상품의 상품번호를 파라메터 받아온 뒤, 해당 번호로 상품을 검색하여 상품에 대한 정보를 객체에 저장한다.
		Product p = pservice.getProductByNum(pnum);
		// 객체에 저장된 정보를 reviewForm.jsp로 보내준다.
		ModelAndView mav = new ModelAndView("review/reviewForm");
		mav.addObject("p", p);
		return mav;   
	}             
	
	/**
	 * 
	 * @param r 리뷰 폼에 입력 받은 자료를 객체에 저장 
	 * @return 리뷰 폼이 완성되었을 때 main 페이지로 이동.
	 */
	@RequestMapping("/review/write")
	public String write(Review r) {
		//작성한 폼을 DB에 저장한다.
		service.addReview(r);
		return "redirect:/member/main";
	}
	

	/**
	 * 
	 * @return 작성됨 리뷰들을 리스트로 화면에 출력
	 */
	@RequestMapping("/review/reviewlist")
	public ModelAndView viewlist(@RequestParam("p_num") int p_num, @RequestParam("what")String what) {
		System.out.println(what);
		System.out.println(what.getClass());
		//System.out.println(p_num);
		// 작성된 모든 리뷰를 리스트에 저장
		ArrayList<Review> reviewlist = null;
		if(what.equals("basic") || what.equals("none")) {
			reviewlist = (ArrayList<Review>) service.getByPnum(p_num);
		}else if(what.equals("latest")) {
			reviewlist = (ArrayList<Review>) service.getDetailByDate(p_num);
		}
		System.out.println(reviewlist);
		// 리스트에 저장된 리뷰들을 reviewlist.jsp에 보냄
		ModelAndView mav = new ModelAndView("review/reviewlist");
		//mav.setViewName("review/list");
		mav.addObject("list", reviewlist);
		return mav;
	}
	
	@RequestMapping("/review/list")
	public ModelAndView list(@RequestParam("what")String what, @RequestParam("p_num")int p_num) {
		ArrayList<Review> reviewlist = null;
		if(what.equals("basic") || what.equals("none")) {
			reviewlist = (ArrayList<Review>) service.getByPnum(p_num);
		}else if(what.equals("latest")) {
			reviewlist = (ArrayList<Review>) service.getDetailByDate(p_num);
		}
		System.out.println(reviewlist);
		// 리스트에 저장된 리뷰들을 reviewlist.jsp에 보냄
		ModelAndView mav = new ModelAndView("review/list");
		//mav.setViewName("review/list");
		mav.addObject("list", reviewlist);
		return mav;
	}
	
	/**
	 * 
	 * @param num 특정번호에 해당하는 리뷰를 가져오기 위한 파라메터
	 * @return 특정번호에 해당하는 리뷰를 화면에 출력
	 */
	@RequestMapping("/review/reviewDetail")
	public ModelAndView detail(@RequestParam("num") int num) {
		// 특정 번호에 해당하는 리뷰에 대한 정보를 가져와 객체에 담는다.
		Review r = service.getDetail(num);	
		// 객체에 담긴 정보를 reviewDetail.jsp에 보냄
		ModelAndView mav = new ModelAndView("review/reviewDetail");
		mav.addObject("r", r);
		return mav;
	}
	
	/**
	 * 	
	 * @param r 리뷰 수정 폼에서 입력받은 자료를 객체에 저장
	 * @return 수정을 마친 뒤 main 페이지로 이동
	 */
	@RequestMapping("/review/editReview")
	public String edit(Review r) {
		// 수정 폼에 입력된 자료를 DB에 저장
		service.editReview(r);
		return "/member/main";
	}
	

	
	/**
	 * 
	 * @param req session에서 id값을 받아오기 위한 파라메터
	 * @param pwd 입력받은 비밀번호를 받아온다
	 * @return 비밀번호 체크에 대한 결과를 출력
	 */
	@RequestMapping("/review/pwdCheck")
	public ModelAndView pwdCheck(HttpServletRequest req, @RequestParam("password")String pwd) {
		HttpSession session = req.getSession(false);
		String id = (String) session.getAttribute("id");
		
		System.out.println(id);
		System.out.println(pwd);
		Member m = mservice.getMember(id);
		String result = "";
		if(m != null && m.getPassword().equals(pwd)) {
			result = "비밀번호 확인 완료";
		}
		else {
			result = "비밀번호가 다릅니다.";
		}
		ModelAndView mav = new ModelAndView("review/pwdCheck");
		mav.addObject("result", result);
		
		return mav;
	}
	
	/**
	 * 
	 * @param num 특정 번호에 해당하는 리뷰 글을 지우기 위한 파라메터
	 * @return 삭제가 되었을 때 main 페이지로 이동
	 */
	@RequestMapping("/review/delReview")
	public String del(@RequestParam("num")int num) {
		// DB에서 특정 번호에 해당하는 리뷰 글 삭제	
		service.delReview(num);
		return "redirect:/member/main";	
	}
	
	@RequestMapping("/review/reviewRating")
	public ModelAndView rating(@RequestParam("num") int num, @RequestParam("type")String type) {
		System.out.println("Parameter : " + num);
		System.out.println("Type : " + type);
		Review r = service.getDetail(num);
		if(type.equals("like")) {
			System.out.println("증가");
			service.IncRating(r);
		}else if(type.equals("감소")){
			System.out.println("감소");
		}
		
		//service.IncRating(num);
		
		System.out.println(r);
		
		
		
		ModelAndView mav = new ModelAndView("review/reviewRating");
		mav.addObject("r", r);
		return mav;
	}
}


