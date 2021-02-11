package com.example.demo.board;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardMapper {

	void insert(Board b);
	Board select(int num);
	ArrayList<Board> selectByType(String Type);
	ArrayList<Board> selectAll();
	void delete(int num);
	void update(Board b);
}	
