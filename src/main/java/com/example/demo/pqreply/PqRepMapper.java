package com.example.demo.pqreply;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PqRepMapper {

	ArrayList<PqReply> getPqReplyById(String writer);

	ArrayList<PqReply> getPqReplyByPqnum(int pqnum);
	
	public int insert(PqReply r);

	PqReply select(int pqnum);

	public int delete(int num); //해당 댓글만 지우기
	
	public List selectAll();
	
	public int update(PqReply pqrep);

  
}
