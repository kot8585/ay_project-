package com.example.demo.event;

import java.io.File;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.product.Product;
import com.example.demo.product.ProductService;

@Controller
public class EventController {
	
	@Autowired
	private ProductService service;
	
	public static String basePath = "C:\\shopimg\\p";

	
	 @RequestMapping("/event/list")
	   public ModelAndView List() {
		  //list에 service.getProductAll()을 담는다
	      ArrayList<Product> list = (ArrayList<Product>) service.getProductByEvent();
	      
	      //mav에 product/list를 담는다
	      ModelAndView mav = new ModelAndView("event/eventList");

	      //리스트 갯수만큼 반복
	      for (int i = 0; i < list.size(); i++) {
	    	  
	    	 //path에 basePath에 담긴 이미지와 list에 담긴 번호를 저장
	         String path = basePath + list.get(i).getNum() + "\\";
	         
	         //imDir에 path를 저장
	         File imgDir = new File(path);   
	        
	         //files에 imgDir을 저장
	         String[] files = imgDir.list();
	         //mav에 files에 저장된 값을 저장한다
	         if(imgDir.exists()) {
	            for(int j = 0; j < files.length; j++) {
	               mav.addObject("file" + j, files[j]);
	            }
	            
	            list.get(i).setImgPath(files[0]);
	           	System.out.println(list.get(i).toString());
	         }
	      }
	       //mav에 list를 담는다
	      mav.addObject("list", list);
	      
	      return mav;
	   }
	      
}
