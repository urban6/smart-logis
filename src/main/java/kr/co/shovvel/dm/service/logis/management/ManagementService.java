package kr.co.shovvel.dm.service.logis.management;

import kr.co.shovvel.dm.dao.logis.management.ManagementMapper;
import kr.co.shovvel.dm.domain.logis.RFID;
import kr.co.shovvel.dm.domain.logis.RFIDItem;
import kr.co.shovvel.dm.domain.logis.apply.LogisOrderInfo;
import kr.co.shovvel.dm.domain.logis.management.Company;
import kr.co.shovvel.dm.domain.logis.management.DriverLogin;
import kr.co.shovvel.dm.domain.logis.management.SearchRfidInfo;
import kr.co.shovvel.dm.domain.warehouse.WarehouseItem;
import kr.co.shovvel.dm.domain.warehouse.WarehouseSpace;
import kr.co.shovvel.dm.message.MessagingService;
import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Random;

@Service
public class ManagementService {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private ManagementMapper managementMapper;

    /**
     * 차량번호와 비밀번호가 일치하는지 확인한다.
     *
     * @param logisNumber - 차량번호 [아이디]
     * @param passwd      - 비밀번호 [SHA256]
     */
    public String logisLogin(String logisNumber, String passwd) {

        String result = managementMapper.searchLogisUser(logisNumber, passwd);
        logger.debug("Logis No = " + logisNumber);

        // 차량번호와 아이디가 일치한다면
        if (result != null) {
            return result;
        } else {
            return "";
        }
    }

    /**
     * 휴대폰 번호와 인증번호를 DB에 추가한다.
     *
     * @param phoneNumber - 휴대폰번호 [- 제외]
     */
    public String addAuthInfo(String phoneNumber) {
        // 인증번호 생성
        String certNumber = certNumGenerator(4).toString();
        logger.debug("회원가입 인증번호 : " + certNumber);

        managementMapper.addAuthInfo(phoneNumber, certNumber);

        /*
         * 인증번호를 메시지로 전송한다.
         * 메시지를 보냈을 때, 리턴값은 다음과 같다.
         * -> resultJson = {"group_id":"R2GJBapnz5mIGHJQ","success_count":1,"error_count":0}
         * 참고 - https://www.coolsms.co.kr/
         */
        MessagingService messageSend = MessagingService.getInstance();
        JSONObject resultJson = messageSend.sendCertificationSMS(phoneNumber, certNumber);

        String successCount = resultJson.get("success_count").toString();
        logger.debug("메시지 전송 Success Count = " + Integer.parseInt(successCount));
        return successCount;
    }

    /**
     * 인증까지 하고 최종으로 로그인 데이터를 추가한다.
     *
     * @param login      - 기사 정보 [차량번호, 휴대폰번호, 기사이름]
     * @param authNumber - 인증번호 4자리
     */
    public String resultLogin(DriverLogin login, String authNumber) {

        // 인증번호가 맞는지 확인을 한다.
        String authResult = managementMapper.searchAuthNumber(authNumber, login.getDriverHpNo());

        // null이 아닐 경우, 휴대폰번호와 인증번호가 일치한다.
        if (authResult != null) {
            managementMapper.addDriverLogin(login);

            if (login.getDriverLoginUid() != null) {
                return login.getDriverLoginUid();
            }
        }

        return "";
    }

    /**
     * 전달된 파라미터에 맞게 난수를 생성한다.
     *
     * @param length - 생성할 난수의 길이
     */
    public StringBuilder certNumGenerator(int length) {
        Random random = new Random();
        StringBuilder certNumStr = new StringBuilder();

        for (int i = 0; i < length; i++) {
            String ran = Integer.toString(random.nextInt(10));
            certNumStr.append(ran);
        }

        return certNumStr;
    }

    /**
     * 택배 목록을 조회한다.
     */
    public List<LogisOrderInfo> searchLogisOrderInfo() {
        return managementMapper.searchLogisOrderInfo();
    }

    /**
     * 해당 택배 차량에 설정된 택배를 조회한다.
     *
     * @param logisNumber - 차량 번호
     */
    public List<LogisOrderInfo> searchMyLogisOrderInfo(String logisNumber) {
        return managementMapper.searchMyLogisOrderInfo(logisNumber);
    }

    /**
     * 상세한 택배 목록을 조회한다.
     */
    public LogisOrderInfo searchLogisOrderInfoDetail(String logisOrderUid) {
        // 해당 배송에 포함된 물품을 조회한다.
        List<RFIDItem> rfidItemList = managementMapper.searchRfidItem(logisOrderUid);

        LogisOrderInfo info = managementMapper.searchLogisOrderInfoDetail(logisOrderUid);
        info.setRfidItemList(rfidItemList);
        // RFID 검색을 한다.
        return info;
    }

    /**
     * 신청자가 입력한 물품정보를 조죄한다.
     */
    public String searchLogisItemInfo(String logisOrderUid) {
        return managementMapper.searchLogisItemInfo(logisOrderUid);
    }

    /**
     * 배송 상태를 업데이트한다.
     *
     * @param logisOrderUid - 배송 고유번호
     * @param status        - 상태 0:접수완료, 1:상품인수 출발, 2:상품인수, 3:배달출발, 4:배달완료
     */
    public void updateLogisStatus(String logisOrderUid, int status) {

        managementMapper.updateLogisStatus(logisOrderUid, status);

        // 배달출발 상태는 출발시간을 변경
        if (status == 4) {
            managementMapper.updateLogisStartTime(logisOrderUid);
        } else if (status == 5) {
            // 배달완료 상태는 도착시간을 변경
            managementMapper.updateLogisArriveTime(logisOrderUid);
        }
    }

    /**
     * 택배 기사가 물품을 인수하면서 RFID로 데이터를 추가할 때, 사용한다.
     *
     * @param itemInfo       - 창고 보관 데이터의 고유번호
     * @param rfidUid        - RFID 번호
     * @param logisOrderInfo - 배송 고유번호
     */
    public void logisItemAction(String rfidUid, String logisOrderInfo, String itemInfo) {
        // warehouse_item에 데이터를 추가하고
        WarehouseItem item = new WarehouseItem();
        item.setItemInfo(itemInfo);
        managementMapper.addItemUsingLogis(item);

        // RFID에 데이터를 위의 UID 값을 넣어준다.
        RFID rfid = new RFID();
        rfid.setRfidUid(rfidUid);
        rfid.setLogisOrderUid(logisOrderInfo);
        rfid.setItemUid(item.getItemUid());

        managementMapper.insertRfidByDriver(rfid);
    }

    /**
     * 배송에 담당 기사를 설정한다.
     */
    public void updateOrderLogisNumber(String logisNumber, String logisOrderUid) {
        managementMapper.updateOrderLogisNumber(logisNumber, logisOrderUid);
    }

    /**
     * 기사가 배송 상세화면에서 RFID가 등록된 물품을 지울 때 동작
     */
    public void removeItemInfoByDriver(String rfidUid, String itemUid) {
        managementMapper.clearRfidInfo(rfidUid);
        managementMapper.removeItemInfo(itemUid);
    }

    // ---------------------------- 창고 관리자 관련 ----------------------------
    public String warehouseLogin(String id, String passwd) {
        String result = managementMapper.searchWarehouseManager(id, passwd);

        // 차량번호와 아이디가 일치한다면
        if (result != null) {
            return result;
        } else {
            return "";
        }
    }

    /**
     * 해당 창고 업체에서 보유하고 있는 공간 목록을 조회한다.
     *
     * @param warehouseUid - 창고 고유번호
     */
    public List<WarehouseSpace> searchWarehouseSpace(String warehouseUid) {
        return managementMapper.searchWarehouseSpace(warehouseUid);
    }

    /**
     * RFID에 담긴 자세한 내용을 조회한다.
     */
    public SearchRfidInfo searchRfidInfo(String rfidUid) {
        return managementMapper.searchRfidInfo(rfidUid);
    }

    public List<SearchRfidInfo> searchItemList(String warehouseUid) {
        return managementMapper.searchItemList(warehouseUid);
    }

    public SearchRfidInfo searchItem(String itemUid) {
        return managementMapper.searchItem(itemUid);
    }

    /**
     * 창고에 맡긴 물건의 입출고 시간을 설정한다.
     *
     * @param state   - 1:입고, 2:출고
     * @param itemUid - 물품 고유번호
     */
    public void updateItemDate(int state, String itemUid, String rfidUid) {
        // 입고
        if (state == 1) {
            // 물품을 입고 상태로 변경
            managementMapper.updateItemInItem(itemUid);

            // 물품 로그 데이터 추가
            WarehouseItem item = managementMapper.searchItemForHistory(itemUid);
            managementMapper.insertInItemHistory(item);

        } else if (state == 2) {
            // 물품을 출고 상태로 변경
            managementMapper.updateItemOutItem(itemUid);

            managementMapper.deleteSpaceRfid(rfidUid);

            // 물품 로그 데이터 추가
            WarehouseItem item = managementMapper.searchItemForHistory(itemUid);
            managementMapper.insertOutItemHistory(item);
        }
    }

    /**
     * 물품의 보관장소를 변경한다.
     */
    public void updateSpaceUid(String itemUid, String spaceUid, String rfidUid) {
        // 물품의 보관 위치를 변경
        managementMapper.updateSpaceUid(itemUid, spaceUid);

        // 공간(warehouse_item)에 기록된 RFID UID 정보를 업데이트한다.
        managementMapper.deleteSpaceRfid(rfidUid);
        managementMapper.updateRfidByManager(rfidUid, spaceUid);
    }

    /**
     * 회사명을 검색한다.
     */
    public List<Company> searchCompany() {
        return managementMapper.searchCompany();
    }

    /**
     * 창고 관리자가 직접 물품을 등록할 때
     */
    public boolean enroll(String rfidUid, String orderInfoUid, String spaceUid, String itemInfo) {

        // 1. RFID_UID가 이미 사용중인지 확인을 한다.
        String rfidNo = managementMapper.checkRfidUid(rfidUid);
        logger.debug("RFID_NO = " + rfidNo);

        // RFID_UID가 등록되지 않은 경우, rfidNo는 NULL이다.
        if (rfidNo == null) {
            WarehouseItem item = new WarehouseItem();
            item.setSpaceUid(spaceUid);
            item.setOrderInfoUid(orderInfoUid);
            item.setItemInfo(itemInfo);

            // 2. warehouse_item 테이블에 데이터를 추가한다.
            managementMapper.insertItemByManager(item);

            if (Integer.parseInt(item.getItemUid()) > 0) {
                // 3. rfid 테이블에 데이터를 추가한다.
                managementMapper.insertRfidByManager(rfidUid, item.getItemUid(), orderInfoUid);

                // 4. warehouse_space 테이블에 RFID_UID 값을 업데이트 한다.
                managementMapper.updateRfidByManager(rfidUid, spaceUid);

                // 5. 업고 물품에 대한 로그성 데이터를 추가한다.
                managementMapper.insertInItemHistory(item);

                return true;
            }
        }
        return false;
    }
}
