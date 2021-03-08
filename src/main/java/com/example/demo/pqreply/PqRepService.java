package com.example.demo.pqreply;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PqRepService {

	@Autowired
	private PqRepMapper mapper;

	public ArrayList<PqReply> getPqReplyById(String writer) {
		return mapper.getPqReplyById(writer);
	}

	public ArrayList<PqReply> getPqReplyByPqnum(int pqnum) {
		return mapper.getPqReplyByPqnum(pqnum);
	}
	
	public PqReply getPqReply(int num) {
		return mapper.select(num);
	}

	@Transactional
	public int addPqReply(PqReply r) {
		return mapper.insert(r);
	}

	@Transactional
	public int delPqReply(int num) {
		return mapper.delete(num);
	}
	
	public List getAllPqReply() {
		return mapper.selectAll();
	}
	
	@Transactional
	public int editPqReply(PqReply rep) {
		return mapper.update(rep);
	}
}
