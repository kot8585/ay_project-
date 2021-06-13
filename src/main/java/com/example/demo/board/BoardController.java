package com.example.demo.board;

import java.util.ArrayList;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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
 * @author 문효정
 */
@Controller
@RequestMapping("/board/*")
@RequiredArgsConstructor
@Slf4j
public class BoardController {

	private final BoardService service;

	/**
	 * 타입에 맞는 게시물의 목록을 제공하는 기능
	 * @param type :faq, notice
	 * @param cri : 페이지 기준
	 */
	@RequestMapping(value = "/{type}/list")
	public ModelAndView list(@PathVariable String type, Criteria cri) {
		log.info("board/type = " + type);
		log.info("cri=" + cri);
		cri.changeOffset(cri.getPageNum(), cri.getAmount()); //@ModelAttribute때문에 나중에 설정해줘야한다.. 해결법은 없을까..
		int total = service.getTotal(type, cri.getKeyword());
		ArrayList<Board> list = (ArrayList<Board>) service.getList(type, cri);
		ModelAndView mav = new ModelAndView("board/list");
		mav.addObject("list", list);
		mav.addObject("type", type);
		mav.addObject("pageMaker", new PageDTO(cri, total)); 
		return mav;
	}

	@GetMapping("/{type}")
	public ModelAndView listCursor(@PathVariable String type, Criteria cri) {
		log.info("board/type = " + type);
		log.info("cri=" + cri);
		ArrayList<Board> list = (ArrayList<Board>) service.getListWithPagingCursor(type, cri);
		ModelAndView mav = new ModelAndView("board/list_more");
		mav.addObject("list", list);
		mav.addObject("type", type);
		return mav;
	}

	/**
	 * 게시판 수정 기능 담당
	 */
	@PostMapping("/edit")
	public String edit(Board b, @ModelAttribute("cri") Criteria cri, RedirectAttributes redirectAttributes) {
		boolean result = service.update(b);
		redirectAttributes.addAttribute("type", b.getType());
		redirectAttributes.addAttribute("pageNum", cri.getPageNum());
		redirectAttributes.addAttribute("amount", cri.getAmount());
		log.info("수정 결과값 : {}", result);
		return "redirect:/board/{type}/list";
	}

	/**
	 * 게시판 삭제기능 담당
	 * @param num 게시판 번호
	 * @return 게시판 삭제하고 이동할 페이지
	 */
	@GetMapping("/{type}/del")
	public String del(int num, @PathVariable String type, RedirectAttributes redirectAttributes) {
		service.delBoard(num);
		redirectAttributes.addAttribute("type", type);
		return "redirect:/board/{type}/list";
	}
	/**
	 * @ModelAttribute는 자동으로 Model에 데이터를 지정한 이름으로 담아준다. 게시판 상세페이지 제공
	 * @param num 게시판 번호,
	 * @return 해당 게시판과 이동할 페이지
	 */
	@GetMapping("/detail")
	public void detail(@RequestParam("num") int num, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("상세 게시글 번호 : {}", num);
		model.addAttribute("b", service.getBoardByNum(num));
	}
}
