package com.example.demo.qna;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface QnaMapper {

	void insert(Qna b);
	Qna select(int num);
	List selectAll();
	void delete(int num);
	void update(Qna b);
	ArrayList<Qna> selectByWriter(String writer);
	int getNum();
	String selectO_history(String writer);
	void updateState(HashMap<String, Object> map);
}	
