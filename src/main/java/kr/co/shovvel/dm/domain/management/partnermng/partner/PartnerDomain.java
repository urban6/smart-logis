package kr.co.shovvel.dm.domain.management.partnermng.partner;

import kr.co.shovvel.dm.domain.common.CommonCondition;
import lombok.ToString;

@ToString
public class PartnerDomain extends CommonCondition{
	private String partner_sno;
	private String partner_hist_sno;
	private String partner_cd;
	private String partner_nm;
	private String partner_clcd;
	private String partner_clnm;
	private String partner_business_clcd;
	private String partner_rep_nm;
	private String partner_business_no;
	private String partner_corp_no;
	private String partner_medical_no;
	private String partner_tel_no;
	private String partner_fax_no;
	private String partner_email;
	private String partner_home_page;
	private String partner_addr;
	private String partner_desc;
	private String partner_user_nm;
	private String partner_user_tel_no;
	private String partner_user_email;
	private String partner_user_hp_no;
	private String partner_contract_ins_dd;
	private String partner_contract_upd_dd;
	private String partner_contract_end_dd;
	private String partner_coaching_use_yn;
	private String partner_community_use_yn;
	private String use_yn;
	private String ins_dt;
	private String ins_user_sno;
	private String upd_dt;
	private String upd_user_sno;
	
	/** 조회조건_파트너 구분 */
	private String search_partner_clcd;
	/** 조회조건_파트너사 */
	private String search_partner_nm;
	
	public String getPartner_sno() {
		return partner_sno;
	}
	public void setPartner_sno(String partner_sno) {
		this.partner_sno = partner_sno;
	}
	public String getPartner_hist_sno() {
		return partner_hist_sno;
	}
	public void setPartner_hist_sno(String partner_hist_sno) {
		this.partner_hist_sno = partner_hist_sno;
	}
	public String getPartner_cd() {
		return partner_cd;
	}
	public void setPartner_cd(String partner_cd) {
		this.partner_cd = partner_cd;
	}
	public String getPartner_nm() {
		return partner_nm;
	}
	public void setPartner_nm(String partner_nm) {
		this.partner_nm = partner_nm;
	}
	public String getPartner_clcd() {
		return partner_clcd;
	}
	public void setPartner_clcd(String partner_clcd) {
		this.partner_clcd = partner_clcd;
	}
	public String getPartner_clnm() {
		return partner_clnm;
	}
	public void setPartner_clnm(String partner_clnm) {
		this.partner_clnm = partner_clnm;
	}
	public String getPartner_business_clcd() {
		return partner_business_clcd;
	}
	public void setPartner_business_clcd(String partner_business_clcd) {
		this.partner_business_clcd = partner_business_clcd;
	}
	public String getPartner_rep_nm() {
		return partner_rep_nm;
	}
	public void setPartner_rep_nm(String partner_rep_nm) {
		this.partner_rep_nm = partner_rep_nm;
	}
	public String getPartner_business_no() {
		return partner_business_no;
	}
	public void setPartner_business_no(String partner_business_no) {
		this.partner_business_no = partner_business_no;
	}
	public String getPartner_corp_no() {
		return partner_corp_no;
	}
	public void setPartner_corp_no(String partner_corp_no) {
		this.partner_corp_no = partner_corp_no;
	}
	public String getPartner_medical_no() {
		return partner_medical_no;
	}
	public void setPartner_medical_no(String partner_medical_no) {
		this.partner_medical_no = partner_medical_no;
	}
	public String getPartner_tel_no() {
		return partner_tel_no;
	}
	public void setPartner_tel_no(String partner_tel_no) {
		this.partner_tel_no = partner_tel_no;
	}
	public String getPartner_fax_no() {
		return partner_fax_no;
	}
	public void setPartner_fax_no(String partner_fax_no) {
		this.partner_fax_no = partner_fax_no;
	}
	public String getPartner_email() {
		return partner_email;
	}
	public void setPartner_email(String partner_email) {
		this.partner_email = partner_email;
	}
	public String getPartner_home_page() {
		return partner_home_page;
	}
	public void setPartner_home_page(String partner_home_page) {
		this.partner_home_page = partner_home_page;
	}
	public String getPartner_addr() {
		return partner_addr;
	}
	public void setPartner_addr(String partner_addr) {
		this.partner_addr = partner_addr;
	}
	public String getPartner_desc() {
		return partner_desc;
	}
	public void setPartner_desc(String partner_desc) {
		this.partner_desc = partner_desc;
	}
	public String getPartner_user_nm() {
		return partner_user_nm;
	}
	public void setPartner_user_nm(String partner_user_nm) {
		this.partner_user_nm = partner_user_nm;
	}
	public String getPartner_user_tel_no() {
		return partner_user_tel_no;
	}
	public void setPartner_user_tel_no(String partner_user_tel_no) {
		this.partner_user_tel_no = partner_user_tel_no;
	}
	public String getPartner_user_email() {
		return partner_user_email;
	}
	public void setPartner_user_email(String partner_user_email) {
		this.partner_user_email = partner_user_email;
	}
	public String getPartner_user_hp_no() {
		return partner_user_hp_no;
	}
	public void setPartner_user_hp_no(String partner_user_hp_no) {
		this.partner_user_hp_no = partner_user_hp_no;
	}
	public String getPartner_contract_ins_dd() {
		return partner_contract_ins_dd;
	}
	public void setPartner_contract_ins_dd(String partner_contract_ins_dd) {
		this.partner_contract_ins_dd = partner_contract_ins_dd;
	}
	public String getPartner_contract_upd_dd() {
		return partner_contract_upd_dd;
	}
	public void setPartner_contract_upd_dd(String partner_contract_upd_dd) {
		this.partner_contract_upd_dd = partner_contract_upd_dd;
	}
	public String getPartner_contract_end_dd() {
		return partner_contract_end_dd;
	}
	public void setPartner_contract_end_dd(String partner_contract_end_dd) {
		this.partner_contract_end_dd = partner_contract_end_dd;
	}
	public String getPartner_coaching_use_yn() {
		return partner_coaching_use_yn;
	}
	public void setPartner_coaching_use_yn(String partner_coaching_use_yn) {
		this.partner_coaching_use_yn = partner_coaching_use_yn;
	}
	public String getPartner_community_use_yn() {
		return partner_community_use_yn;
	}
	public void setPartner_community_use_yn(String partner_community_use_yn) {
		this.partner_community_use_yn = partner_community_use_yn;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getIns_dt() {
		return ins_dt;
	}
	public void setIns_dt(String ins_dt) {
		this.ins_dt = ins_dt;
	}
	public String getIns_user_sno() {
		return ins_user_sno;
	}
	public void setIns_user_sno(String ins_user_sno) {
		this.ins_user_sno = ins_user_sno;
	}
	public String getUpd_dt() {
		return upd_dt;
	}
	public void setUpd_dt(String upd_dt) {
		this.upd_dt = upd_dt;
	}
	public String getUpd_user_sno() {
		return upd_user_sno;
	}
	public void setUpd_user_sno(String upd_user_sno) {
		this.upd_user_sno = upd_user_sno;
	}
	public String getSearch_partner_clcd() {
		return search_partner_clcd;
	}
	public void setSearch_partner_clcd(String search_partner_clcd) {
		this.search_partner_clcd = search_partner_clcd;
	}
	public String getSearch_partner_nm() {
		return search_partner_nm;
	}
	public void setSearch_partner_nm(String search_partner_nm) {
		this.search_partner_nm = search_partner_nm;
	}
	
}
