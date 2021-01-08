package kr.co.shovvel.dm.controller.logis.management;

import com.google.gson.Gson;
import kr.co.shovvel.dm.domain.logis.apply.LogisOrderInfo;
import kr.co.shovvel.dm.domain.logis.management.DriverLogin;
import kr.co.shovvel.dm.service.logis.management.ManagementService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 기사, 창고 관리자를 위한 안드로이드 앱에서 사용하는 REST API
 */
@RestController
@RequestMapping(value = "/management/logis")
public class ManageLogisController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private ManagementService managementService;

    @RequestMapping("/checkRFID")
    public String checkRFID(HttpServletResponse response, HttpServletRequest request) {
        return "TESTTESTTEST";
    }

    /**
     * 기사, 로그인
     */
    @RequestMapping(value = "/loginAction", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String loginAction(@RequestBody Map<String, Object> param) {
        String id = param.get("id").toString();
        String password = param.get("password").toString();

        String logisNumber = managementService.logisLogin(id, password);

        Map<String, Object> data = new HashMap<>();

        // 아이디 패스워드 일치
        if (!logisNumber.equals("")) {
            data.put("result", true);
            data.put("logisNumber", logisNumber);
        } else {
            data.put("result", false);
        }

        Gson gson = new Gson();
        return gson.toJson(data);
    }

    /**
     * 기사는 로그인 할 때, 인증을 하지 않게 되어서 사용하지 않음
     */
    @Deprecated
    @RequestMapping(value = "/authAction", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String authAction(@RequestBody Map<String, Object> param) {
        String phoneNumber = param.get("phoneNumber").toString();

        /*
        String result = managementService.addAuthInfo(phoneNumber);

        // 인증번호 메시지를 보내고 값을 DB에 저장한다.
        Map<String, Object> data = new HashMap<>();
        if (result.equals("1")) {
            data.put("result", true);
        } else {
            data.put("result", false);
        }
         */

        // 개발중일 때, 메시지를 보내지 않음
        Map<String, Object> data = new HashMap<>();
        data.put("result", true);

        Gson gson = new Gson();
        return gson.toJson(data);
    }

    @RequestMapping(value = "/resultLoginAction", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String resultLoginAction(@RequestBody Map<String, Object> param) {

        String logisNumber = param.get("logisNumber").toString();
        String driverHpNo = param.get("driverHpNo").toString();
        String driverName = param.get("name").toString();
        String authNumber = param.get("authNumber").toString();

        DriverLogin login = new DriverLogin();
        login.setLogisNumber(logisNumber);
        login.setDriverHpNo(driverHpNo);
        login.setDriverName(driverName);

        String driverLogUid = managementService.resultLogin(login, authNumber);

        Map<String, Object> data = new HashMap<>();

        // 아이디 패스워드 일치
        if (!driverLogUid.equals("")) {
            data.put("result", true);
            data.put("driverLogUid", Integer.parseInt(driverLogUid));
        } else {
            data.put("result", false);
        }

        Gson gson = new Gson();
        return gson.toJson(data);
    }

    /**
     * 접수된 택배를 조회한다.
     */
    @RequestMapping(value = "/searchLogisOrderInfo", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String searchLogisOrderInfo() {
        List<LogisOrderInfo> list = managementService.searchLogisOrderInfo();
        Gson gson = new Gson();
        logger.debug(gson.toJson(list));
        return gson.toJson(list);
    }

    /**
     * 해당 차량에 담당된 택배를 조회한다.
     */
    @RequestMapping(value = "/searchMyLogisOrderInfo", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String searchMyLogisOrderInfo(@RequestBody String logisNumber) {
        List<LogisOrderInfo> list = managementService.searchMyLogisOrderInfo(logisNumber);
        Gson gson = new Gson();
        logger.debug(gson.toJson(list));
        return gson.toJson(list);
    }

    /**
     * 택배 항목에 대한 자세한 정보를 조회한다.
     *
     * @param logisOrderUid - 택배 고유번호
     */
    @RequestMapping(value = "/searchLogisOrderInfoDetail", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String searchLogisOrderInfoDetail(@RequestBody String logisOrderUid) {
        LogisOrderInfo info = managementService.searchLogisOrderInfoDetail(logisOrderUid);

        Gson gson = new Gson();
        logger.debug(gson.toJson(info));
        return gson.toJson(info);
    }

    @RequestMapping(value = "/updateLogisStatus", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String updateLogisStatus(@RequestBody Map<String, Object> param) {

        logger.debug("logisOrderUid = " + param);

        String logisOrderUid = (String) param.get("logisOrderUid");
        int status = (int) param.get("status");

        managementService.updateLogisStatus(String.valueOf(logisOrderUid), status);

        Map<String, Object> data = new HashMap<>();
        data.put("result", true);

        Gson gson = new Gson();
        return gson.toJson(data);
    }

    @RequestMapping(value = "/addLogisItem", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String addLogisItem(@RequestBody Map<String, Object> param) {
        // 1. 회원이 가지고 있는 창고를 조회한다.
        String rfidUid = (String) param.get("rfidUid");
        String logisOrderInfo = (String) param.get("logisOrderInfo");
        String itemInfo = (String) param.get("itemInfo");

        managementService.logisItemAction(rfidUid, logisOrderInfo, itemInfo);

        Map<String, Object> data = new HashMap<>();
        data.put("result", true);

        Gson gson = new Gson();
        return gson.toJson(data);
    }

    @RequestMapping(value = "/updateOrderLogisNumber", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String updateOrderLogisNumber(@RequestBody Map<String, Object> param) {
        String logisNumber = (String) param.get("logisNumber");
        int logisOrderUid = (int) param.get("logisOrderUid");

        managementService.updateOrderLogisNumber(logisNumber, String.valueOf(logisOrderUid));

        Map<String, Object> data = new HashMap<>();
        data.put("result", true);

        Gson gson = new Gson();
        return gson.toJson(data);
    }

    @RequestMapping(value = "/searchLogisItemInfo", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String searchLogisItemInfo(@RequestBody String logisOrderUid) {
        String itemInfo = managementService.searchLogisItemInfo(logisOrderUid);

        Map<String, Object> data = new HashMap<>();
        data.put("itemInfo", itemInfo);

        Gson gson = new Gson();
        return gson.toJson(data);
    }

    @RequestMapping(value = "/removeItemInfo", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String removeItemInfo(@RequestBody Map<String, Object> param) {

        String rfidUid = (String) param.get("rfidUid");
        int itemUid = (int) param.get("itemUid");

        managementService.removeItemInfoByDriver(rfidUid, String.valueOf(itemUid));

        Map<String, Object> data = new HashMap<>();
        data.put("result", true);

        Gson gson = new Gson();
        return gson.toJson(data);
    }
}
