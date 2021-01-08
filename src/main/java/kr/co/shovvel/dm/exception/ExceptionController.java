package kr.co.shovvel.dm.exception;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
@RequestMapping(value = "/exception")
public class ExceptionController {
	
	/**
	 * JSTL Exception 처리
	 * @return
	 */
	@RequestMapping(value = "jstlexception")
	public String jstlexception() throws Exception {
		return "exception/jstlexception";
	}
	
	/**
	 * JSTL Exception 처리
	 * @return
	 */
	@RequestMapping(value = "notfound")
	public String notfound(HttpServletRequest request) throws Exception {
		return "exception/notfound";
	}
	
	/**
	 * 자바 모든 Exception 처리
	 * @param e
	 * @return
	 */
	@ResponseStatus(value = HttpStatus.NOT_FOUND)
	@ExceptionHandler(value = {Exception.class, RuntimeException.class})
	public ModelAndView defaultErrorHandler(Exception e) {
		e.printStackTrace();
		ModelAndView mv = new ModelAndView("exception.controller"); //tiles name 선언
        mv.addObject("errorMsg", e);
        return mv;
	}
}
