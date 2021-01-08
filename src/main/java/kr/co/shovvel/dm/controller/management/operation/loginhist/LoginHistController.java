package kr.co.shovvel.dm.controller.management.operation.loginhist;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.shovvel.dm.common.Consts;
import kr.co.shovvel.dm.domain.common.PrevSessionUser;
import kr.co.shovvel.dm.domain.common.paging.Paging;
import kr.co.shovvel.dm.domain.management.operation.loginhist.Condition;
import kr.co.shovvel.dm.domain.management.operation.loginhist.LoginHistDomain;
import kr.co.shovvel.dm.domain.management.operation.userlevel.UserLevelDomain;
import kr.co.shovvel.dm.service.common.CommonService;
import kr.co.shovvel.dm.service.management.operation.loginhist.LoginHistService;
import kr.co.shovvel.dm.service.management.operation.usermanage.UserManageService;
import kr.co.shovvel.hcf.utils.PasingUtil;
import kr.co.shovvel.hcf.utils.StringUtils;

@Controller
@RequestMapping( value = "/management/operation/loginhist" )
public class LoginHistController {
	private Logger				logger	= Logger.getLogger(this.getClass());

	@Autowired
	private LoginHistService	loginHistService;
	private String				thisUrl	= "management/operation/loginhist";

	// operation history insert를 위한 서비스
	@Autowired
	private CommonService		commonService;

	// user group 검색을 위한 서비스
	@Autowired
	private UserManageService	userLevelService;

	/**
	 * <PRE>
	 * 1. MethodName: list
	 * 2. ClassName : LoginHistController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2016. 4. 7. 오후 7:56:09
	 * </PRE>
	 *
	 * @return String
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping( value = "list" , method = RequestMethod.POST )
	public String list( HttpSession session , Model model ) throws Exception {
		// 1.Display 2.Search 3.Insert 4.Delete 5.Update 6.Save
		// commonService.insertOperationHist("1");

		// session
		PrevSessionUser sessionUser		= (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);

		UserLevelDomain	userLevelDomain	= new UserLevelDomain();
		userLevelDomain.setUserLevelId(sessionUser.getUserLevelId());
		String language = sessionUser.getLanguage();

		model.addAttribute("startDate" , commonService.getNowDate(language));
		model.addAttribute("endDate" , commonService.getNowDate(language));
		model.addAttribute("endHour" , commonService.getNowHour());
		model.addAttribute("endMin" , StringUtils.lpad(commonService.getNowMin() , 2 , '0'));
		model.addAttribute("listUserLevel" , userLevelService.listUserLevel(userLevelDomain.getUserLevelId()));
		return thisUrl + "/list";
	}

	/**
	 * <PRE>
	 * 1. MethodName: listAction
	 * 2. ClassName : LoginHistController
	 * 3. Comment   :
	 * 4. 작성자    :
	 * 5. 작성일    : 2016. 4. 7. 오후 7:56:06
	 * </PRE>
	 *
	 * @return String
	 * @param condition
	 * @param page
	 * @param perPage
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping( value = "listAction" , method = RequestMethod.POST )
	public String listAction( Condition condition , @RequestParam( required = false , defaultValue = "1" ) int page , @RequestParam( required = false , defaultValue = "10" ) int perPage , HttpSession session ,
			Model model ) throws Exception {
		// session
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		condition.setUserLevelId(sessionUser.getUserLevelId());
		condition.setLanguage(sessionUser.getLanguage());
		// Keyword 검색 처리
		String	searchType	= condition.getSearchType();	// code , probable_cause, description
		String	searchText	= condition.getSearchText();	// 검색 text
		if ( searchText != null ) {
			searchText = searchText.trim();
			if ( "userSno".equals(searchType) )
				condition.setUserSno(searchText);
			if ( "userFnm".equals(searchType) )
				condition.setUserFnm(searchText);
		}

		// paging
		Paging					paging	= new Paging();
		List<LoginHistDomain>	list	= null;
		int						count	= 0;

		count = loginHistService.count(condition);
		page = PasingUtil.getPage(page , perPage , count);
		if ( count > 0 ) {
			list = loginHistService.list(condition , page , perPage);
		}

		// paging을 위한 DTO를 생성
		paging.setLists(list); // 결과를 DTO에 저장
		paging.setTotalCount(count); // 결과 갯수를 DTO에 저장
		paging.setPage(page); // 현재 페이지를 저장
		paging.setPerPage(perPage); // 페이징수

		model.addAttribute("loginHistList" , paging);

		return thisUrl + "/listAction";
	}

}
