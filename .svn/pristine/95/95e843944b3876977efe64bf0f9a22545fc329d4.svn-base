package kr.co.shovvel.dm.service.management.manager;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import kr.co.shovvel.dm.dao.management.manager.ManagerMapper;
import kr.co.shovvel.dm.domain.management.manager.ManagerDomain;
import kr.co.shovvel.hcf.utils.StringUtils;
import kr.co.shovvel.hcf.utils.pagingUtil;

@Service
public class ManagerService {

    private Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private ManagerMapper managerMapper;
	
	public void selectManagerListInfo(
			ManagerDomain managerDomain,
			Model model) {
		
		// 검색정보
		Map<String, Object> search =  new HashMap<String, Object>();
		search.put("search_type", managerDomain.getSearch_type());
		search.put("search_str", managerDomain.getSearch_str());
		search.put("view_rows", managerDomain.getView_rows());
		model.addAttribute("search", managerDomain);
		
		// 관리자 관리 > 리스트(갯수)
		int selectManagerListCnt = managerMapper.selectManagerListCnt(managerDomain);
		model.addAttribute("selectManagerListCnt", selectManagerListCnt);
		
		// 페이징 번호
		Map<String, Object> paging = pagingUtil.getInfo(managerDomain.getView_rows(), 10, selectManagerListCnt, managerDomain.getPage());
		managerDomain.setStartRow(Integer.parseInt(String.valueOf(paging.get("startRow"))));
		managerDomain.setEndRow(Integer.parseInt(String.valueOf(paging.get("endRow"))));
		model.addAttribute("paging", paging);	

		// 관리자 관리 > 리스트
		List<ManagerDomain> selectManagerList = managerMapper.selectManagerList(managerDomain);
		model.addAttribute("selectManagerList", selectManagerList);
	}
	
	public void selectManagerIdCheck(
			ManagerDomain managerDomain,
			Model model) {

		if (StringUtils.isEmpty(managerDomain.getMng_id())) {
			model.addAttribute("rtnMsg", "아이디를 입력해주세요");
			model.addAttribute("use_yn", "N");
			return;
		}
		
		// 관리자 관리 > 아이디 중복 확인 (갯수)
		int SelectManagerListCnt = managerMapper.selectMngIdCnt(managerDomain);
    	
		if (SelectManagerListCnt > 0) {
			model.addAttribute("rtnMsg", "이미 존재하는 아이디입니다. 다른 아이디를 입력해주세요.");
			model.addAttribute("use_yn", "N");
		} else {
			model.addAttribute("rtnMsg", "사용 가능한 아이디 입니다.");
			model.addAttribute("use_yn", "Y");
		}
	}
	
	public void insertManager(
			ManagerDomain managerDomain,
			Model model) throws Exception {
		
		// 관리자 관리 > 아이디 중복 확인
		this.selectManagerIdCheck(managerDomain, model);
		
		// if ("test".equals("teco"+"ee") == false) throw new Exception("에러 발생!!!");
		
		if (model.asMap().get("use_yn").equals("Y") == false) {
			model.addAttribute("rtnIsSucc", false);
			return;
		}
		
		String mng_mobile = StringUtils.nvl(managerDomain.getMng_mobile_1()) 
					+ "-" + StringUtils.nvl(managerDomain.getMng_mobile_2()) 
					+ "-" + StringUtils.nvl(managerDomain.getMng_mobile_3());
		
		managerDomain.setMng_mobile(mng_mobile);
		managerDomain.setMng_power("[USER],[COACH],[ASSIGN],[MISSION],[PROGRAM],[FEEDBACK]");
		
		// 관리자 관리 > 등록하기
		managerMapper.insertManager(managerDomain);
		
		model.addAttribute("rtnMsg", managerDomain.toString());
	}
	
	public void selectManagerDetail(
			ManagerDomain managerDomain,
			Model model) {
		
		ManagerDomain selectManagerDetail = managerMapper.selectManagerDetail(managerDomain);
		
		// 휴대폰 번호
		if (StringUtils.isEmpty(selectManagerDetail.getMng_mobile()) == false) {
			String[] mngMobileStrArr = StringUtils.nvl(selectManagerDetail.getMng_mobile()).split("-");
			int tmpIntI = 0;
			selectManagerDetail.setMng_mobile_1(mngMobileStrArr.length > tmpIntI ? mngMobileStrArr[tmpIntI++] : "");
			selectManagerDetail.setMng_mobile_2(mngMobileStrArr.length > tmpIntI ? mngMobileStrArr[tmpIntI++] : "");
			selectManagerDetail.setMng_mobile_3(mngMobileStrArr.length > tmpIntI ? mngMobileStrArr[tmpIntI] : "");
		}
		
		model.addAttribute("selectManagerDetail", selectManagerDetail);
	}
	
	public void updateUsedYn(
			ManagerDomain managerDomain,
			Model model) {
		
		// 관리자 관리 > 사용중지/허용
		managerMapper.updateUsedYn(managerDomain);
		
		// 관리자 관리 > 관리자 상세
		this.selectManagerDetail(managerDomain, model);
	}
	
	public void updateManager(
			String[] mng_power,
			ManagerDomain managerDomain,
			Model model) {
		
		// 메뉴 접근 권한
		if (mng_power != null) {
			ArrayList<String> listMng_power = new ArrayList<String>();
			for ( String objStr : (String[]) mng_power ){				
				listMng_power.add(objStr);
			}
			
			managerDomain.setMng_power(StringUtils.join(listMng_power, ","));
		}
		
		// 휴대폰 번호
		String mng_mobile = StringUtils.nvl(managerDomain.getMng_mobile_1()) 
				+ "-" + StringUtils.nvl(managerDomain.getMng_mobile_2()) 
				+ "-" + StringUtils.nvl(managerDomain.getMng_mobile_3());
		
		managerDomain.setMng_mobile(mng_mobile);
		
		// 관리자 관리 > 등록하기
		managerMapper.updateManager(managerDomain);
		
		// 관리자 관리 > 리스트
		this.selectManagerListInfo(managerDomain, model);
	}
	
}
