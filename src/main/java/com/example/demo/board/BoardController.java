package com.example.demo.board;

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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.reply.RepService;
import com.example.demo.reply.Reply;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService service;
	
	
	
	public static String basePath = "C:\\shopimg\\";
	/*게시물 리스트 뽑기
	 * author : 문효정
	 */
	
	//타입에 맞는 게시판 목록 가져오기
	@RequestMapping(value="/board/{type}/list")
	public ModelAndView list(@PathVariable String type) {
		System.out.println("board/type = " + type);
		ArrayList<Board> list = (ArrayList<Board>) service.getBoardByType(type);
		ModelAndView mav = new ModelAndView("board/list");
		mav.addObject("list", list);
		return mav;
	}
	
	//해당 url로 바로 들어올 경우를 대비해 한번더 검사하기
	@GetMapping("/board/writeForm") 
	public String writeForm(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		String id = (String) session.getAttribute("id");
		if(id.isBlank()) {
			return "redirect:member/loginForm";
		}else {
			return "/board/write";
		}
	}
	
	@PostMapping("/board/write")
	public String write(Board b) {
		String type = b.getType();
		service.addBoard(b);
		return "redirect:/admin/admin";
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
	
	
	@RequestMapping("/board/edit")
	public String edit(Board b) {
		service.update(b);
		return "redirect:/board/list";
	}
	
	@RequestMapping("/board/del")
	public String del(int num) {
		System.out.println("BoardController.del()");
		service.delBoard(num);
		
	
		
		return "redirect:/board/list";
	}
}
