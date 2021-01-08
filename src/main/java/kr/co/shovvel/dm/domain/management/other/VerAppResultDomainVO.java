package kr.co.shovvel.dm.domain.management.other;

import lombok.Data;

@Data
public class VerAppResultDomainVO {
	/** 결과 코드 */
	private String	resultCode	= "";
	/** 결과 내용 */
	private String	resultMsg	= "";
	public String getResultCode() {
		return resultCode;
	}
	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}
	public String getResultMsg() {
		return resultMsg;
	}
	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}
	
	
}
