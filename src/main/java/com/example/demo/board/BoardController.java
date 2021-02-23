package com.example.demo.board;

import java.util.ArrayList;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.page.Criteria;
import com.example.demo.page.PageDTO;


@Controller
public class BoardController {

	@Autowired
	private BoardService service;

	public static String basePath = "C:\\shopimg\\";
	/*
	 * 게시물 리스트 뽑기 author : 문효정
	 */

	// 타입에 맞는 게시판 목록 가져오기
	@RequestMapping(value = "/board/{type}/list")
	public ModelAndView list(@PathVariable String type, Criteria cri) {
		System.out.println("board/type = " + type);
		System.out.println("cri=" + cri);
		int total = service.getTotal(type, cri.getKeyword());
		ArrayList<Board> list = (ArrayList<Board>) service.getList(type, cri);
		ModelAndView mav = new ModelAndView("board/list");
		mav.addObject("list", list);
		mav.addObject("type", type);
		mav.addObject("pageMaker", new PageDTO(cri, total)); // 총 개수 구현해야함
		return mav;
	}

	@RequestMapping("/board/detail")
	public ModelAndView detail(int num) {
		System.out.println("/board/detail()");
		ModelAndView mav = new ModelAndView("board/detail");
		System.out.println(num);
		Board b = service.getBoardByNum(num);

		mav.addObject("b", b);
		return mav;
	}

	// admin으로 수정
	@RequestMapping("/board/edit")
	public String edit(Board b) {
		service.update(b);
		return "redirect:/board/list";
	}

	// admin으로 수정
	@RequestMapping("/board/del")
	public String del(int num) {
		System.out.println("BoardController.del()");
		service.delBoard(num);

		return "redirect:/board/list";
	}
	

}
