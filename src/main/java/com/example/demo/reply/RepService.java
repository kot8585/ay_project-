package com.example.demo.reply;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RepService {

	@Autowired
	private RepMapper mapper;

	public ArrayList<Reply> getReplyById(String writer) {
		// TODO Auto-generated method stub
		return mapper.getReplyById(writer);
	}

	public ArrayList<Reply> getReplyByQnaNum(int qna_num) {
		// TODO Auto-generated method stub
		return mapper.getReplyByQnaNum(qna_num);
	}
	
	public Reply getReply(int num) {
		return mapper.select(num);
	}

	public int addReply(Reply r) {
		return mapper.insert(r);
	}

	public int delReply(int num) {
		return mapper.delete(num);
	}
	
	public List getAllReply() {
		return mapper.selectAll();
	}
	
	public int editReply(Reply rep) {
		return mapper.update(rep);
	}
}
