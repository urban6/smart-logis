package kr.co.shovvel.dm.domain.management.login;

import java.io.Serializable;

import com.thoughtworks.xstream.annotations.XStreamAlias;

@XStreamAlias("ipBandwidth")
public class IpBandwidth implements Serializable {

	private static final long serialVersionUID = -7518621032196918539L;
	
	private int maxSimult;
	private int sessionCnt;
	
	private String ipManagerNo;
	private String ip;
	private String allowYn;
	private String description;

	public int getMaxSimult() {
		return maxSimult;
	}

	public void setMaxSimult(int maxSimult) {
		this.maxSimult = maxSimult;
	}

	public int getSessionCnt() {
		return sessionCnt;
	}

	public void setSessionCnt(int sessionCnt) {
		this.sessionCnt = sessionCnt;
	}

	public String getIpManagerNo() {
		return ipManagerNo;
	}

	public void setIpManagerNo(String ipManagerNo) {
		this.ipManagerNo = ipManagerNo;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getAllowYn() {
		return allowYn;
	}

	public void setAllowYn(String allowYn) {
		this.allowYn = allowYn;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Override
	public String toString() {
		return "IpBandwidth [maxSimult=" + maxSimult + ", sessionCnt=" + sessionCnt + ", ipManagerNo=" + ipManagerNo
				+ ", ip=" + ip + ", allowYn=" + allowYn + ", description=" + description + "]";
	}
	
	
}
