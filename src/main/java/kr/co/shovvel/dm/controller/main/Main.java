package kr.co.shovvel.dm.controller.main;

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
import kr.co.shovvel.dm.domain.common.PrevSessionUser;
import kr.co.shovvel.dm.domain.common.paging.Paging;
import kr.co.shovvel.dm.domain.main.DashboardPresent;
import kr.co.shovvel.dm.domain.main.DashboardProduct;
import kr.co.shovvel.dm.service.main.MainService;
import kr.co.shovvel.hcf.utils.PasingUtil;

@Controller
@RequestMapping(value = "/main")
public class Main {
	private Logger logger = Logger.getLogger(this.getClass());
	
	private String thisUrl = "main";
	
	@Autowired
	private	MainService mainService;

	@RequestMapping(value = "main")
	public String main(HttpServletRequest request, HttpSession session, Model model) {
		
		return thisUrl + "/main";
	}

	@RequestMapping(value = "mainPresentAction", method = RequestMethod.POST)
	public String mainPresentAction(DashboardProduct dashboardProduct , HttpSession session , Model model) {
		
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		dashboardProduct.setUser_sno(sessionUser.getUserSno());
		String strUserLevelID = sessionUser.getUserLevelId();
		
		DashboardPresent dashboardPresent = new DashboardPresent();
		if(strUserLevelID == "6") {
			dashboardPresent = mainService.getMakePresent(dashboardProduct);
		} else if(strUserLevelID == "7") {
			dashboardPresent = mainService.getDeployPresent(dashboardProduct);
		} else {
			dashboardPresent = mainService.getMakePresent(dashboardProduct);
//			dashboardPresent = mainService.getDeployPresent(dashboardProduct);
		}
		
		// null일때 처리할 것
		String info = dashboardPresent.getPlan_job_product_info();
		
 
//			String tmp[] = info.split("<br>");
//			
//			if(tmp.length >3){
//				String result = "";
//				for(int i=0 ; i<3 ; i++){
//					result += tmp[i];
//					result += "<br>";
//				}
//				result += "...";
//				info = result;
//			} 

		
		dashboardPresent.setPlan_job_product_info(info);
		model.addAttribute("dashboardPresent", dashboardPresent);		
		return thisUrl + "/mainPresentAction";
	}
	
	@RequestMapping(value = "mainListAction", method = RequestMethod.POST)
	public String dashSearchAll(DashboardProduct dashboardProduct
            , @RequestParam(required=false, defaultValue="1") int page
            , @RequestParam(required=false, defaultValue="5") int perPage
            , HttpSession session
            , Model model) {

		//paging
		Paging paging = new Paging();		
		List<DashboardProduct> dashboardProductList = null;
		
		int count  = mainService.getProductListCount(dashboardProduct);
		page = PasingUtil.getPage(page, perPage, count);
		if(count > 0) {
			dashboardProductList = mainService.getProductList(dashboardProduct ,page , perPage);
			
			for(DashboardProduct dashboardProductTemp : dashboardProductList){
				dashboardProductTemp.setDashboardReferenceList(mainService.getReferenceList(dashboardProductTemp));
			}
		}
		
		//paging을 위한 DTO를 생성
		paging.setLists(dashboardProductList); //결과를 DTO에 저장
		paging.setTotalCount(count); //결과 갯수를 DTO에 저장	
		paging.setPage(page); //현재 페이지를 저장
		paging.setPerPage(perPage); //페이징수
		
		model.addAttribute("dashboardProductList", paging);
		
		return thisUrl + "/mainListAction";
	}
	
	@RequestMapping(value = "getProductRelateHostList", method = RequestMethod.POST )
	public String getProductRelateHostList(DashboardProduct dashboardProduct, HttpSession session, Model model){
		model.addAttribute("productRelateHostList", mainService.selectProductRelateHostList(dashboardProduct));
		return thisUrl + "/popupProductRelateHostList";
	}
	
}
