package kr.co.shovvel.dm.domain.management.other;

import lombok.Data;

@Data
public class VerAppDomainVO {
	/** 버전 식별번호 */
	private int		verAppNum			= 0;
	/** 버전 타입 (P: 공용앱) */
	private String	verAppType			= "";
	/** 버전 번호 */
	private int		verAppNo			= 0;
	/** 버전 표시명 */
	private String	verAppStr			= "";
	/** 파일명 */
	private String	verAppFileNm		= "";
	/** 파일 경로 */
	private String	verAppFilePath		= "";
	/** 파일 크기 */
	private long	verAppFileSize		= 0;
	/** 버전 내용 */
	private String	verAppCnte			= "";
	/** 버전 삭제 여부 */
	private String	verAppDelYn			= "N";
	/** 버전 등록자 */
	private String	verAppRegUserSno	= "";
	/** 버전 등록일시 */
	private String	verAppRegDt			= "";
	/** 버전 등록일시 */
	private String	verAppRegDtTime		= "";
	/** 버전 수정자 */
	private String	verAppModUserSno	= "";
	/** 버전 수정일시 */
	private String	verAppModDt			= "";
	/** 버전 수정일시 */
	private String	verAppModDtTime		= "";
	public int getVerAppNum() {
		return verAppNum;
	}
	public void setVerAppNum(int verAppNum) {
		this.verAppNum = verAppNum;
	}
	public String getVerAppType() {
		return verAppType;
	}
	public void setVerAppType(String verAppType) {
		this.verAppType = verAppType;
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
	public String getVerAppFileNm() {
		return verAppFileNm;
	}
	public void setVerAppFileNm(String verAppFileNm) {
		this.verAppFileNm = verAppFileNm;
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
	public String getVerAppDelYn() {
		return verAppDelYn;
	}
	public void setVerAppDelYn(String verAppDelYn) {
		this.verAppDelYn = verAppDelYn;
	}
	public String getVerAppRegUserSno() {
		return verAppRegUserSno;
	}
	public void setVerAppRegUserSno(String verAppRegUserSno) {
		this.verAppRegUserSno = verAppRegUserSno;
	}
	public String getVerAppRegDt() {
		return verAppRegDt;
	}
	public void setVerAppRegDt(String verAppRegDt) {
		this.verAppRegDt = verAppRegDt;
	}
	public String getVerAppRegDtTime() {
		return verAppRegDtTime;
	}
	public void setVerAppRegDtTime(String verAppRegDtTime) {
		this.verAppRegDtTime = verAppRegDtTime;
	}
	public String getVerAppModUserSno() {
		return verAppModUserSno;
	}
	public void setVerAppModUserSno(String verAppModUserSno) {
		this.verAppModUserSno = verAppModUserSno;
	}
	public String getVerAppModDt() {
		return verAppModDt;
	}
	public void setVerAppModDt(String verAppModDt) {
		this.verAppModDt = verAppModDt;
	}
	public String getVerAppModDtTime() {
		return verAppModDtTime;
	}
	public void setVerAppModDtTime(String verAppModDtTime) {
		this.verAppModDtTime = verAppModDtTime;
	}
	
	
}
