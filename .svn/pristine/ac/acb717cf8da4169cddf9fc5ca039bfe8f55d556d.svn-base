package kr.co.shovvel.dm.service.main;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.shovvel.dm.dao.main.MainMapper;
import kr.co.shovvel.dm.domain.main.DashboardPresent;
import kr.co.shovvel.dm.domain.main.DashboardProduct;
import kr.co.shovvel.dm.domain.main.DashboardReference;
import kr.co.shovvel.dm.domain.main.DashboardRelateHost;

@Service
public class MainService {
	private Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private MainMapper mainMapper;
	

	public int getProductListCount(DashboardProduct dashboardProduct) {
		return mainMapper.selectProductListCount(dashboardProduct);
	}
	
	public DashboardPresent getMakePresent(DashboardProduct dashboardProduct) {
		DashboardPresent dashboardPresent = mainMapper.selectMakePresent(dashboardProduct);
		
		DashboardPresent dashboardPresentTemp = new DashboardPresent();
		dashboardPresentTemp = mainMapper.selectPlanDeployPresent(dashboardProduct);
		if(dashboardPresentTemp != null) {
			dashboardPresent.setPlan_job_datetime(dashboardPresentTemp.getPlan_job_datetime());
			dashboardPresent.setPlan_job_product_info(dashboardPresentTemp.getPlan_job_product_info());
		}
		return dashboardPresent;
	}
	
	public DashboardPresent getDeployPresent(DashboardProduct dashboardProduct) {
		DashboardPresent dashboardPresent = mainMapper.selectDeployPresent(dashboardProduct);
		
		DashboardPresent dashboardPresentTemp = new DashboardPresent();
		dashboardPresentTemp = mainMapper.selectPlanDeployPresent(dashboardProduct);
		if(dashboardPresentTemp != null) {
			dashboardPresent.setPlan_job_datetime(dashboardPresentTemp.getPlan_job_datetime());
			dashboardPresent.setPlan_job_product_info(dashboardPresentTemp.getPlan_job_product_info());
		}
		return dashboardPresent;
	}
	
	public List<DashboardProduct> getProductList(DashboardProduct dashboardProduct, int page ,int perPage) {
		int start = ((page - 1) * perPage);
		int end = perPage;
		return mainMapper.selectProductList(dashboardProduct, start ,end);
	}
	
	public List<DashboardReference> getReferenceList(DashboardProduct dashboardProduct) {
		return mainMapper.selectReferenceList(dashboardProduct);
	}
	
	public List<DashboardRelateHost> selectProductRelateHostList(DashboardProduct dashboardProduct){
    	return mainMapper.selectProductRelateHostList(dashboardProduct);
	}
	
		
}