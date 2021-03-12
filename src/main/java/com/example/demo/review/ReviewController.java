package com.example.demo.review;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.HashMap;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.admin.AdminController;
import com.example.demo.member.Member;
import com.example.demo.member.MemberService;
import com.example.demo.product.Product;
import com.example.demo.product.ProductService;
import com.example.demo.qna.QnaController;
/**
 * Review 기능(2021.02.25)
 *	
 *	1. 리뷰 리스트
 *	- 상품 클릭 후 상품 상세 페이지에서 해당 상품에 등록된 리뷰 글 목록이 제대로 뜨는지 확인
 *	- 최신순 / 좋아요순 / 별점 갯수에 따른 목록이 기능별로 작동하는지 확인
 *	
 *	2. 리뷰 글 등록
 *	- 마이페이지 -> 주문상품 목록에서 리뷰 작성 버튼을 클릭 후 리뷰 작성 폼으로 이동 -> 작성 폼 작성 후 등록 -> 1번의 리뷰 리스트에서 목록에 추가 됐는지 확인
 *	
 *	3. 리뷰 글 수정 및 삭제
 *	- 리뷰 리스트에서 리뷰 제목클릭 시 리뷰 상세 페이지로 이동하는지 확인
 *	- 리뷰 상세페이지에서 수정 또는 삭제 버튼을 클릭했을 시, 프롬프트로 비밀번호 확인 기능이 제대로 작동하는지 확인 후 수정 및 삭제 -> 1번의 리뷰 리스트 목록에서 수정 및 삭제되었는지 확인
 * @author Hyun Jin Kim
 * 2021.02.08
 * 기능 : 리뷰 작성 / 리스트 출력 / 수정 / 삭제
 *
 */
@Controller
public class ReviewController {
	
	/**
	 * 로그 찍는 용.
	 */
	private final Logger log = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private ReviewService service;
	
	@Autowired
	private ProductService pservice;
	
	@Autowired
	private MemberService mservice;
	
	public static String basePath = "C:\\shopimg\\r";
	
	AdminController admin = new AdminController();
	
	QnaController qna = new QnaController();
	
	/**
	 * 
	 * @param req session값을 받아오기 위한 파라메터
	 * @param pnum 해당 상품에 대한 리뷰를 쓰기위해 상품번호를 받아우기 위한 파라메터
	 * @return 상품 번호를 jsp에서 사용하기 위해, 상품에 대한 정보를 리턴함.
	 */
	@RequestMapping("/review/reviewForm")
		public ModelAndView reviewForm(HttpServletRequest req, @RequestParam("pnum") int pnum) {
		// 로그인한 id를 리뷰작성 페이지의 작성자로 보내주기 위해 서버에서 session값을 받아온다.
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("id");
		// 선택한 상품의 상품번호를 파라메터 받아온 뒤, 해당 번호로 상품을 검색하여 상품에 대한 정보를 객체에 저장한다.
		Product p = pservice.getProductByNum(pnum);
		// 객체에 저장된 정보를 reviewForm.jsp로 보내준다.
		ModelAndView mav = new ModelAndView("review/reviewForm");
		mav.addObject("p", p);
		return mav;   
	}             
	
	/**
	 * 
	 * @param r 리뷰 폼에 입력 받은 자료를 객체에 저장 
	 * @return 리뷰 폼이 완성되었을 때 main 페이지로 이동.
	 */
	@RequestMapping("/review/write")
	public String write(Review r) {
		//작성한 폼을 DB에 저장한다.
		System.out.println("getUploadFile : " + r.getUploadFile());
		
		// 리뷰 글의 번호를 지정한다.
		int num = service.getNum();
		System.out.println("번호 : " +num);
		r.setNum(num);
		for(MultipartFile multipartFile : r.getUploadFile()) {
			String fileName = multipartFile.getOriginalFilename();
			System.out.println("파일 이름 : " + fileName);
			if(fileName != null && !fileName.equals("")) {
				saveQnaImg(num, multipartFile);
			}
		}
		service.addReview(r);
		return "redirect:/member/main";
	}
	
	@RequestMapping("/review/img")
	public ResponseEntity<byte[]> getImg(String fname, int num){
		String path = basePath + num + "\\" + fname;
		System.out.println("fname : " + fname);

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

	/**
	 * 
	 * @return 작성됨 리뷰들을 리스트로 화면에 출력
	 */
	@RequestMapping("/review/reviewlist")
	public ModelAndView viewlist(@RequestParam("p_num") int p_num,  @RequestParam("what")String what) {
		//@RequestParam("p_name")String p_name,
		System.out.println("what : " + what);
		System.out.println("pnum : " + p_num);
		System.out.println(what.getClass());
		ModelAndView mav = new ModelAndView("review/reviewlist");
		//System.out.println(p_num);
		// 작성된 모든 리뷰를 리스트에 저장
		ArrayList<Review> reviewlist = null;
		if(what.equals("basic") || what.equals("none")) {
			reviewlist = (ArrayList<Review>) service.getByPnum(p_num);
		}else if(what.equals("latest")) {
			reviewlist = (ArrayList<Review>) service.getDetailByDate(p_num);
		}
		System.out.println("review list : " + reviewlist);
		String path = "";
		
		for(int i = 0; i < reviewlist.size(); i++) {
			int num = reviewlist.get(i).getNum();
			path = basePath + num + "\\";
			File imgDir = new File(path);
			System.out.println("dir" + imgDir);
			
			String[] files = imgDir.list();
			System.out.println("dir list : " + files);
			if(imgDir.exists()) {
				for(int j = 0; j < files.length; j++) {	
					if(j == 0) {
						reviewlist.get(i).setPath(files[0]);
					}
					else if(j == 1) {
						reviewlist.get(i).setPath2(files[1]);
					}
					mav.addObject("file" + j, files[j]);
				}
			}
			
		}
		System.out.println("경로 : " + path);
		// 리스트에 저장된 리뷰들을 reviewlist.jsp에 보냄
		mav.addObject("list", reviewlist);
		return mav;
	}
	
	/**
	 * 
	 * @param what 리뷰 정렬 조건(좋아요/최신..)을 받는 파라메터
	 * @param p_num 상품 번호를 받는 파라메터
	 * @return what으로 받은 정렬 조건에 따라 결과를 list에 저장해서 화면으로 보내준다.
	 */
	@RequestMapping("/review/list")
	   public ModelAndView list(@RequestParam("what")String what, @RequestParam(value="p_num",required=false)int p_num) {
	      System.out.println("input value : " + what);
	      System.out.println("pnum : " + p_num);
	      // 선택된 상품 번호에 별점을 입력하기 위해 HashMap 사용
	      HashMap<String, Object> map = new HashMap<String, Object>();
	      ArrayList<Review> reviewlist = null;
	      ModelAndView mav = new ModelAndView("review/list");
	      // 리뷰 정렬조건-별점별 정렬
	      if(what.equals("1") || what.equals("2") || what.equals("3") || what.equals("4") || what.equals("5")) {
	         int blackstar = Integer.parseInt(what);
	         // = String star = "";
	         StringBuilder star = new StringBuilder();
	         for (int i = 0; i < blackstar; i++) {
	            // star += "★";
	            star.append("★");
	         }
	         for (int i = 0; i < 5-blackstar; i++) {
	            // star += "☆";
	            star.append("☆");
	         }
	         map.put("pnum", p_num);
	         map.put("stars", star.toString());
	         reviewlist = (ArrayList<Review>) service.getDetailByStar(map);
	      // 리뷰 정렬조건-조건이 없을 때
	      } else if(what.equals("basic") || what.equals("none")) {
	            reviewlist = (ArrayList<Review>) service.getByPnum(p_num);
	      // 리뷰 정렬조건-최신순으로 정렬
	      } else if(what.equals("latest")) {
	            reviewlist = (ArrayList<Review>) service.getDetailByDate(p_num);
	      // 리뷰 정렬조건-좋아요 순으로 정렬
	      } else if(what.equals("like")) {
	            reviewlist = (ArrayList<Review>) service.getDetailByLike(p_num);
	      // 리뷰 정렬조건-특정 단어 검색
	      } else {
	    	  System.out.println("search");
	    	  map.put("pnum", p_num);
	    	  map.put("what", what);
	    	  System.out.println("map : " + map);
	    	  reviewlist = (ArrayList<Review>) service.getDetailByWord(map);
	    	  System.out.println("search finish");
	      }
	      
	      String path = "";
			
			for(int i = 0; i < reviewlist.size(); i++) {
				int num = reviewlist.get(i).getNum();
				path = basePath + num + "\\";
				File imgDir = new File(path);
				System.out.println("dir" + imgDir);
				
				String[] files = imgDir.list();
				System.out.println("dir list : " + files);
				if(imgDir.exists()) {
					for(int j = 0; j < files.length; j++) {	
						if(j == 0) {
							reviewlist.get(i).setPath(files[0]);
						}
						else if(j == 1) {
							reviewlist.get(i).setPath2(files[1]);
						}
						mav.addObject("file" + j, files[j]);
					}
				}
			}
	      
	      System.out.println("review list : " + reviewlist);
	      // 리스트에 저장된 리뷰들을 reviewlist.jsp에 보냄
	      Product product = pservice.getProductByNum(p_num);
	      System.out.println("pro : " + product);
	      mav.addObject("p", product);
	      //mav.setViewName("review/list");
	      mav.addObject("list", reviewlist);
	      return mav;
	   }
	
	/**
	 * 
	 * @param num 특정번호에 해당하는 리뷰를 가져오기 위한 파라메터
	 * @return 특정번호에 해당하는 리뷰를 화면에 출력
	 */
	@RequestMapping("/review/reviewDetail")
	public ModelAndView detail(@RequestParam("num") int num, @RequestParam("p_num")int p_num) {
		// 특정 번호에 해당하는 리뷰에 대한 정보를 가져와 객체에 담는다.
		Review r = service.getDetail(num);	
		// 상품이름을 리스트에 출력하기 위해, 상품 번호로 해당 상품의 정보를 가져와 객체에 저장
		Product p = pservice.getProductByNum(p_num);
		// 객체에 담긴 정보를 reviewDetail.jsp에 보냄
		ModelAndView mav = new ModelAndView("review/reviewDetail");
		mav.addObject("r", r);
		mav.addObject("p", p);
		return mav;
	}
	
	/**
	 * 	
	 * @param r 리뷰 수정 폼에서 입력받은 자료를 객체에 저장
	 * @return 수정을 마친 뒤 main 페이지로 이동
	 */
	@RequestMapping("/review/editReview")
	public String edit(Review r) {
		// 수정 폼에 입력된 자료를 DB에 저장
		service.editReview(r);
		return "/member/main";
	}
	
	/**
	 * 
	 * @param req session에서 id값을 받아오기 위한 파라메터
	 * @param pwd 입력받은 비밀번호를 받아온다
	 * @return 비밀번호 체크에 대한 결과를 출력
	 */
	@RequestMapping("/review/pwdCheck")
	public ModelAndView pwdCheck(HttpServletRequest req, @RequestParam("password")String pwd, @RequestParam("wid")String wid) {
		// 해당 id의 비밀번호를 비교하기 위해 현재 접속된 id 값을 받아온다
		HttpSession session = req.getSession(false);
		String id = (String) session.getAttribute("id");
		System.out.println("session id : " + id);
		System.out.println(pwd);
		System.out.println("Writer : " + wid);
		String result = "";
		// 로그인을 하지 않아 session에 id값이 없는 경우
		if(id == null) {
			result = "로그인부터 해주세요.";
		// 로그인이 되어있어 session에 id 값이 있는 경우 -> session id 값으로 db에 저장된 id 값과 pwd 값을 가져와 입력된 값과 비교
		}else {
			Member m = mservice.getMember(id);
			
			if(!wid.equals(id)) {
				result = "작성자가 아닙니다..";
			}else {
				if(m != null && m.getPassword().equals(pwd)) {
					result = "비밀번호 확인 완료";
				}
				else {
					result = "비밀번호가 다릅니다.";
				}
			}
		}
		System.out.println(result);
		ModelAndView mav = new ModelAndView("review/pwdCheck");
		mav.addObject("result", result);
		
		return mav;
	}
	
	/**
	 * 
	 * @param num 특정 번호에 해당하는 리뷰 글을 지우기 위한 파라메터
	 * @return 삭제가 되었을 때 main 페이지로 이동
	 */
	@RequestMapping("/review/delReview")
	public String del(@RequestParam("num")int num) {
		// DB에서 특정 번호에 해당하는 리뷰 글 삭제	
		service.delReview(num);
		return "redirect:/member/main";	
	}
	
	/**
	 * 
	 * @param req 좋아요 중복 방지를 위한 아이디 값을 받기 위해 사용
	 * @param num Review 객체의 정보를 불러오기 위한 리뷰 번호 파라메터
	 * @param type 좋아요/싫어요 기능 구분을 위한 파라메터
	 * @return
	 */
	@RequestMapping("/review/reviewRating")
	public ModelAndView rating(HttpServletRequest req, @RequestParam("num") int num, @RequestParam("type")String type) {
		String id="";
		System.out.println("Parameter : " + num);
		System.out.println("Type : " + type);
		// 특정 리뷰글의 좋아요를 설정하기 위해 리뷰글 번호를 통해 해당 리뷰글의 정보를 가져온다
		Review r = service.getDetail(num);
		Review review = service.getDetail(num);
		HttpSession session = req.getSession(false);
		String exist = "";
		String message="";
		
		// 한 개의 id당 특정 글에 1번의 좋아요만 할 수 있도록 session에서 id 값을 가져와 비교
		try {
			id = (String)session.getAttribute("id");
			if(id==null) {
				id="";
			}
			ArrayList<ReviewLike> like = service.getLikeByid(num);
			
			for(int i = 0; i < like.size(); i++) {
				if(like.get(i).getId().equals(id) ) {
					if(like.get(i).getRnum()==num) {
						exist = "exist";
					}
				}
			}
			if(id.equals("")) {
				System.out.println("로그인을 하여야 좋아요 기능을 이용할 수 있습니다.");
				message = "로그인을 하여야 좋아요 기능을 이용할 수 있습니다.";
			}else if(!id.equals("") && !exist.equals("exist")) {
				review.setWriter(id);
				service.addReviewID(review);
				
				if(type.equals("like")) {
					System.out.println("증가");
					service.IncRating(r);
					r = service.getDetail(num);
					System.out.println(r);
					//db 업데이트때 생각해보기
				}else if(type.equals("hate")){
					System.out.println("감소");
					service.DecRating(r);
				}
			}else if(!id.equals("") && exist.equals("exist")) {
				System.out.println("이미 좋아요를 누르셨습니다.");
				message = "이미 좋아요를 누르셨습니다.";
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		ModelAndView mav = new ModelAndView("review/reviewRating");
		if(message.equals("로그인을 하여야 좋아요 기능을 이용할 수 있습니다.") || message.equals("이미 좋아요를 누르셨습니다.")) {
			System.out.println("id 없다");
			mav.setViewName("review/reviewRatingFail");
			mav.addObject("message",message);
		}else {
			mav.addObject("r", r);
		}
		return mav;
	}
}