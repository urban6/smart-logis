package kr.co.shovvel.dm.dao.common;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import kr.co.shovvel.dm.domain.common.CommonDomain;

@Component
public interface CommonMapper {
	
	Map<String, Object> findLocalePattern(@Param(value="locale")String locale);
	
	Map<String, Object> findLocaleLanguage(@Param(value="locale")String locale);
	
	Map<String, Object> findMenuName(@Param(value="url")String url, @Param(value="userSno")String userSno);
	
	String getUserLevelId(@Param(value="userSno") String userSno);
	
	int addRecent(Map<String, Object> map);
	
	int removeRecent(Map<String, Object> map);
	
	List<Map<String, Object>> findRecent(@Param(value="userSno")String userSno);

	List<Map<String, String>> groupList();
	
	
	String getNowDateTime(@Param(value="language")String language);
	String getNowDate(@Param(value="language") String language);
	String getNowHour();
	String getNowMin();
	
	List<CommonDomain> getCodeList(CommonDomain commonDomain);	
	List<Map<String, String>> getCodeListMap(CommonDomain commonCode);
	
	
	String schedule();
}
