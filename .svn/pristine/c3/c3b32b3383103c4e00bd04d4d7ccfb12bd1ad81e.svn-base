package kr.co.shovvel.dm.service.common;

import java.nio.file.Files;
import java.nio.file.Paths;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ContentFormatFileService {

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private HttpServletRequest request;
	
	 /**
     * @return
     * 파일 내용 조회
     */
    public String getFileContentFormat(String filename) {
    	try {
    		if (filename == null || filename.equals("")) {
    			return null;
    		}
    		
    		String fullPath = request.getSession().getServletContext().getRealPath("contentFormat/"+filename+".html");
    		
    		logger.debug(fullPath);
    		logger.debug(String.join("\n", Files.readAllLines(Paths.get(fullPath))));
    		return String.join("\n", Files.readAllLines(Paths.get(fullPath)));
    	} catch (Exception ex) {
    		ex.printStackTrace();
    	}
    	return null;
    }
    
}
