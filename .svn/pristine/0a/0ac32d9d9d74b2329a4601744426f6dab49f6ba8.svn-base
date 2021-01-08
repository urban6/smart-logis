package kr.co.shovvel.dm.dao.management.operation.loginhist;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import kr.co.shovvel.dm.domain.management.operation.loginhist.Condition;
import kr.co.shovvel.dm.domain.management.operation.loginhist.LoginHistDomain;

@Component
public interface LoginHistMapper {

	List<Map<String, String>> listUserGroup();

	List<Map<String, String>> listUserLevel( @Param( value = "userLevelId" ) String userLevelId );

	int count( @Param( value = "condition" ) Condition condition );

	List<LoginHistDomain> list( @Param( value = "condition" ) Condition condition , @Param( value = "start" ) int start , @Param( value = "end" ) int end );

	int insertLoginHistory( @Param( "condition" ) LoginHistDomain loginHistDomain );

	int updateLoginHistory( @Param( "condition" ) LoginHistDomain loginHistDomain );
}
