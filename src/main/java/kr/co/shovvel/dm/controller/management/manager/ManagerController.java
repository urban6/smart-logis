package kr.co.shovvel.dm.controller.management.manager;

import java.util.Optional;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.shovvel.dm.domain.common.CommonCode;
import kr.co.shovvel.dm.domain.management.manager.ManagerDomain;
import kr.co.shovvel.dm.service.common.CommonCodeService;
import kr.co.shovvel.dm.service.management.manager.ManagerService;

@Controller
@RequestMapping(value = "/management/manager")
public class ManagerController {
	
	private Logger logger = Logger.getLogger(this.getClass());
    
	@Autowired
	private CommonCodeService commonCodeService;
	
	@Autowired
	private ManagerService managerService;
    
	/**
	 * 
	 * <PRE>
	 * 1. MethodName: manager
	 * 2. ClassName : ManagerController
	 * 3. Comment   : 관리자 관리
	 * 4. 작성자    : 
	 * 5. 작성일    : 
	 * </PRE>
	 *   @param managerDomain
	 *   @param page
	 *   @param perPage
	 *   @param model
	 *   @return String
	 */
    @RequestMapping(value="manager")
    public String manager(
    		ManagerDomain managerDomain,
    		@RequestParam(required=false, defaultValue="10") Optional<Integer> view_rows,
			@RequestParam(required=false, defaultValue="1") Optional<Integer> page,
    		Model model) {
    	
    	CommonCode commonCode1 = new CommonCode();
    	commonCode1.setCode_grp("1000");
    	model.addAttribute("sampleCodeList", commonCodeService.getCodeListMap(commonCode1));
    	//model.addAttribute("sampleDomain", sampleDomain);
    	
    	managerDomain.setPage(page.get().intValue());
    	managerDomain.setView_rows(view_rows.get().intValue());
    	
    	managerService.selectManagerListInfo(managerDomain, model);
		
    	return "management/manager/manager";
    }
    
    /**
     * 
     * <PRE>
     * 1. MethodName: manager_regstration
     * 2. ClassName : ManagerController
     * 3. Comment   : 관리자 관리 > 등록 페이지
     * 4. 작성자    : 
     * 5. 작성일    : 
     * </PRE>
     *   @param model
     *   @return String
     */
    @RequestMapping(value="manager_regstration")
    public String manager_regstration(
    		Model model) {
    	
    	return "management/manager/manager_regstration";
    }
    
    /**
     * 
     * <PRE>
     * 1. MethodName: managerIdCheck
     * 2. ClassName : ManagerController
     * 3. Comment   : 관리자 관리 > 등록 페이지 > 아이디 중복 확인
     * 4. 작성자    : 
     * 5. 작성일    : 
     * </PRE>
     *   @param managerDomain
     *   @param model
     */
    @RequestMapping(value="managerIdCheck", method=RequestMethod.POST)
    public void managerIdCheck(
    		ManagerDomain managerDomain,
    		Model model) {
    	
    	// 아이디 중복 확인
    	managerService.selectManagerIdCheck(managerDomain, model);
    }
    
    /**
     * 
     * <PRE>
     * 1. MethodName: insertManager
     * 2. ClassName : ManagerController
     * 3. Comment   : 관리자 관리 > 등록 페이지 > 관리자 등록
     * 4. 작성자    : 
     * 5. 작성일    : 
     * </PRE>
     *   @param managerDomain
     *   @param model
     *   @return String
     *   @throws Exception 
     */
    @RequestMapping(value="insertManager", method=RequestMethod.POST)
    public String insertManager(
    		ManagerDomain managerDomain,
    		Model model) throws Exception {
    	
    	// 관리자 등록
    	managerService.insertManager(managerDomain, model);
    	
    	return "redirect:/management/manager/manager";
    }
    
    /**
     * 
     * <PRE>
     * 1. MethodName: manager_detail
     * 2. ClassName : ManagerController
     * 3. Comment   : 관리자 관리 > 관리자 상세
     * 4. 작성자    : 
     * 5. 작성일    : 
     * </PRE>
     *   @param managerDomain
     *   @param model
     *   @return String
     */
    @RequestMapping(value="manager_detail")
    public String manager_detail(
    		ManagerDomain managerDomain,
    		Model model) {
    	
    	// 관리자 상세
    	managerService.selectManagerDetail(managerDomain, model);
    	
    	return "management/manager/manager_detail";
    }
    
    /**
     * 
     * <PRE>
     * 1. MethodName: used_yn
     * 2. ClassName : ManagerController
     * 3. Comment   : 관리자 관리 > 관리자 상세 > 사용 허용/중지
     * 4. 작성자    : 
     * 5. 작성일    : 
     * </PRE>
     *   @param managerDomain
     *   @param model
     *   @return String
     */
    @RequestMapping(value="used_yn")
    public String used_yn(
    		ManagerDomain managerDomain,
    		Model model) {
    	
    	// 관리자 상세
    	managerService.updateUsedYn(managerDomain, model);
    	
    	return "management/manager/manager_detail";
    }
    
    /**
     * 
     * <PRE>
     * 1. MethodName: updateManager
     * 2. ClassName : ManagerController
     * 3. Comment   : 관리자 관리 > 관리자 상세 > 수정완료
     * 4. 작성자    : 
     * 5. 작성일    : 
     * </PRE>
     *   @param managerDomain
     *   @param model
     *   @return String
     */
    @RequestMapping(value="updateManager")
    public String updateManager(
    		@RequestParam(required=false, defaultValue="10") Optional<Integer> view_rows,
    		@RequestParam(required=false) String[] mng_power,
    		ManagerDomain managerDomain,
    		Model model) {
    	
    	managerDomain.setView_rows(view_rows.get().intValue());
    	
    	// 관리자 상세
    	managerService.updateManager(mng_power, managerDomain, model);
    	
    	return "management/manager/manager";
    }
    
}
