package com.example.demo.qna;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class QnaService {

	@Autowired
	private QnaMapper mapper;

	public void addQna(Qna q) {
		mapper.insert(q);
	}
	
	public Qna getQnaByNum(int num) {
		return mapper.select(num);
	}
	
	public ArrayList<Qna> getMyQnaListByWriter(String writer) {
		return mapper.selectByWriter(writer);
	}
	
	public List getAllQna() {
		return mapper.selectAll();
	}
	
	void delQna(int num) {
		mapper.delete(num);
	}
	
	void update(Qna q) {
		mapper.update(q);
	}
	
	public int getNum() {
		return mapper.getNum();
	}
	
	public void changeState(HashMap<String, Object> map) {
		mapper.updateState(map);
	}
}
