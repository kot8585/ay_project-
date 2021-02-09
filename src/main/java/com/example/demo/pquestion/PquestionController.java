package com.example.demo.pquestion;

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

import com.example.demo.product.Product;
import com.example.demo.product.ProductService;




@Controller
public class PquestionController {

	@Autowired
	private PquestionService service;
	
	@Autowired
	private ProductService pservice;
	
	@RequestMapping("/pquestion/plist")
	   public ModelAndView List() {
		  System.out.println("PquestionController.pList()");
	      ArrayList<Pquestion> plist = (ArrayList<Pquestion>) service.getAllPquestion();
	      ModelAndView mav = new ModelAndView("pquestion/plist");
	      System.out.println(plist.get(0).toString());
	      mav.addObject("plist", plist);
			return mav;
	   
	}
	
	/*@GetMapping("/question/writeForm")
	public void writeForm() {
	}
	
	@PostMapping("/pquestion/writeForm")
	public String write(Pquestion p) {
		int num = service.getNum();
		p.setNum(num);
		service.addPquestion(p);
		return "redirect:/pquestion/plist";
	}*/
	
	@RequestMapping("/pquestion/writeForm")
	public ModelAndView reviewForm(HttpServletRequest req, @RequestParam("pnum") int pnum) {
		System.out.println("PquestionController.reviewForm()");
	// 로그인한 id를 리뷰작성 페이지의 작성자로 보내주기 위해 서버에서 session값을 받아온다.
	HttpSession session = req.getSession();
	String id = (String) session.getAttribute("id");
	//int num = service.getNum();
	Product p = pservice.getProductByNum(pnum);
	// 객체에 저장된 정보를 writeForm.jsp로 보내준다.
	ModelAndView mav = new ModelAndView("pquestion/writeForm");
	mav.addObject("p", p);
	return mav;
	
}
	
	@RequestMapping("/pquestion/write")
	public String write(Pquestion p) {
		System.out.println("PquestionController.write()");
		//작성한 폼을 DB에 저장한다.
		service.addPquestion(p);
		return "redirect:/member/main";
	}
	
	
	
	
	
	
	
	
	
	
}
