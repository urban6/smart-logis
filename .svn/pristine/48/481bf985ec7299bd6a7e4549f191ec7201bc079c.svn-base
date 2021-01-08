package kr.co.shovvel.dm.controller.management.common;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.shovvel.dm.domain.management.common.ManagementCommonFileDomain;
import kr.co.shovvel.dm.service.management.common.ManagementCommonFileService;

@Controller
@RequestMapping(value = "/management/comFile")
public class ManagetmentCommonFileController {
	
	private Logger logger = Logger.getLogger(this.getClass());
    
	@Autowired
	private ManagementCommonFileService mangementCommonFileService;
	
	/**
	 * 
	 * <PRE>
	 * 1. MethodName: upload
	 * 2. ClassName : ManagetmentCommonController
	 * 3. Comment   : (공통) 파일 업로드
	 * 4. 작성자    : 
	 * 5. 작성일    : 
	 * </PRE>
	 *   @param request
	 *   @param managementCommonFileDomain
	 *   @param model
	 *   @return String
	 * @throws IOException 
	 * @throws IllegalStateException 
	 */
	@RequestMapping(value="upload", method=RequestMethod.POST)
	public void upload(
			HttpServletRequest request,
			ManagementCommonFileDomain managementCommonFileDomain,
			Model model) throws IllegalStateException, IOException {
		
		mangementCommonFileService.insertFile(request, managementCommonFileDomain, model);
	}
	
	/**
	 * 
	 * <PRE>
	 * 1. MethodName: download
	 * 2. ClassName : ManagetmentCommonController
	 * 3. Comment   : (공통) 파일 다운로드
	 * 4. 작성자    : 
	 * 5. 작성일    : 
	 * </PRE>
	 *   @param request
	 *   @param managementCommonFileDomain
	 *   @param model
	 *   @return String
	 * @throws IOException 
	 * @throws IllegalStateException 
	 */
	@RequestMapping(value="download", method= {RequestMethod.GET, RequestMethod.POST})
	public void download(
			HttpServletRequest request,
			HttpServletResponse response,
			ManagementCommonFileDomain managementCommonFileDomain,
			Model model) throws IllegalStateException, IOException {
		
		mangementCommonFileService.downloadFile(request, response, managementCommonFileDomain, model);
	}
}