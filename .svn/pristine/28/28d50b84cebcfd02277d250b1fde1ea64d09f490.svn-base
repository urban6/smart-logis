package kr.co.shovvel.dm.controller.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URLDecoder;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.JsonObject;

import kr.co.shovvel.dm.common.DMConstants;
import kr.co.shovvel.dm.domain.common.CommonFile;
import kr.co.shovvel.dm.service.common.FileService;
import kr.co.shovvel.hcf.utils.ConfigurationUtil;

@Controller
@RequestMapping(value = "/management/file")
public class FileController {
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private FileService fileService;
	
	@Value("#{configuration['fileDirectoryPath']}")
	private String fileDirectoryPath;

	@RequestMapping("/download/{file_no:.+}")
	public @ResponseBody FileSystemResource downloadFile(@PathVariable("file_no") String file_no) {
		return fileService.downloadFile(file_no);
	}
	
	@RequestMapping(value="fileDownload")
	public @ResponseBody void fileDownload(HttpServletResponse response, CommonFile commonfile) throws Exception {
		
		if(commonfile.getFile_save_nm() != null){
			String localFileName = commonfile.getFile_real_nm();
			String localPath = URLDecoder.decode(commonfile.getFile_save_nm(), "UTF-8");
			File configFile = new File (fileDirectoryPath + localPath);			
			InputStream is = new FileInputStream(configFile);

		    response.setHeader("Content-Disposition", "attachment; filename="+localFileName);
		    FileCopyUtils.copy(is, response.getOutputStream());
		    response.flushBuffer();			
		}
	}

	@RequestMapping(value = "fileUpload", method = RequestMethod.POST)
	public String fileUpload(Model model, HttpServletRequest request) {
		String strResult = "fail";
		
		if(!(request instanceof MultipartHttpServletRequest)){
			logger.info("not instance MultipartHttpServletRequest!!!");
			
			model.addAttribute("returnMsg", "false");
			model.addAttribute("resultMsg", "");
			
			strResult = "fail";
		}
			
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Iterator<String> itr =  multipartRequest.getFileNames();
		
		if (itr.hasNext()) {
			MultipartFile fileInfo = multipartRequest.getFile(itr.next());
			String org_filename = fileInfo.getOriginalFilename();

			// 확장자 확인        
			int index = org_filename.lastIndexOf( "." );
			String fileName = org_filename.substring(0, index);
			String extension = org_filename.substring(index);   
			
			String phy_filename = fileName + "_" +System.currentTimeMillis() + extension;
			
			File file = new File(fileDirectoryPath + phy_filename);
			if (file != null && !file.exists()) {
				file.mkdirs();
		    }
			
			try {
				if (!fileInfo.isEmpty()) {
					fileInfo.transferTo(file);
					
					model.addAttribute("org_filename", org_filename);
					model.addAttribute("phy_filename", phy_filename);
//					model.addAttribute("filesize", fileInfo.getSize());
					strResult = "succ";
	    		}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		model.addAttribute("result", strResult);
		return "succ";
	}
	
	@RequestMapping(value = "fileUpload/{filepath}", method = RequestMethod.POST)
	public @ResponseBody String mainFileUpload(Model model, HttpServletRequest request, @PathVariable ("filepath") String filepath) {
		JsonObject strResult = new JsonObject();
		String resultMsg =   DMConstants.Result.FAIL;
		
		if(!(request instanceof MultipartHttpServletRequest)){
			logger.info("not instance MultipartHttpServletRequest!!!");
			resultMsg =  DMConstants.Result.FAIL;	
		}
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Iterator<String> itr =  multipartRequest.getFileNames();
		
		if (itr.hasNext()) {
			MultipartFile fileInfo = multipartRequest.getFile(itr.next());
			try {
				if (!fileInfo.isEmpty()) {
					CommonFile commonFile =fileService.saveMainFile(fileInfo, filepath);
					strResult.addProperty("file_sno", commonFile.getFile_sno());
					strResult.addProperty("file_real_nm", commonFile.getFile_real_nm());
					strResult.addProperty("file_save_nm", commonFile.getFile_save_nm());
					resultMsg =  DMConstants.Result.OK;	
	    		}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		strResult.addProperty("resultMsg", resultMsg);
		
		return strResult.toString();
	}
	
	@RequestMapping(value = "thumbFileUpload/{filepath}", method = RequestMethod.POST)
	public @ResponseBody String thumbFileUpload( HttpServletRequest request, @PathVariable ("filepath") String filepath) {
		
		JsonObject strResult = new JsonObject();
		String resultMsg =   DMConstants.Result.FAIL;
		
		if(!(request instanceof MultipartHttpServletRequest)){
			logger.info("not instance MultipartHttpServletRequest!!!");
			resultMsg =  DMConstants.Result.FAIL;	
		}
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Iterator<String> itr =  multipartRequest.getFileNames();
		
		if (itr.hasNext()) {
			MultipartFile fileInfo = multipartRequest.getFile(itr.next());
			try {
				if (!fileInfo.isEmpty()) {
					CommonFile commonFile =fileService.saveTumbFile(fileInfo, filepath);
					strResult.addProperty("file_sno", commonFile.getFile_sno());
					strResult.addProperty("file_real_nm", commonFile.getFile_real_nm());
					strResult.addProperty("file_save_nm", commonFile.getFile_save_nm());
					resultMsg =  DMConstants.Result.OK;	
	    		}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		strResult.addProperty("resultMsg", resultMsg);
		
		return strResult.toString();
	}
}
