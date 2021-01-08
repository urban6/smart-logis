package kr.co.shovvel.dm.listener;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import kr.co.shovvel.dm.common.Consts;
import kr.co.shovvel.dm.domain.common.Result;
import kr.co.shovvel.dm.domain.common.PrevSessionUser;
import kr.co.shovvel.dm.domain.common.listener.SessionListenerDomain;
import kr.co.shovvel.dm.service.common.listener.SessionListenerService;

@Component
public class SessionListener implements HttpSessionListener {

	private Logger logger = Logger.getLogger(this.getClass());
	
	private SessionListenerService sessionListenerService;
	
	@Autowired
	public void setSessionListenerService(SessionListenerService sessionListenerService) {
		this.sessionListenerService = sessionListenerService;
	}
	
	public void sessionCreated(HttpSessionEvent hse) {}

	public void sessionDestroyed(HttpSessionEvent hse) {
        
    	 HttpSession session= hse.getSession();
    	 
         PrevSessionUser user 	= (PrevSessionUser)session.getAttribute(Consts.USER.SESSION_USER);
         if( user != null ) {
        	 userCloseHistory(user, session.getId());
         }
    }
	
	private void userCloseHistory(PrevSessionUser sessionUser, String sessionId) {
			
		logger.debug("===================CLOSE SESSION===========================");
		
		try {
			logger.debug( "userSno : " + sessionUser.getUserSno() );
			logger.debug( "userLoginDate : " + sessionUser.getUserLoginDate()  );
			logger.debug( "loginGatewayIp : " + sessionUser.getUserIpAddress() );
			logger.debug( "session_id : " + sessionId );
			
			SessionListenerDomain sessionListenerDomain = new SessionListenerDomain();
			sessionListenerDomain.setUser_sno(sessionUser.getUserSno());
			sessionListenerDomain.setSessionId(sessionId);
			sessionListenerDomain.setLogin_date(sessionUser.getUserLoginDate());
			if(sessionListenerService == null) {
				logger.debug("sessionListenerService IS NULL");
			}
			Result result = sessionListenerService.deleteUserSession(sessionListenerDomain);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		logger.debug("===================CLOSE SESSION LOGGING===================");

	}
}
