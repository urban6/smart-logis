package kr.co.shovvel.dm.domain.management.operation.usermanage;

import kr.co.shovvel.dm.domain.common.CommonCondition;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode( callSuper = true )
public class UserManageDomain extends CommonCondition {
	/* ONC_COM_USER */ /* 운영진; DM 서비스를 사용하는 운영진 (의료진, 관리자 등)의 정보를 관리 */
	/** 운영진 일련번호 */
	private String	userSno			= "";
	/** 파트너사 일련번호 */
	private String	partnerSno		= "";
	/** 레벨ID */
	private String	levelId			= "";
	/** 운영진 성명 */
	private String	userFnm			= "";
	/** 운영진 영문 성명 */
	private String	userEngFnm		= "";
	/** 운영진 아이디 */
	private String	loginId			= "";
	/** 운영진 비밀번호 (예전) */
	private String	passwdOld		= "";
	/** 운영진 비밀번호 */
	private String	passwd			= "";
	/** 운영진 비밀번호 (비교) */
	private String	passwd1			= "";
	/** 운영진 비밀번호 (비교) */
	private String	passwd2			= "";
	/**
	 * 운영진 유형코드 00201000 운영진 유형코드 00201100 전문가 00201200 의료진 00201300 콜센터 00201900
	 * 관리자, 00202000 슈퍼관리자
	 */
	private String	userCtcd		= "";
	/** 운영진 영역 구분코드 00201110 혈당전문가 00201120 식이전문   */
	private String	userAreaClcd	= "";
	/** 운영진 일반전화 번호 */
	private String	userTelNo		= "";
	/** 운영진 휴대전화 번호 */
	private String	userHpNo		= "";
	/** 운영진 이메일 */
	private String	userEmail		= "";
	/** 운영진 언어 코드 */
	private String	userLocale		= "";
	/** 운영진 혈당 단위 */
	private String	userGunitClcd	= "";
	/** 운영진 소속 */
	private String	userBelongto	= "";
	/** 운영진 소개 */
	private String	userIntroduce	= "";
	/** 이미지 파일 일련번호 */
	private String	imgFileSno		= "";
	/** 사용 여부 */
	private String	useYn			= "";
	/***/
	private String	insDt			= "";
	/** 등록자 일련번호 */
	private String	insUserSno		= "";
	/***/
	private String	updDt			= "";
	/** 수정자 일련번호 */
	private String	updUserSno		= "";
	/** 디폴트 비밀번호 여부 */
	private String	defaultPasswdYn	= "";
	/** 로그인횟수 */
	private String	loginCount		= "";
	/** 최종로그인IP */
	private String	lastLoginIp		= "";
	/** 최종로그인일시 */
	private String	lastLoginDate	= "";
	/** 비밀번호만료일 */
	private String	passwdExfire	= "";
	/** 계정만료일 */
	private String	accountExfire	= "";
	/** 상태 Y:정상, N:삭제, L:계정잠금(LOCK) */
	private String	status			= "Y";
	/** 상태설명 */
	private String	statusReason	= "";
	/** 재시도횟수 */
	private String	retryCount		= "";
	/***/
	private String	mark			= "";
	/** 생일 */
	private String	brdy			= "";
	/** 부서 */
	private String	dept			= "";
	/** 직원식별ID */
	private String	sid				= "";
	/** 비밀번호 초기화 여부 */
	private String	passwdInitYn	= "N";
	public String getUserSno() {
		return userSno;
	}
	public void setUserSno(String userSno) {
		this.userSno = userSno;
	}
	public String getPartnerSno() {
		return partnerSno;
	}
	public void setPartnerSno(String partnerSno) {
		this.partnerSno = partnerSno;
	}
	public String getLevelId() {
		return levelId;
	}
	public void setLevelId(String levelId) {
		this.levelId = levelId;
	}
	public String getUserFnm() {
		return userFnm;
	}
	public void setUserFnm(String userFnm) {
		this.userFnm = userFnm;
	}
	public String getUserEngFnm() {
		return userEngFnm;
	}
	public void setUserEngFnm(String userEngFnm) {
		this.userEngFnm = userEngFnm;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getPasswdOld() {
		return passwdOld;
	}
	public void setPasswdOld(String passwdOld) {
		this.passwdOld = passwdOld;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getPasswd1() {
		return passwd1;
	}
	public void setPasswd1(String passwd1) {
		this.passwd1 = passwd1;
	}
	public String getPasswd2() {
		return passwd2;
	}
	public void setPasswd2(String passwd2) {
		this.passwd2 = passwd2;
	}
	public String getUserCtcd() {
		return userCtcd;
	}
	public void setUserCtcd(String userCtcd) {
		this.userCtcd = userCtcd;
	}
	public String getUserAreaClcd() {
		return userAreaClcd;
	}
	public void setUserAreaClcd(String userAreaClcd) {
		this.userAreaClcd = userAreaClcd;
	}
	public String getUserTelNo() {
		return userTelNo;
	}
	public void setUserTelNo(String userTelNo) {
		this.userTelNo = userTelNo;
	}
	public String getUserHpNo() {
		return userHpNo;
	}
	public void setUserHpNo(String userHpNo) {
		this.userHpNo = userHpNo;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserLocale() {
		return userLocale;
	}
	public void setUserLocale(String userLocale) {
		this.userLocale = userLocale;
	}
	public String getUserGunitClcd() {
		return userGunitClcd;
	}
	public void setUserGunitClcd(String userGunitClcd) {
		this.userGunitClcd = userGunitClcd;
	}
	public String getUserBelongto() {
		return userBelongto;
	}
	public void setUserBelongto(String userBelongto) {
		this.userBelongto = userBelongto;
	}
	public String getUserIntroduce() {
		return userIntroduce;
	}
	public void setUserIntroduce(String userIntroduce) {
		this.userIntroduce = userIntroduce;
	}
	public String getImgFileSno() {
		return imgFileSno;
	}
	public void setImgFileSno(String imgFileSno) {
		this.imgFileSno = imgFileSno;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getInsDt() {
		return insDt;
	}
	public void setInsDt(String insDt) {
		this.insDt = insDt;
	}
	public String getInsUserSno() {
		return insUserSno;
	}
	public void setInsUserSno(String insUserSno) {
		this.insUserSno = insUserSno;
	}
	public String getUpdDt() {
		return updDt;
	}
	public void setUpdDt(String updDt) {
		this.updDt = updDt;
	}
	public String getUpdUserSno() {
		return updUserSno;
	}
	public void setUpdUserSno(String updUserSno) {
		this.updUserSno = updUserSno;
	}
	public String getDefaultPasswdYn() {
		return defaultPasswdYn;
	}
	public void setDefaultPasswdYn(String defaultPasswdYn) {
		this.defaultPasswdYn = defaultPasswdYn;
	}
	public String getLoginCount() {
		return loginCount;
	}
	public void setLoginCount(String loginCount) {
		this.loginCount = loginCount;
	}
	public String getLastLoginIp() {
		return lastLoginIp;
	}
	public void setLastLoginIp(String lastLoginIp) {
		this.lastLoginIp = lastLoginIp;
	}
	public String getLastLoginDate() {
		return lastLoginDate;
	}
	public void setLastLoginDate(String lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}
	public String getPasswdExfire() {
		return passwdExfire;
	}
	public void setPasswdExfire(String passwdExfire) {
		this.passwdExfire = passwdExfire;
	}
	public String getAccountExfire() {
		return accountExfire;
	}
	public void setAccountExfire(String accountExfire) {
		this.accountExfire = accountExfire;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getStatusReason() {
		return statusReason;
	}
	public void setStatusReason(String statusReason) {
		this.statusReason = statusReason;
	}
	public String getRetryCount() {
		return retryCount;
	}
	public void setRetryCount(String retryCount) {
		this.retryCount = retryCount;
	}
	public String getMark() {
		return mark;
	}
	public void setMark(String mark) {
		this.mark = mark;
	}
	public String getBrdy() {
		return brdy;
	}
	public void setBrdy(String brdy) {
		this.brdy = brdy;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public String getPasswdInitYn() {
		return passwdInitYn;
	}
	public void setPasswdInitYn(String passwdInitYn) {
		this.passwdInitYn = passwdInitYn;
	}
	
	

}
