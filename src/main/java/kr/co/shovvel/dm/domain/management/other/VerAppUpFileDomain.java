package kr.co.shovvel.dm.domain.management.other;

import org.springframework.web.multipart.MultipartFile;

import kr.co.shovvel.dm.domain.common.CommonCondition;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
public class VerAppUpFileDomain {
	private int				verAppNum		= 0;
	private int				verAppNo		= 0;
	private String			verAppStr		= "";
	private String			verAppStrOld	= "";
	private String			verAppFileName	= "";
	private String			verAppFilePath	= "";
	private long			verAppFileSize	= 0;
	private String			verAppCnte		= "";
	private String			verAppUserSno	= "";

	private MultipartFile	upFile;
	private String dbPath = "";
	public int getVerAppNum() {
		return verAppNum;
	}
	public void setVerAppNum(int verAppNum) {
		this.verAppNum = verAppNum;
	}
	public int getVerAppNo() {
		return verAppNo;
	}
	public void setVerAppNo(int verAppNo) {
		this.verAppNo = verAppNo;
	}
	public String getVerAppStr() {
		return verAppStr;
	}
	public void setVerAppStr(String verAppStr) {
		this.verAppStr = verAppStr;
	}
	public String getVerAppStrOld() {
		return verAppStrOld;
	}
	public void setVerAppStrOld(String verAppStrOld) {
		this.verAppStrOld = verAppStrOld;
	}
	public String getVerAppFileName() {
		return verAppFileName;
	}
	public void setVerAppFileName(String verAppFileName) {
		this.verAppFileName = verAppFileName;
	}
	public String getVerAppFilePath() {
		return verAppFilePath;
	}
	public void setVerAppFilePath(String verAppFilePath) {
		this.verAppFilePath = verAppFilePath;
	}
	public long getVerAppFileSize() {
		return verAppFileSize;
	}
	public void setVerAppFileSize(long verAppFileSize) {
		this.verAppFileSize = verAppFileSize;
	}
	public String getVerAppCnte() {
		return verAppCnte;
	}
	public void setVerAppCnte(String verAppCnte) {
		this.verAppCnte = verAppCnte;
	}
	public String getVerAppUserSno() {
		return verAppUserSno;
	}
	public void setVerAppUserSno(String verAppUserSno) {
		this.verAppUserSno = verAppUserSno;
	}
	public MultipartFile getUpFile() {
		return upFile;
	}
	public void setUpFile(MultipartFile upFile) {
		this.upFile = upFile;
	}
	public String getDbPath() {
		return dbPath;
	}
	public void setDbPath(String dbPath) {
		this.dbPath = dbPath;
	}
	
	
}
