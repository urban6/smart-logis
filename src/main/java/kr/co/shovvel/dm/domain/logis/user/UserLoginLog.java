package kr.co.shovvel.dm.domain.logis.user;

import lombok.Builder;
import lombok.Data;

/**
 * 회원 로그인 이력
 */
@Data
@Builder
public class UserLoginLog {
    private String userLogNo;
    private String userUid;
    private String loginId;
    private String loginIp;
    private String loginDatetime;
	public String getUserLogNo() {
		return userLogNo;
	}
	public void setUserLogNo(String userLogNo) {
		this.userLogNo = userLogNo;
	}
	public String getUserUid() {
		return userUid;
	}
	public void setUserUid(String userUid) {
		this.userUid = userUid;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getLoginIp() {
		return loginIp;
	}
	public void setLoginIp(String loginIp) {
		this.loginIp = loginIp;
	}
	public String getLoginDatetime() {
		return loginDatetime;
	}
	public void setLoginDatetime(String loginDatetime) {
		this.loginDatetime = loginDatetime;
	}
	
	public static Object builder() {
		// TODO Auto-generated method stub
		return null;
	}
    
    
}
