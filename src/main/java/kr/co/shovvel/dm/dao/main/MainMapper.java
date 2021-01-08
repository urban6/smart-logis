package kr.co.shovvel.dm.dao.main;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import kr.co.shovvel.dm.domain.main.DashboardPresent;
import kr.co.shovvel.dm.domain.main.DashboardProduct;
import kr.co.shovvel.dm.domain.main.DashboardReference;
import kr.co.shovvel.dm.domain.main.DashboardRelateHost;


@Component
public interface MainMapper {
	
	int selectProductListCount(@Param(value = "condition") DashboardProduct dashboardProduct);
	
	DashboardPresent selectMakePresent(@Param(value = "condition") DashboardProduct dashboardProduct);
	DashboardPresent selectDeployPresent(@Param(value = "condition") DashboardProduct dashboardProduct);
	DashboardPresent selectPlanDeployPresent(@Param(value = "condition") DashboardProduct dashboardProduct);
	
	List<DashboardProduct> selectProductList(@Param(value = "condition") DashboardProduct dashboardProduct
			, @Param(value = "start") int start
			, @Param(value = "end") int end);
	
	List<DashboardReference> selectReferenceList(@Param(value = "condition") DashboardProduct dashboardProduct);
	
	List<DashboardRelateHost> selectProductRelateHostList(@Param(value = "condition") DashboardProduct dashboardProduct);
	
}