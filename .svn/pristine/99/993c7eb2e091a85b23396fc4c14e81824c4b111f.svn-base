package kr.co.shovvel.dm.service.management.operation.menu;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import kr.co.shovvel.dm.dao.management.operation.menu.MenuMapper;
import kr.co.shovvel.dm.domain.management.operation.menu.Menu;
import kr.co.shovvel.dm.domain.management.operation.menu.MenuVO;
import kr.co.shovvel.dm.util.StringUtil;
import net.sf.ehcache.Cache;
import net.sf.ehcache.Ehcache;

@Service
public class MenuService {
	@Autowired
	private MenuMapper	menuMapper;

	@Autowired
	private Ehcache		ehcache;

	public List< MenuVO > listAuthorizationMenu( String userLevel ) {
		return menuMapper.listAuthorizationMenu( userLevel );
	}

	public List< MenuVO > listAllMenu() {
		return menuMapper.listAllMenu();
	}

	public List< MenuVO > listMenu() {
		return menuMapper.listMenu();
	}

	public Menu getMenu( Integer menu_id ) {
		return menuMapper.getMenu( menu_id );
	}

	public String getStartMenu( String userLevel ) {
		return menuMapper.getStartMenu( userLevel );
	}

	public int getNewMenuId( Menu menu ) {
		return menuMapper.getNewMenuId( menu );
	}

	@Transactional
	public boolean insert( Menu menu ) {
		int		i			= menuMapper.insert( menu );
		Cache	menuCache	= ehcache.getCacheManager().getCache( "menuCache" );
		menuCache.removeAll();
		return (i > 0);
	}

	@Transactional
	public boolean update( Menu menu ) {
		int		i			= menuMapper.update( menu );
		Cache	menuCache	= ehcache.getCacheManager().getCache( "menuCache" );
		menuCache.removeAll();
		return (i > 0);
	}

	@Transactional
	public boolean delete( Integer menu_id ) {
		menuMapper.deleteUserAuth( menu_id ); // 메뉴삭제 전 권한부터 삭제.
		int		i			= menuMapper.delete( menu_id );
		Cache	menuCache	= ehcache.getCacheManager().getCache( "menuCache" );
		menuCache.removeAll();
		return (i > 0);
	}

	/*
	 * public List<Menu> list(String package_id) { return
	 * menuMapper.list(package_id); }
	 */

	public List< Menu > list() {
		return menuMapper.list();
	}

	@Transactional
	public boolean addMenu( Menu menu ) {
		menu.setUpMenuId( 0 );
		menu.setMenuPath( menu.getMenuPathNew() );
		menu.setMenuName( menu.getMenuNameNew() );

		int		i			= menuMapper.addMenu( menu );
		Cache	menuCache	= ehcache.getCacheManager().getCache( "menuCache" );
		menuCache.removeAll();
		return (i > 0);
	}

	@Transactional
	public boolean modify( Menu menu ) {
		boolean result = false;

		try {
//			System.out.println( "menuModifyList=" + menu.getMenuList() );

			setModifyMenuList( menu.getMenuList() );

			Cache menuCache = ehcache.getCacheManager().getCache( "menuCache" );
			menuCache.removeAll();

			result = true;
		} catch ( Exception e ) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
		}
		return result;
	}

	private boolean setModifyMenuList( List< Menu > menuList ) throws Exception {
		boolean	result	= false;

		int		i		= 0;
		for ( Menu menuOfList : menuList ) {
			System.out.println( "\tsetMenuListModify[" + i + "]=" + menuOfList );

			setModifyMenu( menuOfList );

			if ( menuOfList.getMenuList().size() > 0 ) {
				setModifyMenuList( menuOfList.getMenuList() );
			}
			i++;
		}

		return result;
	}

	private boolean setModifyMenu( Menu menu ) throws Exception {
		boolean result = false;

		System.out.println( "\t\tsetMenuModify[" + menu.getDepth() + "]=" + menu );

		menuMapper.modify( menu );
		menuMapper.modifyLevel( menu );

		return result;
	}

}
