package com.example.demo.pqreply;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PqRepService {

	@Autowired
	private PqRepMapper mapper;

	public ArrayList<PqReply> getPqReplyById(String writer) {
		// TODO Auto-generated method stub
		return mapper.getPqReplyById(writer);
	}

	public ArrayList<PqReply> getPqReplyByPqnum(int pqnum) {
		// TODO Auto-generated method stub
		return mapper.getPqReplyByPqnum(pqnum);
	}
	
	public PqReply getPqReply(int num) {
		return mapper.select(num);
	}

	public int addPqReply(PqReply r) {
		return mapper.insert(r);
	}

	public int delPqReply(int num) {
		return mapper.delete(num);
	}
	
	public List getAllPqReply() {
		return mapper.selectAll();
	}
	
	public int editPqReply(PqReply rep) {
		return mapper.update(rep);
	}
}
