package kr.co.shovvel.dm.dao.common.listener;

import java.util.List;

import org.springframework.stereotype.Component;

import kr.co.shovvel.dm.domain.common.listener.SessionListenerDomain;

@Component
public interface SessionListenerMapper {
	
	int deleteUserSession(SessionListenerDomain sessionListenerDomain);
	
	int updateUserLoginCount(SessionListenerDomain sessionListenerDomain);
	
	List<SessionListenerDomain> selectLoginHistInfo(SessionListenerDomain sessionListenerDomain);
	
	int updateLogoutResult(SessionListenerDomain sessionListenerDomain);
}

