package kr.co.shovvel.dm.service.common;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.shovvel.dm.dao.common.CommonCodeMapper;
import kr.co.shovvel.dm.domain.common.CommonCode;
import kr.co.shovvel.dm.domain.common.CommonCondition;


@Service
public class CommonCodeService {
	
	@Autowired
	public CommonCodeMapper commonCodeMapper;
	
	public String getNowDateTime(String language){
		return commonCodeMapper.getNowDateTime(language);
	}

	public String getNowDateTime(CommonCondition commonCondition){
		return commonCodeMapper.getNowDateTimeFromCommonCondition(commonCondition);
	}
	
	public String getAddDateTime(String addDate,String language){
		return commonCodeMapper.getAddDateTime(addDate,language);
	}
	
	public String getNowDateTimeFormat(String language){
		return commonCodeMapper.getNowDateTimeFormat(language);
	}
	
	public String getNowDate(String language){
		return commonCodeMapper.getNowDate(language);
	}
	
	public String getNowHour(){
		return commonCodeMapper.getNowHour();
	}
	
	public String getNowMin(){
		return commonCodeMapper.getNowMin();
	}
	
	public String getSysDate(String format){
		return commonCodeMapper.getSysDate(format);
	}
	
	public List<CommonCode> getCodeList(CommonCode commonCode) {
		return commonCodeMapper.getCodeList(commonCode);
	}
	
	public List<Map<String, String>> getCodeListMap(CommonCode commonCode){
		return commonCodeMapper.getCodeListMap(commonCode);
	}
	
	public List<Map<String, String>> getCodeMap(CommonCode commonCode){
		return commonCodeMapper.getCodeMap(commonCode);
	}
	
}
