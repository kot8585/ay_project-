package com.example.demo.category;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * 카테고리 관련 기능을 처리하는 컨트롤러
 * @author kpk
 */
@Controller
public class CategoryController {
	
	@Autowired
	private CategoryService service;

	/**
	 * 카테고리 Data JSON으로 받기용
	 * @param type 분류
	 * @param c_id 카테고리 ID
	 * @return viewName
	 */
	@RequestMapping(value = "/category/getCategory")
	public ModelAndView getsub(@RequestParam(value = "type") int type, @RequestParam(value = "c_id") int c_id) {
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
	 * @param c : 추가 내용
	 * @param type : 카테고리1인가 2인가 구별
	 * @return viewName
	 */
	@RequestMapping(value = "/category/addCategory")  // 카테고리 추가 
	public String addCategory(Category c, @RequestParam(value = "type") int type) {
		service.addCategory(c, type);
		return "admin/admin";
	}
	
	/**
	 * 카테고리 수정
	 * @param type : 카테고리1인가 2인가 구별
	 * @param c : 수정 내용
	 * @return viewName
	 */
	@RequestMapping("/category/editCategory")
	public String editCategory(@RequestParam(value = "type") int type, Category c) {
		service.editCategory(type, c);
		return "redirect:/admin/admin";
	}
	
	/**
	 * 카테고리 삭제
	 * @param type : 카테고리1인가 2인가 구별
	 * @param id : 삭제한 카테고리의 id
	 * @return viewName
	 */
	@RequestMapping("/category/deleteCategory")
	public String deleteCategory(@RequestParam(value = "type") int type, @RequestParam(value = "id") int id) {
		service.delCategory(id, type);
		return "redirect:/admin/admin";
	}

}
