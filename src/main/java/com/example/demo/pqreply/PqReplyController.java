package com.example.demo.pqreply;


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

import com.example.demo.pquestion.PquestionService;

@RestController
public class PqReplyController {
	
	@Autowired
	private PqRepService service;

	@Autowired
	private PquestionService pqService;
	
	
		private final Logger log = LoggerFactory.getLogger(this.getClass());
		

		/**
		 * JSON방식의 데이터만 처리하고, 문자열을 반환
		 * @param r : JSON데이터를 pqreply타입으로 변환하도록 지정
		 * @return : 성공 여부인 String 타입
		 */
		@PostMapping(value= "/pqrep/write",
				consumes = "application/json",
				produces = {MediaType.TEXT_PLAIN_VALUE })
		public ResponseEntity<String> write(@RequestBody PqReply pq) {
			int insertCount = service.addPqReply(pq);
			log.info("insertCount : " + insertCount);
			
			//성공적으로 이루어졌으면 답변 상태 바꾸기
//			if(insertCount == 1) {
//			HashMap<String, Object> map = new HashMap<>();
//			map.put("pqnum", pq.getPqnum());
//			map.put("state", "답변완료");
//			pqService.changeState(map);
//			}
//
			return insertCount ==1 
			? new ResponseEntity<>("success", HttpStatus.OK) 
			: new ResponseEntity<> (HttpStatus.INTERNAL_SERVER_ERROR);
		}

		/**
		 * 댓글의 목록을 JSON으로 반환하는 기능
		 * @param pqnum : pqreply의 번호
		 * @return List<pqreply>, Http상태코드
		 */
		@GetMapping(value = "/pqrep/plist/{pqnum}",
				produces = {MediaType.APPLICATION_XML_VALUE,
							MediaType.APPLICATION_JSON_VALUE})
		public ResponseEntity<List<PqReply>> list(@PathVariable("pqnum") int pqnum) {
			System.out.println("상품 문의 번호 : " + pqnum );
			return new ResponseEntity<>(service.getPqReplyByPqNum(pqnum), HttpStatus.OK);
		}

		/**
		 * PUT 또는 PATCH 방식으로 요청을 받아 댓글을 수정하는 기능 제공
		 * @param pq : 수정할 댓글 내용을 JSON으로 받아와 필요한 객체로 변환
		 * @param num : 댓글 번호
		 * @return HTTP 상태코드
		 */
		@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
				value = "/pqrep/edit/{pqnum}",
				consumes = "application/json",
				produces = {MediaType.TEXT_PLAIN_VALUE})
		public ResponseEntity<String> edit(
				@RequestBody PqReply pq,
				@PathVariable("pqnum") int pqnum) {
			return service.editPqReply(pq) == 1 
					? new ResponseEntity<>("success", HttpStatus.OK)
					: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

		
		/**
		 * 댓글 삭제 기능 
		 * @param num : 삭제할 댓글 번호
		 * @return HTTP 상태코드
		 */
		@DeleteMapping(value = "/pqrep/del/{num}", 
				produces = MediaType.TEXT_PLAIN_VALUE)
		public ResponseEntity<String> del(@PathVariable("num") int pqnum) {
			log.info("pqreplyController del");
			return service.delPqReply(pqnum) == 1 
					? new ResponseEntity<>("success", HttpStatus.OK)
					: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
  
		/**
		 * 번호에 해당하는 댓글 가져오기
		 * 댓글을 눌렀을때 해당 데이터를 모달창에 띄우게 하기 위해 사용
		 * @param num : 해당 댓글 번호
		 * @return JSON타입의 pqreply, HTTP상태코드
		 */
		@GetMapping(value = "pqrep/get/{pqnum}",
				produces = MediaType.APPLICATION_JSON_VALUE)
		public ResponseEntity<PqReply> get(@PathVariable("pqnum") int pqnum){
			
			return new ResponseEntity<PqReply>(service.getPqReply(pqnum), HttpStatus.OK);
		}
	}

     
	
	
	
