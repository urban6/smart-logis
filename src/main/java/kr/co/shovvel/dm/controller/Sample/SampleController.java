package kr.co.shovvel.dm.controller.Sample;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.shovvel.dm.common.Consts;
import kr.co.shovvel.dm.domain.common.CommonDomain;
import kr.co.shovvel.dm.domain.common.PrevSessionUser;
import kr.co.shovvel.dm.domain.common.paging.Paging;
import kr.co.shovvel.dm.domain.sample.SampleDomain;
import kr.co.shovvel.dm.service.common.CommonService;
import kr.co.shovvel.dm.service.sample.SampleService;
import kr.co.shovvel.hcf.utils.PasingUtil;

@Controller
@RequestMapping(value = "/sample")
public class SampleController {
	private Logger logger = Logger.getLogger(this.getClass());
	private String thisUrl = "sample";

	@Autowired
	SampleService sampleService;

	@Autowired
	private CommonService commonService;

	@Value("#{configuration['fileDirectoryPath']}")
	private String fileDirectoryPath;

	@RequestMapping(value="list", method=RequestMethod.POST)
	public String list(SampleDomain sampleDomain, Model model, HttpSession session) throws Exception{

		CommonDomain commonCode1 = new CommonDomain();
		commonCode1.setCodeGrp("1000");
		model.addAttribute("sampleCodeList", commonService.getCodeListMap(commonCode1));

		return thisUrl + "/list";
	}

	@RequestMapping(value="listAction", method=RequestMethod.POST)
	public String listAction(SampleDomain sampleDomain,
			@RequestParam(required=false, defaultValue="1") int page,
			@RequestParam(required=false, defaultValue="10")int perPage,
			HttpSession session, Model model) throws Exception{

		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		sampleDomain.setLanguageClcd(sessionUser.getLanguageClcd());
		sampleDomain.setZoneOffset(sessionUser.getZoneOffset());

		Paging paging = new Paging();
		List<SampleDomain> list = new ArrayList<SampleDomain>();
		int count = 0;

		count = sampleService.selectSampleCount(sampleDomain);
		page = PasingUtil.getPage(page, perPage, count);
		if(count > 0){
			list = sampleService.selectSampleList(sampleDomain, page, perPage);
		}

		paging.setLists(list);
		paging.setTotalCount(count);
		paging.setPage(page);
		paging.setPerPage(perPage);

		model.addAttribute("sampleList", paging);

		return thisUrl + "/listAction";
	}

	@RequestMapping(value="add", method=RequestMethod.POST)
	public String add(SampleDomain sampleDomain, HttpSession session, Model model) throws Exception {

		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		sampleDomain.setReg_user_sno(sessionUser.getUserSno());
		sampleDomain.setLanguageClcd(sessionUser.getLanguageClcd());

		CommonDomain commonCode1 = new CommonDomain();
		commonCode1.setCodeGrp("1000");
		model.addAttribute("sampleCodeList", commonService.getCodeListMap(commonCode1));

		model.addAttribute("sampleDomain", sampleDomain);

		return  thisUrl + "/add";
	}

	@RequestMapping(value = "addAction", method = RequestMethod.POST)
	public void addAction(SampleDomain sampleDomain, HttpServletRequest request, HttpSession session, Model model) {

		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		sampleDomain.setReg_user_sno(sessionUser.getUserSno());
		sampleDomain.setLanguageClcd(sessionUser.getLanguageClcd());

		model.addAttribute("result", sampleService.addAction(sampleDomain));
	}

	@RequestMapping(value="checkSampleName", method=RequestMethod.POST)
	public @ResponseBody String checkSampleName(SampleDomain sampleDomain
				    , HttpSession session
				    , Model model) throws Exception {
		return sampleService.checkSampleName(sampleDomain);
	}

	@RequestMapping(value="detail", method=RequestMethod.POST)
	public String detail(SampleDomain sampleDomain, HttpSession session, Model model) throws Exception{
		model.addAttribute("sampleDomainSearch", sampleDomain);

		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		sampleDomain.setReg_user_sno(sessionUser.getUserSno());
		sampleDomain.setLanguageClcd(sessionUser.getLanguageClcd());
		sampleDomain.setZoneOffset(sessionUser.getZoneOffset());

		SampleDomain sampleDomainInfo = sampleService.selectSampleInfo(sampleDomain);
		model.addAttribute("sampleDomainInfo", sampleDomainInfo);

		return thisUrl + "/detail";
	}

	@RequestMapping(value = "detailPopup", method = RequestMethod.POST )
	public String detailPopup(SampleDomain sampleDomain, HttpSession session, Model model){
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		sampleDomain.setReg_user_sno(sessionUser.getUserSno());
		sampleDomain.setLanguageClcd(sessionUser.getLanguageClcd());
		sampleDomain.setZoneOffset(sessionUser.getZoneOffset());

		SampleDomain sampleDomainInfo = sampleService.selectSampleInfo(sampleDomain);
		model.addAttribute("sampleDomainInfo", sampleDomainInfo);

		return thisUrl + "/detailPopup";
	}

	@RequestMapping(value="modify", method=RequestMethod.POST)
	public String modify(SampleDomain sampleDomain, HttpSession session, Model model) throws Exception{

		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		sampleDomain.setReg_user_sno(sessionUser.getUserSno());
		sampleDomain.setLanguageClcd(sessionUser.getLanguageClcd());
		sampleDomain.setZoneOffset(sessionUser.getZoneOffset());

		CommonDomain commonCode1 = new CommonDomain();
		commonCode1.setCodeGrp("1000");
		model.addAttribute("sampleCodeList", commonService.getCodeListMap(commonCode1));

		SampleDomain sampleDomainInfo = sampleService.selectSampleInfo(sampleDomain);
		model.addAttribute("sampleDomainInfo", sampleDomainInfo);

		return thisUrl + "/modify";
	}

	@RequestMapping(value="modifyAction", method=RequestMethod.POST)
	public void modifyAction (SampleDomain sampleDomain
						    , HttpSession session
			                , Model model) throws Exception{
		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		sampleDomain.setReg_user_sno(sessionUser.getUserSno());
		sampleDomain.setLanguageClcd(sessionUser.getLanguageClcd());

		model.addAttribute("result", sampleService.modifyAction(sampleDomain));
	}

	@RequestMapping(value = "removeSampleAction", method = RequestMethod.POST)
	public void removeSampleAction(SampleDomain sampleDomain, HttpServletRequest request, HttpSession session, Model model) {

		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		sampleDomain.setReg_user_sno(sessionUser.getUserSno());
		sampleDomain.setLanguageClcd(sessionUser.getLanguageClcd());

		model.addAttribute("result", sampleService.deleteSampleAction(sampleDomain));
	}

	@RequestMapping(value="exportAction", method=RequestMethod.POST)
	public String exportAction(SampleDomain sampleDomain
			                 , HttpSession session
			                 , Model model) throws Exception{

		PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);
		sampleDomain.setReg_user_sno(sessionUser.getUserSno());
		sampleDomain.setLanguageClcd(sessionUser.getLanguageClcd());
		sampleDomain.setZoneOffset(sessionUser.getZoneOffset());

		String filename = sampleDomain.getTitleName();
		filename = filename.replace('+', ' ');
		List<LinkedHashMap<String, String>> list = sampleService.selectExcelList(sampleDomain);

		model.addAttribute("list", list); //엑셀에 넣을 user data list
	 	model.addAttribute("nowDate", commonService.getNowDateTime(sampleDomain.getLanguage())); //현재 시간
	 	model.addAttribute("filename", filename); //파일 이름

	 	return "excelViewer";
	}

}
