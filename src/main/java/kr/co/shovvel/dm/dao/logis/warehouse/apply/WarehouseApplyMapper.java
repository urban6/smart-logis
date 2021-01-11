package kr.co.shovvel.dm.dao.logis.warehouse.apply;

import kr.co.shovvel.dm.domain.logis.warehouse.WarehouseOrderInfo;
import kr.co.shovvel.dm.domain.warehouse.WarehouseInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface WarehouseApplyMapper {

    List<WarehouseInfo> getWarehouseName();

    List<WarehouseInfo> getUsingWarehouseName(@Param(value = "userUid") String userUid,
                                              @Param(value = "date") String date);

    List<WarehouseInfo> searchAvailableWarehouse(@Param(value = "startDatetime") String startDatetime,
                                                 @Param(value = "endDatetime") String endDatetime,
                                                 @Param(value = "spaceSize") int spaceSize);

    List<WarehouseInfo> searchUnavailAbleWarehouse(@Param(value = "startDatetime") String startDatetime,
                                                   @Param(value = "endDatetime") String endDatetime,
                                                   @Param(value = "spaceSize") int spaceSize);

    WarehouseInfo searchSelectedWarehouse(@Param(value = "warehouseUid") String warehouseUid,
                                          @Param(value = "startDatetime") String startDatetime,
                                          @Param(value = "endDatetime") String endDatetime,
                                          @Param(value = "spaceSize") int spaceSize);

    int searchUsableSpaceCount(@Param(value = "warehouseUid") String warehouseUid,
                          @Param(value = "startDatetime") String startDatetime,
                          @Param(value = "endDatetime") String endDatetime);

    int addWarehouseOrderInfo(WarehouseOrderInfo orderInfo);

    void updatePayStateInOrderInfo(@Param(value = "salesUid") String salesUid, @Param(value = "orderInfoUid") int orderInfoUid);
}
