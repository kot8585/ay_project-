package com.example.demo.error;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * 에러 발생시 커스터마이징한 에러 페이지를 호출하기 위한 컨트롤러 
 * 2021-03-04 작성
 * @author 김평기
 *
 */
@Controller
public class CustomErrorController implements ErrorController{
	
	private static final String ERROR_PATH = "/error";
	
	@Override
	public String getErrorPath() {
		// TODO Auto-generated method stub
		return ERROR_PATH;
	}
	
	@RequestMapping("/error")
	public ModelAndView handleError(HttpServletRequest request) {
		Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
		HttpStatus httpStatus = HttpStatus.valueOf(Integer.valueOf(status.toString()));
		ModelAndView mav = new ModelAndView("error/error");
		mav.addObject("code", status.toString());
		mav.addObject("msg", httpStatus.getReasonPhrase());
		return mav;
	}
	
}
