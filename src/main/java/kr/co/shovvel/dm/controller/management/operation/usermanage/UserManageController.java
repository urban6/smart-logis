package kr.co.shovvel.dm.controller.management.operation.usermanage;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.shovvel.dm.common.Consts;
import kr.co.shovvel.dm.domain.common.PrevSessionUser;
import kr.co.shovvel.dm.domain.common.paging.Paging;
import kr.co.shovvel.dm.domain.management.operation.userlevel.UserLevelDomain;
import kr.co.shovvel.dm.domain.management.operation.usermanage.UserManageDomain;
import kr.co.shovvel.dm.domain.management.operation.usermanage.UserManageDomainVO;
import kr.co.shovvel.dm.service.common.CommonService;
import kr.co.shovvel.dm.service.management.operation.userlevel.UserLevelService;
import kr.co.shovvel.dm.service.management.operation.usermanage.UserManageService;
import kr.co.shovvel.hcf.utils.DateUtil;
import kr.co.shovvel.hcf.utils.PasingUtil;

@Controller
@RequestMapping( value = "/management/operation/usermanage" )
public class UserManageController {
	private Logger				logger		= Logger.getLogger( this.getClass() );
	private String				language	= DateUtil.getDateRepresentation();

	@Value( "#{configuration['initPassword']}" )
	private String				INIT_PASSWORD;

	@Autowired
	private UserManageService	userManageService;

	private String				thisUrl		= "management/operation/usermanage";

	@Autowired
	private CommonService		commonService;

	@Autowired
	private UserLevelService	userLevelService;

	/**
	 * <PRE>
	 * 1. MethodName: list
	 * 2. ClassName : UserManageController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2016. 4. 12. 오후 2:59:19
	 * </PRE>
	 *
	 * @return String
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping( value = "list" , method = RequestMethod.POST )
	public String list( UserManageDomain userManageDomain , Model model , String url , HttpSession session ) throws Exception {
		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute( Consts.USER.SESSION_USER );

		model.addAttribute( "searchVal" , userManageDomain );

		UserLevelDomain userLevelDomain = new UserLevelDomain();
		userLevelDomain.setUserLevelId( sessionUser.getUserLevelId() );
		model.addAttribute( "listUserLevel" , userLevelService.listUserLevel( userLevelDomain.getUserLevelId() ) );
		model.addAttribute( "listDept" , userManageService.listDept() );

		return thisUrl + "/list";
	}

	/**
	 * <PRE>
	 * 1. MethodName: list
	 * 2. ClassName : UserManageController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2016. 4. 12. 오후 2:59:28
	 * </PRE>
	 *
	 * @return String
	 * @param userManageDomain
	 * @param page
	 * @param perPage
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping( value = "listAction" , method = RequestMethod.POST )
	public String listAction( UserManageDomain userManageDomain , HttpSession session , Model model ) throws Exception {
		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute( Consts.USER.SESSION_USER );
		userManageDomain.setUserLevelId( sessionUser.getUserLevelId() );
		userManageDomain.setLanguageClcd( sessionUser.getLanguageClcd() );

		// paging
		Paging						paging		= new Paging();
		List< UserManageDomainVO >	list		= null;
		int							totalCount	= 0;

		totalCount = userManageService.count( userManageDomain );

		if ( totalCount > 0 ) {
			int page = PasingUtil.getPage( userManageDomain.getPage() , userManageDomain.getPerPage() , totalCount );
			userManageDomain.setPage( page );

			list = userManageService.list( userManageDomain , userManageDomain.getPage() , userManageDomain.getPerPage() );
		}

		// paging을 위한 DTO를 생성
		paging.setLists( list ); // 결과를 DTO에 저장
		paging.setTotalCount( totalCount ); // 결과 갯수를 DTO에 저장

		model.addAttribute( "searchVal" , userManageDomain );
		model.addAttribute( "userManageList" , paging );

		return thisUrl + "/listAction";
	}

	/**
	 * <PRE>
	 * 1. MethodName: detail
	 * 2. ClassName : UserManageController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2016. 4. 12. 오후 6:14:36
	 * </PRE>
	 *
	 * @return String
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping( value = "detail" , method = RequestMethod.POST )
	public String detail( UserManageDomain userManageDomain , HttpSession session , Model model ) throws Exception {
		boolean		boolManage	= false;
		// session
		PrevSessionUser sessionUser	= (PrevSessionUser) session.getAttribute( Consts.USER.SESSION_USER );
		userManageDomain.setUserLevelId( sessionUser.getUserLevelId() );
		userManageDomain.setLanguageClcd( sessionUser.getLanguageClcd() );

		UserManageDomainVO userManage = new UserManageDomainVO();
		userManage = userManageService.detail( userManageDomain );

		// 메뉴 수정권한 확인
		boolManage = true;
		String detailMod = "I";
		if ( boolManage )
			detailMod = "M";

		model.addAttribute( "searchVal" , userManageDomain );
		model.addAttribute( "info" , userManage );
		model.addAttribute( "infoMod" , detailMod );
		model.addAttribute( "listUserLevel" , userLevelService.listUserLevel( sessionUser.getUserLevelId() ) );
		model.addAttribute( "listDept" , userManageService.listDept() );

		return thisUrl + "/detail";
	}

	/**
	 * <PRE>
	 * 1. MethodName: detailAction
	 * 2. ClassName : UserManageController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2016. 4. 12. 오후 6:14:36
	 * </PRE>
	 *
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping( value = "detailAction" , method = RequestMethod.POST )
	public void detailAction( UserManageDomain userManageDomain , HttpSession session , Model model ) throws Exception {
		// boolean boolManage = false;
		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute( Consts.USER.SESSION_USER );
		userManageDomain.setUserLevelId( sessionUser.getUserLevelId() );
		userManageDomain.setLanguageClcd( sessionUser.getLanguageClcd() );

		UserManageDomainVO userManage = new UserManageDomainVO();
		userManage = userManageService.detail( userManageDomain );

		String resultMsg = "";
		if ( userManage != null ) {
			resultMsg = "succ";
		} else {
			resultMsg = "empty";
		}

		model.addAttribute( "searchVal" , userManageDomain );
		model.addAttribute( "info" , userManage );
		model.addAttribute( "resultMsg" , resultMsg );
	}

	/**
	 * <PRE>
	 * 1. MethodName: add
	 * 2. ClassName : UserManageController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2016. 4. 14. 오후 6:12:37
	 * </PRE>
	 *
	 * @return String
	 * @param userManageDomain
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping( value = "add" , method = RequestMethod.POST )
	public String add( UserManageDomain userManageDomain , HttpSession session , Model model ) throws Exception {
		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute( Consts.USER.SESSION_USER );

		model.addAttribute( "infoMod" , "A" );
		model.addAttribute( "searchVal" , userManageDomain );
		model.addAttribute( "userLevelId" , sessionUser.getUserLevelId() );
		model.addAttribute( "listUserLevel" , userLevelService.listUserLevel( sessionUser.getUserLevelId() ) );
		model.addAttribute( "listDept" , userManageService.listDept() );

		return thisUrl + "/addUser";
	}

	/**
	 * <PRE>
	 * 1. MethodName: addAction
	 * 2. ClassName : UserManageController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2016. 5. 3. 오후 1:45:39
	 * </PRE>
	 *
	 * @return void
	 * @param userManageDomain
	 * @param session
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping( value = "addAction" , method = RequestMethod.POST )
	public void addAction( UserManageDomain userManageDomain , HttpSession session , Model model ) throws Exception {
		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute( Consts.USER.SESSION_USER );
		userManageDomain.setUserLevelId( sessionUser.getUserLevelId() );
		userManageDomain.setLanguageClcd( sessionUser.getLanguageClcd() );

		// default passwd yn -> Y
		userManageDomain.setDefaultPasswdYn( "Y" );
		userManageDomain.setLoginId( userManageDomain.getSid() );

		userManageDomain.setInsUserSno( sessionUser.getUserSno() );
		model.addAttribute( "resultMsg" , userManageService.addAction( userManageDomain ) );
	}

	// /**
	// * <PRE>
	// * 1. MethodName: modify
	// * 2. ClassName : UserManageController
	// * 3. Comment :
	// * 4. 작성자 :
	// * 5. 작성일 :
	// * </PRE>
	// *
	// * @return String
	// * @param userManageDomain
	// * @param session
	// * @param model
	// * @return
	// * @throws Exception
	// */
	// @RequestMapping( value = "modify" , method = RequestMethod.POST )
	// public String modify( UserManageDomain userManageDomain , HttpSession session , Model model ) throws Exception {
	// // session
	//// SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
	//// userManageDomain.setUserLevelId(sessionUser.getUserLevelId());
	//// userManageDomain.setLanguageClcd(sessionUser.getLanguageClcd());
	////
	//// UserManageDomain userManage = new UserManageDomain();
	//// userManage = userManageService.detail(userManageDomain);
	//// userManage.setInit_passwd(INIT_PASSWORD);
	////
	//// //---------password RSA암호화 객체---------
	//// int KEY_SIZE = Consts.SECURITY.KEY_SIZE; // 512
	////
	//// KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
	//// generator.initialize(KEY_SIZE);
	////
	//// KeyPair keyPair = generator.genKeyPair();
	//// KeyFactory keyFactory = KeyFactory.getInstance("RSA");
	////
	//// PublicKey publicKey = keyPair.getPublic();
	//// PrivateKey privateKey = keyPair.getPrivate();
	////
	//// // 세션에 공개키의 문자열을 키로하여 개인키를 저장한다.
	//// session.setAttribute("rsaPrivateKey", privateKey);
	////
	//// // 공개키를 문자열로 변환하여 JavaScript RSA 라이브러리 넘겨준다.
	//// RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
	////
	//// String publicKeyModulus = publicSpec.getModulus().toString(16);
	//// String publicKeyExponent = publicSpec.getPublicExponent().toString(16);
	////
	//// model.addAttribute("publicKeyModulus", publicKeyModulus);
	//// model.addAttribute("publicKeyExponent", publicKeyExponent);
	//// //---------password RSA암호화 객체---------
	//// //List<UserManageDomain> userGroupList=userManageService.detailUserGroupList(userManageDomain);
	////
	////
	//// model.addAttribute("searchVal", userManageDomain);
	//// model.addAttribute("userLevelId", sessionUser.getUserLevelId());
	//// model.addAttribute("listUserLevel", userManageService.listUserLevel(sessionUser.getUserLevelId()));
	//// model.addAttribute("userManage", userManage);
	//// model.addAttribute("sessionUserSno", sessionUser.getUserSno());
	//
	// return thisUrl + "/modify";
	// }

	/**
	 * <PRE>
	 * 1. MethodName: modifyAction
	 * 2. ClassName : UserManageController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2016. 4. 14. 오후 6:12:46
	 * </PRE>
	 *
	 * @return void
	 * @param userManageDomain
	 * @param session
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping( value = "modifyAction" , method = RequestMethod.POST )
	public void modifyAction( UserManageDomain userManageDomain , HttpSession session , Model model ) throws Exception {
		// 1.Display 2.Search 3.Insert 4.Delete 5.Update 6.Save
		// commonService.insertOperationHist("5");

		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute( Consts.USER.SESSION_USER );
		userManageDomain.setUserLevelId( sessionUser.getUserLevelId() );
		userManageDomain.setLanguageClcd( sessionUser.getLanguageClcd() );

		// if ( userManageDomain.getPasswd() != null && !userManageDomain.getPasswd().equals("") ) {

		// passwd 암호화
		// userManageDomain.setPasswd(Sha256Util.getEncrypt(userManageDomain.getPasswd()));
		// userManageDomain.setPasswd(userManageService.selectEncryptPasswd(userManageDomain.getPasswd()));

		// passwd change check
		// String passwd = userManageService.getPasswd(userManageDomain.getUserSno());

		// logger.debug("1)passwd=" + passwd + ", 2)userManageDomain.getPasswd()=" + userManageDomain.getPasswd());

		// if ( !passwd.equals(userManageDomain.getPasswd()) ) {
		// // 비밀번호 바꾼 경우
		//// userManageDomain.setDefaultPasswdYn("N");
		//// int passwd_life_cycle = userManageService.getPasswdLifeCycle(userManageDomain.getUserLevelId());
		//// userManageDomain.setPasswdLifeCycle(passwd_life_cycle);
		// } else {
		// // DB에 입력된 비밀번호와 동일한 경우 update하지 않음
		// userManageDomain.setPasswd("");
		// }
		// }
		model.addAttribute( "resultMsg" , userManageService.modifyAction( userManageDomain ) );

		// if ( !(sessionUser.getUserLevelId().equals(userManageDomain.getLevelId())) && sessionUser.getUserSno().equals(userManageDomain.getUserSno()) ) {
		// sessionUser.setUserLevelId(userManageDomain.getLevelId());
		// model.addAttribute("logout" , "Y");
		// } else {
		// model.addAttribute("logout" , "N");
		// }
	}

	/**
	 * <PRE>
	 * 1. MethodName: removeAction
	 * 2. ClassName : UserManageController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2016. 4. 12. 오후 8:08:21
	 * </PRE>
	 *
	 * @return void
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping( value = "removeAction" , method = RequestMethod.POST )
	public void removeAction( UserManageDomain userManageDomain , Model model ) throws Exception {
		model.addAttribute( "resultMsg" , userManageService.removeAction( userManageDomain ) );
	}

	/**
	 * <PRE>
	 * 1. MethodName: initPasswdAction
	 * 2. ClassName : UserManageController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2019. 5. 12.
	 * </PRE>
	 *
	 * @return void
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping( value = "initPasswdAction" , method = RequestMethod.POST )
	public void initPasswdAction( UserManageDomain userManageDomain , Model model ) throws Exception {
		model.addAttribute( "resultMsg" , userManageService.initPasswdAction( userManageDomain ) );
	}

	@RequestMapping( value = "loginPasswdAction" , method = RequestMethod.POST )
	public void loginPasswdAction( @RequestParam String loginId , Model model ) throws Exception {
		System.out.println( "loginId loginIdloginIdloginId  " + loginId );
		UserManageDomain userManageDomain = new UserManageDomain();
		userManageDomain.setLoginId( loginId );
		System.out.println( "loginId loginIdloginIdloginId  " + loginId );
		model.addAttribute( "resultMsg" , userManageService.initPasswdAction( userManageDomain ) );
	}

	// /**
	// * <PRE>
	// * 1. MethodName: duplChkUserSno
	// * 2. ClassName : UserManageController
	// * 3. Comment :
	// * 4. 작성자 :
	// * 5. 작성일 : 2016. 4. 21. 오후 9:23:04
	// * </PRE>
	// *
	// * @return void
	// * @param userSno
	// * @param model
	// * @throws Exception
	// */
	// @RequestMapping( value = "duplChkUserSno" , method = RequestMethod.POST )
	// public void duplChkUserSno( @RequestParam( "userSno" ) String userSno , Model model ) throws Exception {
	// int duplCnt = userManageService.duplChkUserSno(userSno);
	//
	// model.addAttribute("duplCnt" , duplCnt);
	// }

	/**
	 * <PRE>
	 * 1. MethodName: changePasswdAction
	 * 2. ClassName : UserManageController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2019. 5. 28.
	 * </PRE>
	 *
	 * @return void
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping( value = "changePasswdAction" , method = RequestMethod.POST )
	public void changePasswdAction( UserManageDomain userManageDomain , Model model ) throws Exception {
		model.addAttribute( "resultMsg" , userManageService.changePasswdAction( userManageDomain ) );
	}

	/**
	 * <PRE>
	 * 1. MethodName: restoreAction
	 * 2. ClassName : UserManageController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2019. 5. 28.
	 * </PRE>
	 *
	 * @return void
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping( value = "restoreAction" , method = RequestMethod.POST )
	public void restoreAction( UserManageDomain userManageDomain , Model model ) throws Exception {
		model.addAttribute( "resultMsg" , userManageService.restoreAction( userManageDomain ) );
	}

	@RequestMapping( value = "userInfo" , method = RequestMethod.POST )
	public String userInfo( HttpSession session , Model model ) throws Exception {
		// session
		PrevSessionUser sessionUser			= (PrevSessionUser) session.getAttribute( Consts.USER.SESSION_USER );

		UserManageDomain	userManageDomain	= new UserManageDomain();
		userManageDomain.setUserLevelId( sessionUser.getUserLevelId() );
		userManageDomain.setLanguageClcd( sessionUser.getLanguageClcd() );
		userManageDomain.setUserSno( sessionUser.getUserSno() );

		UserManageDomainVO userManage = new UserManageDomainVO();
		userManage = userManageService.detail( userManageDomain );

		model.addAttribute( "language" , language );
		model.addAttribute( "userLevelId" , sessionUser.getUserLevelId() );
		model.addAttribute( "listUserLevel" , userLevelService.listUserLevel( sessionUser.getUserLevelId() ) );
		model.addAttribute( "listDept" , userManageService.listDept() );
		model.addAttribute( "info" , userManage );
		model.addAttribute( "sessionUserSno" , sessionUser.getUserSno() );

		return "main/userInfo";
	}

	// @RequestMapping( value = "userInfoAction" , method = RequestMethod.POST )
	// public void userInfoAction( HttpSession session , Model model , UserManageDomain userManageDomain ) throws Exception {
	// SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.USER.SESSION_USER);
	// userManageDomain.setUserLevelId(sessionUser.getUserLevelId());
	// userManageDomain.setLanguageClcd(sessionUser.getLanguageClcd());
	//
	// // passwd 암호화
	// userManageDomain.setPasswd(Sha256Util.getEncrypt(userManageDomain.getPasswd()));
	//
	// // passwd change check
	// String passwd = userManageService.getPasswd(userManageDomain.getUserSno());
	//
	// logger.debug("1)passwd=" + passwd + ", 2)userManageDomain.getPasswd()=" + userManageDomain.getPasswd());

	// if ( !passwd.equals(userManageDomain.getPasswd()) ) {
	// // 비밀번호 바꾼 경우
	// userManageDomain.setDefaultPasswdYn("N");
	// int passwd_life_cycle = userManageService.getPasswdLifeCycle(userManageDomain.getUserLevelId());
	// } else {
	// // DB에 입력된 비밀번호와 동일한 경우 update하지 않음
	// userManageDomain.setPasswd("");
	// }
	//
	// model.addAttribute("resultMsg" , userManageService.modifyAction(userManageDomain));
	// model.addAttribute("logout" , "N");
	// }

}
