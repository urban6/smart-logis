package kr.co.shovvel.dm.controller.management.operation.userlevel;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.shovvel.dm.common.Consts;
import kr.co.shovvel.dm.domain.common.PrevSessionUser;
import kr.co.shovvel.dm.domain.common.paging.Paging;
import kr.co.shovvel.dm.domain.management.operation.menu.Menu;
import kr.co.shovvel.dm.domain.management.operation.userlevel.UserLevelDomain;
import kr.co.shovvel.dm.domain.management.operation.usermanage.UserManageDomain;
import kr.co.shovvel.dm.service.common.CommonService;
import kr.co.shovvel.dm.service.management.operation.menu.MenuService;
import kr.co.shovvel.dm.service.management.operation.userlevel.UserLevelService;
import kr.co.shovvel.hcf.utils.PasingUtil;

@Controller
@RequestMapping( value = "/management/operation/userlevel" )
public class UserLevelController {
	private Logger				logger			= Logger.getLogger( this.getClass() );

	// menuList
	private List< Menu >		listMenu		= null;
	// menuAuthList
	private List< Menu >		listAuthMenu	= null;

	@Autowired
	private UserLevelService	userLevelService;
	private String				thisUrl			= "management/operation/userlevel";

	@Autowired
	private CommonService		commonService;

	@Autowired
	private MenuService			menuService;

	/**
	 * <PRE>
	 * 1. MethodName: list
	 * 2. ClassName : UserLevelController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2016. 4. 25. 오후 7:51:38
	 * </PRE>
	 *
	 * @return String
	 * @param userLevelDomain
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping( value = "list" , method = RequestMethod.POST )
	public String list( UserLevelDomain userLevelDomain , HttpSession session , Model model ) {
		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute( Consts.USER.SESSION_USER );
		userLevelDomain.setUserLevelId( sessionUser.getUserLevelId() );
		userLevelDomain.setLanguageClcd( sessionUser.getLanguageClcd() );

//		CommonDomain commonDomain = new CommonDomain();
//		commonDomain.setUpper_com_cd("50201000");
//		commonDomain.setLanguageClcd(userLevelDomain.getLanguageClcd());
//		model.addAttribute("partnerClcdList", commonService.getCodeListMap(commonDomain));

		model.addAttribute( "searchVal" , userLevelDomain );
		model.addAttribute( "listUserLevel" , userLevelService.listUserLevel( userLevelDomain.getUserLevelId() ) );

		return thisUrl + "/list";
	}

	/**
	 * <PRE>
	 * 1. MethodName: listAction
	 * 2. ClassName : UserLevelController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2016. 4. 25. 오후 8:08:48
	 * </PRE>
	 *
	 * @return String
	 * @param userLevelDomain
	 * @param page
	 * @param perPage
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping( value = "listAction" , method = RequestMethod.POST )
	public String listAction( UserLevelDomain userLevelDomain , HttpServletRequest request ,  HttpSession session , Model model ) throws Exception {
		// session
logger.info("userLevelDomain=:" + request.getParameter("page") );		
		
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute( Consts.USER.SESSION_USER );
		// session user level
		userLevelDomain.setUserLevelId( sessionUser.getUserLevelId() );
		userLevelDomain.setLanguageClcd( sessionUser.getLanguageClcd() );
		userLevelDomain.setZoneOffset( sessionUser.getZoneOffset() );

		userLevelDomain.setPartner_clcd_up( "50201000" );
		

		// paging
		Paging					paging	= new Paging();
		List< UserLevelDomain >	list	= null;
		List< UserLevelDomain >	listTot	= null;

		int						count	= 0;
		count = userLevelService.count( userLevelDomain );
		
		
		if(userLevelDomain.getPage() == null) {
			
			userLevelDomain.setPage(1);
			
		}
		
		logger.info("page1==" + userLevelDomain.getPage() );
		logger.info("page2==" + userLevelDomain.getPerPage()  );
		logger.info("page3==" + count );
		
		
		
		
		int page = PasingUtil.getPage( userLevelDomain.getPage() , userLevelDomain.getPerPage() , count );
		
		userLevelDomain.setPage(page);

logger.info("page==" + page );
		
		//int	start	= PasingUtil.getStartRowNum( userLevelDomain.getPage() , userLevelDomain.getPerPage() );
		//int	end		= PasingUtil.getEndRowNum( userLevelDomain.getPage() , userLevelDomain.getPerPage() );
		
		
logger.info(  "page chk01==:" +  userLevelDomain.getPage() + "||"  +  userLevelDomain.getPerPage() + "##" + count );
		
		
		if ( count > 0 ) {
			
//logger.info("page check==:" + start + "||" + end );			
			
			//list = userLevelService.list( userLevelDomain , start , end );
			listTot = userLevelService.listUser( userLevelDomain , userLevelDomain.getPage()  , userLevelDomain.getPerPage() );
		}

		// paging을 위한 DTO를 생성
		paging.setLists( listTot ); // 결과를 DTO에 저장
		paging.setTotalCount( count ); // 결과 갯수를 DTO에 저장
		//paging.setPage( page ); // 현재 페이지를 저장
		//paging.setPerPage( perPage ); // 페이징수

		//model.addAttribute( "userTotList" , listTot );

		model.addAttribute( "searchVal" , userLevelDomain );
		
		model.addAttribute( "userTotList" , paging );
		
		model.addAttribute( "userLevelList" , paging );

		
		
		
		
		
		
		
		logger.info( "===================================" );

//		logger.info( " List==: " + listTot.toString() );

		logger.info( "===================================" );

		return thisUrl + "/listAction";
	}

	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping( value = "duplChkLevelName" , method = RequestMethod.POST )
	public void duplChkLevelName( @RequestParam( "levelName" ) String levelName , Model model ) throws Exception {
		int duplCnt = userLevelService.duplChkLevelName( levelName );

		model.addAttribute( "duplCnt" , duplCnt );
	}

	/**
	 * <PRE>
	 * 1. MethodName: detail
	 * 2. ClassName : UserLevelController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2016. 4. 27. 오전 11:47:40
	 * </PRE>
	 *
	 * @return String
	 * @param userLevelDomain
	 * @param model
	 * @return
	 * @throws Exception
	 */

	@RequestMapping( value = "detail" , method = RequestMethod.POST )
	public String detail( UserLevelDomain userLevelDomain , UserManageDomain userManageDomain , HttpSession session , Model model ) throws Exception {

		
logger.info("domain check=:" + userLevelDomain.toString() );
		
		String							rootMenuId	= "0";

		List< Map< String , Object > >	listTotMenu	= null;
		List< UserLevelDomain >			listUseMenu	= null;
		List< UserLevelDomain >			listTot		= null;

		listTotMenu = userLevelService.UserMenuDetailList( userLevelDomain.getLevel_id() );
		listTot = userLevelService.listUserDetail( userLevelDomain.getLevel_id() );

		listTotMenu = this.getOrganizedMenu( rootMenuId , listTotMenu );

		logger.info( "listTotMenu=============:" + listTotMenu.toString() );

		model.addAttribute( "userTotList" , listTot ); //권한

		model.addAttribute( "menuList" , listTotMenu );
		model.addAttribute( "menuUseList" , listUseMenu );

		return thisUrl + "/detail";
	}

	/**
	 * <PRE>
	 * 1. MethodName: modify
	 * 2. ClassName : UserLevelController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2016. 4. 28. 오전 10:24:17
	 * </PRE>
	 *
	 * @return String
	 * @param userLevelDomain
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping( value = "modify" , method = RequestMethod.POST )
	public String modify( UserLevelDomain userLevelDomain , UserManageDomain userManageDomain , HttpSession session , Model model ) throws Exception {

		logger.info( "modify start=========================" + userLevelDomain.toString() );
		// level_id chk_use
		userLevelService.modify( userLevelDomain );

		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute( Consts.USER.SESSION_USER );

		model.addAttribute( "searchVal" , userManageDomain );

		userLevelDomain.setUserLevelId( sessionUser.getUserLevelId() );
		model.addAttribute( "listUserLevel" , userLevelService.listUserLevel( userLevelDomain.getUserLevelId() ) );

		logger.info( "modify end=========================" );

		// return thisUrl + "/modify";
		userLevelDomain.setLanguageClcd( sessionUser.getLanguageClcd() );
		model.addAttribute( "searchVal" , userLevelDomain );
		model.addAttribute( "listUserLevel" , userLevelService.listUserLevel( userLevelDomain.getUserLevelId() ) );

		return thisUrl + "/list";

	}

	
	
	/**
	 * <PRE>
	 * 1. MethodName: modify
	 * 2. ClassName : UserLevelController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2016. 4. 28. 오전 10:24:17
	 * </PRE>
	 *
	 * @return String
	 * @param userLevelDomain
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping( value = "moveModify" , method = RequestMethod.POST )
	public String moveModify( UserLevelDomain userLevelDomain , UserManageDomain userManageDomain , HttpSession session , Model model ) throws Exception {

		logger.info( "moveModify start=========================" + userLevelDomain.toString() );
		
		
		String							rootMenuId	= "0";

		List< Map< String , Object > >	listTotMenu	= null;
		List< UserLevelDomain >			listUseMenu	= null;
		List< UserLevelDomain >			listTot		= null;

		listTotMenu = userLevelService.UserMenuDetailList( userLevelDomain.getLevel_id() );
		listTot = userLevelService.listUserDetail( userLevelDomain.getLevel_id() );

		listTotMenu = this.getOrganizedMenu( rootMenuId , listTotMenu );

		logger.info( "listTotMenu=============:" + listTotMenu.toString() );

		model.addAttribute( "userTotList" , listTot ); //권한

		model.addAttribute( "menuList" , listTotMenu );
		model.addAttribute( "menuUseList" , listUseMenu );
		
		
		return thisUrl + "/modify";

	}
	
	
	
	/**
	 * <PRE>
	 * 1. MethodName: dupLevelTitle
	 * 2. ClassName : UserLevelController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2019. 5. 12.
	 * </PRE>
	 *
	 * @return void
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping( value = "dupLevelTitle" , method = RequestMethod.POST )
	public void dupLevelTitle( UserLevelDomain userLevelDomain , Model model ) throws Exception {
		model.addAttribute("resultMsg" , userLevelService.dupLevelTitle(userLevelDomain));
	}
	
	
	
	/**
	 * <PRE>
	 * 1. MethodName: modify
	 * 2. ClassName : UserLevelController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2016. 4. 28. 오전 10:24:17
	 * </PRE>
	 *
	 * @return String
	 * @param userLevelDomain
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping( value = "addAction" , method = RequestMethod.POST )
	public String addAction( UserLevelDomain userLevelDomain , UserManageDomain userManageDomain , HttpSession session , Model model ) throws Exception {

		logger.info( "add start=========================" + userLevelDomain.toString() );

		// level_id chk_use
		// userLevelService.modify(userLevelDomain);

		userLevelService.insert( userLevelDomain );

		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute( Consts.USER.SESSION_USER );

		// model.addAttribute("searchVal" , userManageDomain);
		// userLevelDomain.setUserLevelId(sessionUser.getUserLevelId());
		// model.addAttribute("listUserLevel" ,
		// userLevelService.listUserLevel(userLevelDomain.getUserLevelId()));

		logger.info( "modify end=========================" );

		// return thisUrl + "/modify";
		// userLevelDomain.setLanguageClcd(sessionUser.getLanguageClcd());
		// model.addAttribute("searchVal" , userLevelDomain);
		// model.addAttribute("listUserLevel" ,
		// userLevelService.listUserLevel(userLevelDomain.getUserLevelId()));

		return thisUrl + "/list";

	}

	/**
	 * <PRE>
	 * 1. MethodName: modifyAction
	 * 2. ClassName : UserLevelController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2016. 5. 2. 오후 1:01:05
	 * </PRE>
	 *
	 * @return void
	 * @param userLevelDomain
	 * @param userAuthDomain
	 * @param model
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping( value = "modifyAction" , method = RequestMethod.POST )
	public String modifyAction( UserLevelDomain userLevelDomain , HttpSession session ,Model model ) throws Exception {
		
		String message = "";
logger.info("modifyAction====:" +userLevelDomain.toString() );

		//userLevelService.modifyAction( userLevelDomain );

			
			message = userLevelService.dupModifyLevelTitle( userLevelDomain );
			
logger.info("message check=:" + message );

			if( "succ".equals(  message )) {
				
				userLevelService.modify( userLevelDomain );
				
			}
			
			model.addAttribute("resultMsg" , message);
			
			return message;

	}

	/**
	 * <PRE>
	 * 1. MethodName: modify
	 * 2. ClassName : UserLevelController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2016. 4. 28. 오전 10:24:17
	 * </PRE>
	 *
	 * @return String
	 * @param userLevelDomain
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping( value = "add" , method = RequestMethod.POST )
	public String add( UserLevelDomain userLevelDomain , UserManageDomain userManageDomain , HttpSession session , Model model ) throws Exception {
		
		String			rootMenuId				= "0";
		
		/*List< MenuVO >	listAuthorizationMenu	= null;
		
		listAuthorizationMenu = menuService.listAuthorizationMenu( "1" );
		listAuthorizationMenu = CommonUtil.getOrganizedMenu( rootMenuId , listAuthorizationMenu );*/
		
		
		List< Map< String , Object > >	listTotMenu	= null;

		listTotMenu = userLevelService.UserMenuList( "1" );
		//listTot = userLevelService.listUserDetail( userLevelDomain.getLevel_id() );

		listTotMenu = this.getOrganizedMenu( rootMenuId , listTotMenu );

		model.addAttribute( "menuList" , listTotMenu );

		return thisUrl + "/add";
	}

	/*
	 * @RequestMapping( value = "addAction" , method = RequestMethod.POST ) public
	 * void addAction( UserLevelDomain userLevelDomain , Model model ) throws
	 * Exception { userLevelService.addAction(userLevelDomain); }
	 */

	/**
	 * <PRE>
	 * 1. MethodName: getTree
	 * 2. ClassName : UserLevelController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2016. 4. 28. 오후 5:42:12
	 * </PRE>
	 *
	 * @return Object
	 * @param pkgName
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping( value = "getMenuTree" , method = RequestMethod.POST )
	public @ResponseBody Object getTree( /*
											 * @RequestParam(value="pkgName") String pkgName ,
											 */Model model ) throws Exception {
		// listMenu = userLevelService.getMenu(pkgName); // db data
		listMenu = userLevelService.getMenu( /* pkgName */ ); // db data

		ArrayList< Object >			root		= new ArrayList< Object >();			// json data
		Map< String , Object >		rootNode	= new HashMap< String , Object >();
		Map< Integer , Boolean >	removeNode	= new HashMap< Integer , Boolean >();

		rootNode.put( "title" , "Menu" );
		rootNode.put( "isFolder" , "true" );
		rootNode.put( "key" , "0" );
		rootNode.put( " " , "0" );
		rootNode.put( "children" , makeMenuJson( null , 0 , removeNode , "M" ) );
		root.add( rootNode );

		return root;
	}

	/**
	 * <PRE>
	 * 1. MethodName: getAuthMenuTree
	 * 2. ClassName : UserLevelController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2016. 4. 28. 오후 6:09:34
	 * </PRE>
	 *
	 * @return Object
	 * @param pkgName
	 * @param levelId
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping( value = "getAuthRootMenuTree" , method = RequestMethod.POST )
	public @ResponseBody Object getAuthRootMenuTree( /*
														 * @RequestParam(value="pkgName") String pkgName ,
														 */@RequestParam( value = "levelId" ) String levelId , Model model ) throws Exception {
		// listAuthMenu = userLevelService.getAuthMenu(pkgName,levelId); // db data
		// listAuthMenu = userLevelService.getAuthMenu(/*pkgName,*/levelId); // db data

		ArrayList< Object >			root		= new ArrayList< Object >();			// json data
		Map< String , Object >		rootNode	= new HashMap< String , Object >();
		Map< Integer , Boolean >	removeNode	= new HashMap< Integer , Boolean >();

		rootNode.put( "title" , "Menu" );
		rootNode.put( "isFolder" , "true" );
		rootNode.put( "key" , "0" );
		rootNode.put( "depth" , "0" );
		rootNode.put( "children" , null );
		root.add( rootNode );

		return root;
	}

	/**
	 * <PRE>
	 * 1. MethodName: getAuthMenuTree
	 * 2. ClassName : UserLevelController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2016. 4. 28. 오후 6:09:34
	 * </PRE>
	 *
	 * @return Object
	 * @param pkgName
	 * @param levelId
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping( value = "getAuthMenuTree" , method = RequestMethod.POST )
	public @ResponseBody Object getAuthMenuTree( /*
													 * @RequestParam(value="pkgName") String pkgName ,
													 */@RequestParam( value = "levelId" ) String levelId , Model model ) throws Exception {
		// listAuthMenu = userLevelService.getAuthMenu(pkgName,levelId); // db data
		listAuthMenu = userLevelService.getAuthMenu( /* pkgName, */levelId ); // db data

		ArrayList< Object >			root		= new ArrayList< Object >();			// json data
		Map< String , Object >		rootNode	= new HashMap< String , Object >();
		Map< Integer , Boolean >	removeNode	= new HashMap< Integer , Boolean >();

		rootNode.put( "title" , "Menu" );
		rootNode.put( "isFolder" , "true" );
		rootNode.put( "key" , "0" );
		rootNode.put( "depth" , "0" );
		rootNode.put( "children" , makeMenuJson( null , 0 , removeNode , "AM" ) );
		root.add( rootNode );

		return root;
	}

	/**
	 * <PRE>
	 * 1. MethodName: makeMenuJson
	 * 2. ClassName : UserLevelController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2016. 4. 28. 오후 2:36:21
	 * </PRE>
	 *
	 * @return ArrayList<Object>
	 * @param parent
	 * @param index
	 * @param removeNode
	 * @return
	 */
	private ArrayList< Object > makeMenuJson( Map< String , Object > parent , int index , Map< Integer , Boolean > removeNode , String makeType ) {
		Menu				menu			= null;
		ArrayList< Object >	folder			= new ArrayList< Object >();
		Integer				parent_menu_id	= 0;
		List< Menu >		menuType		= null;

		if ( makeType == "AM" ) {
			menuType = listAuthMenu;
		} else {
			menuType = listMenu;
		}

		if ( index > 0 ) {
			parent_menu_id = Integer.parseInt( parent.get( "key" ).toString() );
		}

		for ( int i = index ; i < menuType.size() ; i++ ) {
			menu = menuType.get( i );

			if ( index > 0 && !menu.getUpMenuId().equals( parent_menu_id ) ) {
				continue;
			}

			if ( (Boolean) removeNode.get( menu.getMenuId() ) != null ) {
				continue;
			}

			if ( "Y".equals( menu.getIsFolder() ) ) {
				Map< String , Object > node = new HashMap< String , Object >();
				if ( makeType == "AM" ) {
					node.put( "title" , menu.getMenuName() + "<em>:" + menu.getAuthType() + "</em>" );
				} else {
					node.put( "title" , menu.getMenuName() );
				}
				node.put( "isFolder" , "true" ); // menu.getIs_folder());
				node.put( "key" , menu.getMenuId() );
				node.put( "depth" , menu.getDepth() );
				node.put( "expand" , "true" );

				ArrayList< Object > tmpList = makeMenuJson( node , index + 1 , removeNode , makeType );
				if ( tmpList.size() > 0 ) {
					node.put( "children" , tmpList );
				}
				folder.add( node );
				removeNode.put( menu.getMenuId() , Boolean.TRUE );
			} else {
				Map< String , Object > leaf = new HashMap< String , Object >();
				if ( makeType == "AM" ) {
					leaf.put( "title" , menu.getMenuName() + "<em>:" + menu.getAuthType() + "</em>" );
				} else {
					leaf.put( "title" , menu.getMenuName() );
				}
				leaf.put( "key" , menu.getMenuId() );
				leaf.put( "depth" , menu.getDepth() );
				folder.add( leaf );
				removeNode.put( menu.getMenuId() , Boolean.TRUE );
			}
		}

		return folder;
	}

	@RequestMapping( value = "removeAction" , method = RequestMethod.POST )
	public void removeAction( UserLevelDomain userLevelDomain , Model model ) {

		
logger.info("revoce controller ");		
		
		model.addAttribute( "resultMsg" , userLevelService.removeAction( userLevelDomain ) );
	}

	public List< Map< String , Object > > getOrganizedMenu( String parentId , List< Map< String , Object > > listAuthorizationMenu ) {
		List< Map< String , Object > > ret = new ArrayList< Map< String , Object > >();

		for ( Map< String , Object > menu : listAuthorizationMenu ) {
			if ( menu.get( "UP_MENU_ID" ).toString().equals( parentId ) ) {
				menu.put( "CHILDREN" , this.getOrganizedMenu( menu.get( "MENU_ID" ).toString() , listAuthorizationMenu ) );
				ret.add( menu );
			}
		}

		return ret;
	}
}
