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
	public ModelAndView pquestionForm(@RequestParam("pnum") int pnum) {
		System.out.println("PquestionController.pquestionForm()");
		
	Product p = pservice.getProductByNum(pnum);
	ModelAndView mav = new ModelAndView("pquestion/pquestionForm");
	
	
	mav.addObject("pq", p);
	return mav;   
}            
	

	@RequestMapping("/pquestion/plist")
	   public ModelAndView list(@RequestParam("pnum") int pnum) {
		  System.out.println("PquestionController.list()");
	      ArrayList<Pquestion> plist = (ArrayList<Pquestion>) service.getAll();
	      ModelAndView mav = new ModelAndView("pquestion/plist");
	      mav.addObject("plist", plist);
	      return mav;
	}
	
	
	@RequestMapping("/pquestion/write")
	public String write(Pquestion pq) {
		//작성한 폼을 DB에 저장한다.
		service.addPquestion(pq);
		return "redirect:/product/detail";
	}
	
		
	
	
	
//	@RequestMapping("/pquestion/plist")
//	public ModelAndView list() {
//		ArrayList<Pquestion> list = (ArrayList<Pquestion>) service.getAll();
//		
//		ModelAndView mav = new ModelAndView("pquestion/plist");
//		
//		mav.addObject("plist", list);
//		return mav;
//	}
//	
	
//	@RequestMapping("/product/detail")
//	   public ModelAndView detail(@RequestParam("num") int num) {
//	      Pquestion pq = service.getDetail(num);
//	      
//	      ModelAndView mav = new ModelAndView("pquestion/pdetail");
//	      
//	
//	      //mav에 p를 담는다
//	      mav.addObject("p", pq);
//	      return mav;
//	      
//	   }
//	
}	
	

