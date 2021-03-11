package com.example.demo.pquestion;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.member.MemberService;
import com.example.demo.pqreply.PqRepService;
import com.example.demo.pqreply.PqReply;
import com.example.demo.product.Product;
import com.example.demo.product.ProductService;
import com.example.demo.qna.Qna;
import com.example.demo.review.Review;
import com.example.demo.shoppingcart.Shoppingcart;
import com.fasterxml.jackson.annotation.JsonCreator.Mode;




@Controller
public class PquestionController {

	@Autowired
	private PquestionService service;
	
	@Autowired
	private ProductService pservice;
	
	@Autowired
	private MemberService mservice;
	
	@Autowired
	private PqRepService pqservice;
	
	
	/**
	 * 상품문의등록폼
	 * @param req : 로그인확인
	 * @param pnum : 상품의 번호를 확인
	 * @return : 상품번호를 받아서 mav에 상품문의폼을 담는다.
	 */
	@RequestMapping("/pquestion/pquestionForm")
	public ModelAndView pquestionForm(HttpServletRequest req,@RequestParam("pnum") int pnum) {
		System.out.println("PquestionController.pquestionForm()");
		
	HttpSession session = req.getSession();
	String id = (String) session.getAttribute("id");
		
	Product p = pservice.getProductByNum(pnum);
	
	ModelAndView mav = new ModelAndView("pquestion/pquestionForm");
	
	
	mav.addObject("pq", p);
	return mav;   
}            
	
/**
 * 상품문의리스트
 * @param pnum : 상품번호 확인
 * @return : 상품번호를 검색후 그상품의 문의리스트를 mav에담는다.
 */
	@RequestMapping("/pquestion/plist")
	   public ModelAndView list(@RequestParam("pnum") int pnum) {
		  System.out.println("PquestionController.list()");
 
		  ArrayList<Pquestion> plist = (ArrayList<Pquestion>) service.getByPnum(pnum);
//		  ArrayList<PqReply> plist = (ArrayList<PqReply>) pqservice.getPqReplyByPqNum(pqnum);
		  
		  
		  for(Pquestion pq : plist) {
			  int pqnum = pq.getNum();
			
			  //상품 문의번호에 맞는 상품문의 댓글 가져오기
			  ArrayList<PqReply> pqrep = pqservice.getPqReplyByPqNum(pqnum);
			  
			  //댓글을 상품문의에 세팅하기
			  pq.setPqreply(pqrep);
			  
		  }
		  
		  System.out.println(plist.toString());
	      ModelAndView mav = new ModelAndView("pquestion/plist");
	      mav.addObject("plist", plist);
	      return mav;
	}
	
	/**
	 * 상품문의작성
	 * @param pq : 상품문의작성폼이 pq에 담겨 있다
	 * @return : 상품문의작성을 한뒤 메인으로 돌아감
	 */
	@RequestMapping("/pquestion/write")
	public String write(Pquestion pq) {
		//작성한 폼을 DB에 저장한다.
		service.addPquestion(pq);
		return "redirect:/member/main";
	}
	
	/**
	 * 상품문의리스트를 클릭하면 자세한 내용이 보인다
	 * @param num : 상품문의리스트의 번호를 나타냄
	 * @return : 상품리스트가 담긴 번호를 찾아 mav에담고 출력
	 */
	@RequestMapping("/pquestion/pDetail")
	public ModelAndView detail(@RequestParam("num") int num) {
		// 특정 번호에 해당하는 상품리스트에 대한 정보를 가져와 객체에 담는다.
		Pquestion pq = service.getDetail(num);	
		// 객체에 담긴 정보를 pDetail.jsp에 보냄
		ModelAndView mav = new ModelAndView("pquestion/pDetail");
		mav.addObject("pq", pq);
		return mav;
	}
	
	/**
	 * 상품문의리스트수정
	 * @param pq : 상품문의리스트의 번호
	 * @return 상품문의리스트 수정후 상품 상세페이지으로 이동
	 */
	@RequestMapping("/pquestion/editpquestion")
	public String pquestion(Pquestion pq) {
		// 수정 폼에 입력된 자료를 DB에 저장
		service.editPquestion(pq);
		return "redirect:/product/detail?num=" + pq.getpnum();
	}
	
		
	/**
	 * 상품문의리스트삭제
	 * @param num : 상품문의리스트의 번호
	 * @return : 상품문의리스트의 번호를 검색해 삭제후 메인으로 이동
	 */
	@RequestMapping("/pquestion/delpquestion")
	public String delete(@RequestParam("num")int num) {
		
		service.delPquestion(num);
		return "redirect:/member/main";
	}
	

}	
	

