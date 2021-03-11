package com.example.demo.reply;


import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.qna.QnaService;

/**
 * 참고 : https://maxcomfem.tistory.com/49  더 자셍한 사항은 '코드로 배우는 스프링 웹 프로젝트 댓글'으로 검색
 * 
 * 비동기 방식으로만 댓글 처리
 * 관리자가 1:1문의게시판(QnA)에 답변을 달 때 사용됩니다.
 * Rest방식으로 작성하였는데 Rest방식은 요청받은 데이터타입과 응답할 데이터타입을 정확하게 명시해야한다.
 * @author 문효정
 *
 */
@RestController
public class ReplyController {
	@Autowired
	private RepService service;

	@Autowired
	private QnaService qnaService;
	
	private final Logger log = LoggerFactory.getLogger(this.getClass());
	

	/**
	 * JSON방식의 데이터만 처리하고, 문자열을 반환
	 * @param r : JSON데이터를 Reply타입으로 변환하도록 지정
	 * @return : 성공 여부인 String 타입
	 */
	@PostMapping(value= "/rep/write",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> write(@RequestBody Reply r) {
		int insertCount = service.addReply(r);
		log.info("insertCount : " + insertCount);
		
		//성공적으로 이루어졌으면 답변 상태 바꾸기
		if(insertCount == 1) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("num", r.getQna_num());
		map.put("state", "답변완료");
		qnaService.changeState(map);
		}

		return insertCount == 1 
		? new ResponseEntity<>("success", HttpStatus.OK) 
		: new ResponseEntity<> (HttpStatus.INTERNAL_SERVER_ERROR);
	}

	/**
	 * 댓글의 목록을 JSON으로 반환하는 기능
	 * @param qna_num : Qna의 번호
	 * @return List<Reply>, Http상태코드
	 */
	@GetMapping(value = "/rep/list/{qna_num}",
			produces = {MediaType.APPLICATION_XML_VALUE,
						MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<Reply>> list(@PathVariable("qna_num") int qna_num) {
		return new ResponseEntity<>(service.getReplyByQnaNum(qna_num), HttpStatus.OK);
	}

	/**
	 * PUT 또는 PATCH 방식으로 요청을 받아 댓글을 수정하는 기능 제공
	 * @param r : 수정할 댓글 내용을 JSON으로 받아와 필요한 객체로 변환
	 * @param num : 댓글 번호
	 * @return HTTP 상태코드
	 */
	@RequestMapping(method = {RequestMethod.PUT},
			value = "/rep/edit/{num}",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> edit(
			@RequestBody Reply r,
			@PathVariable("num") int num) {
		return service.editReply(r) == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	
	/**
	 * 댓글 삭제 기능 
	 * @param num : 삭제할 댓글 번호
	 * @return HTTP 상태코드
	 */
	@DeleteMapping(value = "/rep/del/{num}", 
			produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> del(@PathVariable("num") int num) {
		log.info("ReplyController del");
		return service.delReply(num) == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	/**
	 * 번호에 해당하는 댓글 가져오기
	 * 댓글을 눌렀을때 해당 데이터를 모달창에 띄우게 하기 위해 사용
	 * @param num : 해당 댓글 번호
	 * @return JSON타입의 Reply, HTTP상태코드
	 */
	@GetMapping(value = "rep/get/{num}",
			produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Reply> get(@PathVariable("num") int num){
		
		return new ResponseEntity<Reply>(service.getReply(num), HttpStatus.OK);
	}
}
