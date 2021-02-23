package com.example.demo.reply;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RepMapper {

	ArrayList<Reply> getReplyById(String writer);

	ArrayList<Reply> getReplyByQnaNum(int qna_num);
	
	public int insert(Reply r);

	Reply select(int num);

	public int delete(int num); //해당 댓글만 지우기
	
	public List selectAll();
	
	public int update(Reply rep);
}
