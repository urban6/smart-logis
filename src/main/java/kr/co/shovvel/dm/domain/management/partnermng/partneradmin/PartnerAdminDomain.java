package kr.co.shovvel.dm.domain.management.partnermng.partneradmin;

import kr.co.shovvel.dm.domain.common.CommonCondition;
import lombok.ToString;

@ToString
public class PartnerAdminDomain extends CommonCondition{
	private String search_partner_clcd;
	private String search_partner_sno;
	private String search_type;
	private String search_text;
	
	private String user_sno;
	private String partner_sno;
	private String partner_clcd;
	private String partner_nm;
	private String level_id;
	private String level_title;
	private String level_clcd;
	private String login_id;
	private String user_fnm;
	private String user_hp_no;
	private String img_file_sno;
	private String file_save_nm;
	private String file_real_nm;
	private String passwd;
	private String user_ctcd;
	private String ins_dt;
	
	private String default_passwd_yn;
	private String passwd_life_cycle;
	private String account_exfire;
	
	private String msgSendGroupSno;
	private String msgCtcd;
	private String msgCtnt;
	public String getSearch_partner_clcd() {
		return search_partner_clcd;
	}
	public void setSearch_partner_clcd(String search_partner_clcd) {
		this.search_partner_clcd = search_partner_clcd;
	}
	public String getSearch_partner_sno() {
		return search_partner_sno;
	}
	public void setSearch_partner_sno(String search_partner_sno) {
		this.search_partner_sno = search_partner_sno;
	}
	public String getSearch_type() {
		return search_type;
	}
	public void setSearch_type(String search_type) {
		this.search_type = search_type;
	}
	public String getSearch_text() {
		return search_text;
	}
	public void setSearch_text(String search_text) {
		this.search_text = search_text;
	}
	public String getUser_sno() {
		return user_sno;
	}
	public void setUser_sno(String user_sno) {
		this.user_sno = user_sno;
	}
	public String getPartner_sno() {
		return partner_sno;
	}
	public void setPartner_sno(String partner_sno) {
		this.partner_sno = partner_sno;
	}
	public String getPartner_clcd() {
		return partner_clcd;
	}
	public void setPartner_clcd(String partner_clcd) {
		this.partner_clcd = partner_clcd;
	}
	public String getPartner_nm() {
		return partner_nm;
	}
	public void setPartner_nm(String partner_nm) {
		this.partner_nm = partner_nm;
	}
	public String getLevel_id() {
		return level_id;
	}
	public void setLevel_id(String level_id) {
		this.level_id = level_id;
	}
	public String getLevel_title() {
		return level_title;
	}
	public void setLevel_title(String level_title) {
		this.level_title = level_title;
	}
	public String getLevel_clcd() {
		return level_clcd;
	}
	public void setLevel_clcd(String level_clcd) {
		this.level_clcd = level_clcd;
	}
	public String getLogin_id() {
		return login_id;
	}
	public void setLogin_id(String login_id) {
		this.login_id = login_id;
	}
	public String getUser_fnm() {
		return user_fnm;
	}
	public void setUser_fnm(String user_fnm) {
		this.user_fnm = user_fnm;
	}
	public String getUser_hp_no() {
		return user_hp_no;
	}
	public void setUser_hp_no(String user_hp_no) {
		this.user_hp_no = user_hp_no;
	}
	public String getImg_file_sno() {
		return img_file_sno;
	}
	public void setImg_file_sno(String img_file_sno) {
		this.img_file_sno = img_file_sno;
	}
	public String getFile_save_nm() {
		return file_save_nm;
	}
	public void setFile_save_nm(String file_save_nm) {
		this.file_save_nm = file_save_nm;
	}
	public String getFile_real_nm() {
		return file_real_nm;
	}
	public void setFile_real_nm(String file_real_nm) {
		this.file_real_nm = file_real_nm;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getUser_ctcd() {
		return user_ctcd;
	}
	public void setUser_ctcd(String user_ctcd) {
		this.user_ctcd = user_ctcd;
	}
	public String getIns_dt() {
		return ins_dt;
	}
	public void setIns_dt(String ins_dt) {
		this.ins_dt = ins_dt;
	}
	public String getDefault_passwd_yn() {
		return default_passwd_yn;
	}
	public void setDefault_passwd_yn(String default_passwd_yn) {
		this.default_passwd_yn = default_passwd_yn;
	}
	public String getPasswd_life_cycle() {
		return passwd_life_cycle;
	}
	public void setPasswd_life_cycle(String passwd_life_cycle) {
		this.passwd_life_cycle = passwd_life_cycle;
	}
	public String getAccount_exfire() {
		return account_exfire;
	}
	public void setAccount_exfire(String account_exfire) {
		this.account_exfire = account_exfire;
	}
	public String getMsgSendGroupSno() {
		return msgSendGroupSno;
	}
	public void setMsgSendGroupSno(String msgSendGroupSno) {
		this.msgSendGroupSno = msgSendGroupSno;
	}
	public String getMsgCtcd() {
		return msgCtcd;
	}
	public void setMsgCtcd(String msgCtcd) {
		this.msgCtcd = msgCtcd;
	}
	public String getMsgCtnt() {
		return msgCtnt;
	}
	public void setMsgCtnt(String msgCtnt) {
		this.msgCtnt = msgCtnt;
	}
	

}
