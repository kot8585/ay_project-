package com.example.demo.board;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.page.Criteria;
import com.example.demo.page.PageDTO;

/**
 * 해당 게시판은 자주묻는 질문사항(faq)와 공지사항(notice)로 type가 나뉩니다. 해당 게시판은
 * com.example.demo.page 를 통해 페이징 기능을 제공합니다.
 * 
 * @author 문효정
 *
 */
@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Autowired
	private BoardService service;

	public static String basePath = "C:\\shopimg\\";

	/**
	 * 타입에 맞는 게시물의 목록을 제공하는 기능
	 * 
	 * @param type
	 * @param cri
	 * @return
	 */
	@RequestMapping(value = "/{type}/list")
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

	/**
	 * @ModelAttribute는 자동으로 Model에 데이터를 지정한 이름으로 담아준다. 게시판 상세페이지 제공
	 * @param num 게시판 번호,
	 * @return 해당 게시판과 이동할 페이지
	 */
	@GetMapping("/detail")
	public void detail(@RequestParam("num") int num, @ModelAttribute("cri") Criteria cri, Model model) {
		System.out.println(num);
		model.addAttribute("b", service.getBoardByNum(num));
	}

	/**
	 * 게시판 수정 기능 담당
	 * 
	 * @param b 수정한 게시판 데이터
	 * @return 수정하고 이동할 페이지
	 */
	@PostMapping("/edit")
	public String edit(Board b, @ModelAttribute("cri") Criteria cri) {
		boolean result = service.update(b);
		System.out.println("수정 결과값 : " + result);

		return "redirect:/board/" + b.getType() + "/list?pageNum=" + cri.getPageNum() + "&amount=" + cri.getAmount();
	}

	/**
	 * 게시판 삭제기능 담당
	 * 
	 * @param num 게시판 번호
	 * @return 게시판 삭제하고 이동할 페이지
	 */
	@GetMapping("/{type}/del")
	public String del(int num, @PathVariable String type) {
		service.delBoard(num);
		return "redirect:/board/" + type + "/list";
	}

}
