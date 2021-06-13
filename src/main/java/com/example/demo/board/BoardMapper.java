package com.example.demo.board;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardMapper {

	void insert(Board b);
	Board select(int num);
	List<Board> getListWithPaging(HashMap<String, Object> map);
	//ArrayList<Board> selectAll();
	int delete(int num);
	int update(Board b);
	int countAll(String type, String keyword);

	List<Board> getListWithPagingCursor(HashMap<String, Object> map);
}	
