package kr.co.shovvel.dm.domain.management.other;

import lombok.Data;

@Data
public class VerAppUpFileDomainVO {
	/** 원본 파일명 */
	private String	fileName		= "";
	/** 업로드 파일 경로 */
	private String	uploadFilePath	= "";
	/** 업로드 디렉토리 경로 */
	private String	uploadDirPath	= "";
	/** 파일 크기 */
	private long	fileSize		= 0;
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getUploadFilePath() {
		return uploadFilePath;
	}
	public void setUploadFilePath(String uploadFilePath) {
		this.uploadFilePath = uploadFilePath;
	}
	public String getUploadDirPath() {
		return uploadDirPath;
	}
	public void setUploadDirPath(String uploadDirPath) {
		this.uploadDirPath = uploadDirPath;
	}
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	
	
}
