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
/*
 * ajax통신으로만 qna의 댓글 처리
 */
@RestController
public class ReplyController {
	@Autowired
	private RepService service;

	@Autowired
	private QnaService qnaService;
	
	private final Logger log = LoggerFactory.getLogger(this.getClass());
	
	/*
	 * JSON방식의 데이터만 처리하고, 문자열을 반환
	 * @RequestBody: JSON데이터를 Reply타입으로 변환하도록 지정
	 */
	@PostMapping(value= "/rep/write",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> write(@RequestBody Reply r) {
		int insertCount = service.addReply(r);
		log.info("insertCount : " + insertCount);
		//성공적으로 이루어졌으면 댓글 상태 바꾸기
		if(insertCount == 1) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("num", r.getQna_num());
		map.put("state", "답변완료");
		qnaService.changeState(map);
		}

		return insertCount ==1 
		? new ResponseEntity<>("success", HttpStatus.OK)
		: new ResponseEntity<> (HttpStatus.INTERNAL_SERVER_ERROR);
	}

	// 댓글 목록
	@GetMapping(value = "/rep/list/{qna_num}",
			produces = {MediaType.APPLICATION_XML_VALUE,
						MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<Reply>> list(@PathVariable("qna_num") int qna_num) {
		return new ResponseEntity<>(service.getReplyByQnaNum(qna_num), HttpStatus.OK);
	}

	//댓글 수정 - 안됌
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
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

	
	//댓글 삭제 - 안됌
	@DeleteMapping(value = "/rep/del/{num}", 
			produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> del(@PathVariable("num") int num) {
		log.info("ReplyController del");
		return service.delReply(num) == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "rep/get/{num}",
			produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Reply> get(@PathVariable("num") int num){
		
		return new ResponseEntity<Reply>(service.getReply(num), HttpStatus.OK);
	}
}
