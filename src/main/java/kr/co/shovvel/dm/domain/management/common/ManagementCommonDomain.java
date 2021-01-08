package kr.co.shovvel.dm.domain.management.common;

import lombok.ToString;

@ToString
public class ManagementCommonDomain{
	
	private int cd_no;
	private String cd_tp;
	private String cd_nm;
	
	private int insurer_sno;
	private String insurer_nm;
	
	private int partner_sno;
	private String partner_nm;
	
	public int getCd_no() {
		return cd_no;
	}
	public void setCd_no(int cd_no) {
		this.cd_no = cd_no;
	}
	public String getCd_tp() {
		return cd_tp;
	}
	public void setCd_tp(String cd_tp) {
		this.cd_tp = cd_tp;
	}
	public String getCd_nm() {
		return cd_nm;
	}
	public void setCd_nm(String cd_nm) {
		this.cd_nm = cd_nm;
	}
	public int getInsurer_sno() {
		return insurer_sno;
	}
	public void setInsurer_sno(int insurer_sno) {
		this.insurer_sno = insurer_sno;
	}
	public String getInsurer_nm() {
		return insurer_nm;
	}
	public void setInsurer_nm(String insurer_nm) {
		this.insurer_nm = insurer_nm;
	}
	public int getPartner_sno() {
		return partner_sno;
	}
	public void setPartner_sno(int partner_sno) {
		this.partner_sno = partner_sno;
	}
	public String getPartner_nm() {
		return partner_nm;
	}
	public void setPartner_nm(String partner_nm) {
		this.partner_nm = partner_nm;
	}

}
