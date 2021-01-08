package kr.co.shovvel.dm.domain.main;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name="DashboardRelateHost")
public class DashboardRelateHost {

	private String plan_product_id; 
	private String relate_system_id;
	private String relate_host_id;
	private String host_id; 
	private String host_cd; 
	private String host_cd_name; 
	private String host_name; 
	private String host_ip; 
	private String host_location_cd;
	private String host_location_name;
	private String description;
	private String deploy_datetime;
	
	public String getPlan_product_id() {
		return plan_product_id;
	}
	public void setPlan_product_id(String plan_product_id) {
		this.plan_product_id = plan_product_id;
	}
	public String getRelate_system_id() {
		return relate_system_id;
	}
	public void setRelate_system_id(String relate_system_id) {
		this.relate_system_id = relate_system_id;
	}
	public String getRelate_host_id() {
		return relate_host_id;
	}
	public void setRelate_host_id(String relate_host_id) {
		this.relate_host_id = relate_host_id;
	}
	public String getHost_id() {
		return host_id;
	}
	public void setHost_id(String host_id) {
		this.host_id = host_id;
	}
	public String getHost_cd() {
		return host_cd;
	}
	public void setHost_cd(String host_cd) {
		this.host_cd = host_cd;
	}
	public String getHost_cd_name() {
		return host_cd_name;
	}
	public void setHost_cd_name(String host_cd_name) {
		this.host_cd_name = host_cd_name;
	}
	public String getHost_name() {
		return host_name;
	}
	public void setHost_name(String host_name) {
		this.host_name = host_name;
	}
	public String getHost_ip() {
		return host_ip;
	}
	public void setHost_ip(String host_ip) {
		this.host_ip = host_ip;
	}
	public String getHost_location_cd() {
		return host_location_cd;
	}
	public void setHost_location_cd(String host_location_cd) {
		this.host_location_cd = host_location_cd;
	}
	public String getHost_location_name() {
		return host_location_name;
	}
	public void setHost_location_name(String host_location_name) {
		this.host_location_name = host_location_name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getDeploy_datetime() {
		return deploy_datetime;
	}
	public void setDeploy_datetime(String deploy_datetime) {
		this.deploy_datetime = deploy_datetime;
	}
	
}
