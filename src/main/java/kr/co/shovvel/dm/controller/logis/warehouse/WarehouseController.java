package kr.co.shovvel.dm.controller.logis.warehouse;

import kr.co.shovvel.dm.common.Config;
import kr.co.shovvel.dm.common.Consts;
import kr.co.shovvel.dm.dao.logis.warehouse.apply.WarehouseApplyMapper;
import kr.co.shovvel.dm.domain.logis.apply.LogisOrderInfo;
import kr.co.shovvel.dm.domain.logis.search.WarehouseSearchInfo;
import kr.co.shovvel.dm.domain.logis.warehouse.WarehouseLendInfo;
import kr.co.shovvel.dm.domain.logis.warehouse.WarehouseOrderInfo;
import kr.co.shovvel.dm.domain.warehouse.WarehouseInfo;
import kr.co.shovvel.dm.domain.warehouse.WarehouseSpace;
import kr.co.shovvel.dm.service.logis.warehouse.apply.WarehouseApplyService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.apache.log4j.Logger;

import kr.co.shovvel.dm.domain.management.pay.SellerProductInfoVO;
import kr.co.shovvel.dm.service.logis.warehouse.WarehouseService;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(value = "/user/warehouse")
public class WarehouseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private WarehouseService warehouseService;

    @Autowired
    private WarehouseApplyService warehouseApplyService;

    /**
     * 대여할 수 있는 창고를 조회할 수 있는 화면
     */
    @RequestMapping("/apply")
    public ModelAndView warehouseapply(HttpServletResponse response, HttpServletRequest request, Model model) {
        response.setHeader("Cache-Control", "no-cache");

        List<WarehouseInfo> warehouseNameList = warehouseApplyService.getWarehouseName();

        // 현재 로그인된 사용자의 회사 위치를 가져온다.
        HttpSession session = request.getSession();
        String userUid = (String) session.getAttribute("userUid");
        String companyAddress = warehouseService.searchComapanyAddress(userUid);

        ModelAndView mav = new ModelAndView();
        mav.addObject("warehouseNameList", warehouseNameList);
        mav.addObject("companyAddress", companyAddress);
        mav.setViewName("logis/apply/warehouseApply");
        return mav;
    }

    @RequestMapping("/applyDetail")
    public ModelAndView applyDetail(HttpServletResponse response, @RequestParam Map<String, Object> param) {
        response.setHeader("Cache-Control", "no-cache");

        // 창고 조회에 필요한 파라미터
        String warehouseUid = (String) param.get("warehouseUid");
        String startDatetime = (String) param.get("startDatetime");
        String endDatetime = (String) param.get("endDatetime");
        int spaceSize = Integer.parseInt(param.get("spaceSize").toString());

        
        // 사용자가 선택한 조건의 창고 정보를 가져온다.
        WarehouseInfo info = warehouseApplyService.searchSelectedWarehouse(warehouseUid, startDatetime, endDatetime, spaceSize);

        ModelAndView mav = new ModelAndView();
        mav.addObject("info", info);
        mav.setViewName("logis/apply/warehouseApplyDetail");
        return mav;
    }
    
    @RequestMapping("/paycoTest")
    public ModelAndView paycoTest(HttpServletResponse response, @RequestParam Map<String, Object> param) {
        response.setHeader("Cache-Control", "no-cache");

        // 창고 조회에 필요한 파라미터
        String warehouseUid = "1";
        String startDatetime = "2020-12-25 17:00";
        String endDatetime = "2020-12-26 17:00";
        int spaceSize = 1;

        // 사용자가 선택한 조건의 창고 정보를 가져온다.
        WarehouseInfo info = warehouseApplyService.searchSelectedWarehouse(warehouseUid, startDatetime, endDatetime, spaceSize);

        ModelAndView mav = new ModelAndView();
        mav.addObject("info", info);
        mav.setViewName("logis/apply/paycotest");
        return mav;
    }
    
    @RequestMapping("/paying_test")
    public ModelAndView paying_test(HttpServletRequest request, @RequestParam Map<String, Object> param) {
        String userUid = "1";

        // 배송 박스, 팔레트 수량
        String payType = (String) param.get("payType");
        int quantity = Integer.parseInt((String) param.get("quantity"));

        ModelAndView mav = new ModelAndView();
        mav.addObject("userUid", userUid);
        mav.addObject("type", "warehouse");
        mav.addObject("isStatus", "P"); // 페이코만 사용하기로 결정함
        mav.addObject("quantity", quantity);
        mav.addObject("productKey", "5");

        mav.setViewName("logis/pay/paying_test");
        return mav;
    }


    @RequestMapping("/search")
    public ModelAndView warehousesearch(HttpServletResponse response, HttpServletRequest request, Model model) {
        response.setHeader("Cache-Control", "no-cache");

        HttpSession session = request.getSession();
        String userUid = (String) session.getAttribute("userUid");

        List<WarehouseSearchInfo> infoList = warehouseService.searchWarehouseOrderInfo(userUid);

        ModelAndView mav = new ModelAndView();
        mav.setViewName("logis/search/warehouseSearch");
        mav.addObject("infoList", infoList);
        return mav;
    }
    
    @RequestMapping("/rentSearch")
    public ModelAndView rentSearch(HttpServletResponse response, HttpServletRequest request, Model model) {
        response.setHeader("Cache-Control", "no-cache");

        HttpSession session = request.getSession();
        String userUid = (String) session.getAttribute("userUid");

        List<WarehouseSearchInfo> infoList = warehouseService.serchRentWarehouse(userUid);
        List<WarehouseSearchInfo> infoListBefore = warehouseService.serchRentWarehouseBefore(userUid);

        ModelAndView mav = new ModelAndView();
        mav.setViewName("logis/search/rentWarehouseSearch");
        mav.addObject("infoList", infoList);
        mav.addObject("infoListBefore", infoListBefore);
        return mav;
    }

    @RequestMapping("/searchAction")
    public void searchAction(@RequestParam Map<String, Object> param, Model model) {

        // 대여 시작 날짜, 종료 날짜, 공간 크기
        String startDatetime = (String) param.get("startDatetime");
        String endDatetime = (String) param.get("endDatetime");
        int spaceSize = Integer.parseInt((String) (param.get("spaceSize")));

        // 사용할 수 있는 창고 리스트를 조회한다.
        List<WarehouseInfo> usableList = warehouseApplyService.searchAvailableWarehouse(startDatetime, endDatetime, spaceSize);

        // 사용할 수 없는 창고 리스트를 조회한다.
        List<WarehouseInfo> unusableList = warehouseApplyService.searchUnavailAbleWarehouse(startDatetime, endDatetime, spaceSize);

        usableList.addAll(unusableList);
        model.addAttribute("list", usableList);
    }

    @RequestMapping("/searchDetail")
    public ModelAndView searchDetail(HttpServletResponse response, HttpServletRequest request, Model model) {
        response.setHeader("Cache-Control", "no-cache");

        String orderInfoUid = request.getParameter("orderInfoUid");

        WarehouseSearchInfo info = warehouseService.searchWarehouseOrderInfoDetail(orderInfoUid);

        ModelAndView mav = new ModelAndView();
        mav.addObject("info", info);
        mav.setViewName("logis/search/warehouseSearchDetail");
        return mav;
    }

    @RequestMapping("/complete")
    public ModelAndView warehouseComplete(HttpServletResponse response, HttpServletRequest request, Model model) {
        response.setHeader("Cache-Control", "no-cache");

        ModelAndView mav = new ModelAndView();
        mav.setViewName("logis/complete/warehouseComplete");
        return mav;
    }

    /**
     * 사용자가 결제를 하기 직전에 사용할 수 있는 공간을 확인한다.
     * 사용할 수 있는 공간이 있다면 결제 대기 시간을 설정한다.
     */
    @RequestMapping("/checkAvailableSpace")
    public void checkAvailableSpace(HttpServletRequest request, @RequestParam Map<String, Object> param, Model model) {
        HttpSession session = request.getSession();
        String userUid = (String) session.getAttribute("userUid");

        String warehouseUid = (String) param.get("warehouseUid"); // 창고 번호
        String startDatetime = (String) param.get("startDatetime"); // 대여 시작 Datetime
        String endDatetime = (String) param.get("endDatetime"); // 대여 종료 Datetime
        int spaceSize = Integer.parseInt((String) (param.get("spaceSize"))); // 공간의 수 [파렛트 크기]


        int result = warehouseApplyService.searchUsableSpaceCount(warehouseUid, startDatetime, endDatetime, spaceSize);
        model.addAttribute("result", result);
    }

    @RequestMapping("/order")
    public void order(HttpServletRequest request, @ModelAttribute WarehouseOrderInfo info, int dayPrice, int days, Model model) {
        // orderInfo.setCompanyUid(companyUid);

        HttpSession session = request.getSession();
        String userUid = (String) session.getAttribute("userUid");
        int companyUid = warehouseService.searchCompanyUid(Integer.parseInt(userUid));

        info.setUserUid(Integer.parseInt(userUid)); // 회원 번호 추가
        info.setPayType("P"); // 결제를 아직 정하지 않음
        info.setIsPay("N");
        info.setCompanyUid(companyUid);
        info.setStatus(0);

        int totalPrice = dayPrice * info.getSize() * days;
        info.setPrice(totalPrice);

        // 신청 내역을 추가한다.
        warehouseApplyService.addWarehouseOrderInfo(info);

        if (info.getOrderInfoUid() != 0) {
            // 신청 고유번호를 세션에 잠시 보관한다.
            session.setAttribute("type", "warehouse");
            session.setAttribute("warehouseOrderInfoUid", info.getOrderInfoUid());

            model.addAttribute("result", 1);
            model.addAttribute("payType", info.getPayType());
            model.addAttribute("quantity", info.getSize() * days);

        } else {
            model.addAttribute("result", 0);
        }
    }

    @RequestMapping("/paying")
    public ModelAndView paying(HttpServletRequest request, @RequestParam Map<String, Object> param) {
        HttpSession session = request.getSession();
        String userUid = (String) session.getAttribute("userUid");

        // 배송 박스, 팔레트 수량
        String payType = (String) param.get("payType");
        int quantity = Integer.parseInt((String) param.get("quantity"));

        ModelAndView mav = new ModelAndView();
        mav.addObject("userUid", userUid);
        mav.addObject("type", "warehouse");
        mav.addObject("isStatus", "P"); // 페이코만 사용하기로 결정함
        mav.addObject("quantity", quantity);
        mav.addObject("productKey", "5");

        mav.setViewName("logis/pay/paying");
        return mav;
    }

    /**
     * 사용자가 결제 버튼을 눌렀을 때, 데이터를 추가하고 결제 화면으로 이동한다.
     */
    @RequestMapping("/order2")
    public ModelAndView warehouseOrder(HttpServletResponse response, HttpServletRequest request, @RequestParam Map<String, Object> param, Model model) {
        response.setHeader("Cache-Control", "no-cache");

        // 결제가 성공적으로 되었을 경우, 데이터를 추가해야 하기 때문에 아래의 데이터를 세션에 잠시 저장한다.
        HttpSession session = request.getSession();

        int userUid = Integer.parseInt((String) session.getAttribute("userUid")); // 회원 고유번호
        int warehouseUid = Integer.parseInt((String) param.get("warehouseUid")); // 창고 고유번호
        String startDatetime = (String) param.get("startDatetime"); // 대여 시작 Datetime
        String endDatetime = (String) param.get("endDatetime"); // 대여 종료 Datetime

        String isStatus = (String) param.get("checkPayMethod"); // 결제 방법 P:페이코, Z:제로페이
        int quantity = Integer.parseInt((String) param.get("spaceSize")); // 공간의 수 [파렛트 크기]
        int days = Integer.parseInt((String) param.get("days")); // 대여 기간
        int price = Integer.parseInt((String) param.get("price")); // 공간 1개당 가격

        int totalQuantity = quantity * days; // 최종 수량

        int companyUid = warehouseService.searchCompanyUid(userUid);

        // WarehouseOrderInfo 테이블에 들어갈 데이터 객체를 만든다.
        WarehouseOrderInfo orderInfo = new WarehouseOrderInfo();
        orderInfo.setUserUid(userUid);
        orderInfo.setCompanyUid(companyUid);
        orderInfo.setWarehouseUid(warehouseUid);
        orderInfo.setStartTime(startDatetime);
        orderInfo.setEndTime(endDatetime);
        orderInfo.setSize(quantity);
        orderInfo.setPrice(totalQuantity * price);
        orderInfo.setPayType(isStatus);
        orderInfo.setStatus(0); // 예약 상태
        orderInfo.setIsPay("N"); // 결제는 하지 않음 = N

        // 신청 내역을 추가한다.
        warehouseApplyService.addWarehouseOrderInfo(orderInfo);

        // 신청 고유번호를 세션에 잠시 보관한다.
        session.setAttribute("type", "warehouse");
        session.setAttribute("warehouseOrderInfoUid", orderInfo.getOrderInfoUid());

        // 결제 화면으로 이동한다.
        ModelAndView mav = new ModelAndView();
        if (isStatus.equals("P")) { // 페이코 결제일 때
            mav.addObject("isStatus", isStatus);
            mav.addObject("quantity", totalQuantity);
            mav.setViewName("logis/pay/paying");
        } else {
            // 제로페이 결제일 때
            mav.setViewName("logis/complete/zeropayComplete");
        }
        return mav;
    }

    /**
     * 결제가 완료 되었을 때, 신청 정보 데이터를 결제 완료 상태로 변경
     */
    @RequestMapping(value = "/actionPayUpdate")
    public void actionPayUpdate(HttpServletRequest request, @RequestParam String salesUid, Model model) {
        HttpSession session = request.getSession();

        if (session.getAttribute("warehouseOrderInfoUid") != null) {
            // 결제를 하기 직전에 넣은 orderInfoUid를 가져온다.
            int orderUid = (int) session.getAttribute("warehouseOrderInfoUid");

            if (orderUid > 0) {
                // 결제 완료 상태로 변경한다.
                warehouseApplyService.updatePayStateInOrderInfo(salesUid, orderUid);
            }

            // 새로고침을 했을 때, 다시 결제를 할 수 없도록 값을 변경한다.
            session.setAttribute("warehouseOrderInfoUid", -1);
        }
    }

    /**
     * 내 창고 대여 신청
     */
    @RequestMapping(value = "/lend")
    public ModelAndView lend(HttpServletResponse response, HttpServletRequest request) {
        response.setHeader("Cache-Control", "no-cache");

        ModelAndView mav = new ModelAndView();
        mav.setViewName("logis/lend/warehouseLend");
        return mav;
    }

    /**
     * 대여 신청
     * [ result 값이 0 = 성공, 1 = 실패 ]
     */
    @RequestMapping(value = "/lendAction")
    public void lendAction(HttpServletRequest request, @ModelAttribute WarehouseLendInfo lendInfo, Model model) {
        if (lendInfo != null) {
            // 신청 데이터에 회원 고유번호 추가
            HttpSession session = request.getSession();
            String userUid = (String) session.getAttribute("userUid");
            lendInfo.setUserUid(userUid);

            // DB에 추가
            warehouseService.addWarehouseLend(lendInfo);

            // 추가되었을 경우
            if (lendInfo.getLendOrderUid() != null) {
                model.addAttribute("result", 0); // 성공
            } else {
                // 추가되지 않았을 경우
                model.addAttribute("result", 1); // 실패
            }
        }
    }
}
