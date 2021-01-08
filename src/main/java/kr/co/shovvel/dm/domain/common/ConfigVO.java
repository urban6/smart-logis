package kr.co.shovvel.dm.domain.common;

import com.mysql.jdbc.StringUtils;

import lombok.ToString;

@ToString
public class ConfigVO {
	
	private String driverClass;
	private String url;
	private String username;
	private String password;
	private Integer retry;
	private Integer waitingTime;
	private Integer loginSessionTimeout;
	
	public String getDriverClass() {
		return driverClass;
	}
	public void setDriverClass(String driverClass) {
		this.driverClass = driverClass;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Integer getRetry() {
		return retry;
	}
	public void setRetry(Integer retry) {
		this.retry = retry;
	}
	public Integer getWaitingTime() {
		return waitingTime;
	}
	public void setWaitingTime(Integer waitingTime) {
		this.waitingTime = waitingTime;
	}
	public Integer getLoginSessionTimeout() {
		return loginSessionTimeout;
	}
	public void setLoginSessionTimeout(Integer loginSessionTimeout) {
		this.loginSessionTimeout = loginSessionTimeout;
	}
	
	public String toValue() {
		String value = "driverClass=" + driverClass + ", url=";
		if (!StringUtils.isNullOrEmpty(username)) value += "***************"; 
		value += ", username=";
		if (!StringUtils.isNullOrEmpty(username)) value += "***************";  
		value += ", password=";
		if (!StringUtils.isNullOrEmpty(password)) value += "***************";
		value += ", retry=" + retry + ", waitingTime=" + waitingTime + "]";
		return value;
	}
	
}
