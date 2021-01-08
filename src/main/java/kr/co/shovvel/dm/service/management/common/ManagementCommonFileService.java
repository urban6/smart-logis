package kr.co.shovvel.dm.service.management.common;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.shovvel.dm.dao.management.common.ManagementCommonFileMapper;
import kr.co.shovvel.dm.domain.management.common.ManagementCommonFileDomain;
import kr.co.shovvel.hcf.utils.EncryptUtil;

@Service
public class ManagementCommonFileService {

    private Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private ManagementCommonFileMapper managementCommonFileMapper;
	
	public int insertFileByName(
			HttpServletRequest request,
			ManagementCommonFileDomain managementCommonFileDomain,
			Model model) throws IllegalStateException, IOException {
		
		model.addAttribute("rtnFlag", "N");
		
    	Map<String, MultipartFile> fileMap = getFileMap(request);
    	
    	// managementCommonFileDomain 내 등록 된 파일이 업로드 되었는지 여부에 따라 동작 
    	MultipartFile multipartFile = fileMap.get(managementCommonFileDomain.getFile_nm());
    	
    	if (multipartFile == null || multipartFile.getSize() <= 0) {
    		return -1;
    	}
    	
    	String fileRoot = request.getSession().getServletContext().getRealPath("/") + "attach" + File.separator + "files";
    	
		managementCommonFileDomain.setFile_cd(new Date().getTime() + "_" + (int)(Math.ceil(Math.floor(Math.random() * 999) + 111)) + (int)(Math.ceil(Math.floor(Math.random() * 999) + 111)));
		managementCommonFileDomain.setFile_nm(multipartFile.getOriginalFilename());
		managementCommonFileDomain.setFile_ext(multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf(".")+1).toLowerCase());
		managementCommonFileDomain.setFile_size(multipartFile.getSize());
		managementCommonFileDomain.setData_seq(managementCommonFileDomain.getData_seq());
		
		// 공통 > 첨부파일 등록
		managementCommonFileMapper.insertFile(managementCommonFileDomain);
		
		File uploadFolder = new File(fileRoot + File.separator + managementCommonFileDomain.getData_cd());
		String fileSeqEnc = EncryptUtil.md5(String.valueOf(managementCommonFileDomain.getSeq()));
		
		// 기존 중복 파일 삭제
		this.delDuplicateFile(uploadFolder, fileSeqEnc);
		
		// 파일 저장
		this.uploadFile(uploadFolder, fileSeqEnc, multipartFile);
    	
    	model.addAttribute("rtnFlag", "Y");
    	model.addAttribute("rtnSeq", managementCommonFileDomain.getSeq());
    	model.addAttribute("rtnMsg", "파일 저장완료.");
    	
    	return managementCommonFileDomain.getSeq();
	}
	
	// FileMap in MultipartHttpServletRequest
	// ex > HashMap<String, MultipartFile> fileMap = (HashMap<String, MultipartFile>) managementCommonFIleService.getFileMap(request);
	public Map<String, MultipartFile> getFileMap(HttpServletRequest request) {
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		return multipartHttpServletRequest.getFileMap();
	}
	
	public void insertFile(
			HttpServletRequest request,
			ManagementCommonFileDomain managementCommonFileDomain,
			Model model) throws IllegalStateException, IOException {
		
		model.addAttribute("rtnFlag", "N");
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();	    	
		
		String fileRoot = request.getSession().getServletContext().getRealPath("/") + "attach" + File.separator + "files";
		
		if(iterator.hasNext() == false) {
			return;
		}
		
		while(iterator.hasNext()){
			
			MultipartFile multipartFile = multipartHttpServletRequest.getFile(iterator.next());
			
			managementCommonFileDomain.setFile_cd(new Date().getTime() + "_" + (int)(Math.ceil(Math.floor(Math.random() * 999) + 111)) + (int)(Math.ceil(Math.floor(Math.random() * 999) + 111)));
			managementCommonFileDomain.setFile_nm(multipartFile.getOriginalFilename());
			managementCommonFileDomain.setFile_ext(multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf(".")+1).toLowerCase());
			managementCommonFileDomain.setFile_size(multipartFile.getSize());
			managementCommonFileDomain.setData_seq(managementCommonFileDomain.getData_seq());
			
			// 공통 > 첨부파일 등록
			managementCommonFileMapper.insertFile(managementCommonFileDomain);
			
			File uploadFolder = new File(fileRoot + File.separator + managementCommonFileDomain.getData_cd());
			String fileSeqEnc = EncryptUtil.md5(String.valueOf(managementCommonFileDomain.getSeq()));
			
			// 기존 중복 파일 삭제
			this.delDuplicateFile(uploadFolder, fileSeqEnc);
			
			// 파일 저장
			this.uploadFile(uploadFolder, fileSeqEnc, multipartFile);
		}
		
		model.addAttribute("rtnFlag", "Y");
		model.addAttribute("rtnSeq", managementCommonFileDomain.getSeq());
		model.addAttribute("rtnMsg", "파일 저장완료.");
	}
	
	public void delDuplicateFile(File uploadFolder, String fileSeqEnc) throws IllegalStateException, IOException {
		
		if (uploadFolder.exists() == false) {
			uploadFolder.mkdir();
		}
		
		File[] fileList = uploadFolder.listFiles();
		
		for(File tempFile : fileList) {
			if(tempFile.isFile()) {
				String fileName=tempFile.getName();
				if ( fileName.indexOf(fileSeqEnc+".") > -1 || fileName.indexOf(fileSeqEnc+"_") > -1 )	{
					File deleteFile = new File(uploadFolder.toString() + fileName);

					// 기존 중복 파일 삭제
					deleteFile.delete();
				}
			}
		}
	}
	
	public void uploadFile(File uploadFolder, String fileSeqEnc, MultipartFile multipartFile) throws IllegalStateException, IOException {
		
    	String originFileNm = multipartFile.getOriginalFilename();
    	String originFileExt = originFileNm.substring(originFileNm.lastIndexOf(".")+1);
    	
		// 파일 저장
		File uploadFile = new File(uploadFolder.toString() + File.separator + fileSeqEnc + "."  + originFileExt.toLowerCase());
		multipartFile.transferTo(uploadFile);
		
        // 원본 이미지를 리사이즈한다.
        // resize후 원본은 삭제한다.
        // 휴대폰에서 올리는 원본 이미지는 사이즈가 커서 다음과 같은 기준으로 이미지를 resize 한다.
        // width,height중 큰쪽을 기준으로 1024보다 크면 1024사이즈 배율로 이미지를 resize 한다.
        // 이미지 인경우에만 리사이즈를 수행한다.
        if( "jpg".equals(originFileExt) || "jpeg".equals(originFileExt) || "png".equals(originFileExt) || "gif".equals(originFileExt)  ) {
            resizeImage(uploadFolder.toString(), fileSeqEnc + "."  + originFileExt.toLowerCase());
			makeThumbImage(uploadFolder.toString(), fileSeqEnc + "."  + originFileExt.toLowerCase(), 200);
        }
	}

	
    private void resizeImage(String sFolder, String sFileName) {
        double fVal = 0;
        int nWidth, nHeight;

        String sOrgFileName = sFileName.substring(0, sFileName.lastIndexOf("."));
        String sOrgFileNameExt = sFileName.substring(sFileName.lastIndexOf(".")+1);

        String sFullOrgFileName = sFolder + "/" + sFileName;
        String sFullBakFileName = sFolder + "/" + sOrgFileName + "1." + sOrgFileNameExt;

        try {
            File input = new File(sFullOrgFileName);
            BufferedImage image = ImageIO.read(input);
            if( image.getWidth() > image.getHeight() )
            {
                if( image.getWidth() > 1024 )
                    fVal = (double)image.getWidth() / 1024.0;
            }
            else
            {
                if( image.getHeight() > 1024 )
                    fVal = (double)image.getHeight() / 1024.0;
            }

            if( fVal > 1 )
            {
                nWidth = (int)((double)image.getWidth() / fVal);
                nHeight = (int)((double)image.getHeight() / fVal);

                nWidth = nWidth + (4-nWidth % 4);
                nHeight = nHeight + (4-nHeight % 4);

                BufferedImage resized = resize(image, nHeight, nWidth);
                File output = new File(sFullBakFileName);
                ImageIO.write(resized, sOrgFileNameExt, output);

                input.delete();

                output.renameTo(input);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
	
	private void makeThumbImage(String sFolder, String sFileName, int thumbWidth) {
		int thumbHeight;
		double hVal = 0;

		String sOrgFileName = sFileName.substring(0, sFileName.lastIndexOf("."))+"_s";
		String sOrgFileNameExt = sFileName.substring(sFileName.lastIndexOf(".")+1);

		String sFullOrgFileName = sFolder + "/" + sFileName;
		String sFullBakFileName = sFolder + "/" + sOrgFileName + "." + sOrgFileNameExt;

		try {

			File input = new File(sFullOrgFileName);
			BufferedImage image = ImageIO.read(input);

			// 높이 리사이징
			hVal = (double)image.getWidth() / thumbWidth;
			thumbHeight = (int)((double)image.getHeight() / hVal);

			BufferedImage resized = resize(image, thumbHeight, thumbWidth);
			File output = new File(sFullBakFileName);
			ImageIO.write(resized, sOrgFileNameExt, output);

		} catch(Exception e) {
			e.printStackTrace();
		}
	}

    private BufferedImage resize(BufferedImage img, int height, int width) {
        Image tmp = img.getScaledInstance(width, height, Image.SCALE_SMOOTH);
        BufferedImage resized = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g2d = resized.createGraphics();
        g2d.drawImage(tmp, 0, 0, null);
        g2d.dispose();
        return resized;
    }
	
	public void downloadFile(
			HttpServletRequest request,
			HttpServletResponse response,
			ManagementCommonFileDomain managementCommonFIleDomain,
			Model model) throws IllegalStateException, IOException {
		
        // 공통 > 첨부파일 상세
        ManagementCommonFileDomain selectFileDetail = managementCommonFileMapper.selectFileDetail(managementCommonFIleDomain);
        
        String fileRoot = request.getSession().getServletContext().getRealPath("/") + "attach" + File.separator + "files";
        File uploadFolder = new File(fileRoot + File.separator + selectFileDetail.getData_cd());
		File downloadFile = new File(uploadFolder.toString() 
							+ File.separator 
							+ EncryptUtil.md5(String.valueOf(selectFileDetail.getSeq())) + "."  + selectFileDetail.getFile_ext().toLowerCase());
        
		InputStream is = new FileInputStream(downloadFile);

		String RealNm = new String(selectFileDetail.getFile_nm().getBytes("UTF-8"), "ISO-8859-1"); 
		String browser = request.getHeader("User-Agent"); //파일 인코딩 
		
		if( browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Chrome") ){ 
			RealNm = URLEncoder.encode(selectFileDetail.getFile_nm(),"UTF-8").replaceAll("\\+", "%20"); 
		} 
		
	    response.setHeader("Content-Disposition", "attachment; filename="+RealNm);
	    FileCopyUtils.copy(is, response.getOutputStream());
	    response.flushBuffer();		
	}
	
	public void updateFile(
			ManagementCommonFileDomain managementCommonFIleDomain,
			Model model) {
		
		// 공통 > 첨부파일 등록
		managementCommonFileMapper.updateFile(managementCommonFIleDomain);
		
	}
	
	public void updateUnuseFile(
			ManagementCommonFileDomain managementCommonFIleDomain,
			Model model) {
		
		// 공통 > 첨부파일 사용안함 변경
		managementCommonFileMapper.updateUnuseFile(managementCommonFIleDomain);
		
	}
	
	public ManagementCommonFileDomain selectFileDetail(
			ManagementCommonFileDomain managementCommonFIleDomain,
			Model model) {
		
		// 공통 > 첨부파일 상세
		return managementCommonFileMapper.selectFileDetail(managementCommonFIleDomain);
		
	}
	
	public List<ManagementCommonFileDomain> selectFileMutiList(
			ManagementCommonFileDomain managementCommonFIleDomain,
			Model model) {
		
		// 공통 > 첨부파일 상세 (복수 첨부 리스트)
		return managementCommonFileMapper.selectFileMutiList(managementCommonFIleDomain);
		
	}
	
	public List<ManagementCommonFileDomain> selectDeleteFileMutiList(
			ManagementCommonFileDomain managementCommonFIleDomain,
			Model model) {
		
		// 공통 > 첨부파일 삭제대상 (복수 첨부 리스트)
		return managementCommonFileMapper.selectDeleteFileMutiList(managementCommonFIleDomain);
		
	}
	
}
