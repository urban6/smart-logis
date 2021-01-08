package kr.co.shovvel.dm.domain.main;

import javax.xml.bind.annotation.XmlRootElement;

import kr.co.shovvel.dm.domain.common.CommonCondition;

@XmlRootElement(name="DashboardPresent")
public class DashboardPresent extends CommonCondition {
	private String total_product_count;
	private String total_ref_count;
	
	private String product_count_1;
	private String ref_count_1;
	private String product_count_2;
	private String ref_count_2;
	
	private String plan_job_datetime;
	private String plan_job_product_info;
	
	private String user_sno;

	public String getTotal_product_count() {
		return total_product_count;
	}

	public void setTotal_product_count(String total_product_count) {
		this.total_product_count = total_product_count;
	}

	public String getTotal_ref_count() {
		return total_ref_count;
	}

	public void setTotal_ref_count(String total_ref_count) {
		this.total_ref_count = total_ref_count;
	}

	public String getProduct_count_1() {
		return product_count_1;
	}

	public void setProduct_count_1(String product_count_1) {
		this.product_count_1 = product_count_1;
	}

	public String getRef_count_1() {
		return ref_count_1;
	}

	public void setRef_count_1(String ref_count_1) {
		this.ref_count_1 = ref_count_1;
	}

	public String getProduct_count_2() {
		return product_count_2;
	}

	public void setProduct_count_2(String product_count_2) {
		this.product_count_2 = product_count_2;
	}

	public String getRef_count_2() {
		return ref_count_2;
	}

	public void setRef_count_2(String ref_count_2) {
		this.ref_count_2 = ref_count_2;
	}

	public String getPlan_job_datetime() {
		return plan_job_datetime;
	}

	public void setPlan_job_datetime(String plan_job_datetime) {
		this.plan_job_datetime = plan_job_datetime;
	}

	public String getPlan_job_product_info() {
		return plan_job_product_info;
	}

	public void setPlan_job_product_info(String plan_job_product_info) {
		this.plan_job_product_info = plan_job_product_info;
	}

	public String getUser_sno() {
		return user_sno;
	}

	public void setUser_sno(String user_sno) {
		this.user_sno = user_sno;
	}

	
}
