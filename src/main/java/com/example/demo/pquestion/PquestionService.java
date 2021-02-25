package com.example.demo.pquestion;

import java.util.ArrayList;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class PquestionService {


	@Autowired
	private PquestionMapper mapper; 
	
	public void addPquestion(Pquestion pq) {
		mapper.insert(pq);
	}
	   
	   public ArrayList<Pquestion> getAll(){
		  return mapper.selectAll();
	   }
	   
	   public Pquestion getDetail(int num) {
		   return mapper.select(num);
	   }
	   
	   
	   public void editPquestion(Pquestion pq) {
		   mapper.update(pq);
	   }
	   
	   public void delPquestion(int num) {
		   mapper.delete(num);
	   }

	public ArrayList<Pquestion> getByPnum(int p_num) {
		// TODO Auto-generated method stub
		return mapper.selectByPnum(p_num);
	}
	
}
