package com.example.demo.board;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class BoardService {

	@Autowired
	private BoardMapper mapper;

	public void addBoard(Board b) {
		mapper.insert(b);
	}
	
	public Board getBoardByNum(int num) {
		return mapper.select(num);
	}
	
	public ArrayList<Board> getBoardByType(String type) {
		return mapper.selectByType(type);
	}
	
	public ArrayList<Board> getAllBoard() {
		return mapper.selectAll();
	}
	
	void delBoard(int num) {
		mapper.delete(num);
	}
	
	void update(Board b) {
		mapper.update(b);
	}
	


}
