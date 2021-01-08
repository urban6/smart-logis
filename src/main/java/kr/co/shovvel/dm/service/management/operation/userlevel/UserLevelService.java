package kr.co.shovvel.dm.service.management.operation.userlevel;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;

import kr.co.shovvel.dm.dao.management.operation.userlevel.UserLevelMapper;
import kr.co.shovvel.dm.domain.management.operation.menu.Menu;
import kr.co.shovvel.dm.domain.management.operation.userlevel.AuthMenuDomain;
import kr.co.shovvel.dm.domain.management.operation.userlevel.UserLevelDomain;
import kr.co.shovvel.dm.domain.management.operation.userlevel.UserLevelDomainVO;
import kr.co.shovvel.dm.domain.management.operation.usermanage.UserManageDomain;
import kr.co.shovvel.dm.domain.management.operation.usermanage.UserManageDomainVO;
import kr.co.shovvel.dm.util.EncryptUtil;
import kr.co.shovvel.dm.util.StringUtil;
import net.sf.ehcache.Cache;
import net.sf.ehcache.Ehcache;

@Service
public class UserLevelService {
	@Autowired
	private UserLevelMapper	userLevelMapper;

	@Autowired
	private Ehcache			ehcache;

	public List<UserLevelDomainVO> listUserLevel( String userLevelId ) {
		return userLevelMapper.listUserLevel(userLevelId);
	}
	
/*	public List<UserLevelDomain> listUser( UserLevelDomain userLevelDomain  ) {
		return userLevelMapper.listUser(userLevelDomain);
	}*/
	
	public List<UserLevelDomain> listUser( UserLevelDomain userLevelDomain , int page , int perPage ) {
		int	start	= ((page - 1) * perPage);
		int	end		= perPage;

		return userLevelMapper.listUser(userLevelDomain , start , end);
	}
	
	
	
	//권한추가시 메뉴 리스트 조회
	public List<Map<String, Object>> UserMenuList( String level_id) {
		return userLevelMapper.UserMenuList(level_id);
	}
	
	//권한 정보 조회
	public List<UserLevelDomain> listUserDetail( String level_id  ) {
		return userLevelMapper.listUserDetail(level_id);
	}
	
	//권한별 상세 메뉴 리스트 조회
	public List<Map<String, Object>> UserMenuDetailList( String level_id) {
		return userLevelMapper.UserMenuDetailList(level_id);
	}
	
	
	
	
	@Transactional
	public void insert( UserLevelDomain userLevelDomain ) {

		//List<AuthMenuDomain> authMenuInsList = null;
		
		//menu1Depth.MENU_ID}|${menu1Depth.DISPLAY_ORDER}|${menu1Depth.UP_MENU_ID}|${menu1Depth.DEPTH
		int i= 0;
		
		String[] str_data = userLevelDomain.getChk_use().split(",");
		
		//menu_level_remove
		
		//ONC_COM_USER_LEVEL  inser 후 max level_id 값 조회
		
		
		try {
		
		List<UserLevelDomain> user_level =  userLevelMapper.selectLevel(userLevelDomain.getNew_menu_name());
		
		if(  user_level.size() < 1 ) {
			
			userLevelMapper.insertUserLevel(userLevelDomain.getNew_menu_name(), userLevelDomain.getNew_menu_path() );
			
			List<UserLevelDomain> user_level_chk =  userLevelMapper.selectLevel(userLevelDomain.getNew_menu_name());
			
			userLevelMapper.removeAuthMenuLevel(user_level_chk.get(0).getLevelId());
			
			for(int p=0; p<str_data.length; ) {
				userLevelMapper.insUserLevel(str_data[p], user_level_chk.get(0).getLevelId());
				p++;
			}
		}
		
		Cache menuCache = ehcache.getCacheManager().getCache("menuCache");
		menuCache.removeAll();
		
		} catch (Exception e) {
			throw new RuntimeException("PUSH ERROR, " + e.getMessage());
		}
		
	}
	
	
	

	@Transactional
	public String modify( UserLevelDomain userLevelDomain ) {

		//List<AuthMenuDomain> authMenuInsList = null;
		
		//menu1Depth.MENU_ID}|${menu1Depth.DISPLAY_ORDER}|${menu1Depth.UP_MENU_ID}|${menu1Depth.DEPTH
		int i= 0;
		
		String message = "";
		
		
		String[] str_data = userLevelDomain.getChk_use().split(",");
		
		userLevelMapper.removeAuthMenuLevel(userLevelDomain.getLevel_id());
		
		userLevelMapper.modifyLevelTitle(userLevelDomain);
		
		for(int p=0; p<str_data.length; ) {
			userLevelMapper.insUserLevel(str_data[p], userLevelDomain.getLevel_id());
			p++;
		}
		
		
		Cache menuCache = ehcache.getCacheManager().getCache("menuCache");
		menuCache.removeAll();
		
		return message;
	}
	
	

	@Transactional
	public String dupLevelTitle( UserLevelDomain userLevelDomain  ) {
		try {
			// 권한이 중복된 것이 존재하는 경우
			
System.out.println("###############=:" + userLevelDomain );
			
			int dupCnt  = 0;
			
			 dupCnt = userLevelMapper.dupLevelTitle(userLevelDomain);

System.out.println("###############=:" + dupCnt );
			 
			// 변경할 자료의 건수가 1건인 경우만 수정
			if ( dupCnt == 1 ) {

				return "Fail";
			} else {
				return "succ";
			}
		} catch ( Exception ex ) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}

	
	
	@Transactional
	public String dupModifyLevelTitle( UserLevelDomain userLevelDomain  ) {
		try {
			// 권한이 중복된 것이 존재하는 경우
			
System.out.println("###############=:" + userLevelDomain );
			
			int dupCnt  = 0;
			
			 dupCnt = userLevelMapper.dupModifyLevelTitle(userLevelDomain);

System.out.println("###############=:" + dupCnt );
			 
			// 변경할 자료의 건수가 1건인 경우만 수정
			if ( dupCnt == 1 ) {

				return "Fail";
			} else {
				return "succ";
			}
		} catch ( Exception ex ) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}

	
	
	
	
	
	
	
	

	public List<Menu> getMenu() {
		return userLevelMapper.getMenu();
	}

	public List<Menu> getAuthMenu( String levelId ) {
		return userLevelMapper.getAuthMenu(levelId);
	}

	public int count( UserLevelDomain userLevelDomain ) {
		return userLevelMapper.count(userLevelDomain);
	}

	public List<UserLevelDomain> list( UserLevelDomain userLevelDomain , int page , int perPage ) {
		int	start	= ((page - 1) * perPage);
		int	end		= perPage;

		return userLevelMapper.list(userLevelDomain , start , end);
	}

	public UserLevelDomain detail( UserLevelDomain userLevelDomain ) {
		return userLevelMapper.detail(userLevelDomain);
	}

	@Transactional
	public void modifyAction( UserLevelDomain userLevelDomain ) {

		// json -> List<UserAuthDomain> 파싱
		Gson					gson			= new Gson();
		JsonParser				parser			= new JsonParser();

System.out.println("@111@=:" +userLevelDomain.getAuthMenuArr() )	;

		JsonArray				jsonArray		= (JsonArray) parser.parse(userLevelDomain.getAuthMenuArr());
		
System.out.println("@1@");		
		
		List<AuthMenuDomain>	authMenuList	= gson.fromJson(jsonArray , new TypeToken<List<AuthMenuDomain>>() {
												}.getType());
System.out.println("@2@")	;

		// userLevel 수정
		userLevelMapper.modifyAction(userLevelDomain);

		// 해당 레벨의 authMenu remove
		userLevelMapper.removeAuthMenu(userLevelDomain);

		// 해당 레벨의 authMenu insert
		if ( authMenuList != null ) {
			for ( int i = 0 ; i < authMenuList.size() ; i++ ) {
				userLevelMapper.addAuthMenu(authMenuList.get(i));
			}
		}
		Cache menuCache = ehcache.getCacheManager().getCache("menuCache");
		menuCache.removeAll();
	}

	@Transactional
	public void addAction( UserLevelDomain userLevelDomain ) {
		// json -> List<UserAuthDomain> 파싱
		Gson					gson			= new Gson();
		JsonParser				parser			= new JsonParser();
		
System.out.println("@111@=:" +userLevelDomain.getAuthMenuArr() )	;
		
		JsonArray				jsonArray		= (JsonArray) parser.parse(userLevelDomain.getAuthMenuArr());


		
		List<AuthMenuDomain>	authMenuList	= gson.fromJson(jsonArray , new TypeToken<List<AuthMenuDomain>>() {
												}.getType());

		// userLevel add
		userLevelMapper.addAction(userLevelDomain);
		// 해당 레벨의 authMenu insert
		if ( authMenuList != null ) {
			for ( int i = 0 ; i < authMenuList.size() ; i++ ) {
				authMenuList.get(i).setLevel_id(userLevelDomain.getLevel_id());
				userLevelMapper.addAuthMenu(authMenuList.get(i));
			}
		}
		Cache menuCache = ehcache.getCacheManager().getCache("menuCache");
		menuCache.removeAll();
	}

	@Transactional
	public String removeAction( UserLevelDomain userLevelDomain ) {
		try {
			
			
			List<Map<String, Object>>  userSno = userLevelMapper.selUserLevel(userLevelDomain);
			
			int userCnt = userLevelMapper.userCntOfLevel(userLevelDomain);
			
			
			if ( userCnt == 0 ) {
				userLevelMapper.removeAction(userLevelDomain);
				userLevelMapper.removeAuthMenu(userLevelDomain);
				
				if(userSno.size() > 0) {
				
					for( int k=0; k< userSno.size(); k++) {
						
						userLevelMapper.updateUserLevel(userSno.get(k).get("USER_SNO").toString());
						
					}
					
				}
				
				
				//userLevelMapper.updateUserLevel(userLevelDomain);
				
				return "succ";
			} else {
				return "fail";
			}
		} catch ( Exception ex ) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			ex.printStackTrace();
			return ex.getMessage();
		}
	}

	public int duplChkLevelName( String levelName ) {
		return userLevelMapper.duplChkLevelName(levelName);
	}

}
