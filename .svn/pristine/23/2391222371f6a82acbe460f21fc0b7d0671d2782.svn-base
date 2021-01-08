package kr.co.shovvel.dm.dao.common;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import kr.co.shovvel.dm.domain.common.CommonCode;
import kr.co.shovvel.dm.domain.common.CommonCondition;

@Component
public interface CommonCodeMapper {
	
	String getNowDateTime(@Param(value="language")String language);
	String getNowDateTimeFromCommonCondition(CommonCondition commonCondition);
	String getAddDateTime(@Param(value="addDate")String addDate, @Param(value="language")String language);
	String getNowDateTimeFormat(@Param(value="language")String language);
	String getNowDate(@Param(value="language") String language);
	String getNowHour();
	String getNowMin();
	String getSysDate(@Param(value = "format") String format);
	String getSysDateTypeII(@Param(value = "format") String format, @Param(value = "startPos") int startPos, @Param(value = "length") int length);
	
	List<CommonCode> getCodeList(CommonCode commonCode);
	CommonCode getCode(CommonCode commonCode);
	List<Map<String, String>> getCodeListMap(CommonCode commonCode);
	List<Map<String, String>> getCodeMap(CommonCode commonCode);
	
}

