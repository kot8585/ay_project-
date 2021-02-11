package com.example.demo.qna;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.order.OrderService;
import com.example.demo.reply.RepService;
import com.example.demo.reply.Reply;

@Controller
public class QnaController {
	
	@Autowired
	private QnaService service;
	
	@Autowired
	private RepService repService;
	
	@Autowired
	private OrderService orderService;
	
	public static String basePath = "C:\\shopimg\\";
	
	private final Logger log = LoggerFactory.getLogger(this.getClass());
	/*게시물 리스트 뽑기
	 * author : 문효정
	 */
	
	//로그인을 하지 않고 해당 url로 바로 들어올 경우를 대비해 한번더 검사하기
	@GetMapping("/qna/QuestionForm") 
	public String writeForm(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		String id = (String) session.getAttribute("id");
		if(id.isBlank()) {
			return "redirect:member/loginForm";
		}else {
			return "/qna/QuestionForm";
		}
	}
	
	
	@PostMapping("/qna/write")
	public String write(Qna q) {
		int num = service.getNum();
		System.out.println("q_cate : " + q.getQ_cate());
		System.out.println("writer : " + q.getWriter());
		q.setNum(num);
		saveQnaImg(num, q.getFile1());
		saveQnaImg(num, q.getFile2());
		saveQnaImg(num, q.getFile3());
		service.addQna(q);
		return "redirect:/mypage/myQuestionForm";
	}
	
	public void saveQnaImg(int num, MultipartFile file) { //이미지 저장하기
		String fileName = file.getOriginalFilename();
		if(fileName != null && !fileName.equals("")) {
			File dir = new File(basePath + "q" +num);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			File f = new File(basePath + "q" + num + "\\" + fileName);
			try {
				file.transferTo(f);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	@RequestMapping("/qna/detail")
	public ModelAndView detail(int num) {
		System.out.println("QnaController.detail()");
		ModelAndView mav = new ModelAndView("qna/detail");
		System.out.println(num);
		Qna q = service.getQnaByNum(num);

		String path = basePath + "q" + q.getNum() + "\\";
		File imgDir = new File(path);
		if(imgDir.exists()) {
			String[] files  = imgDir.list();
			for (int j = 0; j < files.length; j++) {
				System.out.println(files[j].toString());
				mav.addObject("file" + j, files[j]); 
			}
			q.setPath(files[0]);
		}
		mav.addObject("q", q);
		return mav;
}
	
	@RequestMapping("/qna/img")
	public ResponseEntity<byte[]> getImg(String fname, int num){
		
		String path = basePath + "q" + num + "\\" + fname;
		File f = new File(path);
		HttpHeaders header = new HttpHeaders();
		ResponseEntity<byte[]> result = null;
		try {
			header.add("Content-Type", Files.probeContentType(f.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(f),header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		} 
		return result;
	}
	
	@RequestMapping("/qna/edit")
	public String edit(Qna b) {
		service.update(b);
		return "redirect:/mypage/myQuestion";
	}
	
	@RequestMapping("/qna/del")
	public String del(int num) {
		System.out.println("BoardController.del()");
		service.delQna(num);
		
		//이미지 삭제하기
		String path = basePath + "q" + num+"\\"; 
		File imgDir = new File(path);
		
		if (imgDir.exists()) {
			String[] files = imgDir.list();
			for (int j = 0; j < files.length; j++) {
				File f = new File(path + files[j]);
				f.delete();
			}
		}
		imgDir.delete();
		
		return "redirect:/mypage/myQuestion";
	}
	
//	@RequestMapping("/qna/getO_num"){ //상품명이랑 주문일자 가져오기
}
