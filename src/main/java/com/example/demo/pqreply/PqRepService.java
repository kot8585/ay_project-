package com.example.demo.pqreply;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;



@Service
public class PqRepService {

	@Autowired
	private PqRepMapper mapper;

	/**
	 * 해당 writer가 작성한 댓글리스트를 받아오는 기능을 제공합니다.
	 * @param writer 작성자
	 * @return 받아온 댓글리스트
	 */
	public ArrayList<PqReply> getPqReplyById(String writer) {
		return mapper.getPqReplyById(writer);
	}

	/**
	 * 해당 문의게시판의 댓글 리스트를 받아오는 기능을 제공합니다.
	 * @param qna_num QnA 번호
	 * @return 받아온 댓글리스트
	 */
	public ArrayList<PqReply> getPqReplyByPqNum(int pqnum) {
		System.out.println("상품 문의 서비스 호출");
		return mapper.getPqReplyByPqnum(pqnum);
	}
	
	/**
	 *  원하는 번호에 해당하는 댓글을 받아오는 기능을 재공합니다. 
	 * @param num 댓글 번호 
	 * @return 받아온 댓글
	 */
	public PqReply getPqReply(int num) {
		return mapper.select(num);
	}

	/**
	 * 댓글 추가
	 * @param r : 작성된 댓글
	 * @return : 작성됐다면 1, 작성안되면 0...?
	 */
	@Transactional
	public int addPqReply(PqReply r) {
		return mapper.insert(r);
	}

	/**
	 * 댓글 삭제
	 * @param num : 댓글 번호
	 * @return : 작성됐다면 1, 작성안되면 0...?
	 */
	@Transactional
	public int delPqReply(int num) {
		return mapper.delete(num);
	}
	
	
//	public List getAllPqReply() {
//		return mapper.selectAll();
//	}
//	
	/**
	 * 댓글 수정
	 * @param rep : 수정된 댓글 
	 * @return : 작성됐다면 1, 작성안되면 0...?
	 */
	@Transactional
	public int editPqReply(PqReply rep) {
		return mapper.update(rep);
	}
}
