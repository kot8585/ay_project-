package com.example.demo.event;

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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.category.Category;

/**
 * 카테고리 관련된 기능들을 구현한 Controller 클래스입니다.
 * @author 김평기
 * @version main 1
 */
@Controller
public class EventController {

	@Autowired
	private EventService service;

	/**
	 * 이미지가 저장될 기본 경로
	 */
	public static String basePath = "C:\\shopimg\\e";

	/**
	 * 이벤트 List와 List의 배열길이만큼 공차가 1인 등차수열을 리턴합니다.
	 * 등차수열을 리턴하는 이유는 배열 길이만큼 버튼을 생성하고, 버튼에 각 이미지로 넘어갈 수 있는 num을 설정하기 위해서입니다. 
	 * @return Redirect할 Url, 받아온 리스트
	 */
	@RequestMapping("/event/list")
	public ModelAndView eventList() {
		// list에 service.getProductAll()을 담는다
		ArrayList<Event> list = (ArrayList<Event>) service.getEventList();

		// mav에 product/list를 담는다
		ModelAndView mav = new ModelAndView("event/eventList");

		// 리스트 갯수만큼 반복
		for (int i = 0; i < list.size(); i++) {

			// path에 basePath에 담긴 이미지와 list에 담긴 번호를 저장
			String path = basePath + list.get(i).getNum() + "\\";

			// File imgDir에 Filepath를 지정
			File imgDir = new File(path);

			// files에 imgDir에 있는 파일 경로들을 저장
			String[] files = imgDir.list();
			// mav에 files에 저장된 값을 저장한다
			if (imgDir.exists()) {
				// 이미지 경로를 저장한다
				list.get(i).setImgPath(files[0]);
				System.out.println(list.get(i).toString());
			}
		}
		
		// 공차가 1인 등차수열 생성.
		ArrayList<Integer> lengths = new ArrayList<Integer>();
		for (int i = 0; i < list.size(); i++) {
			lengths.add(i);
		}

		// mav에 list를 담는다
		mav.addObject("list", list);		
		// mav에 lengths(=등차수열)을 넣는다.
		mav.addObject("lengths", lengths);
		System.out.println("lengths : " + lengths.toString() + ", " + lengths.size());
		return mav;
	}

	/**
	 * 세션이 있다면 이벤트 추가 페이지(/event/writeForm.jsp)로 이동, 없으면 관리자 로그인 페이지로	 * @param req 세션
	 * @return Redirect할 Url
	 */
	@GetMapping("/event/write")
	public String writeForm(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		if (session == null) {
			return "/admin/loginForm";
		} else {
			return "/event/writeForm";
		}

	}

	/**
	 * 이벤트 추가 페이지에서 event에 관련된 내용들이 submit되었을시 실행. 
	 * @param e 저장할 p 상품 정보가 담긴 DTO 객체
	 * @return Redirect할 Url
	 */
	@PostMapping("/event/write")
	public String write(Event e) {
		int num = service.getNum(); // 시퀀스 넘버 가져오기
		e.setNum(num);
		saveEventImg(num, e.getFile());
		service.addEvent(e);
		return "redirect:/admin/admin";
	}

	/**
	 * basePath + num 에 새로운 파일을 추가하는 메소드입니다.
	 * 이때, 해당 디렉토리의 다른 파일은 쓸모가 없으니 새로운 파일을 추가하기 전에 일괄삭제합니다.
	 * @param num 이벤트 번호
	 * @param file 이미지 파일
	 */
	public void saveEventImg(int num, MultipartFile file) { // 이미지 저장하기
		String fileName = file.getOriginalFilename();
		if (fileName != null && !fileName.equals("")) {
			File dir = new File(basePath + num);
			if (!dir.exists()) {
				dir.mkdirs();
			} else {
				String[] files = dir.list();
				int f_length = files.length;
				for (int j = 0; j < f_length; j++) {
					File del = new File(basePath + num + "\\" + files[j]);
					del.delete();
				}
			}

			File f = new File(basePath + num + "\\" + fileName);
			try {
				file.transferTo(f);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 이벤트 이미지를 가져오는 기능
	 * @param fname 파일 이름
	 * @param num 해당 이벤트 num
	 * @return Redirect할 Url
	 */
	@RequestMapping("/event/img")
	public ResponseEntity<byte[]> getEventImg(String fname, int num) {
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

	/**
	 * 
	 * @param num
	 * @param file
	 * @param req
	 * @return Redirect할 Url, 받아온 이벤트
	 */
	@GetMapping("/event/edit")
	public ModelAndView detail(@RequestParam("num") int num, @RequestParam("file") String file,
			HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		ModelAndView mav = new ModelAndView("event/editForm");
		
		// AdminController의 sessionCheck와 동일
		String id = "";
		if (session == null) {
			mav.setViewName("admin/adminLoginForm");
		} else {
			id = (String) session.getAttribute("id");
		}
		if (id.isBlank()) {
			mav.setViewName("admin/adminLoginForm");
		}
		// AdminController의 sessionCheck와 동일
		
		Event e = service.getEventByNum(num);

		e.setImgPath(file);
		mav.addObject("e", e);
		return mav;

	}

	/**
	 * 이벤트 정보 수정.
	 * 이벤트 상세 페이지에서 실행
	 * @param e 수정할 이벤트 정보가 담긴 DTO
	 * @return Redirect할 Url
	 */
	@PostMapping("/event/edit")
	public String eventUpdate(Event e) {
		saveEventImg(e.getNum(), e.getFile());
		service.editEvent(e);
		return "redirect:/admin/admin";
	}

	/**
	 * 이벤트 삭제
	 * @param num 해당 이벤트 num
	 * @return Redirect할 Url
	 */
	@RequestMapping("/event/del")
	public String eventDelete(@RequestParam("num") int num, Event e) {
		service.deleteEvent(num);
		return "redirect:/admin/admin";
	}
	
	/**
	 * 이벤트 리스트 가져오기(/event/getEvent.jsp)에 JSON용으로 전송
	 * @return Redirect할 Url, 받아온 리스트
	 */
	@RequestMapping("/event/getEvent")
	public ModelAndView getEvent() {
		System.out.println("EventController.getEvent()");
		ModelAndView mav = new ModelAndView("event/getEvent");
		ArrayList<Event> list = service.getEventList();
		mav.addObject("list", list);
		return mav;
	}
	
	// 추후 이벤트 베너 클릭시 이벤트 상품 목록이 뜨는 기능이 구현된다면 그때 로그 박기.

}
