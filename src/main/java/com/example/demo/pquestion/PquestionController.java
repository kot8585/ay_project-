package com.example.demo.pquestion;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.member.MemberService;
import com.example.demo.product.Product;
import com.example.demo.product.ProductService;
import com.example.demo.qna.Qna;
import com.example.demo.review.Review;
import com.example.demo.shoppingcart.Shoppingcart;
import com.fasterxml.jackson.annotation.JsonCreator.Mode;




@Controller
public class PquestionController {

	@Autowired
	private PquestionService service;
	
	@Autowired
	private ProductService pservice;
	
	@Autowired
	private MemberService mservice;
	
	
	@RequestMapping("/pquestion/pquestionForm")
	public ModelAndView pquestionForm(HttpServletRequest req,@RequestParam("pnum") int pnum) {
		System.out.println("PquestionController.pquestionForm()");
		
	HttpSession session = req.getSession();
	String id = (String) session.getAttribute("id");
		
	Product p = pservice.getProductByNum(pnum);
	
	ModelAndView mav = new ModelAndView("pquestion/pquestionForm");
	
	
	mav.addObject("pq", p);
	return mav;   
}            
	

	@RequestMapping("/pquestion/plist")
	   public ModelAndView list(@RequestParam("pnum") int pnum) {
		  System.out.println("PquestionController.list()");
	      ArrayList<Pquestion> plist = (ArrayList<Pquestion>) service.getAll();
		  System.out.println(plist.toString());
	      ModelAndView mav = new ModelAndView("pquestion/plist");
	      mav.addObject("plist", plist);
	      return mav;
	}
	
	
	@RequestMapping("/pquestion/write")
	public String write(Pquestion pq) {
		//작성한 폼을 DB에 저장한다.
		service.addPquestion(pq);
		return "redirect:/member/main";
	}
	
	
	@RequestMapping("/pquestion/pDetail")
	public ModelAndView detail(@RequestParam("num") int num) {
		// 특정 번호에 해당하는 리뷰에 대한 정보를 가져와 객체에 담는다.
		Pquestion pq = service.getDetail(num);	
		// 객체에 담긴 정보를 pDetail.jsp에 보냄
		ModelAndView mav = new ModelAndView("pquestion/pDetail");
		mav.addObject("pq", pq);
		return mav;
	}
	
	@RequestMapping("/pquestion/editpquestion")
	public String pquestion(Pquestion pq) {
		// 수정 폼에 입력된 자료를 DB에 저장
		service.editPquestion(pq);
		return "/member/main";
	}
	
		
	@RequestMapping("/pquestion/delpquestion")
	public String delete(@RequestParam("num")int num) {
		
		service.delPquestion(num);
		return "redirect:/member/main";
	}
	

}	
	

