
package com.example.demo.admin;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.example.demo.board.Board;
import com.example.demo.board.BoardService;
import com.example.demo.event.Event;
import com.example.demo.event.EventService;
import com.example.demo.order.Order;
import com.example.demo.order.OrderService;
import com.example.demo.product.Product;
import com.example.demo.product.ProductService;
import com.example.demo.qna.Qna;
import com.example.demo.qna.QnaService;

/**
 * Admin Page에서 사용가능한 기능들을 구현한 Controller 클래스입니다.
 * 1차 수정 : 2021-03-02 
 * @author 김평기
 * @version main 1
 */
@Controller
public class AdminController {

	/**
	 * 이미지가 저장될 기본 경로
	 */
	public static String basePath = "C:\\shopimg\\";

	@Autowired
	private AdminService adminService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private ProductService productService;

	@Autowired
	private BoardService boardService;

	@Autowired
	private QnaService qnaService;

	@Autowired
	private EventService eventService;

	/**
	 * 기본 url에 /admin 추가시 관리자 로그인 페이지로 이동하도록 url을 자동 리턴
	 * @return Redirect할 Url
	 */
	@RequestMapping("/admin")
	public String admin_root() {
		return "redirect:/admin/loginForm";
	}

	/**
	 * 관리자 로그인 페이지(/admin/adminLoginForm.jsp)로 이동
	 * @return Redirect할 Url
	 */
	@RequestMapping("/admin/loginForm")
	public String admin_loginForm() {
		return "admin/adminLoginForm";
	}

	/**
	 * 목표한 기능이 세션이 존재한 상태에서 get입력 등으로 불러와지거나 종료되면 관리자 기본 체이지(/admin/admin.jsp)로 이동.
	 * 없다면 관리자 로그인 페이지로 돌아간다.
	 * 관리자 기본 페이지는 총 4개의 jsp를 c:import하고 있다.
	 * (admin/eventList.jsp, admin/orderList.jsp, admin/productList.jsp, admin/qnaList.jsp)
	 * @param req 세션
	 * @return Redirect할 Url
	 */
	@RequestMapping("/admin/admin")
	public ModelAndView admin(HttpServletRequest req) {
		// sessionCheck 메소드를 수정하여 아래가 1줄로 끝나게 리팩토링
		ModelAndView mav = new ModelAndView("admin/admin");
		String id = "";
		HttpSession session = req.getSession(false);
		sessionCheck(mav, id, session); // 세션 체크용
		return mav;
	}

	/**
	 * 관리자 로그인 페이지에서 id와 password가 submit되었을시 실행.
	 * id와 password가 DB의 id, password 값과 동일하다면 로그인이 성공되어 관리자 페이지로 이동한다.
	 * @param ad 관리자 DB에서 가져온 id, password값을 저장한 객체
	 * @param req 세션
	 * @return Redirect할 Url
	 */
	@RequestMapping("/admin/login")
	public String login(Admin ad, HttpServletRequest req) {
		// 세부 주석을 많이 달아야.
		Admin admin = adminService.getAdmin(ad.getId());
		if (admin == null || !admin.getPassword().equals(ad.getPassword())) {
			return "redirect:/admin/loginForm";
		} else { // 로그인 성공시
			HttpSession session = req.getSession();
			session.setAttribute("id", admin.getId());
			return "redirect:/admin/admin";
		}
	}

	/**
	 * 전체 고객의 주문목록을 확인.
	 * 해당 페이지(/admin/orderList.jsp)에서 아래 기능들을 제공.
	 * {@link #changeState(int, int)}, @see {@link com.example.demo.product.ProductController#getImg(String, int)}
	 * @param req 세션
	 * @return Redirect할 Url, 가져온 리스트
	 */
	@RequestMapping("/admin/orderList")
	public ModelAndView orderList(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("admin/orderList");
		String id = "";
		HttpSession session = req.getSession(false);
		sessionCheck(mav, id, session);
		
		ArrayList<Order> list = orderService.getAllOrderList();
		// 리스트 갯수만큼 반복
		int size = list.size();
		for (int i = 0; i < size; i++) {
			// path에 basePath에 담긴 이미지와 list에 담긴 번호를 저장
			String path = basePath + "p" + list.get(i).getP_num() + "\\";
			// imDir에 path를 저장
			File imgDir = new File(path);
			// files에 imgDir을 저장
			String[] files = imgDir.list();
			// mav에 files에 저장된 값을 저장한다
			int f_length = files.length;
			if (imgDir.exists()) {
				for (int j = 0; j < f_length; j++) {
					mav.addObject("file" + j, files[j]);
				}
				if (size != 0) {
					list.get(i).setImgPath(files[0]);
				}
			}
		}
		mav.addObject("list", list);
		return mav;
	}

	/**
	 * 주문목록 페이지(/admin/orderList.jsp)에서 넘어오며 주문상태 변경 이후 jQuery로 관리자 기본 페이지를 리다이렉트함.
	 * @param num 해당 주문의 고유 num [PK]
	 * @param state 주문상태(배송준비, 배송중, 도착)에 대한 정보를 담은 매개변수
	 */
	@RequestMapping("admin/changeState")
	public void changeState(@RequestParam("num") int num, @RequestParam("state") int state) {
		orderService.changeState(num, state);
	}

	/**
	 * 전체 상품 목록을 확인
	 * 해당 페이지(/admin/productList.jsp)에서 아래 기능들을 제공.
	 * {@link #write(Product)}, {@link #detail(int, HttpServletRequest)} @see {@link com.example.demo.product.ProductController#getImg(fname, p_id)}
	 * @param req 세션
	 * @return Redirect할 Url, 가져온 리스트
	 */
	@SuppressWarnings("unchecked") // 형 변환 에러 거슬려서 지움.
	@RequestMapping("/admin/productList")
	public ModelAndView productList(HttpServletRequest req) {
		String id = "";
		HttpSession session = req.getSession(false);
		ModelAndView mav = new ModelAndView("admin/productList");

		sessionCheck(mav, id, session);
		
		ArrayList<Product> list = (ArrayList<Product>) productService.getProductAll();
		int size = list.size(); // 최적화 용으로 빼놓음.
		for (int i = 0; i < size; i++) {
			String path = basePath + "p" + list.get(i).getNum() + "\\";
			File imgDir = new File(path);

			String[] files = imgDir.list();
			int f_length = files.length;
			if (imgDir.exists()) {
				for (int j = 0; j < f_length; j++) {
					mav.addObject("file" + j, files[j]);
				}
				if (f_length != 0) {
					list.get(i).setImgPath(files[0]);
				}
			}
		}
		mav.addObject("list", list);
		return mav;
	}

	/**
	 * 전체 문의목록을 확인
	 * 해당 페이지(/admin/qnaList.jsp)에서 아래 기능들을 제공.
	 * {@link #qnaDetail(int, HttpServletRequest)}
	 * @param req 세션
	 * @return Redirect할 Url, 가져온 리스트
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/admin/qnaList")
	public ModelAndView qnaList(HttpServletRequest req) {
		String id = "";
		HttpSession session = req.getSession(false);
		ModelAndView mav = new ModelAndView("admin/qnaList");
		sessionCheck(mav, id, session);
		ArrayList<Qna> list = (ArrayList<Qna>) qnaService.getAllQna();
		mav.addObject("list", list);
		return mav;
	}

	/**
	 * 세션이 있다면 관리자 상품 추가 페이지(/admin/writeForm)로 이동, 없으면 관리자 로그인 페이지로
	 * @param req 세션
	 * @return Redirect할 Url
	 */
	@GetMapping("/admin/write")
	public String writeForm(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		if (session == null) {
			return "admin/loginForm";
		} else {
			return "admin/writeForm";
		}
	}

	/**
	 * 상품 추가 페이지에서 product에 관련된 내용들이 submit되었을시 실행.
	 * 상품 이미지를 분류자와 상품번호(ex. num이 1일시 basePath/p1/)에 저장
	 * 이후 입력된 내용을 DB에 저장.
	 * @param 저장할 p 상품 정보가 담긴 DTO 객체
	 * @return Redirect할 Url
	 */
	@PostMapping("/admin/write")
	public String write(Product p) {
		int num = productService.getNum(); // 시퀀스 번호 가져오기.
		p.setNum(num);
		saveProductImg(num, p.getFile1());
		saveProductImg(num, p.getFile2());
		saveProductImg(num, p.getFile3());
		productService.addProduct(p);
		return "redirect:/admin/admin";
	}

	/**
	 * 상품 이미지 저장
	 * 이때, 해당 디렉토리의 다른 파일은 쓸모가 없으니 새로운 파일을 추가하기 전에 일괄삭제합니다.
	 * @param num 상품 번호
	 * @param file 저장할 이미지 파일
	 */
	public void saveProductImg(int num, MultipartFile file) { // 이미지 저장하기
		String fileName = file.getOriginalFilename();
		if (fileName != null && !fileName.equals("")) {
			File dir = new File(basePath + "p" + num);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			// 파일을 여러 개 집어넣고 싶을 경우에는, 아래의 else 부분 메소드를 수정하거나 주석 처리할 것. 
			else {
				String[] files = dir.list();
				int f_length = files.length;
				for (int j = 0; j < f_length; j++) {
					File del = new File(basePath + "p" + num + "\\" + files[j]);
					del.delete();
				}
			}
			File f = new File(basePath + "p" + num + "\\" + fileName);
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
	 * 세션이 있다면 공지사항 작성 페이지(/admin/writeBoard.jsp)로 이동, 아니라면 관리자 로그인 페이지로 이동
	 * @param req 세션
	 * @return Redirect할 Url
	 */
	@GetMapping("/admin/writeBoard")
	public String writeBoardForm(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		if (session == null) {
			return "admin/loginForm";
		} else {
			return "admin/writeBoard";
		}
	}

	/**
	 * 공지사항 작성 페이지에서 게시판 정보가 submit되었을시 실행.
	 * @param b 게시판 정보가 담긴 DTO
	 * @return Redirect할 Url
	 */
	@PostMapping("/admin/writeBoard")
	public String write(Board b) {
		boardService.addBoard(b);
		return "redirect:/board/faq/list";
	}

	/**
	 * 관리자 상품 상세 페이지(/admin/detail)로 이동.
	 * @param num 해당 상품번호
	 * @param req 세션
	 * @return Redirect할 Url, 가져온 상품
	 */
	@RequestMapping("/admin/detail")
	public ModelAndView productDetail(@RequestParam("num") int num, HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		ModelAndView mav = new ModelAndView("admin/detail");
		String id = "";

		sessionCheck(mav, id, session);

		Product p = productService.getProductByNum(num);

		String path = basePath + "p" + p.getNum() + "\\";
		
		// TODO 상품 상세 페이지의 디자인 변경시 수정 예정
		File imgDir = new File(path);
		if (imgDir.exists()) {
			String[] files = imgDir.list();
			int f_length = files.length;
			for (int j = 0; j < f_length; j++) {
				mav.addObject("file" + j, files[j]);
			}
		}
		mav.addObject("p", p);
		return mav;
	}

	/**
	 * 상품 정보 수정.
	 * 관리자 상품 상세 페이지에서 실행
	 * @param p 수정할 상품 정보가 담긴 DTO
	 * @return Redirect할 Url
	 */
	@RequestMapping("/admin/edit")
	public String editProduct(Product p) {
		productService.editProduct(p);
		return "redirect:/admin/admin";
	}

	/**
	 * 관리자 공지사항 상세 페이지(/admin/qnaDetail.jsp)로 이동
	 * @param num 글 번호
	 * @param req 세션
	 * @return Redirect할 Url, 받아온 게시판 정보
	 */
	@RequestMapping("/admin/qnaDetail")
	public ModelAndView qnaDetail(@RequestParam("num") int num, HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		ModelAndView mav = new ModelAndView("admin/qnaDetail");
		String id = "";
		
		sessionCheck(mav, id, session);

		Qna q = qnaService.getQnaByNum(num);
		System.out.println(q.toString());

		String path = basePath + "q" + q.getNum() + "\\";
		File imgDir = new File(path);
		if (imgDir.exists()) {
			String[] files = imgDir.list();
			int f_length = files.length;
			for (int j = 0; j < f_length; j++) {
				mav.addObject("file" + j, files[j]);
			}
			if (f_length != 0) {
				q.setPath(files[0]);
			}
		}
		mav.addObject("q", q);
		return mav;
	}

	/**
	 * 전체 이벤트 목록을 확인
	 * 해당 페이지(/admin/eventList.jsp)에서 아래 기능들을 제공.
	 * @see {@link com.example.demo.event.EventController#write(Event)}, @see {@link com.example.demo.event.EventController#getEventImg(String, int)}, @see {@link com.example.demo.event.EventController#eventUpdate(Event)}, 
	 * @param req 세션
	 * @return Redirect할 Url, 받아온 리스트
	 */
	@RequestMapping("/admin/eventList")
	public ModelAndView eventList(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("admin/eventList");
		String id = "";
		HttpSession session = req.getSession(false);
		sessionCheck(mav, id, session);

		ArrayList<Event> list = eventService.getEventList();
		// 리스트 갯수만큼 반복
		int size = list.size();
		for (int i = 0; i < size; i++) {

			// path에 basePath에 담긴 이미지와 list에 담긴 번호를 저장
			String path = basePath + "e" + list.get(i).getNum() + "\\";

			// imDir에 path를 저장
			File imgDir = new File(path);

			String[] files = imgDir.list();
			// mav에 files에 저장된 값을 저장한다
			if (imgDir.exists()) {
				int f_length = files.length;
				for (int j = 0; j < f_length; j++) {
					mav.addObject("file" + j, files[j]);
				}
				if (f_length != 0) {
					list.get(i).setImgPath(files[0]);
				}
			}
		}
		mav.addObject("list", list);
		return mav;
	}


//	@RequestMapping("/admin/delProduct")
//	public String del(@RequestParam(value = "num") int num) {
//		productService.delProduct(num);
//		String path = basePath + "p" + num + "\\";
//		File imgDir = new File(path);
//		if (imgDir.exists()) {
//			String[] files = imgDir.list();
//			int f_length = files.length;
//			for (int j = 0; j < f_length; j++) {
//				File f = new File(path + files[j]);
//				f.delete();
//			}
//		}
//		imgDir.delete();
//		return "redirect:/admin/admin";
//	}

	/**
	 * 세션 여부 확인, 세션이 없으면 ModelAndView가 관리자 로그인 페이지로 가게 함.
	 * @param mav 해당 ModelAndView가 Redirect할 Url
	 * @param id 해당 메소드의 id에 세션 id를 할당.
	 * @param session 세션
	 */
	private void sessionCheck(ModelAndView mav, String id, HttpSession session) {
		if (session == null) {
			System.out.println("session null");
			mav.setViewName("redirect:/admin/adminLoginForm");
		} else {
			id = (String) session.getAttribute("id");
		}
		if (id.isBlank()) {
			mav.setViewName("redirect:/admin/adminLoginForm");
		}

	}
	
	
	/**
	 * 상품 삭제
	 * 관리자 상품 상세 페이지에서 실행
	 * @param num 삭제할 상품 num
	 * @return Redirect할 Url
	 */
		@RequestMapping("/admin/delProduct")
		public String del(@RequestParam(value = "num") int num) {
			productService.delProduct(num);
			return "admin/admin";
		}

	}
	
	
	/*
	 * public String del(int num) { System.out.println("AdminController.del()");
	 * productService.delProduct(num);
	 * 
	 * return "admin/admin";
	 */


