package com.example.demo.board;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.reply.RepService;
import com.example.demo.reply.Reply;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService service;
	
	@Autowired
	private RepService repService;
	
	public static String basePath = "C:\\shopimg\\";
	/*게시물 리스트 뽑기
	 * author : 문효정
	 */
	@RequestMapping("/board/list")
	public ModelAndView list() {
		System.out.println("/board/list()");
		ArrayList<Board> list = (ArrayList<Board>) service.getAllBoard();
		ModelAndView mav = new ModelAndView("board/list");
		mav.addObject("list", list);
		return mav;
	}
	
	
	
	@GetMapping("/board/writeForm")
	public void writeForm() {
	}
	
	@PostMapping("/board/write")
	public String write(Board b) {
		int num = service.getNum();
		b.setNum(num);
		saveBoardImg(num, b.getFile1());
		saveBoardImg(num, b.getFile2());
		saveBoardImg(num, b.getFile3());
		service.addBoard(b);
		return "redirect:/board/list";
	}
	
	public void saveBoardImg(int num, MultipartFile file) { //이미지 저장하기
		String fileName = file.getOriginalFilename();
		if(fileName != null && !fileName.equals("")) {
			File dir = new File(basePath + num);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			File f = new File(basePath + "b" + num + "\\" + fileName);
			try {
				file.transferTo(f);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	@RequestMapping("/board/detail")
	public ModelAndView detail(int num) {
		System.out.println("/board/detail()");
		ModelAndView mav = new ModelAndView("board/detail");
		System.out.println(num);
		Board b = service.getBoardByNum(num);
		
		//해당 게시물의 댓글 가져오기
		ArrayList<Reply> reps = (ArrayList<Reply>) repService.getReplyByBoardNum(b.getNum());
		b.setReps(reps);
				

		String path = basePath + "b" +b.getNum() + "\\";
		File imgDir = new File(path);
		if(imgDir.exists()) {
			String[] files  = imgDir.list();
			for (int j = 0; j < files.length; j++) {
				System.out.println(files[j].toString());
				mav.addObject("file" + j, files[j]); 
			}
		}
		mav.addObject("b", b);
		return mav;
	}
	
	@RequestMapping("/board/img")
	public ResponseEntity<byte[]> getImg(String fname, int num){
		String path = basePath + "b" + num + "\\" + fname;
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
	
	@RequestMapping("/board/edit")
	public String edit(Board b) {
		service.update(b);
		return "redirect:/board/list";
	}
	
	@RequestMapping("/board/del")
	public String del(int num) {
		System.out.println("BoardController.del()");
		service.delBoard(num);
		
		//이미지 삭제하기
		String path = basePath + "b" + num+"\\"; 
		File imgDir = new File(path);
		
		if (imgDir.exists()) {
			String[] files = imgDir.list();
			for (int j = 0; j < files.length; j++) {
				File f = new File(path + files[j]);
				f.delete();
			}
		}
		imgDir.delete();
		
		return "redirect:/board/list";
	}
}
