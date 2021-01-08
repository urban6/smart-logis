package kr.co.shovvel.dm.domain.common;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class PrevSessionUser {
	private String	userSno;
	private String	partnerSno;
	private String	partnerClcd;
	private String	userFnm;
	private String	userIpAddress;
	private String	userIpBandwidth;
	private String	userLevel;
	private String	userLevelId;
	private String	userLoginDate;
	private String	language;
	private String	country;
	private String	languageClcd;
	private String	zoneOffset;
	private String	patternDate;
	private String	patternTime;
	private String	patternMonth;
	private String	loginGatewayIp;
	private String	lastLoginDate;
	private String	lastLoginTime;
	private String	loginId;
	
	
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
	public String getPartnerClcd() {
		return partnerClcd;
	}
	public void setPartnerClcd(String partnerClcd) {
		this.partnerClcd = partnerClcd;
	}
	public String getUserFnm() {
		return userFnm;
	}
	public void setUserFnm(String userFnm) {
		this.userFnm = userFnm;
	}
	public String getUserIpAddress() {
		return userIpAddress;
	}
	public void setUserIpAddress(String userIpAddress) {
		this.userIpAddress = userIpAddress;
	}
	public String getUserIpBandwidth() {
		return userIpBandwidth;
	}
	public void setUserIpBandwidth(String userIpBandwidth) {
		this.userIpBandwidth = userIpBandwidth;
	}
	public String getUserLevel() {
		return userLevel;
	}
	public void setUserLevel(String userLevel) {
		this.userLevel = userLevel;
	}
	public String getUserLevelId() {
		return userLevelId;
	}
	public void setUserLevelId(String userLevelId) {
		this.userLevelId = userLevelId;
	}
	public String getUserLoginDate() {
		return userLoginDate;
	}
	public void setUserLoginDate(String userLoginDate) {
		this.userLoginDate = userLoginDate;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getLanguageClcd() {
		return languageClcd;
	}
	public void setLanguageClcd(String languageClcd) {
		this.languageClcd = languageClcd;
	}
	public String getZoneOffset() {
		return zoneOffset;
	}
	public void setZoneOffset(String zoneOffset) {
		this.zoneOffset = zoneOffset;
	}
	public String getPatternDate() {
		return patternDate;
	}
	public void setPatternDate(String patternDate) {
		this.patternDate = patternDate;
	}
	public String getPatternTime() {
		return patternTime;
	}
	public void setPatternTime(String patternTime) {
		this.patternTime = patternTime;
	}
	public String getPatternMonth() {
		return patternMonth;
	}
	public void setPatternMonth(String patternMonth) {
		this.patternMonth = patternMonth;
	}
	public String getLoginGatewayIp() {
		return loginGatewayIp;
	}
	public void setLoginGatewayIp(String loginGatewayIp) {
		this.loginGatewayIp = loginGatewayIp;
	}
	public String getLastLoginDate() {
		return lastLoginDate;
	}
	public void setLastLoginDate(String lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}
	public String getLastLoginTime() {
		return lastLoginTime;
	}
	public void setLastLoginTime(String lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	
	
}
