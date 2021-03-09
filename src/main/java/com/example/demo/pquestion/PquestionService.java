package com.example.demo.pquestion;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
public class PquestionService {


	@Autowired
	private PquestionMapper mapper; 
	
	/**
	 * 상품문의 추가
	 * @param pq : 상품문의내용을 qp에 저장
	 */
	@Transactional
	public void addPquestion(Pquestion pq) {
		mapper.insert(pq);
	}
	   
//	
//	   public ArrayList<Pquestion> getAll(){
//		  return mapper.selectAll();
//	   }
	   
	/**
	 * 상품문의작성한것을 보여줌
	 * @param num : 상품문의를 작성한번호를 선택
	 * @return : 상품문의를 작성한 번호를 찾는다.
	 */
	   public Pquestion getDetail(int num) {
		   return mapper.select(num);
	   }
	   
	   /**
	    * 상품문의수정
	    * @param pq : 상품문의수정 한것을 pq에저장 
	    */
	   public void editPquestion(Pquestion pq) {
		   mapper.update(pq);
	   }
	   
	   /**
	    * 상품문의삭제
	    * @param num : 상품문의작성한 번호를 삭제
	    */
	   @Transactional
	   public void delPquestion(int num) {
		   mapper.delete(num);
	   }

	   /**
	    * 상품번호검색
	    * @param p_num : 상품의 번호를 검색
	    * @return
	    */
	public ArrayList<Pquestion> getByPnum(int p_num) {
		// TODO Auto-generated method stub
		return mapper.selectByPnum(p_num);
	}
	
	
	public ArrayList<Pquestion> getAll() {
		return mapper.selectAll();
	}

	public void changeState(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		
	}
	
}
