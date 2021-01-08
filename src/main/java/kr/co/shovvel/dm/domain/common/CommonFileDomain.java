package kr.co.shovvel.dm.domain.common;

import java.sql.Timestamp;

import lombok.ToString;

@ToString
public class CommonFileDomain{
	
	private int seq;
	private String data_cd;
	private String data_cd2;
	private int data_seq;
	private String file_cd;
	private String file_nm;
	private String file_ext;
	private long file_size;
	private Timestamp reg_dt;
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getData_cd() {
		return data_cd;
	}
	public void setData_cd(String data_cd) {
		this.data_cd = data_cd;
	}
	public String getData_cd2() {
		return data_cd2;
	}
	public void setData_cd2(String data_cd2) {
		this.data_cd2 = data_cd2;
	}
	public int getData_seq() {
		return data_seq;
	}
	public void setData_seq(int data_seq) {
		this.data_seq = data_seq;
	}
	public String getFile_cd() {
		return file_cd;
	}
	public void setFile_cd(String file_cd) {
		this.file_cd = file_cd;
	}
	public String getFile_nm() {
		return file_nm;
	}
	public void setFile_nm(String file_nm) {
		this.file_nm = file_nm;
	}
	public String getFile_ext() {
		return file_ext;
	}
	public void setFile_ext(String file_ext) {
		this.file_ext = file_ext;
	}
	public long getFile_size() {
		return file_size;
	}
	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}
	public Timestamp getReg_dt() {
		return reg_dt;
	}
	public void setReg_dt(Timestamp reg_dt) {
		this.reg_dt = reg_dt;
	}
	
}
