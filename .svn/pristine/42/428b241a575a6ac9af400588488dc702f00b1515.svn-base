package kr.co.shovvel.dm.service.common.listener;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import kr.co.shovvel.dm.common.DMConstants;
import kr.co.shovvel.dm.dao.common.listener.StartupListenerMapper;
import kr.co.shovvel.dm.domain.common.Result;
import kr.co.shovvel.dm.domain.common.listener.StartupListenerDomain;

@Service
public class StartupListenerService {
	private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private StartupListenerMapper startupListenerMapper;
    
    @Transactional
	public Result deleteUserSession(StartupListenerDomain startupListenerDomain) {
    	Result result = new Result();
    	try {
    		
    		startupListenerDomain = startupListenerMapper.selectUserInfoByDeveloperId(startupListenerDomain);
    		startupListenerMapper.deleteUserSession(startupListenerDomain);
    		startupListenerMapper.updateLoginHistLogout(startupListenerDomain);
    		
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
