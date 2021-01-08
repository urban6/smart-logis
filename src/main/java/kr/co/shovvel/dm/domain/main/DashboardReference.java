package kr.co.shovvel.dm.domain.main;

import javax.xml.bind.annotation.XmlRootElement;

import kr.co.shovvel.dm.domain.common.CommonCondition;

@XmlRootElement(name="DashboardReference")
public class DashboardReference extends CommonCondition {
	
	private String plan_ref_id;
	private String ref_id;
	private String ref_name;
	private String ref_version;
	private String description;
	
	private String quota_init_type;
	private String quota_init_type_name;
	
	private String ref_type_time_flag;
	private String ref_type_time_config;
	private String ref_type_time_config_name;
	private String ref_type_place_flag;
	private String ref_type_occasion_flag;
	
	public String getPlan_ref_id() {
		return plan_ref_id;
	}
	public void setPlan_ref_id(String plan_ref_id) {
		this.plan_ref_id = plan_ref_id;
	}
	public String getRef_id() {
		return ref_id;
	}
	public void setRef_id(String ref_id) {
		this.ref_id = ref_id;
	}
	public String getRef_name() {
		return ref_name;
	}
	public void setRef_name(String ref_name) {
		this.ref_name = ref_name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getQuota_init_type() {
		return quota_init_type;
	}
	public void setQuota_init_type(String quota_init_type) {
		this.quota_init_type = quota_init_type;
	}
	public String getQuota_init_type_name() {
		return quota_init_type_name;
	}
	public void setQuota_init_type_name(String quota_init_type_name) {
		this.quota_init_type_name = quota_init_type_name;
	}
	public String getRef_type_time_flag() {
		return ref_type_time_flag;
	}
	public void setRef_type_time_flag(String ref_type_time_flag) {
		this.ref_type_time_flag = ref_type_time_flag;
	}
	public String getRef_type_time_config() {
		return ref_type_time_config;
	}
	public void setRef_type_time_config(String ref_type_time_config) {
		this.ref_type_time_config = ref_type_time_config;
	}
	public String getRef_type_place_flag() {
		return ref_type_place_flag;
	}
	public void setRef_type_place_flag(String ref_type_place_flag) {
		this.ref_type_place_flag = ref_type_place_flag;
	}
	public String getRef_type_occasion_flag() {
		return ref_type_occasion_flag;
	}
	public void setRef_type_occasion_flag(String ref_type_occasion_flag) {
		this.ref_type_occasion_flag = ref_type_occasion_flag;
	}
	public String getRef_version() {
		return ref_version;
	}
	public void setRef_version(String ref_version) {
		this.ref_version = ref_version;
	}
	public String getRef_type_time_config_name() {
		return ref_type_time_config_name;
	}
	public void setRef_type_time_config_name(String ref_type_time_config_name) {
		this.ref_type_time_config_name = ref_type_time_config_name;
	}
	
	
}
