package kr.co.shovvel.dm.controller.management.partnermng.partneradmin;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
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
import kr.co.shovvel.dm.domain.common.CommonDomain;
import kr.co.shovvel.dm.domain.common.PrevSessionUser;
import kr.co.shovvel.dm.domain.common.paging.Paging;
import kr.co.shovvel.dm.domain.management.partnermng.partneradmin.PartnerAdminDomain;
import kr.co.shovvel.dm.service.common.CommonService;
import kr.co.shovvel.dm.service.management.operation.usermanage.UserManageService;
import kr.co.shovvel.dm.service.management.partnermng.partneradmin.PartnerAdminService;
import kr.co.shovvel.hcf.utils.PasingUtil;

@Controller
@RequestMapping( value = "/management/partnermng/partneradmin" )
public class PartnerAdminController {
	private Logger				logger							= Logger.getLogger(this.getClass());
	private String				thisUrl							= "management/partnermng/partneradmin";

	public static final String	SMS_MSG_CTCD_SERVICE_MESSAGE	= "00707160";							// V3 웹유저 패스워드 초기화
	public static final String	LEVEL_CLCD_ADMIN				= "50508010";							// level 구분코드 - 관리자
	public static final String	PARTNER_CLCD					= "50201000";							// 파트너사 구분코드

	@Autowired
	PartnerAdminService			partnerAdminService;

	@Autowired
	private CommonService		commonService;

	@Autowired
	private UserManageService	userManageService;

	@Value( "#{configuration['baseContentsUrl']}" )
	private String				baseContentsUrl;

	@Value( "#{configuration['initPassword']}" )
	private String				initPassword;

	@RequestMapping( value = "list" , method = RequestMethod.POST )
	public String list( PartnerAdminDomain partnerAdminDomain , Model model , HttpSession session ) throws Exception {
		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		partnerAdminDomain.setUserLevelId(sessionUser.getUserLevelId());
		partnerAdminDomain.setLanguage(sessionUser.getLanguage());
		partnerAdminDomain.setLanguageClcd(sessionUser.getLanguageClcd());
		partnerAdminDomain.setUserSno(sessionUser.getUserSno());

		CommonDomain commonDomain = new CommonDomain();
		commonDomain.setUpperComCd(PARTNER_CLCD);
		commonDomain.setLanguageClcd(partnerAdminDomain.getLanguageClcd());

		model.addAttribute("partnerClcdList" , commonService.getCodeListMap(commonDomain));
		model.addAttribute("partnerAdminDomain" , partnerAdminDomain);
		return thisUrl + "/list";
	}

	@RequestMapping( value = "listAction" , method = RequestMethod.POST )
	public String listAction( PartnerAdminDomain partnerAdminDomain , @RequestParam( required = false , defaultValue = "1" ) int page , @RequestParam( required = false , defaultValue = "10" ) int perPage ,
			HttpSession session , Model model ) throws Exception {
		logger.debug("PartnerAdminController - listAction");

		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		partnerAdminDomain.setUserLevelId(sessionUser.getUserLevelId());
		partnerAdminDomain.setLanguage(sessionUser.getLanguage());
		partnerAdminDomain.setLanguageClcd(sessionUser.getLanguageClcd());
		partnerAdminDomain.setUserSno(sessionUser.getUserSno());
		partnerAdminDomain.setLevel_clcd(LEVEL_CLCD_ADMIN);

		Paging						paging	= new Paging();
		List<PartnerAdminDomain>	list	= new ArrayList<PartnerAdminDomain>();
		int							count	= 0;

		count = partnerAdminService.selectPartnerAdminCount(partnerAdminDomain);
		page = PasingUtil.getPage(page , perPage , count);
		if ( count > 0 ) {
			list = partnerAdminService.selectPartnerAdminList(partnerAdminDomain , page , perPage);
		}

		paging.setLists(list);
		paging.setTotalCount(count);
		paging.setPage(page);
		paging.setPerPage(perPage);

		model.addAttribute("partnerAdminList" , paging);

		return thisUrl + "/listAction";
	}

	@RequestMapping( value = "add" , method = RequestMethod.POST )
	public String add( PartnerAdminDomain partnerAdminDomain , HttpSession session , Model model ) throws Exception {
		logger.debug("PartnerAdminController - add");

		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		partnerAdminDomain.setUserLevelId(sessionUser.getUserLevelId());
		partnerAdminDomain.setLanguage(sessionUser.getLanguage());
		partnerAdminDomain.setLanguageClcd(sessionUser.getLanguageClcd());
		partnerAdminDomain.setUserSno(sessionUser.getUserSno());
		partnerAdminDomain.setLevel_clcd(LEVEL_CLCD_ADMIN);

		CommonDomain commonDomain = new CommonDomain();
		commonDomain.setUpperComCd(PARTNER_CLCD);
		commonDomain.setLanguageClcd(partnerAdminDomain.getLanguageClcd());

		model.addAttribute("partnerClcdList" , commonService.getCodeListMap(commonDomain));
		model.addAttribute("partnerAdminDomain" , partnerAdminDomain);
		model.addAttribute("baseContentsUrl" , baseContentsUrl);

		return thisUrl + "/add";
	}

	@RequestMapping( value = "selectPartnerAdminbyID" , method = RequestMethod.POST )
	public void selectPartnerAdminbyID( PartnerAdminDomain partnerAdminDomain , Model model , HttpSession session ) throws Exception {
		logger.debug("PartnerAdminController - selectPartnerAdminbyID");
		logger.debug("Input:" + partnerAdminDomain.toString());
		model.addAttribute("rs" , partnerAdminService.selectPartnerAdminbyID(partnerAdminDomain));
	}

	@RequestMapping( value = "addAction" , method = RequestMethod.POST )
	public void addAction( PartnerAdminDomain partnerAdminDomain , Model model , HttpSession session ) throws Exception {
		logger.debug("PartnerAdminController - addAction");

		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		partnerAdminDomain.setUserSno(sessionUser.getUserSno());
		partnerAdminDomain.setLanguage(sessionUser.getLanguage());
		partnerAdminDomain.setLanguageClcd(sessionUser.getLanguageClcd());
		partnerAdminDomain.setUserLevelId(sessionUser.getUserLevelId());

		partnerAdminDomain.setUser_ctcd("00000000"); // 임시 값

		partnerAdminDomain.setDefault_passwd_yn("Y");
		partnerAdminDomain.setPasswd(initPassword);
		partnerAdminDomain.setAccount_exfire("99991231");

		// passwd life cycle
//		int passwd_life_cycle = userManageService.getPasswdLifeCycle(partnerAdminDomain.getLevel_id());
//		partnerAdminDomain.setPasswd_life_cycle(Integer.toString(passwd_life_cycle));

		model.addAttribute("result" , partnerAdminService.addAction(partnerAdminDomain));
	}

	@RequestMapping( value = "modify" , method = RequestMethod.POST )
	public String modify( PartnerAdminDomain partnerAdminDomain , HttpSession session , Model model ) throws Exception {
		logger.debug("PartnerAdminController - modify");
		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		partnerAdminDomain.setUserLevelId(sessionUser.getUserLevelId());
		partnerAdminDomain.setLanguage(sessionUser.getLanguage());
		partnerAdminDomain.setLanguageClcd(sessionUser.getLanguageClcd());
		partnerAdminDomain.setUserSno(sessionUser.getUserSno());

		CommonDomain commonDomain = new CommonDomain();
		commonDomain.setUpperComCd(PARTNER_CLCD);
		commonDomain.setLanguageClcd(partnerAdminDomain.getLanguageClcd());

		model.addAttribute("partnerClcdList" , commonService.getCodeListMap(commonDomain));
		model.addAttribute("partnerAdminDomain" , partnerAdminDomain);
		model.addAttribute("baseContentsUrl" , baseContentsUrl);
		logger.debug("Search Key:" + partnerAdminDomain.getUser_sno());
		PartnerAdminDomain info = partnerAdminService.selectPartnerAdminInfo(partnerAdminDomain);
		model.addAttribute("info" , info);

		return thisUrl + "/modify";
	}

	@RequestMapping( value = "modifyAction" , method = RequestMethod.POST )
	public void modifyAction( PartnerAdminDomain partnerAdminDomain , Model model , HttpSession session , HttpServletRequest request ) throws Exception {
		logger.debug("PartnerAdminController - modifyAction");

		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		partnerAdminDomain.setUserLevelId(sessionUser.getUserLevelId());
		partnerAdminDomain.setLanguage(sessionUser.getLanguage());
		partnerAdminDomain.setLanguageClcd(sessionUser.getLanguageClcd());
		partnerAdminDomain.setUserSno(sessionUser.getUserSno());

		// 이미지 파일 수정되는지 확인
		model.addAttribute("result" , partnerAdminService.modifyAction(partnerAdminDomain));
	}

	@RequestMapping( value = "removeAction" , method = RequestMethod.POST )
	public void removeAction( PartnerAdminDomain partnerAdminDomain , HttpServletRequest request , HttpSession session , Model model ) {
		logger.debug("PartnerAdminController - removeAction");

		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		partnerAdminDomain.setUserLevelId(sessionUser.getUserLevelId());
		partnerAdminDomain.setLanguage(sessionUser.getLanguage());
		partnerAdminDomain.setLanguageClcd(sessionUser.getLanguageClcd());
		partnerAdminDomain.setUserSno(sessionUser.getUserSno());

		model.addAttribute("result" , partnerAdminService.deletePartner(partnerAdminDomain));
	}

	@RequestMapping( value = "exportAction" , method = RequestMethod.POST )
	public String exportAction( PartnerAdminDomain partnerAdminDomain , HttpSession session , Model model ) throws Exception {
		logger.debug("PartnerAdminController - exportAction");

		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		partnerAdminDomain.setUserLevelId(sessionUser.getUserLevelId());
		partnerAdminDomain.setLanguage(sessionUser.getLanguage());
		partnerAdminDomain.setLanguageClcd(sessionUser.getLanguageClcd());
		partnerAdminDomain.setUserSno(sessionUser.getUserSno());

		String filename = partnerAdminDomain.getTitleName();
		filename = filename.replace('+' , ' ');

		List<LinkedHashMap<String, String>>	list	= partnerAdminService.selectExcelList(partnerAdminDomain);

		List<String>						title	= new ArrayList<String>();
		/** (title) header setting */
		for ( String mapKey : list.get(0).keySet() ) {
			title.add(mapKey);
		}

		/** 파일중복다운시 파일명+날짜(년월일시분초[언어별]) 표시 */
		model.addAttribute("list" , list);
		model.addAttribute("title" , title);
		model.addAttribute("nowDate" , commonService.getNowDate(partnerAdminDomain.getLanguage()));
		model.addAttribute("filename" , filename);
		return "excelViewer";
	}

	@RequestMapping( value = "resetPassword" , method = RequestMethod.POST )
	public void resetPassword( PartnerAdminDomain partnerAdminDomain , Model model , HttpSession session ) throws Exception {
		logger.debug("PartnerAdminController - resetPassword");

		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		partnerAdminDomain.setUserLevelId(sessionUser.getUserLevelId());
		partnerAdminDomain.setLanguage(sessionUser.getLanguage());
		partnerAdminDomain.setLanguageClcd(sessionUser.getLanguageClcd());
		partnerAdminDomain.setUserSno(sessionUser.getUserSno());

		partnerAdminDomain.setPasswd(initPassword);
		partnerAdminDomain.setMsgCtcd(SMS_MSG_CTCD_SERVICE_MESSAGE);
		partnerAdminDomain.setMsgCtnt("{\"user_fnm\" : \"" + partnerAdminDomain.getUser_fnm() + "\",\"password\" : \"" + initPassword + "\"}");

		// 참고 : loginService.resetPassword
		StringBuilder	temporaryPassword	= new StringBuilder();
		Random			random				= new Random();

		char[]			charset				= "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ".toCharArray();
		for ( int i = 0 ; i < 8 ; i++ ) {
			temporaryPassword.append(charset[ random.nextInt(charset.length) ]);
		}

		partnerAdminDomain.setPasswd(temporaryPassword.toString());
		// [id] 임시비밀번호는 ... 입니다.
		partnerAdminDomain.setMsgCtnt("[" + partnerAdminDomain.getUser_fnm() + "] 임시 비밀번호는 " + partnerAdminDomain.getPasswd() + " 입니다.");

		model.addAttribute("result" , partnerAdminService.resetPassword(partnerAdminDomain));
	}
}
