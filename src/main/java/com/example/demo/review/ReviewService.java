package com.example.demo.review;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReviewService {

	@Autowired
	private ReviewMapper mapper; 
	
	public void addReview(Review r) {
		mapper.insert(r);
	}
	   
	   public ArrayList<Review> getAll(){
		  return mapper.selectAll();
	   }
	   
	   public Review getDetail(int num) {
		   return mapper.select(num);
	   }
	   
	   public ArrayList<Review> getDetailByDate(int num) {
		   return mapper.selectByDate(num);
	   }
	   
	   
	   public void editReview(Review r) {
		   mapper.update(r);
	   }
	   
	   public void delReview(int num) {
		   mapper.delete(num);
	   }

	public ArrayList<Review> getByPnum(int p_num) {
		// TODO Auto-generated method stub
		return mapper.selectByPnum(p_num);
	}
}
