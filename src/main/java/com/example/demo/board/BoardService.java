package com.example.demo.board;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardService {

	private final Logger log = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private BoardMapper mapper;

	public void addBoard(Board b) {
		mapper.insert(b);
	}
	
	public Board getBoardByNum(int num) {
		return mapper.select(num);
	}
	
	public ArrayList<Board> getList(String type, Criteria cri) {
		log.info("get List with type and critetia: " +type +cri );
		HashMap<String , Object> map = new HashMap<>();
		map.put("type", type);
		map.put("cri", cri);
		return mapper.getListWithPaging(map);
	}
		
	public void delBoard(int num) {
		mapper.delete(num);
	}
	
	public void update(Board b) {
		mapper.update(b);
	}
	
	public int getTotal(String type, String keyword) {
		return mapper.countAll(type, keyword);
	}

}
