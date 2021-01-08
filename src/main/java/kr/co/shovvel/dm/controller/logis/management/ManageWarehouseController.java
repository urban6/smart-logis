package kr.co.shovvel.dm.controller.logis.management;

import com.google.gson.Gson;
import kr.co.shovvel.dm.domain.logis.apply.LogisOrderInfo;
import kr.co.shovvel.dm.domain.logis.management.Company;
import kr.co.shovvel.dm.domain.logis.management.SearchRfidInfo;
import kr.co.shovvel.dm.domain.warehouse.WarehouseSpace;
import kr.co.shovvel.dm.service.logis.management.ManagementService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping(value = "/management/warehouse")
public class ManageWarehouseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private ManagementService managementService;

    /**
     * 기사, 로그인
     */
    @RequestMapping(value = "/loginAction", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String loginAction(@RequestBody Map<String, Object> param) {
        String id = param.get("id").toString();
        String password = param.get("password").toString();

        String warehouseUid = managementService.warehouseLogin(id, password);

        Map<String, Object> data = new HashMap<>();

        // 아이디 패스워드 일치
        if (!warehouseUid.equals("")) {
            data.put("result", true);
            data.put("warehouseUid", Integer.parseInt(warehouseUid));
        } else {
            data.put("result", false);
        }

        Gson gson = new Gson();
        return gson.toJson(data);
    }

    /**
     * 해당 창고의 공간을 조회한다.
     */
    @RequestMapping(value = "/searchSpace", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String searchSpace(@RequestBody Map<String, Object> param) {
        String warehouseUid = param.get("warehouseUid").toString();

        List<WarehouseSpace> list = managementService.searchWarehouseSpace(warehouseUid);

        Gson gson = new Gson();
        logger.debug(gson.toJson(list));
        return gson.toJson(list);
    }

    @RequestMapping(value = "/searchRfid", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String searchRfid(@RequestBody Map<String, Object> param) {
        String rfidUid = param.get("rfidUid").toString();

        SearchRfidInfo info = managementService.searchRfidInfo(rfidUid);

        if (info == null) {
            info = new SearchRfidInfo();
            info.setItemUid(-1);
        }

        Gson gson = new Gson();
        return gson.toJson(info);
    }

    @RequestMapping(value = "/searchItemList", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String searchItemList(@RequestBody Map<String, Object> param) {
        int warehouseUid = (int) param.get("warehouseUid");

        List<SearchRfidInfo> list = managementService.searchItemList(String.valueOf(warehouseUid));
        Gson gson = new Gson();
        return gson.toJson(list);
    }

    @RequestMapping(value = "/searchItem", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String searchItem(@RequestBody Map<String, Object> param) {
        int itemUid = (int) param.get("itemUid");

        SearchRfidInfo item = managementService.searchItem(String.valueOf(itemUid));
        Gson gson = new Gson();
        return gson.toJson(item);
    }

    /**
     * 물품 출고
     */
    @RequestMapping(value = "/updateItemDate", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String updateItemDate(@RequestBody Map<String, Object> param) {
        int state = (int) param.get("state");
        int itemUid = (int) param.get("itemUid");
        String rfidUid = (String) param.get("rfidUid");

        managementService.updateItemDate(state, String.valueOf(itemUid), rfidUid);

        Map<String, Object> data = new HashMap<>();
        data.put("result", true);

        Gson gson = new Gson();
        return gson.toJson(data);
    }

    @RequestMapping(value = "/updateSpace", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String updateSpace(@RequestBody Map<String, Object> param) {
        int spaceUid = (int) param.get("spaceUid");
        int itemUid = (int) param.get("itemUid");
        String rfidUid = (String) param.get("rfidUid");

        logger.debug("RFID_UID = " + rfidUid);

        // 물품의 보관위치 데이터를 변경
        managementService.updateSpaceUid(String.valueOf(itemUid), String.valueOf(spaceUid), rfidUid);

        Map<String, Object> data = new HashMap<>();
        data.put("result", true);

        Gson gson = new Gson();
        return gson.toJson(data);
    }

    /**
     * 현재 시간을 기준으로 공간을 대여하고 있는 회사 리스트를 조회한다.
     */
    @RequestMapping(value = "/searchCompany", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String searchCompany() {
        List<Company> list = managementService.searchCompany();
        Gson gson = new Gson();
        return gson.toJson(list);
    }

    /**
     * 관리자가 직접 창고에 RFID가 부착된 물품을 추가한다.
     */
    @RequestMapping(value = "/enroll", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String enroll(@RequestBody Map<String, Object> param) {

        String rfidUid = (String) param.get("rfidUid"); // RFID
        int orderInfoUid = (int) param.get("orderInfoUid"); // 창고 대여 고유번호
        int spaceUid = (int) param.get("spaceUid"); // 보관위치 고유번호
        String itemInfo = (String) param.get("itemInfo"); // 물품 정보

        boolean result = managementService.enroll(rfidUid, String.valueOf(orderInfoUid), String.valueOf(spaceUid), itemInfo);

        Map<String, Object> data = new HashMap<>();
        data.put("result", result);

        Gson gson = new Gson();
        return gson.toJson(data);
    }
}
