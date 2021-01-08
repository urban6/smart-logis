package kr.co.shovvel.dm.domain.management.manager;

import java.sql.Timestamp;

import lombok.ToString;

@ToString
public class ManagerDomain{
	
	private String search_type;
	private String search_str;
	private int view_rows;
	private int page;
	private int startRow;
	private int endRow;

	private int num_asc;
	private int num_desc;
	private int seq;
	private String mng_tp;
	private String mng_id;
	private String mng_pwd;
	private String mng_nm;
	private String mng_mobile;
	private String mng_phone;
	private String mng_email;
	private String mng_belong;
	private String mng_msg;
	private String mng_power;
	private Timestamp contract_sd;
	private Timestamp contract_ed;
	private String used_yn;
	private String reg_id;
	private Timestamp reg_dt;
	private int rowasc;
	private int rowdesc;
	
	private String use_yn;
	private String mng_mobile_1;
	private String mng_mobile_2;
	private String mng_mobile_3;
	
	public String getSearch_type() {
		return search_type;
	}
	public void setSearch_type(String search_type) {
		this.search_type = search_type;
	}
	public String getSearch_str() {
		return search_str;
	}
	public void setSearch_str(String search_str) {
		this.search_str = search_str;
	}
	public int getView_rows() {
		return view_rows;
	}
	public void setView_rows(int view_rows) {
		this.view_rows = view_rows;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getStartRow() {
		return startRow;
	}
	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}
	public int getEndRow() {
		return endRow;
	}
	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}
	public int getNum_asc() {
		return num_asc;
	}
	public void setNum_asc(int num_asc) {
		this.num_asc = num_asc;
	}
	public int getNum_desc() {
		return num_desc;
	}
	public void setNum_desc(int num_desc) {
		this.num_desc = num_desc;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getMng_tp() {
		return mng_tp;
	}
	public void setMng_tp(String mng_tp) {
		this.mng_tp = mng_tp;
	}
	public String getMng_id() {
		return mng_id;
	}
	public void setMng_id(String mng_id) {
		this.mng_id = mng_id;
	}
	public String getMng_pwd() {
		return mng_pwd;
	}
	public void setMng_pwd(String mng_pwd) {
		this.mng_pwd = mng_pwd;
	}
	public String getMng_nm() {
		return mng_nm;
	}
	public void setMng_nm(String mng_nm) {
		this.mng_nm = mng_nm;
	}
	public String getMng_mobile() {
		return mng_mobile;
	}
	public void setMng_mobile(String mng_mobile) {
		this.mng_mobile = mng_mobile;
	}
	public String getMng_phone() {
		return mng_phone;
	}
	public void setMng_phone(String mng_phone) {
		this.mng_phone = mng_phone;
	}
	public String getMng_email() {
		return mng_email;
	}
	public void setMng_email(String mng_email) {
		this.mng_email = mng_email;
	}
	public String getMng_belong() {
		return mng_belong;
	}
	public void setMng_belong(String mng_belong) {
		this.mng_belong = mng_belong;
	}
	public String getMng_msg() {
		return mng_msg;
	}
	public void setMng_msg(String mng_msg) {
		this.mng_msg = mng_msg;
	}
	public String getMng_power() {
		return mng_power;
	}
	public void setMng_power(String mng_power) {
		this.mng_power = mng_power;
	}
	public Timestamp getContract_sd() {
		return contract_sd;
	}
	public void setContract_sd(Timestamp contract_sd) {
		this.contract_sd = contract_sd;
	}
	public Timestamp getContract_ed() {
		return contract_ed;
	}
	public void setContract_ed(Timestamp contract_ed) {
		this.contract_ed = contract_ed;
	}
	public String getUsed_yn() {
		return used_yn;
	}
	public void setUsed_yn(String used_yn) {
		this.used_yn = used_yn;
	}
	public String getReg_id() {
		return reg_id;
	}
	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}
	public Timestamp getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(Timestamp reg_dt) {
		this.reg_dt = reg_dt;
	}
	public int getRowasc() {
		return rowasc;
	}
	public void setRowasc(int rowasc) {
		this.rowasc = rowasc;
	}
	public int getRowdesc() {
		return rowdesc;
	}
	public void setRowdesc(int rowdesc) {
		this.rowdesc = rowdesc;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getMng_mobile_1() {
		return mng_mobile_1;
	}
	public void setMng_mobile_1(String mng_mobile_1) {
		this.mng_mobile_1 = mng_mobile_1;
	}
	public String getMng_mobile_2() {
		return mng_mobile_2;
	}
	public void setMng_mobile_2(String mng_mobile_2) {
		this.mng_mobile_2 = mng_mobile_2;
	}
	public String getMng_mobile_3() {
		return mng_mobile_3;
	}
	public void setMng_mobile_3(String mng_mobile_3) {
		this.mng_mobile_3 = mng_mobile_3;
	}
	


}
