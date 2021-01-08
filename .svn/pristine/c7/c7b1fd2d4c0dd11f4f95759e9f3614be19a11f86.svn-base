package kr.co.shovvel.dm.controller.management.partnermng.partner;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.shovvel.dm.common.Consts;
import kr.co.shovvel.dm.domain.common.CommonDomain;
import kr.co.shovvel.dm.domain.common.PrevSessionUser;
import kr.co.shovvel.dm.domain.common.paging.Paging;
import kr.co.shovvel.dm.domain.management.partnermng.partner.PartnerDomain;
import kr.co.shovvel.dm.service.common.CommonService;
import kr.co.shovvel.dm.service.management.partnermng.partner.PartnerService;
import kr.co.shovvel.hcf.utils.PasingUtil;

@Controller
@RequestMapping( value = "/management/partnermng/partner" )
public class PartnerController {
	private Logger			logger	= Logger.getLogger(this.getClass());
	private String			thisUrl	= "management/partnermng/partner";

	@Autowired
	PartnerService			partnerService;

	@Autowired
	private CommonService	commonService;

	@RequestMapping( value = "list" , method = RequestMethod.POST )
	public String list( PartnerDomain partnerDomain , Model model , HttpSession session ) throws Exception {
		logger.debug("PartnerController - list");
		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		partnerDomain.setUserLevelId(sessionUser.getUserLevelId());
		partnerDomain.setLanguage(sessionUser.getLanguage());
		partnerDomain.setLanguageClcd(sessionUser.getLanguageClcd());
		partnerDomain.setUserSno(sessionUser.getUserSno());

		CommonDomain commonDomain = new CommonDomain();
		commonDomain.setUpperComCd("50201000"); // 파트너사 구분코드
		commonDomain.setLanguageClcd(partnerDomain.getLanguageClcd());

		model.addAttribute("partnerClcdList", commonService.getCodeListMap(commonDomain));
		model.addAttribute("partnerDomain", partnerDomain);
		return thisUrl + "/list";
	}

	@RequestMapping( value = "listAction" , method = RequestMethod.POST )
	public String listAction( PartnerDomain partnerDomain ,
			@RequestParam( required = false , defaultValue = "1" ) int page ,
			@RequestParam( required = false , defaultValue = "10" ) int perPage , HttpSession session , Model model )
			throws Exception {
		logger.debug("PartnerController - listAction");

		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		partnerDomain.setUserLevelId(sessionUser.getUserLevelId());
		partnerDomain.setLanguage(sessionUser.getLanguage());
		partnerDomain.setLanguageClcd(sessionUser.getLanguageClcd());
		partnerDomain.setUserSno(sessionUser.getUserSno());

		Paging				paging	= new Paging();
		List<PartnerDomain>	list	= new ArrayList<PartnerDomain>();
		int					count	= 0;

		count = partnerService.selectPartnerCount(partnerDomain);
		page = PasingUtil.getPage(page, perPage, count);
		if ( count > 0 ) {
			list = partnerService.selectPartnerList(partnerDomain, page, perPage);
		}

		paging.setLists(list);
		paging.setTotalCount(count);
		paging.setPage(page);
		paging.setPerPage(perPage);

		model.addAttribute("partnerList", paging);

		return thisUrl + "/listAction";
	}

	@RequestMapping( value = "add" , method = RequestMethod.POST )
	public String add( PartnerDomain partnerDomain , HttpSession session , Model model ) throws Exception {
		logger.debug("PartnerController - add");
		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		partnerDomain.setUserLevelId(sessionUser.getUserLevelId());
		partnerDomain.setLanguage(sessionUser.getLanguage());
		partnerDomain.setLanguageClcd(sessionUser.getLanguageClcd());
		partnerDomain.setUserSno(sessionUser.getUserSno());

		CommonDomain commonDomain = new CommonDomain();
		commonDomain.setLanguageClcd(partnerDomain.getLanguageClcd());
		commonDomain.setUpperComCd("50201000"); // 파트너사 구분코드

		model.addAttribute("partnerClcdList", commonService.getCodeListMap(commonDomain));
		model.addAttribute("partnerDomain", partnerDomain);

		return thisUrl + "/add";
	}

	@RequestMapping( value = "getTypeList" , method = RequestMethod.POST )
	public void getTypeList( PartnerDomain partnerDomain , HttpSession session , Model model ) throws Exception {
		logger.debug("PartnerController - getTypeList");
		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		partnerDomain.setUserLevelId(sessionUser.getUserLevelId());
		partnerDomain.setLanguage(sessionUser.getLanguage());
		partnerDomain.setLanguageClcd(sessionUser.getLanguageClcd());
		partnerDomain.setUserSno(sessionUser.getUserSno());

		CommonDomain commonDomain = new CommonDomain();
		commonDomain.setLanguageClcd(partnerDomain.getLanguageClcd());

		if ( partnerDomain.getPartner_clcd().equals("50201020") ) {
			commonDomain.setUpperComCd("50202000"); // 보험사 종별 구분코드
		} else {
			commonDomain.setUpperComCd("50203000"); // 병원 종별 구분코드
		}
		model.addAttribute("partnerBusinessClcdList", commonService.getCodeListMap(commonDomain));
	}

	@RequestMapping( value = "addAction" , method = RequestMethod.POST )
	public void addAction( PartnerDomain partnerDomain , HttpServletRequest request , HttpSession session ,
			Model model ) {
		logger.debug("PartnerController - addAction");

		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		partnerDomain.setUserLevelId(sessionUser.getUserLevelId());
		partnerDomain.setLanguage(sessionUser.getLanguage());
		partnerDomain.setLanguageClcd(sessionUser.getLanguageClcd());
		partnerDomain.setUserSno(sessionUser.getUserSno());

		model.addAttribute("result", partnerService.addAction(partnerDomain, "10"));
	}

	@RequestMapping( value = "modify" , method = RequestMethod.POST )
	public String modify( PartnerDomain partnerDomain , HttpSession session , Model model ) throws Exception {
		logger.debug("PartnerController - modify");
		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		partnerDomain.setUserLevelId(sessionUser.getUserLevelId());
		partnerDomain.setLanguage(sessionUser.getLanguage());
		partnerDomain.setLanguageClcd(sessionUser.getLanguageClcd());
		partnerDomain.setUserSno(sessionUser.getUserSno());

		CommonDomain commonDomain = new CommonDomain();
		commonDomain.setLanguageClcd(partnerDomain.getLanguageClcd());

		model.addAttribute("partnerDomain", partnerDomain);
		logger.debug("Search Key:" + partnerDomain.getPartner_sno());
		PartnerDomain info = partnerService.selectPartnerInfo(partnerDomain);
		model.addAttribute("info", info);

		if ( info.getPartner_clcd().equals("50201020") ) {
			commonDomain.setUpperComCd("50202000"); // 보험사 종별 구분코드
		} else {
			commonDomain.setUpperComCd("50203000"); // 병원 종별 구분코드
		}
		model.addAttribute("cmbTypeList", commonService.getCodeListMap(commonDomain));

		return thisUrl + "/modify";
	}

	@RequestMapping( value = "modifyAction" , method = RequestMethod.POST )
	public void modifyAction( PartnerDomain partnerDomain , HttpSession session , Model model ) throws Exception {
		logger.debug("PartnerController - modifyAction");

		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		partnerDomain.setUserLevelId(sessionUser.getUserLevelId());
		partnerDomain.setLanguage(sessionUser.getLanguage());
		partnerDomain.setLanguageClcd(sessionUser.getLanguageClcd());
		partnerDomain.setUserSno(sessionUser.getUserSno());

		model.addAttribute("result", partnerService.modifyAction(partnerDomain));
	}

	@RequestMapping( value = "removeAction" , method = RequestMethod.POST )
	public void removeAction( PartnerDomain partnerDomain , HttpServletRequest request , HttpSession session ,
			Model model ) {
		logger.debug("PartnerController - removeAction");

		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		partnerDomain.setUserLevelId(sessionUser.getUserLevelId());
		partnerDomain.setLanguage(sessionUser.getLanguage());
		partnerDomain.setLanguageClcd(sessionUser.getLanguageClcd());
		partnerDomain.setUserSno(sessionUser.getUserSno());

		model.addAttribute("result", partnerService.deletePartner(partnerDomain));
	}

	@RequestMapping( value = "exportAction" , method = RequestMethod.POST )
	public String exportAction( PartnerDomain partnerDomain , HttpSession session , Model model ) throws Exception {
		logger.debug("PartnerController - exportAction");

		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		partnerDomain.setUserLevelId(sessionUser.getUserLevelId());
		partnerDomain.setLanguage(sessionUser.getLanguage());
		partnerDomain.setLanguageClcd(sessionUser.getLanguageClcd());
		partnerDomain.setUserSno(sessionUser.getUserSno());

		String filename = partnerDomain.getTitleName();
		filename = filename.replace('+', ' ');

		List<LinkedHashMap<String, String>>	list	= partnerService.selectExcelList(partnerDomain);

		List<String>						title	= new ArrayList<String>();
		/** (title) header setting */
		for ( String mapKey : list.get(0).keySet() ) {
			title.add(mapKey);
		}

		/** 파일중복다운시 파일명+날짜(년월일시분초[언어별]) 표시 */
		model.addAttribute("list", list);
		model.addAttribute("title", title);
		model.addAttribute("nowDate", commonService.getNowDate(partnerDomain.getLanguage()));
		model.addAttribute("filename", filename);
		return "excelViewer";
	}

}
