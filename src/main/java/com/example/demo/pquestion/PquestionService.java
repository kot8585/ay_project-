package com.example.demo.pquestion;

import java.util.ArrayList;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class PquestionService {

//	@Autowired
//	private PquestionMapper mapper;
//
//	public void addPquestion(Pquestion p) {
//		mapper.insert(p);
//	}
//	
//	public Pquestion getPquestionByNum(int num) {
//		return mapper.select(num);
//	}
//	
//	public List getPquestionById(String id) {
//		return mapper.select(id);
//	}
//	public List getAllPquestion() {
//		return mapper.selectAll();
//	}
//	void delPquestion(int num) {
//		mapper.delete(num);
//	}
//	void update(Pquestion p) {
//		mapper.update(p);
//	}
//	
//	public ArrayList<Pquestion> getMyQuestionListById(String id) {
//		// TODO Auto-generated method stub
//		return mapper.selectByIdId(id);
//	}
//	
//	public int getNum() {
//		return mapper.getNum();
//	}
	
	@Autowired
	private PquestionMapper mapper; 
	
	public void addPquestion(Pquestion p) {
		mapper.insert(p);
	}
	   
	   public ArrayList<Pquestion> getAll(){
		  return mapper.selectAll();
	   }
	   
	   public Pquestion getDetail(int num) {
		   return mapper.select(num);
	   }
	   
	   
	   public void editPquestion(Pquestion p) {
		   mapper.update(p);
	   }
	   
	   public void delPquestion(int num) {
		   mapper.delete(num);
	   }

	public ArrayList<Pquestion> getByPnum(int p_num) {
		// TODO Auto-generated method stub
		return mapper.selectByPnum(p_num);
	}
	
}
