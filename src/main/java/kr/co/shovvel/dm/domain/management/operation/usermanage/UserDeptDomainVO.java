package kr.co.shovvel.dm.domain.management.operation.usermanage;

import lombok.Data;

@Data
public class UserDeptDomainVO {

	/** 부서 코드 */
	private String	dept;
	/** 부서 이름 */
	private String	deptNm;
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getDeptNm() {
		return deptNm;
	}
	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}
	
}
