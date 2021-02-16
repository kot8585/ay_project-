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
	      mav.addObject("plist", plist);
	      return mav;
	}
	

	
	
	
	
	
	
	
}
