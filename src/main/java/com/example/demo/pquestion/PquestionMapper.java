package com.example.demo.pquestion;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.board.Board;

@Mapper
public interface PquestionMapper {

	void insert(Pquestion p);
	Pquestion select(int num);
	List selectById(String id);
	List selectAll();
	void delete(int num);
	void update(Pquestion p);
	ArrayList<Pquestion> getMyQuestionListById(String id);
	int getNum();
	
}
