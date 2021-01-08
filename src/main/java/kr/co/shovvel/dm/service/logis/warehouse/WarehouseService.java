package kr.co.shovvel.dm.service.logis.warehouse;

import java.net.HttpCookie;
import java.util.List;
import java.util.Map;

import kr.co.shovvel.dm.common.Consts;
import kr.co.shovvel.dm.domain.logis.search.WarehouseSearchInfo;
import kr.co.shovvel.dm.domain.logis.warehouse.WarehouseLendInfo;
import kr.co.shovvel.dm.domain.warehouse.WarehouseInfo;
import kr.co.shovvel.dm.domain.warehouse.WarehouseSpace;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.shovvel.dm.dao.logis.warehouse.WarehouseMapper;
import kr.co.shovvel.dm.domain.logis.warehouse.WarehouseOrderInfo;
import kr.co.shovvel.dm.domain.management.pay.SellerProductInfoVO;

import javax.servlet.http.HttpSession;

@Service
public class WarehouseService {

    @Autowired
    private WarehouseMapper warehouseMapper;

    private Logger logger = Logger.getLogger(this.getClass());

    public List<WarehouseSearchInfo> searchWarehouseOrderInfo(String userUid) {
        return warehouseMapper.searchWarehouseOrderInfo(userUid);
    }
    
    public List<WarehouseSearchInfo> serchRentWarehouse(String userUid) {
        return warehouseMapper.serchRentWarehouse(userUid);
        
    }
    
    public List<WarehouseSearchInfo> serchRentWarehouseBefore(String userUid) {
        return warehouseMapper.serchRentWarehouseBefore(userUid);
    }

    public WarehouseSearchInfo searchWarehouseOrderInfoDetail(String orderInfoUid) {
        return warehouseMapper.searchWarehouseOrderInfoDetail(orderInfoUid);
    }

    /**
     * 로그인된 사용자의 회사 위치를 검색한다.
     */
    public String searchComapanyAddress(String userUid) {
        return warehouseMapper.searchComapanyAddress(userUid);
    }

    /**
     * 내 창고 대여하기를 신청했을 경우, 사용자가 입력한 데이터를 추가한다.
     * [ 기능은 추가했지만 실제로 사용되지는 않을 예정 ]
     */
    public void addWarehouseLend(WarehouseLendInfo warehouseLendInfo) {
        warehouseMapper.addWarehouseLend(warehouseLendInfo);
    }

    public int searchCompanyUid(int userUid) {
        return warehouseMapper.searchCompanyUid(userUid);
    }
}
