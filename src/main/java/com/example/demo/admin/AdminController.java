
package com.example.demo.admin;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
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
 * 1차 수정 : 2021-03-02 : 세션이 null일 때의 처리 및 주석에 대한 변경 
 * 2차 수정 : 2021-03-03 : 주석에 대한 변경(주석이 너무 길어 적당히 축소할 예정)
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
	 * 기본 url에 /admin 추가시 관리자 로그인 페이지로 이동하도록 url을 자동 리턴하는 메소드입니다.
	 * @return Redirect할 Url
	 */
	@RequestMapping("/admin")
	public String admin_root() {
		return "redirect:/admin/loginForm";
	}

	/**
	 * 관리자 로그인 페이지(/admin/adminLoginForm.jsp)로 이동하기 위한 메소드입니다.
	 * @return Redirect할 Url
	 */
	@RequestMapping("/admin/loginForm")
	public String admin_loginForm() {
		return "admin/adminLoginForm";
	}

	/**
	 * session의 유무를 체크하여, 세션이 없다면 adminLoginForm으로 이동하고, 있다면 admin/admin으로 이동시키는 메소드.
	 * 관리자 기본 페이지(/admin/admin.jsp)는 총 4개의 jsp를 c:import하고 있다.
	 * (admin/eventList.jsp, admin/orderList.jsp, admin/productList.jsp, admin/qnaList.jsp)
	 * @param req 세션을 받아오기 위한 HttpServletRequest 객체.
	 * @return Redirect할 Url
	 */
	@RequestMapping("/admin/admin")
	public String admin(HttpServletRequest req) {
		// 기존에 존재하는 HttpSession을 받아온다. 없다면 null을 받아온다. 
		HttpSession session = req.getSession(false);
		// 세션이 null 이라면
		if(session==null || session.getAttribute("id")==null){
			return "redirect:/admin/adminLoginForm"; // 관리자 로그인 페이지로 이동한다.
		} else {
			return "admin/admin"; // 관리자 기본 페이지로 이동.
		}
	}

	/**
	 * 관리자 로그인 페이지에서 id와 password가 submit되었을시 실행.
	 * id와 password가 DB의 id, password 값과 동일하다면 로그인이 성공되어 관리자 페이지로 이동한다.
	 * @param ad 관리자 DB에서 가져온 id, password값을 저장한 객체
	 * @param req 세션을 받아오기 위한 HttpServletRequest 객체.
	 * @return Redirect할 Url
	 */
	@RequestMapping("/admin/login")
	public String login(Admin ad, HttpServletRequest req) {
		// 관리자 로그인 페이지에서 입력한 id로 DB에 해당 값이 있는지 확인한다. 
		// select * from 관리자DB where id = ?
		Admin admin = adminService.getAdmin(ad.getId());
		// 만약 받아온 admin이 존재하지 않거나. 패스워드가 일치하지 않는다면 
		if (admin == null || !admin.getPassword().equals(ad.getPassword())) {
			return "redirect:/admin/loginForm"; // 관리자 로그인 페이지로 이동한다.
		} else { // 로그인 성공시
			HttpSession session = req.getSession(); // 새로운 세션을 생성하고
			session.setAttribute("id", admin.getId()); // 만들어진 세션에 id를 setting한다.
			return "redirect:/admin/admin"; // 이후 관리자 기본 페이지로 이동한다.
		}
	}

	/**
	 * 전체 고객의 주문목록을 확인.
	 * 해당 페이지(/admin/orderList.jsp)에서 아래 기능들을 제공.
	 * {@link #changeState(int, int)}, @see {@link com.example.demo.product.ProductController#getImg(String, int)}
	 * @param req 세션을 받아오기 위한 HttpServletRequest 객체.
	 * @return Redirect할 Url, 가져온 리스트
	 */
	@RequestMapping("/admin/orderList")
	public ModelAndView orderList(HttpServletRequest req) {
		// 이동할 경로를 담은 ModelAndView 객체를 생성한다.
		ModelAndView mav = new ModelAndView("admin/orderList");
		// 기존에 존재하는 HttpSession을 받아온다. 없다면 null을 받아온다. 
		HttpSession session = req.getSession(false);
		
		// 세션이 존재하지 않는다면
		if(session==null || session.getAttribute("id")==null){
			System.out.println("AdminController.orderList()");
			mav.setViewName("redirect:/admin/loginForm"); // 관리자 로그인 페이지로 가도록 설정하고.
			return mav; // 관리자 로그인 페이지로 이동시킨다.
		} 
		
		// 모든 주문내역이 담긴 ArrayList을 생성한다.
		// select * from 주문내역DB order by num;
		ArrayList<Order> list = orderService.getAllOrderList();
		// 최적화용
		int size = list.size();
		// ArrayList의 크기만큼 for문을 돌린다.
		for (int i = 0; i < size; i++) {
			// list에 담긴 상품번호를 이용해 상품 이미지 경로를 설정한다.
			String path = basePath + "p" + list.get(i).getP_num() + "\\";
			// 상품 이미지 경로에 대하여 참조하는 객체를 생성한다. 
			File imgDir = new File(path);
			// 이후 디렉토리의 리스트를 받고, 이를 String 배열로 받아온다.   
			String[] files = imgDir.list();
			// 해당 경로의 디렉토리가 존재한다면
			if (imgDir.exists()) {
				// 최적화용.
				int f_length = files.length;
				// TODO 현재 file을 3개로 고정으로 받고 있어 사용하고 있으나 Product Detail의 디자인이 변경되면서 제거되거나 수정될 메소드입니다. 
				for (int j = 0; j < f_length; j++) {
					mav.addObject("file" + j, files[j]);
				}
				// 리스트 길이가 0이 아니라면
				if (size != 0) {
					// i번째 리스트에 상품 이미지 경로를 set해준다.
					list.get(i).setImgPath(files[0]);
				}
			}
		}
		// 이후 ModelAndView 객체에 list를 담고
		mav.addObject("list", list);
		// 이를 리턴한다.
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
	 * @param req 세션을 받아오기 위한 HttpServletRequest 객체.
	 * @return Redirect할 Url, 가져온 리스트
	 */
	@SuppressWarnings("unchecked") // 형 변환 에러 거슬려서 지움.
	@RequestMapping("/admin/productList")
	public ModelAndView productList(HttpServletRequest req) {
		
		ModelAndView mav = new ModelAndView("admin/productList");
		// 기존에 존재하는 HttpSession을 받아온다. 없다면 null을 받아온다. 
		HttpSession session = req.getSession(false);
		// 세션이 존재하지 않는다면
		if(session==null || session.getAttribute("id")==null){
			mav.setViewName("redirect:/admin/loginForm"); // 관리자 로그인 페이지로 가도록 설정하고.
			return mav; // 관리자 로그인 페이지로 이동시킨다.
		} 
		
		/*
		 * 모든 상품의 목록을 담은 ArrayList를 생성한다.
		 * select * from 상품DB;
		 */
		ArrayList<Product> list = (ArrayList<Product>) productService.getProductAll();
		int size = list.size(); // 최적화용
		// 모든 상품 목록의 갯수만큼 for문을 돌려서
		for (int i = 0; i < size; i++) {
			// list에 담긴 상품번호를 이용해 상품 이미지 경로를 설정한다.
			String path = basePath + "p" + list.get(i).getNum() + "\\";
			// 상품 이미지 경로에 대하여 참조하는 객체를 생성한다. 
			File imgDir = new File(path);
			// 이후 디렉토리의 리스트를 받고, 이를 String 배열로 받아온다.   
			String[] files = imgDir.list();
			// 해당 경로의 디렉토리가 존재한다면
			if (imgDir.exists()) {
				// 최적화용
				int f_length = files.length;
				// TODO 현재 file을 3개로 고정으로 받고 있어 사용하고 있으나 Product Detail의 디자인이 변경되면서 제거되거나 수정될 메소드입니다. 
				for (int j = 0; j < f_length; j++) {
					mav.addObject("file" + j, files[j]);
				}
				// 리스트 길이가 0이 아니라면
				if (f_length != 0) {
					// i번째 리스트에 상품 이미지 경로를 set해준다.
					list.get(i).setImgPath(files[0]);
				}
			}
		}
		// 이후 ModelAndView 객체에 list를 담고
		mav.addObject("list", list);
		// 이를 리턴한다.
		return mav;
	}

	/**
	 * 전체 문의목록을 확인
	 * 해당 페이지(/admin/qnaList.jsp)에서 아래 기능들을 제공.
	 * {@link #qnaDetail(int, HttpServletRequest)}
	 * @param req 세션을 받아오기 위한 HttpServletRequest 객체.
	 * @return Redirect할 Url, 가져온 리스트
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/admin/qnaList")
	public ModelAndView qnaList(HttpServletRequest req) {
		// 이동할 경로를 담은 ModelAndView 객체를 생성한다.
		ModelAndView mav = new ModelAndView("admin/qnaList");
		// 기존에 존재하는 HttpSession을 받아온다. 없다면 null을 받아온다. 
		HttpSession session = req.getSession(false);
		// 세션이 존재하지 않는다면
		if(session==null){
			mav.setViewName("redirect:/admin/loginForm"); // 관리자 로그인 페이지로 가도록 설정하고.
			return mav; // 관리자 로그인 페이지로 이동시킨다.
		} 
		// 모든 문의내역이 담긴 ArrayList을 생성한다.
		ArrayList<Qna> list = (ArrayList<Qna>) qnaService.getAllQna();
		// 이후 ModelAndView 객체에 list를 담고
		mav.addObject("list", list);
		// 이를 리턴한다.
		return mav;
	}

	/**
	 * 세션이 있다면 관리자 상품 추가 페이지(/admin/writeForm)로 이동, 없으면 관리자 로그인 페이지로 이동하는 메소드입니다.
	 * @param req 세션을 받아오기 위한 HttpServletRequest 객체.
	 * @return Redirect할 Url
	 */
	@GetMapping("/admin/write")
	public String writeForm(HttpServletRequest req) {
		// 기존에 존재하는 HttpSession을 받아온다. 없다면 null을 받아온다. 
		HttpSession session = req.getSession(false);
		// 세션이 존재하지 않는다면
		if (session == null) {
			return "admin/loginForm"; // 관리자 로그인 페이지로 
		} else {
			return "admin/writeForm"; // 관리자 상품 추가 페이지로.
		}
	}

	/**
	 * 상품 추가 페이지에서 product에 관련된 내용들이 submit되었을시 실행되는 메소드입니다.
	 * 상품 이미지를 분류자와 상품번호(ex. num이 1일시 basePath/p1/)에 저장
	 * 이후 입력된 내용을 DB에 저장.
	 * @param 저장할 p 상품 정보가 담긴 DTO 객체
	 * @return Redirect할 Url
	 */
	@PostMapping("/admin/write")
	public String write(Product p) {
		int num = productService.getNum(); // 시퀀스 번호 가져오기.
		p.setNum(num); // 해당 시퀀스 번호를 num에 세팅함.
		// TODO 상품 상세 디자인 변경시 수정될 메소드.
		saveProductImg(num, p.getFile1()); 
		saveProductImg(num, p.getFile2());
		saveProductImg(num, p.getFile3());
		// DB에 해당 상품에 대한 정보를 저장한다.
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
		// 파일 이름
		String fileName = file.getOriginalFilename();
		// 파일 이름이 비지 않았거나 공백이 아니라면
		if (fileName != null && !fileName.equals("")) {
			// 이미지 경로에 대하여 참조하는 객체를 생성한다.
			File dir = new File(basePath + "p" + num);
			// 해당 경로에 디렉토리가 존재하지 않는다면
			if (!dir.exists()) {
				dir.mkdirs(); // 새로 만들어준다.
			}
			// 디렉토리가 존재한다면
			// P.S. 파일을 여러 개 집어넣고 싶을 경우에는, 아래의 else 부분 메소드를 수정하거나 주석 처리할 것. 
			else {
				// 디렉토리의 리스트를 받고, 이를 String 배열로 받아온다. 
				String[] files = dir.list();
				// 최적화용
				int f_length = files.length;
				for (int j = 0; j < f_length; j++) {
					// 해당 경로에 파일이 있으면
					File del = new File(basePath + "p" + num + "\\" + files[j]);
					// 삭제한다.
					del.delete();
				}
			}
			// 이미지 경로에 대하여 참조하는 객체를 생성한다.
			File f = new File(basePath + "p" + num + "\\" + fileName);
			try {
				// 해당 경로에 파일을 저장한다.
				file.transferTo(f);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 세션이 있다면 공지사항 작성 페이지(/admin/writeBoard.jsp)로 이동, 아니라면 관리자 로그인 페이지로 이동하는 메소드
	 * @param req 세션을 받아오기 위한 HttpServletRequest 객체.
	 * @return Redirect할 Url
	 */
	@GetMapping("/admin/writeBoard")
	public String writeBoardForm(HttpServletRequest req) {
		// 기존에 존재하는 HttpSession을 받아온다. 없다면 null을 받아온다. 
		HttpSession session = req.getSession(false);
		// 세션이 존재하지 않는다면
		if (session == null) {
			return "redirect:/admin/loginForm"; // 관리자 로그인 페이지로 
		} else {
			return "admin/writeBoard"; // 공지사항 작성 페이지로 
		}
	}

	/**
	 * 공지사항 작성 페이지에서 게시판 정보가 submit되었을시 실행되는 메소드로 게시판 추가하는데 사용된다.
	 * @param b 게시판 정보가 담긴 DTO
	 * @return Redirect할 Url
	 */
	@PostMapping("/admin/writeBoard")
	public String write(Board b) {
		// INSERT INTO 게시판DB VALUES(?)
		boardService.addBoard(b);
		return "redirect:/board/faq/list";
	}

	/**
	 * 관리자 상품 상세 페이지(/admin/detail)로 이동.
	 * @param num 해당 상품의 상품번호
	 * @param req 세션을 받아오기 위한 HttpServletRequest 객체.
	 * @return Redirect할 Url, 가져온 상품
	 */
	@RequestMapping("/admin/detail")
	public ModelAndView productDetail(@RequestParam("num") int num, HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("admin/detail");
		// 기존에 존재하는 HttpSession을 받아온다. 없다면 null을 받아온다. 
		HttpSession session = req.getSession(false);
		// 세션이 존재하지 않는다면
		if(session==null){
			mav.setViewName("redirect:/admin/adminLoginForm"); // 관리자 로그인 페이지로 가도록 설정하고.
			return mav; // 관리자 로그인 페이지로 이동시킨다.
		} 
		// num을 이용하여 해당 상품의 정보를 불러온다.
		Product p = productService.getProductByNum(num);

		// p에 담긴 상품번호를 이용해 상품 이미지 경로를 설정한다.
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
		// 이후 ModelAndView 객체에 p를 담고
		mav.addObject("p", p);
		// 이를 리턴한다.
		return mav;
	}

	/**
	 * 상품 정보 수정.
	 * 관리자 상품 상세 페이지에서 실행
	 * @param p 수정할 상품 정보가 담긴 DTO
	 * @return Redirect할 Url
	 */
	@PostMapping("/admin/edit")
	public String editProduct(Product p) {
		// UPDATE 상품DB SET ?=? WHERE 상품번호=p.get 
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
		ModelAndView mav = new ModelAndView("admin/qnaDetail");
		// 기존에 존재하는 HttpSession을 받아온다. 없다면 null을 받아온다. 
		HttpSession session = req.getSession(false);
		// 세션이 존재하지 않는다면
		if(session==null){
			mav.setViewName("redirect:/admin/loginForm"); // 관리자 로그인 페이지로 가도록 설정하고.
			return mav; // 관리자 로그인 페이지로 이동시킨다.
		}
		
		// 해당 1:1문의 받아오기. 
		Qna q = qnaService.getQnaByNum(num);

		// q에 담긴 num을 이용해 1:1문의 이미지 경로를 생성한다.
		String path = basePath + "q" + q.getNum() + "\\";
		
		// 상품 이미지 경로에 대하여 참조하는 객체를 생성한다. 
		File imgDir = new File(path);
		// 만약 해당 경로에 디렉토리가 존재한다면
		if (imgDir.exists()) {
			// 디렉토리의 리스트를 받고, 이를 String 배열로 받아온다. 
			String[] files = imgDir.list();
			// 최적화용
			int f_length = files.length;
			// TODO 현재 file을 3개로 고정으로 받고 있어 사용하고 있으나 Product Detail의 디자인이 변경되면서 제거되거나 수정될 메소드입니다. 
			for (int j = 0; j < f_length; j++) {
				mav.addObject("file" + j, files[j]);
			}
			// 리스트 길이가 0이 아니라면
			if (f_length != 0) {
				// q에 이미지 경로를 set해준다.
				q.setPath(files[0]);
			}
		}
		// 이후 ModelAndView 객체에 q를 담고
		mav.addObject("q", q);
		// 이를 리턴한다.
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
		// 기존에 존재하는 HttpSession을 받아온다. 없다면 null을 받아온다. 
		HttpSession session = req.getSession(false);
		// 세션이 존재하지 않는다면
		if(session==null || session.getAttribute("id")==null){
			mav.setViewName("redirect:/admin/loginForm"); // 관리자 로그인 페이지로 가도록 설정하고.
			return mav; // 관리자 로그인 페이지로 이동시킨다.
		} 
		/*
		 * 모든 이벤트의 목록을 담은 ArrayList를 생성한다.
		 * select * from 이벤트DB; 
		 */
		ArrayList<Event> list = eventService.getEventList();
		// 최적화용
		int size = list.size();
		// 모든 이벤트 목록의 갯수만큼 for문을 돌려서
		for (int i = 0; i < size; i++) {
			//  list에 담긴 이벤트번호를 이용해 상품 이미지 경로를 설정한다.
			String path = basePath + "e" + list.get(i).getNum() + "\\";

			// 이벤트 이미지 경로에 대하여 참조하는 객체를 생성한다. 
			File imgDir = new File(path);

			// 이후 디렉토리의 리스트를 받고, 이를 String 배열로 받아온다. 
			String[] files = imgDir.list();
			
			// 해당 경로에 디렉토리가 존재한다면
			if (imgDir.exists()) {
				// 최적화용
				int f_length = files.length;
				// TODO 현재 file을 3개로 고정으로 받고 있어 사용하고 있으나 Product Detail의 디자인이 변경되면서 제거되거나 수정될 메소드입니다. 
				for (int j = 0; j < f_length; j++) {
					mav.addObject("file" + j, files[j]);
				}
				// 리스트 길이가 0이 아니라면
				if (f_length != 0) {
					// i번째 리스트에 상품 이미지 경로를 set해준다.
					list.get(i).setImgPath(files[0]);
				}
			}
		}
		// 이후 ModelAndView 객체에 list를 담고
		mav.addObject("list", list);
		// 이를 리턴한다.
		return mav;
	}

	
	/**
	 * 상품 삭제
	 * 관리자 상품 상세 페이지에서 실행
	 * @param num 삭제할 상품 num
	 * @return Redirect할 Url
	 */
	@PostMapping("/admin/delProduct")
	public String del(@RequestParam(value = "num") int num) {
		// delete from 상품DB where num=@RequestParam(value = "num") num
		productService.delProduct(num);
		// 관리자 기본 페이지로
		return "redirect:/admin/admin";
	}
}


