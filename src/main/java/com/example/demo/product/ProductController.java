package com.example.demo.product;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.board.Board;

@Controller
public class ProductController {


   @Autowired
   private ProductService service;
   
   public static String basePath = "C:\\shopimg\\p";
   
   
   @RequestMapping("/product/list")
   public ModelAndView List() {
	  //list에 service.getProductAll()을 담는다
      ArrayList<Product> list = (ArrayList<Product>) service.getProductAll();
      
      //mav에 product/list를 담는다
      ModelAndView mav = new ModelAndView("product/list");

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
         }
      }
       //mav에 list를 담는다
      mav.addObject("list", list);
      return mav;
   }
      
   @RequestMapping("/product/detail")
   public ModelAndView detail(@RequestParam(value = "num") int num) {
      ModelAndView mav = new ModelAndView("product/detail");
      Product p = service.getProductByNum(num);
      
      //path에 basePath의 이미지와 상품번호를 담는다
      String path = basePath + p.getNum() + "\\";
      
      //imgDir에 path를 저장
      File imgDir = new File(path);
      if(imgDir.exists()) {
    	  
    	 //files에 imgDir의 리스트를 저장
         String[] files = imgDir.list();
         for(int j = 0; j < files.length; j++) {
            mav.addObject("file" + j, files[j]);
         }
         
      }
      
      //mav에 p를 담는다
      mav.addObject("p", p);
      return mav;
      
   }
   
   @RequestMapping("/img")
   public ResponseEntity<byte[]> getImg(String fname, int num) {
      String path = basePath + num + "\\" + fname;
      File f = new File(path);
      HttpHeaders header = new HttpHeaders();
      ResponseEntity<byte[]> result = null;
      try {
    	  header.add("Content-Type", Files.probeContentType(f.toPath()));
    	  result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(f), header, HttpStatus.OK);

      } catch (IOException e) {
         e.printStackTrace();
      }

      return result;
   }
   
  
}
   
   