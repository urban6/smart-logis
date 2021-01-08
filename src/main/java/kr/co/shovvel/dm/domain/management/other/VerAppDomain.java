package kr.co.shovvel.dm.domain.management.other;

import kr.co.shovvel.dm.domain.common.CommonCondition;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode( callSuper = true )
public class VerAppDomain extends CommonCondition {
	/** 버전 식별번호 */
	private int		verAppNum	= 0;
	/** 버전 타입 (P: 공용앱) */
	private String	verAppType	= "";
	/** 버전 번호 */
	private int		verAppNo	= 0;
	/** 버전 표시명 */
	private String	verAppStr	= "";
	/** DB 구분 */
	private String	dbPath	= "";
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
	public String getDbPath() {
		return dbPath;
	}
	public void setDbPath(String dbPath) {
		this.dbPath = dbPath;
	}
	
	
}
