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

@Controller
public class EventController {

	@Autowired
	private EventService service;

	public static String basePath = "C:\\shopimg\\e";

	@RequestMapping("/event/list")
	public ModelAndView List() {
		// list에 service.getProductAll()을 담는다
		ArrayList<Event> list = (ArrayList<Event>) service.getEventList();

		// mav에 product/list를 담는다
		ModelAndView mav = new ModelAndView("event/eventList");

		// 리스트 갯수만큼 반복
		for (int i = 0; i < list.size(); i++) {

			// path에 basePath에 담긴 이미지와 list에 담긴 번호를 저장
			String path = basePath + list.get(i).getNum() + "\\";

			// imDir에 path를 저장
			File imgDir = new File(path);

			// files에 imgDir을 저장
			String[] files = imgDir.list();
			// mav에 files에 저장된 값을 저장한다
			if (imgDir.exists()) {
				for (int j = 0; j < files.length; j++) {
					mav.addObject("file" + j, files[j]);
				}

				list.get(i).setImgPath(files[0]);
				System.out.println(list.get(i).toString());
			}
		}

		ArrayList<Integer> lengths = new ArrayList<Integer>();
		for (int i = 0; i < list.size(); i++) {
			lengths.add(i);
		}

		// mav에 list를 담는다
		mav.addObject("list", list);
		mav.addObject("lengths", lengths);
		System.out.println("lengths : " + lengths.toString() + ", " + lengths.size());
		return mav;
	}

	@GetMapping("/event/write")
	public String writeForm(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		if (session == null) {
			return "/admin/loginForm";
		} else {
			return "/event/writeForm";
		}

	}

	@PostMapping("/event/write")
	public String write(Event e) {
		int num = service.getNum();
		e.setNum(num);
		saveEventImg(num, e.getFile());
		service.addEvent(e);
		return "redirect:/admin/admin";
	}

	public void saveEventImg(int num, MultipartFile file) { // 이미지 저장하기
		String fileName = file.getOriginalFilename();
		if (fileName != null && !fileName.equals("")) {
			File dir = new File(basePath + num);
			if (!dir.exists()) {
				dir.mkdirs();
			} else {
				String[] files = dir.list();
				for (int j = 0; j < files.length; j++) {
					File del = new File(basePath + num + "\\" + files[j]);
					System.out.println("TARGET : " + files[j].toString());
					del.delete();
				}
			}

			File f = new File(basePath + num + "\\" + fileName);
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

	@GetMapping("/event/edit")
	public ModelAndView detail(@RequestParam("num") int num, @RequestParam("file") String file,
			HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		ModelAndView mav = new ModelAndView("event/editForm");

		if (session == null) {
			mav.setViewName("admin/adminLoginForm");
		}

		Event e = service.getEventByNum(num);

		e.setImgPath(file);
		mav.addObject("e", e);
		return mav;

	}

	@PostMapping("/event/edit")
	public String eventUpdate(Event e) {

		saveEventImg(e.getNum(), e.getFile());
		service.editEvent(e);
		System.out.println("TARGET : " + e.toString());
		return "redirect:/admin/admin";
	}

	@RequestMapping("/event/del")
	public String eventDelete(@RequestParam("num") int num, Event e) {
		service.deleteEvent(num);
		return "redirect:/admin/admin";
	}
	
	@RequestMapping("/event/getEvent")
	public ModelAndView getEvent() {
		System.out.println("EventController.getEvent()");
		ModelAndView mav = new ModelAndView("event/getEvent");
		ArrayList<Event> list = service.getEventList();
		System.out.println("TAG : " + list.size());
		mav.addObject("list", list);
		return mav;
	}

}
