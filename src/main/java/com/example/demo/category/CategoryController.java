package com.example.demo.category;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * 카테고리 관련된 기능들을 구현한 Controller 클래스입니다.
 * 모든 기능이 /admin/admin.jsp에서 제공됩니다.
 * @author 김평기
 * @version main 1
 */
@Controller
public class CategoryController {
	
	@Autowired
	private CategoryService service;

	/**
	 * 원하는 카테고리의 리스트를 받아오는 기능을 제공합니다.
	 * @param type 카테고리 분류
	 * @param c_id 카테고리 ID
	 * @return Redirect할 Url
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/category/getCategory")
	public ModelAndView getCategory(@RequestParam(value = "type") int type, @RequestParam(value = "c_id") int c_id) {
		ModelAndView mav = new ModelAndView("category/getCategory");
		ArrayList<Category> list = null;
		switch (type) {
		case 1:
			list = (ArrayList<Category>) service.getAll(1, 0);//상의메뉴가 없으니 0 
			break;
		case 2:
			list = (ArrayList<Category>) service.getAll(2, c_id); // 중분류 선택한 대분류의 id 
			break;
		}
		mav.addObject("list", list);
		return mav;
	}

	/**
	 * 카테고리 추가.
	 * @param c : 추가할 카테고리 내용을 담은 DTO
	 * @param type : 카테고리 분류
	 * @return Redirect할 Url
	 */
	@RequestMapping(value = "/category/addCategory")  // 카테고리 추가 
	public String addCategory(Category c, @RequestParam(value = "type") int type) {
		System.out.println("원인 체크 : " + c.toString());
		System.out.println("원인 체크 : " + type);
		service.addCategory(c, type);
		return "redirect:/admin/admin";
	}
	
	/**
	 * 카테고리 수정
	 * @param type : 카테고리 분류
	 * @param c : 수정할 카테고리 내용을 담은 DTO
	 * @return Redirect할 Url
	 */
	@RequestMapping("/category/editCategory")
	public String editCategory(@RequestParam(value = "type") int type, Category c) {
		service.editCategory(type, c);
		return "redirect:/admin/admin";
	}
	
	/**
	 * 카테고리 삭제
	 * @param type : 카테고리 분류
	 * @param id : 삭제한 카테고리의 id
	 * @return Redirect할 Url
	 */
	@RequestMapping("/category/deleteCategory")
	public String deleteCategory(@RequestParam(value = "type") int type, @RequestParam(value = "id") int id) {
		service.delCategory(id, type);
		return "redirect:/admin/admin";
	}

}
