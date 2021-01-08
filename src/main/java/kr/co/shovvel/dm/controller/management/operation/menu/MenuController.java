package kr.co.shovvel.dm.controller.management.operation.menu;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.co.shovvel.dm.domain.management.operation.menu.Menu;
import kr.co.shovvel.dm.domain.management.operation.menu.MenuVO;
import kr.co.shovvel.dm.service.management.operation.menu.MenuService;
import kr.co.shovvel.dm.util.CommonUtil;
import kr.co.shovvel.hcf.utils.MessageUtil;

@Controller
@RequestMapping( value = "/management/operation/menu" )
public class MenuController {
	private Logger		logger	= Logger.getLogger( this.getClass() );

	@Autowired
	private MenuService	menuService;

	private String		thisUrl	= "management/operation/menu";

	@RequestMapping( value = "index" , method = RequestMethod.POST )
	public String index( Model model , @RequestParam( value = "menu_id" , required = false ) String menu_id , HttpServletRequest request , HttpSession session ) {
		String			rootMenuId	= "0";
		List< MenuVO >	listMenu	= null;
		// listAuthorizationMenu = menuService.listAuthorizationMenu("1");
		listMenu = menuService.listMenu();
		listMenu = CommonUtil.getOrganizedMenu( rootMenuId , listMenu );

		model.addAttribute( "menuList" , listMenu );

		return thisUrl + "/index";
	}

	/**
	 * <PRE>
	* 1. MethodName: getMenuTree
	* 2. ClassName : MenuController
	* 3. Comment   : 페키지 별 메뉴 트리 조회.
	* 4. 작성자    : junwoo
	* 5. 작성일    : 2016. 4. 12. 오후 9:03:43
	 * </PRE>
	 *
	 * @return Object
	 * @return
	 */
	// @RequestMapping( value = "getMenuTree" , method = RequestMethod.POST )
	// public @ResponseBody Object getMenuTree( @RequestParam String package_id ) {
	// Gson gson = new Gson();
	// return gson.toJson(menuService.getMenuTree(package_id));
	// }

	/**
	 * <PRE>
	* 1. MethodName: insert
	* 2. ClassName : MenuController
	* 3. Comment   : 등록 화면 호출
	* 4. 작성자    : junwoo
	* 5. 작성일    : 2016. 4. 15. 오후 5:31:01
	 * </PRE>
	 *
	 * @return String
	 * @param is_folder
	 * @param menu_id
	 * @param model
	 * @return
	 */
	@RequestMapping( value = "insert" , method = RequestMethod.POST )
	public String insert( @RequestParam String is_folder , @RequestParam Integer menu_id , HttpServletRequest request , HttpSession session , Model model ) {
		if ( menu_id == 0 ) {
			model.addAttribute( "up_menu_id" , "0" );
			model.addAttribute( "depth" , "1" );
		} else {
			Menu menu = menuService.getMenu( menu_id );
			model.addAttribute( "up_menu_id" , menu_id );
			model.addAttribute( "depth" , menu.getDepth() + 1 );
		}
		// model.addAttribute("pkg_name", pkg_name);
		model.addAttribute( "is_folder" , is_folder );
		model.addAttribute( "newStyle" , true );
		return thisUrl + "/insert";
	}

	@RequestMapping( value = "insertAction" , method = RequestMethod.POST )
	public void insertAction( @Valid Menu menu , BindingResult result , HttpServletRequest request , HttpSession session , Model model ) {
		if ( result.hasErrors() ) {
			logger.debug( "result.hasErrors()=>" + result.getFieldError() );
			model.addAttribute( "menu" , menu );
		}
		if ( menuService.insert( menu ) ) {
			model.addAttribute( "resultMsg" , MessageUtil.getMessage( "msg.common.save.result" ) );
			model.addAttribute( "returnMsg" , "SUCCESS" );

			model.addAttribute( "menu_id" , menu.getMenuId() );
		} else {
			model.addAttribute( "resultMsg" , MessageUtil.getMessage( "msg.common.error.result" ) );
			model.addAttribute( "returnMsg" , "FAIL" );
		}

		// SO_COMMON_CODE의 그룹코드(200003) 참고
		// commonService.insertOperationHist("3"); // 1.Display 2.Search 3.Insert
		// 4.Delete 5.Update 6.Save
	}

	/**
	 * <PRE>
	* 1. MethodName: getMenuAction
	* 2. ClassName : MenuController
	* 3. Comment   : 선택한 메뉴의 정보조회.
	* 4. 작성자    : junwoo
	* 5. 작성일    : 2016. 4. 18. 오후 3:19:56
	 * </PRE>
	 *
	 * @return String
	 * @param menu_id
	 * @param model
	 * @return
	 */
	@RequestMapping( value = "getMenuAction" , method = RequestMethod.POST )
	public String getMenuAction( @RequestParam Integer menu_id , HttpServletRequest request , HttpSession session , Model model ) {

		Menu menu = menuService.getMenu( menu_id );
		model.addAttribute( "menu" , menu );
		model.addAttribute( "newStyle" , true );
		return thisUrl + "/update";
	}

	@RequestMapping( value = "detailMenuListAction" , method = RequestMethod.POST )
	public String detailMenuListAction( @RequestParam( value = "menu_id" , required = false ) Integer menu_id , HttpServletRequest request , HttpSession session , Model model ) {

		String			rootMenuId				= "0";
		List< MenuVO >	listAuthorizationMenu	= null;
		listAuthorizationMenu = menuService.listMenu();
		listAuthorizationMenu = CommonUtil.getOrganizedMenu( rootMenuId , listAuthorizationMenu );

		model.addAttribute( "menuList" , listAuthorizationMenu );
		return thisUrl + "/detailMenuListAction";
	}

	@RequestMapping( value = "detailMenuAction" , method = RequestMethod.POST )
	public String detailMenuAction( @RequestParam( value = "menu_id" , required = false ) Integer menu_id , HttpServletRequest request , HttpSession session , Model model ) {

		String			rootMenuId				= "0";
		List< MenuVO >	listAuthorizationMenu	= null;
		listAuthorizationMenu = menuService.listMenu();
		listAuthorizationMenu = CommonUtil.getOrganizedMenu( rootMenuId , listAuthorizationMenu );

		model.addAttribute( "menuList" , listAuthorizationMenu );
		return thisUrl + "/detail";
	}

	@RequestMapping( value = "updateAction" , method = RequestMethod.POST )
	public void updateAction( @Valid Menu menu , BindingResult result , HttpServletRequest request , HttpSession session , Model model ) {
		if ( result.hasErrors() ) {
			logger.debug( "result.hasErrors()=>" + result.getFieldError() );
			model.addAttribute( "menu" , menu );
		}
		if ( menuService.update( menu ) ) {
			model.addAttribute( "menu" , menu );
			model.addAttribute( "resultMsg" , MessageUtil.getMessage( "msg.common.save.result" ) );
			model.addAttribute( "returnMsg" , "SUCCESS" );
		} else {
			model.addAttribute( "resultMsg" , MessageUtil.getMessage( "msg.common.error.result" ) );
			model.addAttribute( "returnMsg" , "FAIL" );
		}
		// SO_COMMON_CODE의 그룹코드(200003) 참고
		// commonService.insertOperationHist("5"); // 1.Display 2.Search 3.Insert
		// 4.Delete 5.Update 6.Save

	}

	@RequestMapping( value = "modifyAction" , method = RequestMethod.POST )
	public String modifyAction( @Valid Menu menu , BindingResult result , HttpServletRequest request , HttpSession session , Model model ) throws IllegalStateException , IOException {

		logger.info( "menu====:" + menu.toString() );

		if ( result.hasErrors() ) {
			logger.debug( "result.hasErrors()=>" + result.getFieldError() );
			model.addAttribute( "menu" , menu );
		}
		if ( menuService.modify( menu ) ) {
			model.addAttribute( "menu" , menu );
			model.addAttribute( "resultMsg" , MessageUtil.getMessage( "msg.common.save.result" ) );
			model.addAttribute( "returnMsg" , "SUCCESS" );
		} else {
			model.addAttribute( "resultMsg" , MessageUtil.getMessage( "msg.common.error.result" ) );
			model.addAttribute( "returnMsg" , "FAIL" );
		}
		// SO_COMMON_CODE의 그룹코드(200003) 참고
		// commonService.insertOperationHist("5"); // 1.Display 2.Search 3.Insert
		// 4.Delete 5.Update 6.Save

		return this.index( model , "1" , request , session );

	}

	@RequestMapping( value = "deleteAction" , method = RequestMethod.POST )
	public void deleteAction( @RequestParam Integer menuId , HttpServletRequest request , HttpSession session , Model model ) {

		logger.info( "delete action  start" );

		if ( menuService.delete( menuId ) ) {
			model.addAttribute( "resultMsg" , MessageUtil.getMessage( "msg.common.delete.result" ) );
			model.addAttribute( "returnMsg" , "SUCCESS" );
			// } else {
			// model.addAttribute("resultMsg",
			// MessageUtil.getMessage("msg.common.error.result"));
			// model.addAttribute("returnMsg", "FAIL");
		}

		// SO_COMMON_CODE의 그룹코드(200003) 참고
		// commonService.insertOperationHist("4"); // 1.Display 2.Search 3.Insert
		// 4.Delete 5.Update 6.Save

	}

	@RequestMapping( value = "addMenu" , method = RequestMethod.POST )
	public void addMenu( Menu menu , BindingResult result , HttpServletRequest request , HttpSession session , Model model ) {

		if ( menuService.addMenu( menu ) ) {
			model.addAttribute( "resultMsg" , MessageUtil.getMessage( "msg.common.save.result" ) );
			model.addAttribute( "returnMsg" , "SUCCESS" );

			model.addAttribute( "menu_id" , menu.getMenuId() );
		} else {
			model.addAttribute( "resultMsg" , MessageUtil.getMessage( "msg.common.error.result" ) );
			model.addAttribute( "returnMsg" , "FAIL" );
		}

	}

}
