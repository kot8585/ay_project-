package com.example.demo.review;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.member.Member;
import com.example.demo.member.MemberService;
import com.example.demo.product.Product;
import com.example.demo.product.ProductService;
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

	@Autowired
	private ReviewService service;
	
	@Autowired
	private ProductService pservice;
	
	@Autowired
	private MemberService mservice;
	
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
		service.addReview(r);
		return "redirect:/member/main";
	}
	

	/**
	 * 
	 * @return 작성됨 리뷰들을 리스트로 화면에 출력
	 */
	@RequestMapping("/review/reviewlist")
	public ModelAndView viewlist(@RequestParam("p_num") int p_num,  @RequestParam("what")String what) {
		//@RequestParam("p_name")String p_name,
		System.out.println(what);
		System.out.println(what.getClass());
		//System.out.println(p_num);
		// 작성된 모든 리뷰를 리스트에 저장
		ArrayList<Review> reviewlist = null;
		if(what.equals("basic") || what.equals("none")) {
			reviewlist = (ArrayList<Review>) service.getByPnum(p_num);
		}else if(what.equals("latest")) {
			reviewlist = (ArrayList<Review>) service.getDetailByDate(p_num);
		}
		System.out.println(reviewlist);
		// 리스트에 저장된 리뷰들을 reviewlist.jsp에 보냄
		ModelAndView mav = new ModelAndView("review/reviewlist");
		//mav.setViewName("review/list");
		mav.addObject("list", reviewlist);
		return mav;
	}
	
	@RequestMapping("/review/list")
	public ModelAndView list(@RequestParam("what")String what, @RequestParam("p_num")int p_num) {
		System.out.println("input value : " + what);
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<Review> reviewlist = null;
		//for문으로 짜래..
		/*
		 *   *
		 *  ***
		 *   * 
		 */
		if(what.equals("1") || what.equals("2") || what.equals("3") || what.equals("4") || what.equals("5")) {
			if(what.equals("1")) {
				System.out.println(1);
				what = "★☆☆☆☆";
				map.put("pnum", p_num);
				map.put("stars", what);
				reviewlist = (ArrayList<Review>) service.getDetailByStar(map);
			}else if(what.equals("2")) {
				System.out.println(2);
				what = "★★☆☆☆";
				map.put("pnum", p_num);
				map.put("stars", what);
				System.out.println(map);
				reviewlist = (ArrayList<Review>) service.getDetailByStar(map);
			}else if(what.equals("3")) {
				System.out.println(3);
				what = "★★★☆☆";
				map.put("pnum", p_num);
				map.put("stars", what);
				System.out.println(map);
				reviewlist = (ArrayList<Review>) service.getDetailByStar(map);
			}else if(what.equals("4")) {
				System.out.println(5);
				what = "★★★★☆";
				map.put("pnum", p_num);
				map.put("stars", what);
				System.out.println(map);
				reviewlist = (ArrayList<Review>) service.getDetailByStar(map);
			}else if(what.equals("5")) {
				System.out.println(5);
				what = "★★★★★";
				map.put("pnum", p_num);
				map.put("stars", what);
				System.out.println(map);
				reviewlist = (ArrayList<Review>) service.getDetailByStar(map);
			}
		}else {
			if(what.equals("basic") || what.equals("none")) {
				reviewlist = (ArrayList<Review>) service.getByPnum(p_num);
			}else if(what.equals("latest")) {
				reviewlist = (ArrayList<Review>) service.getDetailByDate(p_num);
			}else if(what.equals("like")) {
				reviewlist = (ArrayList<Review>) service.getDetailByLike(p_num);
			}
		}
		System.out.println(reviewlist);
		// 리스트에 저장된 리뷰들을 reviewlist.jsp에 보냄
		ModelAndView mav = new ModelAndView("review/list");
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
	public ModelAndView detail(@RequestParam("num") int num) {
		// 특정 번호에 해당하는 리뷰에 대한 정보를 가져와 객체에 담는다.
		Review r = service.getDetail(num);	
		// 객체에 담긴 정보를 reviewDetail.jsp에 보냄
		ModelAndView mav = new ModelAndView("review/reviewDetail");
		mav.addObject("r", r);
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
		HttpSession session = req.getSession(false);
		String id = (String) session.getAttribute("id");
		
		System.out.println("session id : " + id);
		System.out.println(pwd);
		System.out.println("Writer : " + wid);
		Member m = mservice.getMember(id);
		String result = "";
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
	
	@RequestMapping("/review/reviewRating")
	public ModelAndView rating(HttpServletRequest req, @RequestParam("num") int num, @RequestParam("type")String type) {
		String id="";
		System.out.println("Parameter : " + num);
		System.out.println("Type : " + type);
		Review r = service.getDetail(num);
		Review review = service.getDetail(num);
		HttpSession session = req.getSession(false);
		String exist = "";
		String message="";
		
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
			
			System.out.println(exist);
			
			System.out.println("like table : " + like);
		
			System.out.println(like.contains(12));
			System.out.println(like.contains("aa"));
			
			
			
			if(id.equals("")) {
				System.out.println("로그인을 하여야 좋아요 기능을 이용할 수 있습니다.");
				message = "동준씨 로그인부터 하시죠..";
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

		System.out.println(r);
		
		System.out.println("message : " + "동준씨 로그인부터 하시죠..");
		
		ModelAndView mav = new ModelAndView("review/reviewRating");
		if(message.equals("동준씨 로그인부터 하시죠..") || message.equals("이미 좋아요를 누르셨습니다.")) {
			System.out.println("id 없다");
			mav.setViewName("review/reviewRatingFail");
			mav.addObject("message",message);
		}else {
			mav.addObject("r", r);
		}
		
		return mav;
	}
}


