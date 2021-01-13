package kr.co.shovvel.dm.dao.logis.management;

import kr.co.shovvel.dm.domain.logis.RFID;
import kr.co.shovvel.dm.domain.logis.RFIDItem;
import kr.co.shovvel.dm.domain.logis.apply.LogisOrderInfo;
import kr.co.shovvel.dm.domain.logis.management.Company;
import kr.co.shovvel.dm.domain.logis.management.DriverLogin;
import kr.co.shovvel.dm.domain.logis.management.SearchRfidInfo;
import kr.co.shovvel.dm.domain.warehouse.WarehouseItem;
import kr.co.shovvel.dm.domain.warehouse.WarehouseSpace;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface ManagementMapper {

    String searchLogisUser(@Param(value = "logisNumber") String logisNumber, @Param(value = "passwd") String passwd);

    void addDriverLogin(DriverLogin driverLogin);

    void addAuthInfo(@Param(value = "phoneNumber") String phoneNumber, @Param(value = "authNumber") String authNumber);

    String searchAuthNumber(@Param(value = "authNumber") String authNumber, @Param(value = "phoneNumber") String phoneNumber);

    List<LogisOrderInfo> searchLogisOrderInfo();

    List<LogisOrderInfo> searchMyLogisOrderInfo(@Param(value = "logisNumber") String logisNumber);

    LogisOrderInfo searchLogisOrderInfoDetail(@Param(value = "logisOrderUid") String logisOrderUid);

    String searchLogisItemInfo(@Param(value = "logisOrderUid") String logisOrderUid);

    void updateLogisStatus(@Param(value = "logisOrderUid") String logisOrderUid, @Param(value = "status") int status);

    void updateLogisStartTime(@Param(value = "logisOrderUid") String logisOrderUid);

    void updateLogisArriveTime(@Param(value = "logisOrderUid") String logisOrderUid);

    void addItemUsingLogis(WarehouseItem warehouseItem);

    void insertRfidByDriver(RFID rfid);

    void clearRfidInfo(@Param(value = "rfidUid") String rfidUid);

    void removeItemInfo(@Param(value = "itemUid") String itemUid);

    List<RFIDItem> searchRfidItem(String logisOrderUid);

    void updateOrderLogisNumber(@Param(value = "logisNumber") String logisNumber, @Param(value = "logisOrderUid") String logisOrderUid);

    // 창고 관련
    String searchWarehouseManager(@Param(value = "id") String id, @Param(value = "passwd") String passwd);

    List<WarehouseSpace> searchWarehouseSpace(@Param(value = "warehouseUid") String warehouseUid);

    SearchRfidInfo searchRfidInfo(@Param(value = "rfidUid") String rfidUid);

    List<SearchRfidInfo> searchItemList(@Param(value = "warehouseUid") String warehouseUid);

    SearchRfidInfo searchItem(@Param(value = "itemUid") String itemUid);

    void updateItemInItem(@Param(value = "itemUid") String itemUid);

    void updateItemOutItem(@Param(value = "itemUid") String itemUid);

    void updateSpaceUid(@Param(value = "itemUid") String itemUid, @Param(value = "spaceUid") String spaceUid);

    List<Company> searchCompany();

    void insertItemByManager(WarehouseItem warehouseItem);

    String checkRfidUid(@Param(value = "rfidUid") String rfidUid);

    void insertRfidByManager(@Param(value = "rfidUid") String rfidUid,
                             @Param(value = "itemUid") String itemUid,
                             @Param(value = "orderInfoUid") String orderInfoUid);

    void updateRfidByManager(@Param(value = "rfidUid") String rfidUid, @Param(value = "spaceUid") String spaceUid);

    void deleteSpaceRfid(@Param(value = "rfidUid") String rfidUid);

    void insertInItemHistory(WarehouseItem warehouseItem);

    void insertOutItemHistory(WarehouseItem warehouseItem);

    WarehouseItem searchItemForHistory(@Param(value = "itemUid") String itemUid);

    String searchWhseOrderUid(String logisOrderUid);
}
