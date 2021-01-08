package kr.co.shovvel.dm.dao.management.operation.menu;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import kr.co.shovvel.dm.domain.management.operation.menu.Menu;
import kr.co.shovvel.dm.domain.management.operation.menu.MenuVO;

@Component
public interface MenuMapper {

	List< MenuVO > listAllMenu();

	/**
	 *
	 * <PRE>
	 * 1. MethodName: listAuthorizationMenu
	 * 2. ClassName : MenuMapper
	 * 3. Comment   : 권한별 메뉴 조회
	 * 4. 작성자    : hancheonsu
	 * 5. 작성일    : 2016. 3. 17. 오후 3:19:11
	 * </PRE>
	 *
	 * @return List<Map<String,Object>>
	 * @param userSno
	 * @return
	 */
	List< MenuVO > listAuthorizationMenu( @Param( value = "userLevel" ) String userLevel );

	List< MenuVO > listMenu();

	Menu getMenu( Integer menu_id );

	String getStartMenu( String userLevel );

	int getNewMenuId( Menu menu );

	int insert( Menu menu );

	int update( Menu menu );

	int delete( Integer menuId );

	int deleteUserAuth( Integer menuId );

	List< Menu > list();

	/**
	 * 메뉴 정보 추가
	 *
	 * @param menu
	 * @return
	 */
	int addMenu( Menu menu );

	/**
	 * 메뉴 전보 업데이트
	 *
	 * @param menu
	 * @return
	 */
	int modify( Menu menu );

	/**
	 * 메뉴에 대한 권한 정보 업데이트
	 *
	 * @param menu
	 * @return
	 */
	int modifyLevel( Menu menu );

}
