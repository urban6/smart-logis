package kr.co.shovvel.dm.service.common.listener;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import kr.co.shovvel.dm.common.Consts;
import kr.co.shovvel.dm.common.DMConstants;
import kr.co.shovvel.dm.dao.common.listener.SessionListenerMapper;
import kr.co.shovvel.dm.domain.common.Result;
import kr.co.shovvel.dm.domain.common.listener.SessionListenerDomain;

@Service
public class SessionListenerService {
	private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private SessionListenerMapper sessionListenerMapper;
    
    
    @Transactional
	public Result deleteUserSession(SessionListenerDomain sessionListenerDomain) {
    	logger.debug("sessionListenerDomain = " + sessionListenerDomain.toString());
    	Result result = new Result();
    	try {
    		int nCount = sessionListenerMapper.deleteUserSession(sessionListenerDomain);
			
    		if(nCount > 0) {
    			
    			sessionListenerMapper.updateUserLoginCount(sessionListenerDomain);
    			List<SessionListenerDomain> sessionListenerDomainList = sessionListenerMapper.selectLoginHistInfo(sessionListenerDomain);

				for(int i = 0; i < sessionListenerDomainList.size(); i++) {
					SessionListenerDomain sessionListenerDomainLogoutResult = sessionListenerDomainList.get(i);
					
					String logoutResult = sessionListenerDomainLogoutResult.getLogout_result();					
					if( logoutResult == null || logoutResult.equals(Consts.EMPTY_STRING)) {
						
						sessionListenerMapper.updateLogoutResult(sessionListenerDomainLogoutResult);
					}
				}
    		}
    		
    		result.setResult(DMConstants.Result.OK);
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			
			result.setResult(DMConstants.Result.FAIL);
			result.setMessage(e.getMessage());
		}
    	
    	return result;
	}
}
