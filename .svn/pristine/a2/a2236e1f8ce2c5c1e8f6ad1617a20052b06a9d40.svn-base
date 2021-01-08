package kr.co.shovvel.dm.interceptor;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.time.DateUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.co.shovvel.hcf.utils.ConfigurationUtil;

public class TimeoutInterceptor extends HandlerInterceptorAdapter {
	private Logger logger = Logger.getLogger(this.getClass());

	@Override
	public boolean preHandle(
			HttpServletRequest request,
			HttpServletResponse response,
			Object handler) throws Exception  {
		
		int timeoutMinute = getTimeoutMinute();
		
		//타임아웃 시간이 0이하의 경우 timeout을 사용하지 않음
		if(timeoutMinute <= 0){
			logger.debug("Not Use Timeout, timeoutMinute is " + timeoutMinute);

			return super.preHandle(request, response, handler);
		}			

		logger.debug( "request " + request.getRequestURI() );

		HttpSession session = request.getSession(true);
		
		//get now, expireDate
		Date nowDate = new Date();
		nowDate = DateUtils.addSeconds(nowDate, -1);
		Date expireDate = (Date)session.getAttribute("expireDate");
						
		// 현재시각이 expireDate를 지났다면
		// session invalidate, invalidate 된 후 다음 keepAlive 호출 때 로그인 페이지로 이동됨
		if(expireDate != null && nowDate.compareTo(expireDate) == 1){
			session.invalidate();
								
			return super.preHandle(request, response, handler);
		}
		
		return super.preHandle(request, response, handler);
	}

	@Override
	public void postHandle(
			HttpServletRequest request,
			HttpServletResponse response,
			Object handler,
			ModelAndView mv) throws Exception {
		
		super.postHandle(request, response, handler, mv);
	}

	@Override
	public void afterCompletion(
			 HttpServletRequest request,
			 HttpServletResponse response,
			 Object handler,
			 Exception ex) throws Exception {

		super.afterCompletion(request, response, handler, ex);
	}
	
	private int getTimeoutMinute(){
		return (new ConfigurationUtil()).getLoginSessionTimeout();
	}
}