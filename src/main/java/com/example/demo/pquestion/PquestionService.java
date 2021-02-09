package com.example.demo.pquestion;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.board.Board;

@Service
public class PquestionService {

	@Autowired
	private PquestionMapper mapper;

	public void addPquestion(Pquestion p) {
		mapper.insert(p);
	}
	
	public Pquestion getPquestionByNum(int num) {
		return mapper.select(num);
	}
	
	public List getPquestionById(String id) {
		return mapper.selectById(id);
	}
	public List getAllPquestion() {
		return mapper.selectAll();
	}
	void delPquestion(int num) {
		mapper.delete(num);
	}
	void update(Pquestion p) {
		mapper.update(p);
	}
	
	public ArrayList<Pquestion> getMyQuestionListById(String id) {
		// TODO Auto-generated method stub
		return mapper.getMyQuestionListById(id);
	}
	
	public int getNum() {
		return mapper.getNum();
	}
	
}
