package kr.co.shovvel.dm.service.logis.warehouse.apply;

import kr.co.shovvel.dm.common.Consts;
import kr.co.shovvel.dm.dao.logis.warehouse.apply.WarehouseApplyMapper;
import kr.co.shovvel.dm.domain.logis.warehouse.WarehouseOrderInfo;
import kr.co.shovvel.dm.domain.warehouse.WarehouseInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WarehouseApplyService {

    @Autowired
    private WarehouseApplyMapper warehouseApplyMapper;

    /**
     * 등록되어 있는 창고 리스트를 조회한다.
     */
    public List<WarehouseInfo> getWarehouseName() {
        return warehouseApplyMapper.getWarehouseName();
    }

    /**
     * 사용자가 대여를 하고 있는 창고 리스트를 조회한다.
     *
     * @param userUid - 회원 고유번호
     */
    public List<WarehouseInfo> getUsingWarehouseName(String userUid, String date) {
        return warehouseApplyMapper.getUsingWarehouseName(userUid, date);
    }

    /**
     * 창고 신청 화면에서 조건에 맞는 창고를 조회한다.
     *
     * @param startDatetime - 대여 시작 날짜
     * @param endDatetime   - 대여 종료 날짜
     * @param spaceSize     - 공간 수
     */
    public List<WarehouseInfo> searchAvailableWarehouse(String startDatetime, String endDatetime, int spaceSize) {
        return warehouseApplyMapper.searchAvailableWarehouse(startDatetime, endDatetime, spaceSize);
    }

    /**
     * 창고 신청 화면에서 사용할 수 없는 창고를 조회한다.
     *
     * @param startDatetime - 대여 시작 날짜
     * @param endDatetime   - 대여 종료 날짜
     * @param spaceSize     - 공간 수
     */
    public List<WarehouseInfo> searchUnavailAbleWarehouse(String startDatetime, String endDatetime, int spaceSize) {
        return warehouseApplyMapper.searchUnavailAbleWarehouse(startDatetime, endDatetime, spaceSize);
    }

    /**
     * 사용자가 창고를 선택했을 경우, 해당 창고의 자세한 정보를 조회한다.
     *
     * @param warehouseUid  - 창고 고유번호
     * @param startDatetime - 대여 시작 날짜
     * @param endDatetime   - 대여 종료 날짜
     * @param spaceSize     - 공간 수
     */
    public WarehouseInfo searchSelectedWarehouse(String warehouseUid, String startDatetime, String endDatetime, int spaceSize) {
        return warehouseApplyMapper.searchSelectedWarehouse(warehouseUid, startDatetime, endDatetime, spaceSize);
    }

    /**
     * 사용자가 창고를 결제를 하는 동안 다른 사용자가 창고를 선택 및 결제할 수 없도록 한다.
     *
     * @param warehouseUid  - 창고 고유번호
     * @param startDatetime - 대여 시작 날짜
     * @param endDatetime   - 대여 종료 날짜
     * @param spaceSize     - 공간 수
     */
    public int searchUsableSpaceCount(String warehouseUid, String startDatetime, String endDatetime, int spaceSize) {
        // 빌릴 수 있는 공간을 다시 확인한다.
        int availableSize = warehouseApplyMapper.searchUsableSpaceCount(warehouseUid, startDatetime, endDatetime);
        if (spaceSize <= availableSize) {
            return Consts.SPACE_PREV_PAY_STATE.SUCCESS;
        } else {
            return Consts.SPACE_PREV_PAY_STATE.FAIL;
        }
    }

    /**
     * 창고 대여를 신청을 했을 때, 사용자가 입력한 정보를 추가한다.
     *
     * @param orderInfo - 창고 대여에 필요한 데이터
     */
    public void addWarehouseOrderInfo(WarehouseOrderInfo orderInfo) {
        warehouseApplyMapper.addWarehouseOrderInfo(orderInfo);
    }

    /**
     * 결제가 성공적으로 되었을 경우, 기존에 추가했던 신청 데이터의 결제 상태를 변경한다.
     * [ IS_PAY = 'Y, STATUS = 1 ]
     *
     * @param salesUid     - 결제 고유번호
     * @param orderInfoUid - 주문 고유번호
     */
    public void updatePayStateInOrderInfo(String salesUid, int orderInfoUid) {
        warehouseApplyMapper.updatePayStateInOrderInfo(salesUid, orderInfoUid);
    }
}
