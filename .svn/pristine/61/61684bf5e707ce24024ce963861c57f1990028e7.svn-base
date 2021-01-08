package kr.co.shovvel.dm.service.common;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.shovvel.dm.dao.common.CommonMapper;
import kr.co.shovvel.dm.domain.common.CommonDomain;

@Service
public class CommonService {
	@Autowired
	private CommonMapper commonMapper;

//	public Map<String, Object> findLocalePattern(String language) {
//		return commonMapper.findLocalePattern(language);
//	}
//	
//	public Map<String, Object> findLocaleLanguage(String language) {
//		return commonMapper.findLocaleLanguage(language);
//	}
	
	public Map<String, Object> findMenuName(String url, String userSno) {
		return commonMapper.findMenuName(url, userSno);
	}
	
	public String getUserLevelId(String userSno) {
		return commonMapper.getUserLevelId(userSno);
	}
	
	@Transactional
	public int addRecent(Map<String, Object> map) {
		return commonMapper.addRecent(map);
	}
	
	@Transactional
	public int removeRecent(Map<String, Object> map) {
		return commonMapper.removeRecent(map);
	}
	
	public List<Map<String, Object>> findRecent(String userSno) {
		return commonMapper.findRecent(userSno);
	}
	
	public List<Map<String, String>> groupList() {
		return commonMapper.groupList();
	}
	
	public String getNowDateTime(String language){
		return commonMapper.getNowDateTime(language);
	}
	
	public String getNowDate(String language){
		return commonMapper.getNowDate(language);
	}
	public String getNowHour(){
		return commonMapper.getNowHour();
	}
	public String getNowMin(){
		return commonMapper.getNowMin();
	}
		
	public List<CommonDomain> getCodeList(CommonDomain commonDomain) {
		return commonMapper.getCodeList(commonDomain);
	}
	public List<Map<String, String>> getCodeListMap(CommonDomain commonDomain){
		return commonMapper.getCodeListMap(commonDomain);
	}
	
	
	public String  schedule(){
		return commonMapper.schedule();
	}
	
		
}
