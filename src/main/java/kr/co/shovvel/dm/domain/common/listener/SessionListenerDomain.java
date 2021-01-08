package kr.co.shovvel.dm.domain.common.listener;

import lombok.ToString;

@ToString
public class SessionListenerDomain {
	
	private String sessionId;
	private String user_sno;
	
	private String login_date;
	private String logout_result;
	private String login_ip;
	
	public String getSessionId() {
		return sessionId;
	}
	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}
	public String getUser_sno() {
		return user_sno;
	}
	public void setUser_sno(String user_sno) {
		this.user_sno = user_sno;
	}
	public String getLogin_date() {
		return login_date;
	}
	public void setLogin_date(String login_date) {
		this.login_date = login_date;
	}
	public String getLogout_result() {
		return logout_result;
	}
	public void setLogout_result(String logout_result) {
		this.logout_result = logout_result;
	}
	public String getLogin_ip() {
		return login_ip;
	}
	public void setLogin_ip(String login_ip) {
		this.login_ip = login_ip;
	}
	
	
}
