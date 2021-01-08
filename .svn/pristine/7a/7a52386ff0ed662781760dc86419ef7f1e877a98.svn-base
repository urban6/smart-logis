package kr.co.shovvel.dm.controller.common;

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
import kr.co.shovvel.dm.domain.common.CommonDomain;
import kr.co.shovvel.dm.domain.common.PrevSessionUser;
import kr.co.shovvel.dm.service.common.CommonService;
import kr.co.shovvel.dm.service.management.login.PrevLoginService;

@Controller
@RequestMapping(value = "/common")
public class CommonController {
	
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private PrevLoginService loginService;
	
	
	@RequestMapping(value = "removeRecent", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> removeRecent(@RequestParam (required=false, defaultValue="") String menuId, HttpSession session) {
		logger.debug("menuId:"+menuId);
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("menuId", menuId);
		param.put("userSno", sessionUser.getUserSno());
		
		int result = commonService.removeRecent(param);
		if (result > 0) return commonService.findRecent(sessionUser.getUserSno());
		return null;
	}
	
	/**
	 * 
	 * <PRE>
	 * 1. MethodName: keepAlive
	 * 2. ClassName : CommonController
	 * 3. Comment   : 세션 유지 기능
	 * 4. 작성자    : 
	 * 5. 작성일    : 
	 * </PRE>
	 *   @return int
	 *   @param session
	 *   @param request
	 *   @return
	 */
	@RequestMapping(value = "keepAlive", method = RequestMethod.POST)
	public @ResponseBody int keepAlive(HttpSession session, HttpServletRequest request) {
		
		PrevSessionUser sessionUser = (PrevSessionUser)session.getAttribute(Consts.USER.SESSION_USER);
		
		if (sessionUser == null) {
			return Consts.VALID_USER.NULL;
		} 
		else {
			//접속 가능한자인지 체크한다. return 2;
			String isValidUser = loginService.isValidUser(sessionUser.getUserSno(), session.getId());
			
			if( !isValidUser.equals(Consts.ACCOUNT_STATUS.YES) ) {
				session.invalidate();
				return Consts.VALID_USER.INVALID;
			}
			
			//level이 변경됬는지 체크한다. return 3;
			String checkLevelId = commonService.getUserLevelId(sessionUser.getUserSno());
			
			if(!checkLevelId.equals(sessionUser.getUserLevelId())){
				session.invalidate();
				return Consts.VALID_USER.CHK_LEVEL;
			}
		}
		
		return Consts.VALID_USER.VALID;
	}
	
	/**
	 * <PRE>
	 * 1. MethodName: noSession
	 * 2. ClassName : CommonController
	 * 3. Comment   :
	 * 4. 작성자    : 
	 * 5. 작성일    : 
	 * </PRE>
	 *   @return String
	 *   @param session
	 *   @param request
	 *   @return
	 */
	@RequestMapping(value = "noSession")
	public String noSession(HttpSession session) {
		return "exception/noSession";
	}
	
	@RequestMapping(value = "getCodeList")
	public void getCodeList(Model model, CommonDomain commonCode) {
		model.addAttribute("codeList", commonService.getCodeList(commonCode));
	}
	
}
