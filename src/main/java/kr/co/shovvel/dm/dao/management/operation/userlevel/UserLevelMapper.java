package kr.co.shovvel.dm.dao.management.operation.userlevel;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import kr.co.shovvel.dm.domain.management.operation.menu.Menu;
import kr.co.shovvel.dm.domain.management.operation.userlevel.AuthMenuDomain;
import kr.co.shovvel.dm.domain.management.operation.userlevel.UserLevelDomain;
import kr.co.shovvel.dm.domain.management.operation.userlevel.UserLevelDomainVO;

@Component
public interface UserLevelMapper {

	List<UserLevelDomainVO> listUserLevel( @Param( value = "userLevelId" ) String userLevelId );
	
	//List<UserLevelDomain> listUser( @Param( value = "condition" ) UserLevelDomain userLevelDomain );
	
	
	List<UserLevelDomain> listUser( @Param( "condition" ) UserLevelDomain userLevelDomain , @Param( "start" ) int start , @Param( "end" ) int end );
	
	
	List<UserLevelDomain> listUserDetail( @Param( value = "level_id" ) String level_id );
	
	List<Map<String, Object>> UserMenuList( @Param( value = "level_id" ) String level_id );
	
	List<Map<String, Object>> UserMenuDetailList( @Param( value = "level_id" ) String level_id );
	
	
	
	int removeAuthMenuLevel( @Param( value = "level_id" ) String level_id );
	
	int insUserLevel( @Param( value = "menu_id" ) String menu_id , @Param( value = "level_id" ) String level_id);
	
	
	int dupLevelTitle( @Param( value = "condition" ) UserLevelDomain userLevelDomain );

	int dupModifyLevelTitle( @Param( value = "condition" ) UserLevelDomain userLevelDomain );
	
	
	
	
	int insertUserLevel( @Param( value = "menu_name" ) String menu_name , @Param( value = "description" ) String description);
	
	List<UserLevelDomain> selectLevel( @Param( value = "menu_name" ) String menu_name );
	
	
	

	List<Menu> getMenu();

	List<Menu> getAuthMenu( @Param( value = "levelId" ) String levelId );

	int count( @Param( value = "condition" ) UserLevelDomain userLevelDomain );

	List<UserLevelDomain> list( @Param( "condition" ) UserLevelDomain userLevelDomain , @Param( "start" ) int start , @Param( "end" ) int end );

	List<UserLevelDomain> listNoPage( @Param( "condition" ) UserLevelDomain userLevelDomain );

	UserLevelDomain detail( @Param( value = "condition" ) UserLevelDomain userLevelDomain );

	int modifyAction( @Param( value = "condition" ) UserLevelDomain userLevelDomain );
	
	int modifyLevelTitle( @Param( value = "condition" ) UserLevelDomain userLevelDomain );
	
	
	int updateUserLevel( @Param( value = "userSno" ) String userSno );
	

	int removeAuthMenu( @Param( value = "condition" ) UserLevelDomain userLevelDomain );
	

	int addAuthMenu( @Param( value = "condition" ) AuthMenuDomain authMenuDomain );
	

	int addAction( UserLevelDomain userLevelDomain );

	int userCntOfLevel( UserLevelDomain userLevelDomain );

	void removeAction( UserLevelDomain userLevelDomain );

	int duplChkLevelName( @Param( value = "levelName" ) String levelName );

	
	List<Map<String, Object>> selUserLevel( @Param( value = "condition" ) UserLevelDomain userLevelDomain );
	
	
}
