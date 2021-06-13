package com.example.demo.board;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.page.Criteria;

/**
 * by 문효정
 */

@Service
@Slf4j
@RequiredArgsConstructor
public class BoardService {

	private final BoardMapper mapper;

	/**
	 * 고객센터 게시판 추가 기능
	 */
	public void addBoard(Board b) {
		mapper.insert(b);
	}
	
	/**
	 * 해당 게시물을 받아오는 기능 제공
	 * @param num : 게시물 번호
	 */
	public Board getBoardByNum(int num) {
		return mapper.select(num);
	}
	
	/**
	 * @param type : faq인지 notice인지 구분
	 * @param cri : 페이징 기능을 위한 것입니다.
	 * @return Board 목록 : type과 cri에 따른 게시판 목록
	 */
	public List<Board> getList(String type, Criteria cri) {
		log.info("get List with type and critetia: " +type + "," +cri );
		HashMap<String , Object> map = new HashMap<>();
		map.put("type", type);
		map.put("cri", cri);
		return mapper.getListWithPaging(map);
	}

	public List<Board> getListWithPagingCursor(String type, Criteria cri) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("type", type);
		map.put("cri", cri);
		return mapper.getListWithPaging(map);
	}

	/**
	 * 게시판을 키워드로 검색할때 해당 키워드를 가지고 있는 게시판의 개수
	 * 페이징 기능을 위한 것입니다.
	 * @param type : faq인지 notice인지 구분
	 * @param keyword : 검색 키워드
	 * @return 검색된 게시물의 개수
	 */
	public int getTotal(String type, String keyword) {
		return mapper.countAll(type, keyword);
	}

	/**
	 * 게시판 삭제 기능
	 * @param num 게시판 번호
	 */
	@Transactional
	public int delBoard(int num) {
		return mapper.delete(num);
	}
	
	/**
	 * 게시판 수정 기능
	 * @param b 수정한 게시판 데이터
	 */
	@Transactional
	public boolean update(Board b) {
		int result =  mapper.update(b);
		if(result > 0) {
			return true;
		}
		return false;
	}

}
