package kr.co.shovvel.dm.dao.logis.warehouse;

import java.util.List;

import kr.co.shovvel.dm.domain.logis.search.WarehouseSearchInfo;
import kr.co.shovvel.dm.domain.logis.warehouse.WarehouseLendInfo;
import kr.co.shovvel.dm.domain.warehouse.WarehouseInfo;
import kr.co.shovvel.dm.domain.warehouse.WarehouseSpace;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import kr.co.shovvel.dm.domain.logis.warehouse.WarehouseOrderInfo;
import kr.co.shovvel.dm.domain.management.pay.SellerProductInfoVO;

@Component
public interface WarehouseMapper {

    void updatePeriodInSpace(@Param(value = "spaceUid") String spaceUid,
                             @Param(value = "startDatetime") String startDatetime,
                             @Param(value = "endDatetime") String endDatetime);

    SellerProductInfoVO getProductInfo();

    List<WarehouseSearchInfo> searchWarehouseOrderInfo(String userUid);

    List<WarehouseSearchInfo> serchRentWarehouseBefore(String userUid);
    
    List<WarehouseSearchInfo> serchRentWarehouse(String userUid);

    WarehouseSearchInfo searchWarehouseOrderInfoDetail(String orderInfoUid);

    String searchComapanyAddress(@Param(value = "userUid") String userUid);

    void addWarehouseLend(WarehouseLendInfo warehouseLendInfo);

    int searchCompanyUid(@Param(value = "userUid") int userUid);
}
