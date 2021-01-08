package kr.co.shovvel.dm.service.management.operation.loginhist;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.shovvel.dm.dao.management.operation.loginhist.LoginHistMapper;
import kr.co.shovvel.dm.domain.management.operation.loginhist.Condition;
import kr.co.shovvel.dm.domain.management.operation.loginhist.LoginHistDomain;

@Service
public class LoginHistService {

	@Autowired
	private LoginHistMapper loginHistMapper;

	public List<Map<String, String>> listUserGroup() {
		return loginHistMapper.listUserGroup();
	}

	public List<Map<String, String>> listUserLevel( String userLevelId ) {
		return loginHistMapper.listUserLevel(userLevelId);
	}

	public int count( Condition condition ) {
		return loginHistMapper.count(condition);
	}

	public List<LoginHistDomain> list( Condition condition , int page , int perPage ) {
		int						start	= ((page - 1) * perPage);
		int						end		= perPage;
		List<LoginHistDomain>	list	= loginHistMapper.list(condition , start , end);

		return list;
	}
}
