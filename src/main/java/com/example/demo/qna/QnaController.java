package com.example.demo.qna;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.order.OrderService;
import com.example.demo.reply.RepService;
import com.example.demo.reply.Reply;

@Controller
@RequiredArgsConstructor
public class QnaController {
	
	private final QnaService service;
	private final RepService repService;
	private final OrderService orderService;
	
	private static String basePath = "C:\\shopimg\\q";
	
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
	
	
	@PostMapping("/qna/new")
	public String write(Qna q) {
		int num = service.getNum();
		log.info("q_cate : " + q.getQ_cate());
		log.info("getUploadFile : " + q.getUploadFile());
		q.setNum(num);
		for(MultipartFile multipartFile : q.getUploadFile()) {
			String fileName = multipartFile.getOriginalFilename();
			if(fileName != null && !fileName.equals("")) {
				saveQnaImg(num, multipartFile);
			}
		}
		service.addQna(q);
		return "redirect:/mypage/mypage";
	}
	
	public void saveQnaImg(int num, MultipartFile uploadFile) { //이미지 저장하기
			File dir = new File(basePath + num);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			
		String fileName = uploadFile.getOriginalFilename();
			File f = new File(dir, fileName);
			try {
				uploadFile.transferTo(f);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	
	
	@RequestMapping("/qna/detail")
	public ModelAndView detail(int num) {
		System.out.println("QnaController.detail()");
		ModelAndView mav = new ModelAndView("qna/detail");
		System.out.println(num);
		Qna q = service.getQnaByNum(num);

		String path = basePath + q.getNum();
		String[] files = null;
		File imgDir = new File(path);
		if(imgDir.exists()) {
			files  = imgDir.list();
		}
		mav.addObject("files", files); 
		mav.addObject("q", q);
		return mav;
}
	
	@RequestMapping("/qna/img")
	public ResponseEntity<byte[]> getImg(String fname, int num){
		
		String path = basePath+ num;
		File f = new File(path, fname);
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
		return "redirect:/mypage/mypage";
	}
	
	@PostMapping("/qna/{num}/delete")
	public String del(@PathVariable int num) {
		System.out.println("BoardController.del()");
		service.delQna(num);
		
		//이미지 삭제하기
		String path = basePath + num; 
		File imgDir = new File(path);
		
		//파일 존재하는지 확인하는 메소드 분리 - 존재하면 파일 리스트 리턴
				//존재한다면 파일 리스트를 받아서
				//파일을 삭제한다.
		if (imgDir.exists()) {
			String[] files = imgDir.list();
			System.out.println("delFiles: "+files);
			for (int j = 0; j < files.length; j++) {
				File f = new File(path + files[j]);
				f.delete();
			}
		}
		imgDir.delete();
		
		return "redirect:/mypage/mypage";
	}
	
	@PostMapping("/uploadAjaxAction")
	public void uploadAjaxPost(MultipartFile[] uploadFile) {
		System.out.println(uploadFile);
		String uploadFolder = "C:\\upload";

		for(MultipartFile multipartFile : uploadFile) {
			log.info("Upload File Name: " +  multipartFile.getOriginalFilename());
			log.info("Upload File Size: " +  multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			File saveFile = new File(uploadFolder, uploadFileName);
			
			try {
				multipartFile.transferTo(saveFile);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				log.error(e.getMessage());
			}
		}
	}
	
//	@RequestMapping("/qna/getO_num"){ //상품명이랑 주문일자 가져오기
}
