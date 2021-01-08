package kr.co.shovvel.dm.service.management.map;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import kr.co.shovvel.dm.dao.management.map.LctInfo;
import kr.co.shovvel.dm.domain.management.login.LoginDomain;
import kr.co.shovvel.dm.domain.management.map.LctDomain;
import kr.co.shovvel.dm.domain.management.map.LctVO;

@Service
public class MapService {
	private Logger 				logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private LctInfo				lctInfo;
	
	
	public LctDomain getLocation() {
		LctDomain lct = lctInfo.getLocation();
		return lct;
	}
	
	public LoginDomain getLoginTest() {
		return lctInfo.searchUserInfo("6");
	}
}
