package com.example.demo.board;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardMapper {

	void insert(Board b);
	Board select(int num);
	ArrayList<Board> getListWithPaging(HashMap<String, Object> map);
	//ArrayList<Board> selectAll();
	void delete(int num);
	void update(Board b);
	int countAll(String type);
}	
