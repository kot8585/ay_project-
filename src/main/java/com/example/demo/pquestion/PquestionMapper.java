package com.example.demo.pquestion;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.board.Board;
import com.example.demo.review.Review;

@Mapper
public interface PquestionMapper {

//	void insert(Pquestion p);
//	Pquestion select(int num);
//	List selectById(String id);
//	List selectAll();
//	void delete(int num);
//	void update(Pquestion p);
//	ArrayList<Pquestion> selectById(String id);
//	int getNum();
	
	void insert(Pquestion p);
	   
	ArrayList<Pquestion> selectAll();
	
	Pquestion select(int num);
	   
	void update(Pquestion p);
	   
	void delete(int num);

	ArrayList<Pquestion> selectByPnum(int p_num);
	
}
