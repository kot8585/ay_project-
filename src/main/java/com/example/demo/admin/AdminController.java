package com.example.demo.admin;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import com.example.demo.category.Category;
import com.example.demo.category.CategoryService;
import com.example.demo.event.Event;
import com.example.demo.event.EventService;
import com.example.demo.order.Order;
import com.example.demo.order.OrderService;
import com.example.demo.product.Product;
import com.example.demo.product.ProductService;
import com.example.demo.qna.Qna;
import com.example.demo.qna.QnaService;

@Controller
public class AdminController {
	
	// TODO 세션 id 없으면 쫓겨나게.
	
	private final Logger log = LoggerFactory.getLogger(this.getClass());
	
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
	
	
	@RequestMapping("/admin")
	public String admin_root() {
		return "redirect:/admin/loginForm";
	}
	
	@RequestMapping("/admin/loginForm")
	public String admin_loginForm() {
		return "admin/adminLoginForm";
	}
	

	@RequestMapping("/admin/admin")
	public ModelAndView admin(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("admin/admin");
		String id = "";
		HttpSession session = req.getSession(false);
		// TODO 공통 함수로 리팩토링 필요
		if (session == null) {
			System.out.println("session null");
			mav.setViewName("admin/adminLoginForm");
		} else {
			id = (String) session.getAttribute("id");
		}
		if (id.isBlank()) {
			mav.setViewName("admin/adminLoginForm");
		}
		return mav;
	}
	
	@RequestMapping("/admin/login")
	public String login(Admin ad, HttpServletRequest req) {
		Admin admin = adminService.getAdmin(ad.getId());
		if (admin == null || !admin.getPassword().equals(ad.getPassword())) {
			log.error("로그인 실패 : " + ad.toString());
			return "/admin/loginForm";
		} else { // 로그인 성공시
			HttpSession session = req.getSession();
			session.setAttribute("id", admin.getId());
			return "redirect:/admin/admin";
		}
	}
	
	@RequestMapping("/admin/orderList")
	public ModelAndView orderList(HttpServletRequest req, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("admin/orderList");
		String id = "";
		HttpSession session = req.getSession(false);
		
		if (session == null) {
			System.out.println("session null");
			mav.setViewName("admin/adminLoginForm");
		} else {
			id = (String) session.getAttribute("id");
		}
		
		if (id.isBlank()) {
			mav.setViewName("admin/adminLoginForm");
		}
		System.out.println("id = " + id +", mav = " + mav.getViewName());
		
		ArrayList<Order> list = orderService.getAllOrderList();
		 //리스트 갯수만큼 반복
	      for (int i = 0; i < list.size(); i++) {
	    	  
	    	 //path에 basePath에 담긴 이미지와 list에 담긴 번호를 저장
	         String path = basePath + "p" + list.get(i).getP_num() + "\\";
	         
	         //imDir에 path를 저장
	         File imgDir = new File(path);   
	        
	         //files에 imgDir을 저장
	         String[] files = imgDir.list();
	         //mav에 files에 저장된 값을 저장한다
	         if(imgDir.exists()) {
	            for(int j = 0; j < files.length; j++) {
	               mav.addObject("file" + j, files[j]);
	            }
	            
	            list.get(i).setImgPath(files[0]);
	         }
	      }
		mav.addObject("list", list);
		return mav;
		
	}
	
	@RequestMapping("admin/changeState")
	public void changeState(@RequestParam("num") int num, @RequestParam("state") int state) {
		System.out.println(num + "," +state);
		orderService.changeState(num, state); 
	}
	
	@RequestMapping("/admin/productList")
	public ModelAndView productList(HttpServletRequest req) {
		String id = "";
		HttpSession session = req.getSession(false);
		ModelAndView mav = new ModelAndView("admin/productList");

		if (session == null) {
			System.out.println("session null");
			mav.setViewName("admin/adminLoginForm");
		} else {
			id = (String) session.getAttribute("id");
		}

		if (id.isBlank()) {
			mav.setViewName("admin/adminLoginForm");
		}
		
		ArrayList<Product> list = (ArrayList<Product>) productService.getProductAll();
		for (int i = 0; i < list.size(); i++) {
	         String path = basePath + "p" + list.get(i).getNum() + "\\";
	         File imgDir = new File(path);   
	        
	         String[] files = imgDir.list();
	         if(imgDir.exists()) {
	            for(int j = 0; j < files.length; j++) {
	               mav.addObject("file" + j, files[j]);
	            }
	            list.get(i).setImgPath(files[0]);
	         }
	      }
		mav.addObject("list", list);
		return mav;
	}



	//1:1문의 리스트
	@RequestMapping("/admin/qnaList")
	public ModelAndView qnaList(HttpServletRequest req) {
		String id = "";
		HttpSession session = req.getSession(false);
		ModelAndView mav = new ModelAndView("admin/qnaList");
		
		if (session == null) {
			System.out.println("session null");
			mav.setViewName("admin/adminLoginForm");
		} else {
			id = (String) session.getAttribute("id");
		}
		

		if (id.isBlank()) {
			mav.setViewName("admin/adminLoginForm");
		}
		
		ArrayList<Qna> list = (ArrayList<Qna>) qnaService.getAllQna();
		mav.addObject("list", list);
		return mav;
		
	}
	
	
	
	@GetMapping("/admin/write")
	public String writeForm(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		if (session == null) {
			return "/admin/loginForm";
		} else {
			return "/admin/writeForm";
		}
		
	}
	
	@PostMapping("/admin/write")
	public String write(Product p) {
		int num = productService.getNum();
		p.setNum(num);
		saveProductImg(num, p.getFile1());
		saveProductImg(num, p.getFile2());
		saveProductImg(num, p.getFile3());
		productService.addProduct(p);
		return "redirect:/admin/admin";
	}
	
	public void saveProductImg(int num, MultipartFile file) { //이미지 저장하기
		String fileName = file.getOriginalFilename();
		if(fileName != null && !fileName.equals("")) {
			File dir = new File(basePath + "p" +num);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			File f = new File(basePath + "p" + num + "\\" + fileName);
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

	@GetMapping("/admin/writeBoard")
	public String writeBoardForm(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		if (session == null) {
			return "/admin/loginForm";
		} else {
			return "/admin/writeBoard";
		}
		
	}
	
	@PostMapping("/admin/writeBoard")
	public String write(Board b) {
		boardService.addBoard(b);
		return "/admin/admin";
	}
	
	
	@RequestMapping("/admin/detail")
	public ModelAndView detail(@RequestParam("num") int num, HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		ModelAndView mav = new ModelAndView("admin/detail");
		
		if (session == null) {
			mav.setViewName("admin/adminLoginForm");
		}
		
	    Product p = productService.getProductByNum(num);
	      
	    String path = basePath + "p" + p.getNum() + "\\";
	    File imgDir = new File(path);
	    if(imgDir.exists()) {
	       String[] files = imgDir.list();
	       for(int j = 0; j < files.length; j++) {
	          mav.addObject("file" + j, files[j]);
	       }
	    }
	      
	    mav.addObject("p", p);
	    return mav;
	}
	
	@RequestMapping("/admin/edit")
	public String edit(Product p) {
		productService.editProduct(p);
		return "/admin/admin";
	}
	

	
	//1:1문의 상세보기
	@RequestMapping("/admin/qnaDetail")
	public ModelAndView qnaDetail(@RequestParam("num") int num, HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		ModelAndView mav = new ModelAndView("admin/qnaDetail");

		if (session == null) {
			mav.setViewName("admin/adminLoginForm");
		}

		Qna q = qnaService.getQnaByNum(num);
		System.out.println(q.toString());
		
		String path = basePath + "q" + q.getNum() + "\\";
		File imgDir = new File(path);
		if(imgDir.exists()) {
			String[] files  = imgDir.list();
			for (int j = 0; j < files.length; j++) {
				mav.addObject("file" + j, files[j]); 
			}
			q.setPath(files[0]);
		}
		mav.addObject("q", q);
		return mav;
	}

	@RequestMapping("/admin/eventList")
	public ModelAndView eventList(HttpServletRequest req, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("admin/eventList");
		String id = "";
		HttpSession session = req.getSession(false);
		
		if (session == null) {
			System.out.println("session null");
			mav.setViewName("admin/adminLoginForm");
		} else {
			id = (String) session.getAttribute("id");
		}
		
		if (id.isBlank()) {
			mav.setViewName("admin/adminLoginForm");
		}
		
		System.out.println("id = " + id +", mav = " + mav.getViewName());
		
		ArrayList<Event> list = eventService.getEventList();
		 //리스트 갯수만큼 반복
	      for (int i = 0; i < list.size(); i++) {
	    	  
	    	 //path에 basePath에 담긴 이미지와 list에 담긴 번호를 저장
	         String path = basePath + "e" + list.get(i).getNum() + "\\";
	         
	         //imDir에 path를 저장
	         File imgDir = new File(path);   
	        
	         String[] files = imgDir.list();
	         //mav에 files에 저장된 값을 저장한다
	         if(imgDir.exists()) {
	            for(int j = 0; j < files.length; j++) {
	               mav.addObject("file" + j, files[j]);
	            }
	            
	            list.get(i).setImgPath(files[0]);
	         }
	      }
		mav.addObject("list", list);
		return mav;
	}
	
	
	@RequestMapping("/admin/delProduct")
	
		public String del(@RequestParam(value = "num") int num) {
			productService.delProduct(num);
			
			return "admin/admin";
		}
	}
	
	

