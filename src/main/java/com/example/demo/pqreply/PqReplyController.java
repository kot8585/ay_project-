package com.example.demo.pqreply;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.pquestion.PquestionService;

@RestController
public class PqReplyController {
	@Autowired
	private PqRepService service;

	@Autowired
	private PquestionService pqService;
	
	
}
	
	
	
