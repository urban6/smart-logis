package kr.co.shovvel.dm.controller.logis.logis;

import kr.co.shovvel.dm.common.Config;
import kr.co.shovvel.dm.common.Consts;
import kr.co.shovvel.dm.domain.logis.apply.LogisOrderInfo;
import kr.co.shovvel.dm.domain.logis.apply.LogisUserInfo;
import kr.co.shovvel.dm.domain.logis.search.LogisSearchInfo;
import kr.co.shovvel.dm.domain.warehouse.WarehouseInfo;
import kr.co.shovvel.dm.service.logis.logis.LogisService;
import kr.co.shovvel.dm.service.logis.warehouse.apply.WarehouseApplyService;
import kr.co.shovvel.dm.service.management.pay.PayService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/user/logis")
public class LogisController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private LogisService logisService;

    @Autowired
    private WarehouseApplyService warehouseApplyService;

    @Autowired
    private PayService payService;

    /**
     * 창고로 물류 배송신청
     */
    @RequestMapping("/apply")
    public ModelAndView apply(HttpServletResponse response, HttpServletRequest request, Model model) {
        response.setHeader("Cache-Control", "no-cache");

        HttpSession session = request.getSession();
        String userUid = (String) session.getAttribute("userUid");

        // 현재 대여하고 있는 창고 리스트
        List<WarehouseInfo> warehouseNameList = warehouseApplyService.getUsingWarehouseName(userUid);

        // 회원의 기본적인 정보를 가져온다 (이름, 연락처, 우편번호, 주소, 상세주소)
        LogisUserInfo info = logisService.searchUserAddress(userUid);

        ModelAndView mav = new ModelAndView();
        mav.addObject("warehouseNameList", warehouseNameList);
        mav.addObject("userInfo", info);
        mav.setViewName("logis/apply/logisApply");
        return mav;
    }

    /**
     * 창고로 물류 배송신청
     */
    @RequestMapping("/normalApply")
    public ModelAndView normalApply(HttpServletResponse response, HttpServletRequest request, Model model) {
        response.setHeader("Cache-Control", "no-cache");

        HttpSession session = request.getSession();
        String userUid = (String) session.getAttribute("userUid");

        // 현재 대여하고 있는 창고 리스트
        List<WarehouseInfo> warehouseNameList = warehouseApplyService.getUsingWarehouseName(userUid);

        // 회원의 기본적인 정보를 가져온다 (이름, 연락처, 우편번호, 주소, 상세주소)
        LogisUserInfo info = logisService.searchUserAddress(userUid);

        ModelAndView mav = new ModelAndView();
        mav.addObject("warehouseNameList", warehouseNameList);
        mav.addObject("userInfo", info);
        mav.setViewName("logis/apply/logisNormalApply");
        return mav;
    }

    @RequestMapping("/search")
    public ModelAndView search(HttpServletResponse response, HttpServletRequest request, Model model) {
        response.setHeader("Cache-Control", "no-cache");

        HttpSession session = request.getSession();
        String userUid = (String) session.getAttribute("userUid");

        List<LogisSearchInfo> infoList = logisService.searchLogisOrderInfo(userUid);

        ModelAndView mav = new ModelAndView();
        mav.addObject("infoList", infoList);
        mav.setViewName("logis/search/logisSearch");
        return mav;
    }

    @RequestMapping("/searchDetail")
    public ModelAndView searchDetail(HttpServletResponse response, HttpServletRequest request, Model model) {
        response.setHeader("Cache-Control", "no-cache");

        String logisOrderUid = request.getParameter("logisOrderUid");

        LogisSearchInfo info = logisService.searchLogisDetail(logisOrderUid);

        ModelAndView mav = new ModelAndView();
        mav.addObject("info", info);
        mav.setViewName("logis/search/logisSearchDetail");
        return mav;
    }

    @RequestMapping("/order")
    public void order(HttpServletRequest request, @ModelAttribute LogisOrderInfo info, Model model) {
        HttpSession session = request.getSession();
        String userUid = (String) session.getAttribute("userUid");
        info.setUserUid(userUid); // 회원 번호 추가
        info.setPayType("X"); // 결제를 아직 정하지 않음

        // 박스, 팔레트 배송가격을 검색한다.
        // FIXME: 2020/12/11 실 서비스를 시작할 때, seller_product_info 테이블을 새로 추가하는 경우 키 값을 변경해야 한다.
        int boxPrice = payService.searchLogisPrice(Consts.LOGIS_PRICE_KEY.BOX);
        int palettePrice = payService.searchLogisPrice(Consts.LOGIS_PRICE_KEY.PALETTE);

        // 총 배송 가격
        int totalPrice = (boxPrice * info.getBoxCount()) + (palettePrice * info.getPaletteCount());
        info.setPrice(totalPrice);

        // 희망 배송 날짜가 유효하지 않을 경우 null
        if (!validationDate(info.getWishDeliveryDatetime())) {
            info.setWishDeliveryDatetime(null);
        }

        // DB에 물류 신청 데이터 추가
        logisService.applyAction(info);

        if (info.getLogisOrderUid() != null) {
            model.addAttribute("result", 1);
        } else {
            model.addAttribute("result", 0);
        }
    }

    @RequestMapping("/payOrder")
    public void payOrder(HttpServletRequest request, @ModelAttribute LogisOrderInfo info, Model model) {

        // 아직 추가되지 않은 정보 추가
        HttpSession session = request.getSession();
        String userUid = (String) session.getAttribute("userUid");
        info.setUserUid(userUid); // 회원 번호 추가
        info.setLogisType(1); // 회사에서 창로고 보내는 경우, logisType = 1 로 설정한다.
        info.setPayType("P"); // Payco 결제만 가능

        int boxPrice = payService.searchLogisPrice(Consts.LOGIS_PRICE_KEY.BOX);
        int palettePrice = payService.searchLogisPrice(Consts.LOGIS_PRICE_KEY.PALETTE);

        // 총 배송 가격
        int totalPrice = (boxPrice * info.getBoxCount()) + (palettePrice * info.getPaletteCount());
        info.setPrice(totalPrice);

        // 희망 배송 날짜가 유효하지 않을 경우 null
        if (!validationDate(info.getWishDeliveryDatetime())) {
            info.setWishDeliveryDatetime(null);
        }

        // DB에 물류 신청 데이터 추가
        logisService.applyActionToWarehouse(info);

        if (info.getLogisOrderUid() != null) {
            // FIXME: 2020/12/11 - 일반 박스 배송은 3,500원 팔레트 배송은 50,000원이다.
            // 일반 배송지에서 창고로 운송하는 경우의 가격 데이터를 조회한다.
            // String productName = payService.searchSellerKey(3);

            model.addAttribute("result", 1);

            // 결제를 할 때, 신청 고유번호가 필요하기 때문에 세션에 저장을 한다.
            session.setAttribute("type", "logis");
            session.setAttribute("logisOrderUid", info.getLogisOrderUid());

            // 결제에 필요한 데이터를 담는다.
            model.addAttribute("logisOrderInfo", ""); // 사용한 데이터는 삭제
            model.addAttribute("isStatus", "P");
            // model.addAttribute("productName", productName);

            // model.addAttribute("quantity", info.getWeight());
            model.addAttribute("boxCount", info.getBoxCount());
            model.addAttribute("paletteCount", info.getPaletteCount());
        } else {
            model.addAttribute("result", 0);
        }
    }

    @RequestMapping("/paying")
    public ModelAndView paying(HttpServletRequest request, @RequestParam Map<String, Object> param) {
        HttpSession session = request.getSession();
        String userUid = (String) session.getAttribute("userUid");

        // 배송 박스, 팔레트 수량
        int boxCount = Integer.parseInt((String) param.get("boxCount"));
        int paletteCount = Integer.parseInt((String) param.get("paletteCount"));

        // 배송 상품별 키 조회
        String boxSellerKey = payService.searchSellerKey(Consts.LOGIS_PRICE_KEY.BOX);
        String paletteSellerKey = payService.searchSellerKey(Consts.LOGIS_PRICE_KEY.PALETTE);

        ModelAndView mav = new ModelAndView();
        mav.addObject("userUid", userUid);
        mav.addObject("isStatus", "P"); // 페이코만 사용하기로 결정함
        mav.addObject("type", "logis");

        mav.addObject("boxCount", boxCount);
        mav.addObject("paletteCount", paletteCount);

        mav.addObject("boxSellerKey", boxSellerKey);
        mav.addObject("paletteSellerKey", paletteSellerKey);

        mav.setViewName("logis/pay/paying");
        return mav;
    }

    /**
     * 결제가 완료 되었을 때, 신청 정보 데이터를 결제 완료 상태로 변경
     */
    @RequestMapping(value = "/actionPayUpdate")
    public void actionPayUpdate(HttpServletRequest request, @RequestParam String salesUid, Model model) {
        HttpSession session = request.getSession();

        if (session.getAttribute("logisOrderUid") != null) {
            // 결제를 하기 직전에 넣은 orderInfoUid를 가져온다.
            int orderUid = Integer.parseInt((String) session.getAttribute("logisOrderUid"));

            if (orderUid > 0) {
                // 결제 완료 상태로 변경한다.
                logisService.updatePayStateInOrderInfo(salesUid, orderUid);
            }

            // 새로고침을 했을 때, 다시 결제를 할 수 없도록 값을 변경한다.
            session.setAttribute("logisOrderInfoUid", -1);
        }
    }

    public boolean validationDate(String checkDate) {
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            dateFormat.setLenient(false);
            dateFormat.parse(checkDate);
            return true;
        } catch (ParseException e) {
            return false;
        }
    }
}
