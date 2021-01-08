package kr.co.shovvel.dm.service.common;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.co.shovvel.dm.common.Consts;
import kr.co.shovvel.dm.dao.common.FileMapper;
import kr.co.shovvel.dm.domain.common.CommonFile;
import kr.co.shovvel.dm.domain.common.PrevSessionUser;
import kr.co.shovvel.hcf.utils.ConfigurationUtil;

@Service
public class FileService {

	private Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private FileMapper fileMapper;

	@Value("#{configuration['fileDirectoryPath']}")
	private String fileDirectoryPath;

	@Autowired
	private HttpServletRequest request;

	/**
	 * @param file_no
	 * @return
	 * 파일 정보 조회
	 */
	public CommonFile getCommonFile(String file_no) {
		CommonFile commonFile = new CommonFile();
		commonFile.setFile_sno(file_no);
		return fileMapper.getFile(commonFile);
	}

	/**
	 * @param commonFile
	 * @return
	 * 물리 파일 경로
	 * 파일 검색 속도를 위해 하나의 디렉토리에 파일을 100개씩만 저장한다.
	 */
	public String getFilePath(CommonFile commonFile) {
		int nFileNo = Integer.parseInt(commonFile.getFile_sno());
		int nSubDir = nFileNo / 100;
		String sFilePath = fileDirectoryPath + "/" + nSubDir + "/" + commonFile.getFile_save_nm();
		return sFilePath;
	}

    /**
     * @param file_no
     * @return
     * 파일 다운로드
     */
    public FileSystemResource downloadFile(String file_no) {
    	try {
    		CommonFile commonFile = this.getCommonFile(file_no);
    		if (commonFile == null) {
    			return null;
    		}
            String fullPath = this.getFilePath(commonFile);
            File downloadFile = new File(fullPath);
            return new FileSystemResource(downloadFile);
    	} catch (Exception ex) {
    		ex.printStackTrace();
    	}
    	return null;
    }

    public FileSystemResource downloadSFIcon(String icon_type, String file_no) {
    	try {
    		FileSystemResource ret = this.downloadFile(file_no);
    		if (ret == null || ret.getFile() == null || !ret.getFile().exists()) {
    			ret = this.downloadDefaultSFIcon(icon_type);
    		}
    		return ret;
    	} catch (Exception ex) {
    		ex.printStackTrace();
    	}
    	return null;
    }

    public FileSystemResource downloadDefaultSFIcon(String icon_type) {
    	try {
    		String fullPath = request.getSession().getServletContext().getRealPath("/images/icon/default_"+icon_type+".svg");
    		logger.debug(fullPath);
            File downloadFile = new File(fullPath);
            return new FileSystemResource(downloadFile);
    	} catch (Exception ex) {
    		ex.printStackTrace();
    	}
    	return null;
    }

    /**
     * @return
     * 파일 내용 조회
     */
    public String getFileContent(String file_no) {
    	try {
    		if (file_no == null || file_no.equals("")) {
    			return null;
    		}
    		CommonFile commonFile = this.getCommonFile(file_no);
    		if (commonFile == null) {
    			return null;
    		}
    		String sFilePath = this.getFilePath(commonFile);
    		return String.join("\n", Files.readAllLines(Paths.get(sFilePath)));
    	} catch (Exception ex) {
    		ex.printStackTrace();
    	}
    	return null;
    }

    /**
     * @return
     * 파일 내용 조회
     */
    public String getFileContentRead(String file_no) {
    	try {
    		if (file_no == null || file_no.equals("")) {
    			return null;
    		}
    		CommonFile commonFile = this.getCommonFile(file_no);
    		if (commonFile == null) {
    			return null;
    		}
    		String sFilePath = this.getFilePath(commonFile);

    		//Files.re

    		return String.join("\n", Files.readAllLines(Paths.get(sFilePath)));
    	} catch (Exception ex) {
    		ex.printStackTrace();
    	}
    	return null;
    }

    /**
	 * @param sFileName
	 * @return
	 * 파일 확장자를 리턴한다.
	 */
	public String getFileExt(String sFileName) {
		if (sFileName == null || sFileName.equals("")) {
			return "";
		}
		return sFileName.substring(sFileName.lastIndexOf(".")+1);
	}

    @Transactional
    public CommonFile saveMainFile(MultipartFile multipartFile, String sFilePath) throws Exception {
    	try {

        	HttpSession session = request.getSession(true);
        	PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);

        	String SubDir = (new ConfigurationUtil()).entryParse(sFilePath);
        	String saveFileDir = fileDirectoryPath + SubDir;


        	String file_real_name = multipartFile.getOriginalFilename();
        	String file_save_name = UUID.randomUUID().toString() + "." +  this.getFileExt(file_real_name);

        	CommonFile commonFile = new CommonFile();
        	commonFile.setFile_real_nm(file_real_name);
        	commonFile.setFile_save_nm(SubDir+"/"+file_save_name);
        	commonFile.setFile_clcd("00701120");
        	commonFile.setFile_sz(multipartFile.getSize());
        	commonFile.setIns_user_sno(sessionUser.getUserSno());

        	if (fileMapper.insertFile(commonFile) <= 0) {
        		throw new Exception("Faild to insert File.");
        	}

        	File fSubDir = new File(saveFileDir);
        	if (!fSubDir.exists()) {
        		fSubDir.mkdirs();
        	}

        	String filePath = fileDirectoryPath + commonFile.getFile_save_nm();

        	File file = new File(filePath);
        	multipartFile.transferTo(file);

        	return commonFile;
    	} catch (Exception ex) {
    		ex.printStackTrace();
    		throw new Exception(ex.getMessage());
    	}
    }

    @Transactional
    public CommonFile saveTumbFile(MultipartFile multipartFile, String sFilePath) throws Exception {
    	try {

        	HttpSession session = request.getSession(true);
        	PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);

        	String SubDir = (new ConfigurationUtil()).entryParse(sFilePath);
        	String saveFileDir = fileDirectoryPath + SubDir + "/";

        	String file_real_name = multipartFile.getOriginalFilename();
        	String file_save_name = UUID.randomUUID().toString() + "." +  this.getFileExt(file_real_name);

        	CommonFile commonFile = new CommonFile();
        	commonFile.setFile_real_nm(file_real_name);
        	commonFile.setFile_save_nm(SubDir+"/"+file_save_name);
        	commonFile.setFile_clcd("00701110");
        	commonFile.setFile_sz(multipartFile.getSize());
        	commonFile.setIns_user_sno(sessionUser.getUserSno());

        	if (fileMapper.insertFile(commonFile) <= 0) {
        		throw new Exception("Faild to insert File.");
        	}

        	File fSubDir = new File(saveFileDir);
        	if (!fSubDir.exists()) {
        		fSubDir.mkdirs();
        	}

        	String filePath = fileDirectoryPath + commonFile.getFile_save_nm();

        	File file = new File(filePath);
        	multipartFile.transferTo(file);

        	return commonFile;
    	} catch (Exception ex) {
    		ex.printStackTrace();
    		throw new Exception(ex.getMessage());
    	}
    }

    /**
     * infra, servicecore관련 yaml파일 수정
     * 파일명이 같은 경우 yaml파일 수정 가능, network slice가 deploy 상태이면 수정 불가능
     * @param multipartFile
     * @param sFileType
     * @param sFileNo
     * @return
     * @throws Exception
     */
    @Transactional
    public CommonFile updateFile(MultipartFile multipartFile, String sFileType, String sFileNo) throws Exception {
    	try {
        	String org_filename = multipartFile.getOriginalFilename();
        	String phy_filename = UUID.randomUUID().toString() + "." + this.getFileExt(org_filename);
        	HttpSession session = request.getSession(true);
        	PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);

        	CommonFile commonFile = new CommonFile();
        	commonFile.setFile_real_nm(org_filename);
        	commonFile.setFile_save_nm(phy_filename);
        	commonFile.setFile_clcd(sFileType);
        	commonFile.setIns_user_sno(sessionUser.getUserSno());
        	commonFile.setFile_sno(sFileNo);

        	if (fileMapper.updateFile(commonFile) <= 0) {
        		throw new Exception("Faild to update File.");
        	}

        	int nSubDir = Integer.parseInt(commonFile.getFile_sno()) / 100;
        	String sSubDir = fileDirectoryPath + nSubDir + "/";
        	File fSubDir = new File(sSubDir);
        	if (!fSubDir.exists()) {
        		fSubDir.mkdirs();
        	}

        	String sFilePath = sSubDir + commonFile.getFile_save_nm();
        	File file = new File(sFilePath);
        	multipartFile.transferTo(file);

        	return commonFile;
    	} catch (Exception ex) {
    		ex.printStackTrace();
    		throw new Exception(ex.getMessage());
    	}
    }

    @Transactional
    public CommonFile saveFile(File file, String sFileType) throws Exception {
    	try {
        	String org_filename = file.getName();
        	String phy_filename = UUID.randomUUID().toString() + "." + this.getFileExt(org_filename);
        	HttpSession session = request.getSession(true);
        	PrevSessionUser sessionUser = (PrevSessionUser) session.getAttribute(Consts.USER.SESSION_USER);

        	CommonFile commonFile = new CommonFile();
        	commonFile.setFile_real_nm(org_filename);
        	commonFile.setFile_save_nm(phy_filename);
        	commonFile.setFile_clcd(sFileType);
        	commonFile.setIns_user_sno(sessionUser.getUserSno());

        	if (fileMapper.insertFile(commonFile) <= 0) {
        		throw new Exception("Faild to insert File.");
        	}

        	int nSubDir = Integer.parseInt(commonFile.getFile_sno()) / 100;
        	String sSubDir = fileDirectoryPath + "/" + nSubDir + "/";
        	File fSubDir = new File(sSubDir);
        	if (!fSubDir.exists()) {
        		fSubDir.mkdirs();
        	}

        	String sFilePath = sSubDir + commonFile.getFile_save_nm();
        	Files.move(Paths.get(file.getPath()), Paths.get(sFilePath));

        	return commonFile;
    	} catch (Exception ex) {
    		ex.printStackTrace();
    		throw new Exception(ex.getMessage());
    	}
    }

    /**
     * @param file_type
     * @return
     * SO_FILE.FILE_TYPE = file_type 에 해당하는 모든 정보를 삭제처리한다.(DELETE_YN = Y)
     */
    public int deleteFilesByFileType(String file_type) {
    	return fileMapper.deleteFilesByType(file_type);
    }

    public CommonFile getYamlFile() {
    	return fileMapper.getYamlFile();
    }

    public CommonFile getYamlFileSA(CommonFile commonFile) {
    	return fileMapper.getYamlFileSA(commonFile);
    }

}
