package com.example.demo.reply;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RepService {

	
	@Autowired
	private RepMapper mapper;

	/**
	 * 해당 writer가 작성한 댓글리스트를 받아오는 기능을 제공합니다.
	 * @param writer 작성자
	 * @return 받아온 댓글리스트
	 */
	public ArrayList<Reply> getReplyById(String writer) {
		return mapper.getReplyById(writer);
	}

	/**
	 * 해당 문의게시판의 댓글 리스트를 받아오는 기능을 제공합니다.
	 * @param qna_num QnA 번호
	 * @return 받아온 댓글리스트
	 */
	public ArrayList<Reply> getReplyByQnaNum(int qna_num) {
		return mapper.getReplyByQnaNum(qna_num);
	}
	
	/**
	 *  원하는 번호에 해당하는 댓글을 받아오는 기능을 재공합니다. 
	 * @param num 댓글 번호 
	 * @return 받아온 댓글
	 */
	public Reply getReply(int num) {
		return mapper.select(num);
	}

	/**
	 * 댓글 추가
	 * @param r : 작성된 댓글
	 * @return : 작성됐다면 1, 작성안되면 0...?
	 */
	public int addReply(Reply r) {
		return mapper.insert(r);
	}

	/**
	 * 댓글 삭제
	 * @param num : 댓글 번호
	 * @return : 작성됐다면 1, 작성안되면 0...?
	 */
	public int delReply(int num) {
		return mapper.delete(num);
	}
	
	
//	public List getAllReply() {
//		return mapper.selectAll();
//	}
//	
	/**
	 * 댓글 수정
	 * @param rep : 수정된 댓글 
	 * @return : 작성됐다면 1, 작성안되면 0...?
	 */
	public int editReply(Reply rep) {
		return mapper.update(rep);
	}
}
