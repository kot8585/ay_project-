package com.example.demo.review;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReviewMapper {

	void insert(Review r);
	   
	ArrayList<Review> selectAll();
	
	Review select(int num);
	   
	void update(Review r);
	   
	void delete(int num);

	ArrayList<Review> selectByPnum(int p_num);
	
	ArrayList<Review> selectByDate(int p_num);
	
	ArrayList<Review> selectByLike(int p_num);
	
	ArrayList<Review> selectByStar(HashMap<String, Object> map);
	
	void increaseRating(Review r);
	
	void decreaseRating(Review r);
}
