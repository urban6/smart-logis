package kr.co.shovvel.dm.dao.common.listener;

import org.springframework.stereotype.Component;

import kr.co.shovvel.dm.domain.common.listener.StartupListenerDomain;

@Component
public interface StartupListenerMapper {
	
	
	StartupListenerDomain selectUserInfoByDeveloperId(StartupListenerDomain startupListenerDomain);;
	int deleteUserSession(StartupListenerDomain startupListenerDomain);	
	int updateLoginHistLogout(StartupListenerDomain startupListenerDomain);
}

