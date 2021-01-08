package kr.co.shovvel.dm.domain.common.listener;

import lombok.ToString;

@ToString
public class StartupListenerDomain {
	
	private String developerId;
	private String user_sno;
	public String getDeveloperId() {
		return developerId;
	}
	public void setDeveloperId(String developerId) {
		this.developerId = developerId;
	}
	public String getUser_sno() {
		return user_sno;
	}
	public void setUser_sno(String user_sno) {
		this.user_sno = user_sno;
	}

	
	
}
