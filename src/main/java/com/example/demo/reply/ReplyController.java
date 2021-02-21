package com.example.demo.reply;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.qna.QnaService;

@Controller
public class ReplyController {
	@Autowired
	private RepService service;

	@Autowired
	private QnaService qnaService;
	
	@RequestMapping("/admin/rep/write")
	public String write(Reply r) {
		service.addReply(r);
		//성공적으로 이루어졌으면 댓글 상태 바꾸기
		HashMap<String, Object> map = new HashMap<>();
		map.put("num", r.getQna_num());
		map.put("state", "답변완료");
		qnaService.changeState(map);
		
		return "redirect:/rep/list?qna_num=" + r.getQna_num();
	}

	// 댓글 목록
	@ResponseBody
	@RequestMapping(value = "/rep/list")
	public List<Reply> list(int qna_num) {
		return service.getReplyByQnaNum(qna_num);
	}

	//댓글 수정 - 안됌
	@RequestMapping("/rep/edit")
	public void edit(int board_num) {
	}

	
	//댓글 삭제 - 안됌
	@RequestMapping(value = "/rep/del", method = RequestMethod.POST)
	public Map<String, Object> del(int num) {

		Map<String, Object> result = new HashMap<>();

		service.delReply(num);
		try {
			service.delReply(num);
			result.put("status", "OK");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "False");
		}
		return result;
	}
}
