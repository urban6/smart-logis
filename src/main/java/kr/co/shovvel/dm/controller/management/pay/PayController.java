package kr.co.shovvel.dm.controller.management.pay;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.shovvel.dm.domain.logis.user.PayOrderInfo;
import kr.co.shovvel.dm.domain.management.pay.SellerApprovalVO;
import kr.co.shovvel.dm.domain.management.pay.SellerInfoVO;
import kr.co.shovvel.dm.domain.management.pay.SellerProductInfoVO;
import kr.co.shovvel.dm.domain.management.pay.SellerProductOrderVO;
import kr.co.shovvel.dm.service.management.pay.PayService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;


@Controller
@RequestMapping(value = "/user/pay")
public class PayController {

    private Logger logger = Logger.getLogger(this.getClass());

    java.text.SimpleDateFormat dateformat = new java.text.SimpleDateFormat("yyyyMMddHHmmss");

    /*
     * 개발용 간편결제 String sellerKey = "S0FSJE"; // 가맹점 코드 - 파트너센터에서 알려주는 값으로, 초기 연동 시
     * PAYCO에서 쇼핑몰에 값을 전달한다. String cpId = "PARTNERTEST"; // 상점ID String productId =
     * "PROD_EASY"; // 상품ID String deliveryId = "DELIVERY_PROD"; // 배송비상품ID String
     * deliveryReferenceKey = "DV0001"; // 가맹점에서 관리하는 배송비상품 연동 키 String serverType =
     * "DEV"; // 서버유형. DEV:개발, REAL:운영 String logYn = "Y"; // 로그Y/N
     */

    @Autowired
    private PayService payService;

    // 도메인명 or 서버IP
    String domainName = "user/pay";

    boolean isMobile = false;

    //가맹점 DB 아이디 real 환경

    public int sellerUid = 2;
    public String sellerKey = "F1S8YJ";
    PaycoUtil util = new PaycoUtil("REAL"); // CommonUtil


    //개발 환경
    /*
    public int sellerUid = 1;
    public String sellerKey = "S0FSJE";
    PaycoUtil util = new PaycoUtil("DEV"); // CommonUtil
    */


    // 취소, 환불, 영수증을 위한 데이터 가져오기
    @RequestMapping(value = "getApproval")
    public void getApproval(HttpServletRequest request, Model model) {

        String userUid = "1";
        SellerApprovalVO approvalInfo = payService.getArrovalDetail(userUid);

        model.addAttribute("approvalInfo", approvalInfo);

    }

    @RequestMapping(value = "payco_return_test")
    public String payco_return_test(HttpServletRequest request, Model model) throws JsonProcessingException, IOException {
        logger.debug("payco_return");

        ObjectMapper mapper = new ObjectMapper(); // jackson json object

        String userUid = "1";

        Boolean doCancel = false; // 승인 후 오류발생시 결제취소 여부
        Boolean doApproval = true; // 요청금액과 결제 금액 일치여부(true : 일치)
        String returnUrl = "";

        /*
         * http://localhost:8080/user/pay/payco_return?code=0&reserveOrderNo=
         * 202010262005369928&sellerOrderReferenceKey=TEST38558103697&mainPgCode=98&
         * totalPaymentAmt=10
         * &totalRemoteAreaDeliveryFeeAmt=0&discountAmt=0&pointAmt=10&
         * paymentCertifyToken=oKZISNRmoLPY2OV8qDj89MtlznqRiVWA9HIETrG-
         * SkEDMfeRUB80UattSHjKU2R_&bid=DMLHCSGKH3TFUAE512MXE2ULA
         */
        /* 인증 데이타 변수선언 */
        String reserveOrderNo = request.getParameter("reserveOrderNo"); // 주문예약번호
        String sellerOrderReferenceKey = request.getParameter("sellerOrderReferenceKey"); // 가맹점주문연동키
        String paymentCertifyToken = request.getParameter("paymentCertifyToken"); // 결제인증토큰(결제승인시필요)

        Map<String, Object> map = new HashMap<String, Object>() {
        };
        map.put("code", request.getParameter("code"));
        map.put("message", request.getParameter("message"));
        map.put("reserveOrderNo", request.getParameter("reserveOrderNo"));
        map.put("sellerOrderReferenceKey", request.getParameter("sellerOrderReferenceKey"));
        map.put("mainPgCode", request.getParameter("mainPgCode"));
        map.put("totalPaymentAmt", request.getParameter("totalPaymentAmt"));
        map.put("totalRemoteAreaDeliveryFeeAmt", request.getParameter("totalRemoteAreaDeliveryFeeAmt"));
        map.put("discountAmt", request.getParameter("discountAmt"));
        map.put("pointAmt", request.getParameter("pointAmt"));
        map.put("paymentCertifyToken", request.getParameter("paymentCertifyToken"));
        map.put("bid", request.getParameter("bid"));

        int totalPaymentAmt = 0;
        if (request.getParameter("totalPaymentAmt") == null) { // 총 결제금액
            totalPaymentAmt = 0;
        } else {
            totalPaymentAmt = (int) Float.parseFloat(request.getParameter("totalPaymentAmt").toString());
        }

        String code = request.getParameter("code"); // 결과코드(성공 : 0)
        String message = request.getParameter("message"); // 결과 메시지
        String cacelResulCode = "";
        String cacelResultMsg = "";
        String approvalCode = "";

        /* 주문예약시 전달한 returnUrlParam */
        String taxationType = request.getParameter("taxationType");
        int taxfreeAmt = (int) Float.parseFloat(request.getParameter("totalTaxfreeAmt").toString());
        int taxableAmt = (int) Float.parseFloat(request.getParameter("totalTaxableAmt").toString());
        int vatAmt = (int) Float.parseFloat(request.getParameter("totalVatAmt").toString());
        System.out.println("taxationType : " + taxationType);





        /* 결제 인증 성공시 */
        if (code.equals("0")) {
            payService.updateOrderCode(code, userUid);        //productorder에 결제 코드 저장 성공 : 0
            /*
             * 수신된 데이터 중 필요한 정보를 추출하여 총 결제금액과 요청금액이 일치하는지 확인하고, 결제요청 상품의 재고파악을 실행하여 PAYCO 결제
             * 승인 API 호출 여부를 판단한다.
             */
			/*----------------------------------------------------------------
			.. 가맹점 처리 부분
			..
			-----------------------------------------------------------------*/

            /*
             * ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★ ★★★★★★★★★★ ★★★★★★★★★
             * ★★★★★★★★★★ 중요 사항 ★★★★★★★★★ ★★★★★★★★★★ ★★★★★★★★★
             * ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
             *
             * 총 금액 결제된 금액을 주문금액과 비교.(반드시 필요한 검증 부분.) 주문금액을 변조하여 결제를 시도 했는지 확인함.(반드시 DB에서
             * 읽어야 함.) 금액이 변조되었으면 반드시 승인을 취소해야 함.
             *
             * ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
             */
            int myDBtotalValue = payService.getOrderTotalPrice(sellerOrderReferenceKey); // 가맹점 DB에서 읽은 주문요청 금액
            if (myDBtotalValue != totalPaymentAmt) { // 주문 요청금액과 인증정보로 넘어온 결제금액 비교
                doApproval = false;
                message = "주문금액과 결제금액이 틀립니다.";
                approvalCode = "15";
                returnUrl = "/cancel";
            }

            /* 주문금액과 결제금액이 일치한다고 가정(doApproval = true) */
            if (doApproval) {
                Map<String, Object> sendMap = new HashMap<String, Object>();
                sendMap.put("sellerKey", sellerKey);
                sendMap.put("reserveOrderNo", reserveOrderNo);
                sendMap.put("sellerOrderReferenceKey", sellerOrderReferenceKey);
                sendMap.put("paymentCertifyToken", paymentCertifyToken);
                sendMap.put("totalPaymentAmt", totalPaymentAmt);

                /*
                 * sendMap.put("totalTaxfreeAmt", taxfreeAmt); sendMap.put("totalTaxableAmt",
                 * taxableAmt); sendMap.put("totalVatAmt ", vatAmt);
                 * sendMap.put("totalServiceAmt ", 0);
                 */

                System.out.println("승인요청 : " + sendMap.toString());

                /* payco 결제승인 API 호출 */
                String result = util.payco_approval(sendMap, "Y");

                // jackson Tree 이용
                JsonNode node = mapper.readTree(result);
                approvalCode = node.path("code").toString();

                if (node.path("code").toString().equals("0")) {
                    // 예시
                    try {

                        /*
                         * 결제승인 후 리턴된 데이터 중 필요한 정보를 추출하여 가맹점 에서 필요한 작업을 실시합니다.(예 주문서 작성 등..) 결제연동시 리턴되는
                         * PAYCO주문번호(orderNo)와 주문인증키(orderCertifyKey)에 대해 가맹점 DB 저장이 필요합니다.
                         */

                        /*
                         *
                         * node 값 예시
                         * {result={sellerOrderReferenceKey=TEST21083284446,
                         * reserveOrderNo=202010272005371315, orderNo=202010272002576080, memberName=**,
                         * memberEmail=ka****, orderChannel=PC, totalOrderAmt=10, totalDeliveryFeeAmt=0,
                         * totalRemoteAreaDeliveryFeeAmt=0, totalPaymentAmt=10, receiptPaycoPointAmt=0,
                         * receiptPaycoPointTaxfreeAmt=0, receiptPaycoPointTaxableAmt=0,
                         * receiptPaycoPointVatAmt=0, receiptPaycoPointServiceAmt=0,
                         *
                         * orderProducts=[{orderProductNo=202010272002790969,
                         * sellerOrderProductReferenceKey=2960903800, orderProductStatusCode=OPSPAED,
                         * orderProductStatusName=결제완료, cpId=PARTNERTEST, productId=PROD_EASY,
                         * productKindCode=GENERAL_PRODUCT, productPaymentAmt=10,
                         * originalProductPaymentAmt=10}]
                         *
                         * , paymentDetails=[{paymentTradeNo=202010272003839857, paymentMethodCode=98,
                         * paymentMethodName=PAYCO 포인트, paymentAmt=10, taxfreeAmt=0, taxableAmt=9,
                         * vatAmt=1, serviceAmt=0, tradeYmdt=20201027152217,
                         * pgAdmissionNo=2020102723169283, pgAdmissionYmdt=20201027152217,
                         * easyPaymentYn=N}] ,
                         * orderCertifyKey=oFTbXjmiTdspYhxkpMhWoAmJ8unqPm4bcmvI7l3SXN4CC,
                         * paymentCompletionYn=Y, paymentCompleteYmdt=20201027152217}, code=0,
                         * message=success}

                         *
                         */

                        // 주문완료 페이지 전달용 데이터 변수
                        String orderNo, orderCertifyKey, requestMemo, cancelTotalAmt, cancelDetailContent;
                        List<String> sellerOrderProductReferenceKey = new ArrayList<String>();

                        // 결제승인 후 리턴된 데이터 중 필요한 정보를 추출 예시
                        orderNo = node.path("result").get("orderNo").textValue();
                        reserveOrderNo = node.path("result").get("reserveOrderNo").textValue();
                        sellerOrderReferenceKey = node.path("result").get("sellerOrderReferenceKey").textValue();
                        orderCertifyKey = node.path("result").get("orderCertifyKey").textValue();
                        totalPaymentAmt = (int) Float.parseFloat(node.path("result").get("totalPaymentAmt").toString());

                        // orderProducts 추출 예시
                        ArrayNode orderProducts_arr = (ArrayNode) node.path("result").get("orderProducts");
                        for (int i = 0; i < orderProducts_arr.size(); i++) {
                            String orderProductKey = orderProducts_arr.get(i).get("sellerOrderProductReferenceKey").textValue();
                            sellerOrderProductReferenceKey.add(i, orderProductKey);
                        }


                        payService.setOrder(userUid, sellerOrderReferenceKey, returnUrl);        //결제 버튼을 누르자 마자 DB에 승인정보 입력, 결제버튼을 분리할거면 주석처리 해야함
                        payService.updateUserOrder(sellerOrderReferenceKey, orderProducts_arr);
                        payService.setOrderApproval(node, userUid);

                        String cancleTestMemo = "결제취소 테스트 입니다.";
                        model.addAttribute("orderNo", orderNo);
                        model.addAttribute("sellerOrderProductReferenceKey", sellerOrderProductReferenceKey);
                        model.addAttribute("orderCertifyKey", orderCertifyKey);
                        model.addAttribute("totalCancelTaxfreeAmt", taxfreeAmt);
                        model.addAttribute("totalCancelTaxableAmt", taxableAmt);
                        model.addAttribute("totalCancelVatAmt", vatAmt);
                        model.addAttribute("totalCancelPossibleAmt", totalPaymentAmt);
                        model.addAttribute("cancelTotalAmt", totalPaymentAmt);
                        model.addAttribute("cancelDetailContent", cancleTestMemo);
                        model.addAttribute("requestMemo", cancleTestMemo);
                        model.addAttribute("reserveOrderNo", reserveOrderNo);
                        model.addAttribute("sellerOrderReferenceKey", sellerOrderReferenceKey);

                        message = "주문이 정상적으로 완료되었습니다.";
                        returnUrl = "/paycoComplete";
                        logger.debug("return_complete: " + returnUrl);
                        // return returnUrl;

                    } catch (Exception e) {
                        e.printStackTrace();
                        message = "정상 결제승인 완료 되었으나 가맹점 주문서 작성중 데이터처리 오류로 인하여 주문을 취소합니다.";
                        returnUrl = "/cancel";
                        doCancel = true;
                    }

                } else {
                    message = node.path("message").textValue();
                    returnUrl = "/cancel";
                }

                if (doCancel) {
                    /*
                     * ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★ # PAYCO 결제 승인이 완료되고 아래와 같은 상황이
                     * 발생하였을경우 예외 처리가 필요합니다. 1. 가맹점 DB 처리중 오류 발생시 2. 통신 장애로 인하여 결과를 리턴받지 못했을 경우
                     *
                     * 위와 같은 상황이 발생하였을 경우 이미 승인 완료된 주문건에 대하여 주문 취소처리(전체취소)가 필요합니다. - PAYCO에서는
                     * 주문승인(결제완료) 처리 되었으나 가맹점은 해당 주문서가 없는 경우가 발생 - PAYCO에서는 승인 완료된 상태이므로 주문 상세정보
                     * API를 이용해 결제정보를 조회하여 취소요청 파라미터에 셋팅합니다.
                     * ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
                     */

                    // 결제상세 조회 필수값 셋팅
                    Map<String, Object> verifyPaymentMap = new HashMap<String, Object>();
                    verifyPaymentMap.put("sellerKey", sellerKey);
                    verifyPaymentMap.put("reserveOrderNo", reserveOrderNo); // 주문예약번호
                    verifyPaymentMap.put("sellerOrderReferenceKey", sellerOrderReferenceKey); // 가맹점주문연동키

                    // 결제상세 조회 API 호출
                    String verifyPaymentResult = util.payco_verifyPayment(verifyPaymentMap, "Y");

                    // jackson Tree 이용
                    try {
                        JsonNode verifyPayment_node = mapper.readTree(verifyPaymentResult);

                        String cancel_orderNo = verifyPayment_node.path("result").get("orderNo").textValue();
                        String cancel_orderCertifyKey = verifyPayment_node.path("result").get("orderCertifyKey")
                                .textValue();
                        String cancel_cancelTotalAmt = verifyPayment_node.path("result").get("totalPaymentAmt")
                                .toString();

                        /* 설정한 주문취소 정보로 Json String 을 작성합니다. */
                        Map<String, Object> param = new HashMap<String, Object>();
                        param.put("sellerKey", sellerKey); // [필수]가맹점 코드
                        param.put("orderNo", cancel_orderNo); // [필수]주문번호
                        param.put("orderCertifyKey", cancel_orderCertifyKey); // [필수]주문인증 key
                        param.put("cancelTotalAmt", Integer.parseInt(cancel_cancelTotalAmt)); // [필수]취소할 총 금액(전체취소, 부분취소
                        // 전부다)

                        /* 주문 결제 취소 API 호출 */
                        String cancelResult = util.payco_cancel(param, "Y", "Y");

                        JsonNode cancelNode = mapper.readTree(cancelResult);

                        if (!cancelNode.path("code").toString().equals("0")) {
                            cacelResultMsg = "망취소 실패사유 : " + cancelNode.path("message").textValue();
                            returnUrl = "/cancel";
                        } else {
                            cacelResultMsg = "망취소 결과 : " + cancelNode.path("message").textValue();
                            returnUrl = "/cancel";
                        }
                    } catch (Exception e) {
                        // TODO: handle exception
                        e.printStackTrace();
                    }

                }
            }

            // 사용자 취소(결제창 취소버튼 클릭시)
        } else if (code.equals("2222")) {
            returnUrl = "/cancel";
        } else {
            returnUrl = "/cancel";
        }
        logger.debug("return: " + returnUrl);
        logger.debug("message: " + message);
        logger.debug("cacelResultMsg: " + cacelResultMsg);

        payService.updateApprovalCode(approvalCode, sellerOrderReferenceKey);

        model.addAttribute("returnUrl", returnUrl);
        model.addAttribute("message", message);
        model.addAttribute("cacelResultMsg", cacelResultMsg);

        return "logis/complete" + returnUrl + "_test";
//		return domainName + returnUrl;
    }

    @RequestMapping(value = "payco_return")
    public String payco_return(HttpServletRequest request, Model model) throws JsonProcessingException, IOException {
        logger.debug("payco_return");
        ObjectMapper mapper = new ObjectMapper(); // jackson json object

        HttpSession session = request.getSession(false);
        String userUid = (String) session.getAttribute("userUid");

        Boolean doCancel = false; // 승인 후 오류발생시 결제취소 여부
        Boolean doApproval = true; // 요청금액과 결제 금액 일치여부(true : 일치)
        String returnUrl = "";

        /*
         * http://localhost:8080/user/pay/payco_return?code=0&reserveOrderNo=
         * 202010262005369928&sellerOrderReferenceKey=TEST38558103697&mainPgCode=98&
         * totalPaymentAmt=10
         * &totalRemoteAreaDeliveryFeeAmt=0&discountAmt=0&pointAmt=10&
         * paymentCertifyToken=oKZISNRmoLPY2OV8qDj89MtlznqRiVWA9HIETrG-
         * SkEDMfeRUB80UattSHjKU2R_&bid=DMLHCSGKH3TFUAE512MXE2ULA
         */
        /* 인증 데이타 변수선언 */
        String reserveOrderNo = request.getParameter("reserveOrderNo"); // 주문예약번호
        String sellerOrderReferenceKey = request.getParameter("sellerOrderReferenceKey"); // 가맹점주문연동키
        String paymentCertifyToken = request.getParameter("paymentCertifyToken"); // 결제인증토큰(결제승인시필요)

        Map<String, Object> map = new HashMap<String, Object>() {
        };
        map.put("code", request.getParameter("code"));
        map.put("message", request.getParameter("message"));
        map.put("reserveOrderNo", request.getParameter("reserveOrderNo"));
        map.put("sellerOrderReferenceKey", request.getParameter("sellerOrderReferenceKey"));
        map.put("mainPgCode", request.getParameter("mainPgCode"));
        map.put("totalPaymentAmt", request.getParameter("totalPaymentAmt"));
        map.put("totalRemoteAreaDeliveryFeeAmt", request.getParameter("totalRemoteAreaDeliveryFeeAmt"));
        map.put("discountAmt", request.getParameter("discountAmt"));
        map.put("pointAmt", request.getParameter("pointAmt"));
        map.put("paymentCertifyToken", request.getParameter("paymentCertifyToken"));
        map.put("bid", request.getParameter("bid"));

        int totalPaymentAmt = 0;
        if (request.getParameter("totalPaymentAmt") == null) { // 총 결제금액
            totalPaymentAmt = 0;
        } else {
            totalPaymentAmt = (int) Float.parseFloat(request.getParameter("totalPaymentAmt").toString());
        }

        String code = request.getParameter("code"); // 결과코드(성공 : 0)
        String message = request.getParameter("message"); // 결과 메시지
        String cacelResulCode = "";
        String cacelResultMsg = "";
        String approvalCode = "";

        /* 주문예약시 전달한 returnUrlParam */
        String taxationType = request.getParameter("taxationType");
        int taxfreeAmt = (int) Float.parseFloat(request.getParameter("totalTaxfreeAmt").toString());
        int taxableAmt = (int) Float.parseFloat(request.getParameter("totalTaxableAmt").toString());
        int vatAmt = (int) Float.parseFloat(request.getParameter("totalVatAmt").toString());
        System.out.println("taxationType : " + taxationType);





        /* 결제 인증 성공시 */
        if (code.equals("0")) {
            payService.updateOrderCode(code, userUid);        //productorder에 결제 코드 저장 성공 : 0
            /*
             * 수신된 데이터 중 필요한 정보를 추출하여 총 결제금액과 요청금액이 일치하는지 확인하고, 결제요청 상품의 재고파악을 실행하여 PAYCO 결제
             * 승인 API 호출 여부를 판단한다.
             */
			/*----------------------------------------------------------------
			.. 가맹점 처리 부분
			..
			-----------------------------------------------------------------*/

            /*
             * ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★ ★★★★★★★★★★ ★★★★★★★★★
             * ★★★★★★★★★★ 중요 사항 ★★★★★★★★★ ★★★★★★★★★★ ★★★★★★★★★
             * ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
             *
             * 총 금액 결제된 금액을 주문금액과 비교.(반드시 필요한 검증 부분.) 주문금액을 변조하여 결제를 시도 했는지 확인함.(반드시 DB에서
             * 읽어야 함.) 금액이 변조되었으면 반드시 승인을 취소해야 함.
             *
             * ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
             */
            int myDBtotalValue = payService.getOrderTotalPrice(sellerOrderReferenceKey); // 가맹점 DB에서 읽은 주문요청 금액
            if (myDBtotalValue != totalPaymentAmt) { // 주문 요청금액과 인증정보로 넘어온 결제금액 비교
                doApproval = false;
                message = "주문금액과 결제금액이 틀립니다.";
                approvalCode = "15";
                returnUrl = "/cancel";
            }

            /* 주문금액과 결제금액이 일치한다고 가정(doApproval = true) */
            if (doApproval) {
                Map<String, Object> sendMap = new HashMap<String, Object>();
                sendMap.put("sellerKey", sellerKey);
                sendMap.put("reserveOrderNo", reserveOrderNo);
                sendMap.put("sellerOrderReferenceKey", sellerOrderReferenceKey);
                sendMap.put("paymentCertifyToken", paymentCertifyToken);
                sendMap.put("totalPaymentAmt", totalPaymentAmt);

                /*
                 * sendMap.put("totalTaxfreeAmt", taxfreeAmt); sendMap.put("totalTaxableAmt",
                 * taxableAmt); sendMap.put("totalVatAmt ", vatAmt);
                 * sendMap.put("totalServiceAmt ", 0);
                 */

                System.out.println("승인요청 : " + sendMap.toString());

                /* payco 결제승인 API 호출 */
                String result = util.payco_approval(sendMap, "Y");

                // jackson Tree 이용
                JsonNode node = mapper.readTree(result);
                approvalCode = node.path("code").toString();

                if (node.path("code").toString().equals("0")) {
                    // 예시
                    try {

                        /*
                         * 결제승인 후 리턴된 데이터 중 필요한 정보를 추출하여 가맹점 에서 필요한 작업을 실시합니다.(예 주문서 작성 등..) 결제연동시 리턴되는
                         * PAYCO주문번호(orderNo)와 주문인증키(orderCertifyKey)에 대해 가맹점 DB 저장이 필요합니다.
                         */

                        /*
                         *
                         * node 값 예시
                         * {result={sellerOrderReferenceKey=TEST21083284446,
                         * reserveOrderNo=202010272005371315, orderNo=202010272002576080, memberName=**,
                         * memberEmail=ka****, orderChannel=PC, totalOrderAmt=10, totalDeliveryFeeAmt=0,
                         * totalRemoteAreaDeliveryFeeAmt=0, totalPaymentAmt=10, receiptPaycoPointAmt=0,
                         * receiptPaycoPointTaxfreeAmt=0, receiptPaycoPointTaxableAmt=0,
                         * receiptPaycoPointVatAmt=0, receiptPaycoPointServiceAmt=0,
                         *
                         * orderProducts=[{orderProductNo=202010272002790969,
                         * sellerOrderProductReferenceKey=2960903800, orderProductStatusCode=OPSPAED,
                         * orderProductStatusName=결제완료, cpId=PARTNERTEST, productId=PROD_EASY,
                         * productKindCode=GENERAL_PRODUCT, productPaymentAmt=10,
                         * originalProductPaymentAmt=10}]
                         *
                         * , paymentDetails=[{paymentTradeNo=202010272003839857, paymentMethodCode=98,
                         * paymentMethodName=PAYCO 포인트, paymentAmt=10, taxfreeAmt=0, taxableAmt=9,
                         * vatAmt=1, serviceAmt=0, tradeYmdt=20201027152217,
                         * pgAdmissionNo=2020102723169283, pgAdmissionYmdt=20201027152217,
                         * easyPaymentYn=N}] ,
                         * orderCertifyKey=oFTbXjmiTdspYhxkpMhWoAmJ8unqPm4bcmvI7l3SXN4CC,
                         * paymentCompletionYn=Y, paymentCompleteYmdt=20201027152217}, code=0,
                         * message=success}

                         *
                         */

                        // 주문완료 페이지 전달용 데이터 변수
                        String orderNo, orderCertifyKey, requestMemo, cancelTotalAmt, cancelDetailContent;
                        List<String> sellerOrderProductReferenceKey = new ArrayList<String>();

                        // 결제승인 후 리턴된 데이터 중 필요한 정보를 추출 예시
                        orderNo = node.path("result").get("orderNo").textValue();
                        reserveOrderNo = node.path("result").get("reserveOrderNo").textValue();
                        sellerOrderReferenceKey = node.path("result").get("sellerOrderReferenceKey").textValue();
                        orderCertifyKey = node.path("result").get("orderCertifyKey").textValue();
                        totalPaymentAmt = (int) Float.parseFloat(node.path("result").get("totalPaymentAmt").toString());

                        // orderProducts 추출 예시
                        ArrayNode orderProducts_arr = (ArrayNode) node.path("result").get("orderProducts");
                        for (int i = 0; i < orderProducts_arr.size(); i++) {
                            String orderProductKey = orderProducts_arr.get(i).get("sellerOrderProductReferenceKey").textValue();
                            sellerOrderProductReferenceKey.add(i, orderProductKey);

                        }


                        payService.setOrder(userUid, sellerOrderReferenceKey, returnUrl);        //결제 버튼을 누르자 마자 DB에 승인정보 입력, 결제버튼을 분리할거면 주석처리 해야함
                        payService.updateUserOrder(sellerOrderReferenceKey, orderProducts_arr);
                        payService.setOrderApproval(node, userUid);

                        String cancleTestMemo = "결제취소 테스트 입니다.";
                        model.addAttribute("orderNo", orderNo);
                        model.addAttribute("sellerOrderProductReferenceKey", sellerOrderProductReferenceKey);
                        model.addAttribute("orderCertifyKey", orderCertifyKey);
                        model.addAttribute("totalCancelTaxfreeAmt", taxfreeAmt);
                        model.addAttribute("totalCancelTaxableAmt", taxableAmt);
                        model.addAttribute("totalCancelVatAmt", vatAmt);
                        model.addAttribute("totalCancelPossibleAmt", totalPaymentAmt);
                        model.addAttribute("cancelTotalAmt", totalPaymentAmt);
                        model.addAttribute("cancelDetailContent", cancleTestMemo);
                        model.addAttribute("requestMemo", cancleTestMemo);
                        model.addAttribute("reserveOrderNo", reserveOrderNo);
                        model.addAttribute("sellerOrderReferenceKey", sellerOrderReferenceKey);

                        message = "주문이 정상적으로 완료되었습니다.";
                        returnUrl = "/paycoComplete";
                        logger.debug("return_complete: " + returnUrl);
                        // return returnUrl;

                    } catch (Exception e) {
                        e.printStackTrace();
                        message = "정상 결제승인 완료 되었으나 가맹점 주문서 작성중 데이터처리 오류로 인하여 주문을 취소합니다.";
                        returnUrl = "/cancel";
                        doCancel = true;
                    }

                } else {
                    message = node.path("message").textValue();
                    returnUrl = "/cancel";
                }

                if (doCancel) {
                    /*
                     * ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★ # PAYCO 결제 승인이 완료되고 아래와 같은 상황이
                     * 발생하였을경우 예외 처리가 필요합니다. 1. 가맹점 DB 처리중 오류 발생시 2. 통신 장애로 인하여 결과를 리턴받지 못했을 경우
                     *
                     * 위와 같은 상황이 발생하였을 경우 이미 승인 완료된 주문건에 대하여 주문 취소처리(전체취소)가 필요합니다. - PAYCO에서는
                     * 주문승인(결제완료) 처리 되었으나 가맹점은 해당 주문서가 없는 경우가 발생 - PAYCO에서는 승인 완료된 상태이므로 주문 상세정보
                     * API를 이용해 결제정보를 조회하여 취소요청 파라미터에 셋팅합니다.
                     * ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
                     */

                    // 결제상세 조회 필수값 셋팅
                    Map<String, Object> verifyPaymentMap = new HashMap<String, Object>();
                    verifyPaymentMap.put("sellerKey", sellerKey);
                    verifyPaymentMap.put("reserveOrderNo", reserveOrderNo); // 주문예약번호
                    verifyPaymentMap.put("sellerOrderReferenceKey", sellerOrderReferenceKey); // 가맹점주문연동키

                    // 결제상세 조회 API 호출
                    String verifyPaymentResult = util.payco_verifyPayment(verifyPaymentMap, "Y");

                    // jackson Tree 이용
                    try {
                        JsonNode verifyPayment_node = mapper.readTree(verifyPaymentResult);

                        String cancel_orderNo = verifyPayment_node.path("result").get("orderNo").textValue();
                        String cancel_orderCertifyKey = verifyPayment_node.path("result").get("orderCertifyKey")
                                .textValue();
                        String cancel_cancelTotalAmt = verifyPayment_node.path("result").get("totalPaymentAmt")
                                .toString();

                        /* 설정한 주문취소 정보로 Json String 을 작성합니다. */
                        Map<String, Object> param = new HashMap<String, Object>();
                        param.put("sellerKey", sellerKey); // [필수]가맹점 코드
                        param.put("orderNo", cancel_orderNo); // [필수]주문번호
                        param.put("orderCertifyKey", cancel_orderCertifyKey); // [필수]주문인증 key
                        param.put("cancelTotalAmt", Integer.parseInt(cancel_cancelTotalAmt)); // [필수]취소할 총 금액(전체취소, 부분취소
                        // 전부다)

                        /* 주문 결제 취소 API 호출 */
                        String cancelResult = util.payco_cancel(param, "Y", "Y");

                        JsonNode cancelNode = mapper.readTree(cancelResult);

                        if (!cancelNode.path("code").toString().equals("0")) {
                            cacelResultMsg = "망취소 실패사유 : " + cancelNode.path("message").textValue();
                            returnUrl = "/cancel";
                        } else {
                            cacelResultMsg = "망취소 결과 : " + cancelNode.path("message").textValue();
                            returnUrl = "/cancel";
                        }
                    } catch (Exception e) {
                        // TODO: handle exception
                        e.printStackTrace();
                    }

                }
            }

            // 사용자 취소(결제창 취소버튼 클릭시)
        } else if (code.equals("2222")) {
            returnUrl = "/cancel";
        } else {
            returnUrl = "/cancel";
        }
        logger.debug("return: " + returnUrl);
        logger.debug("message: " + message);
        logger.debug("cacelResultMsg: " + cacelResultMsg);

        payService.updateApprovalCode(approvalCode, sellerOrderReferenceKey);

        model.addAttribute("returnUrl", returnUrl);
        model.addAttribute("message", message);
        model.addAttribute("cacelResultMsg", cacelResultMsg);

        return "logis/complete" + returnUrl;
//		return domainName + returnUrl;
    }

    @RequestMapping(value = "payco_complete")
    public String payco_complete(HttpServletRequest request) {
        logger.debug("payco_complete");

        return domainName + "/payco_complete";
    }

    @RequestMapping(value = "payco_upstatus")
    public void payco_upstatus(HttpServletRequest request, Model model) {
        logger.debug("payco_upstatus");

        ObjectMapper mapper = new ObjectMapper(); // jackson json object

        String orderNo = (String) request.getParameter("orderNo"); // payco에서 발급받은 주문번호
        String sellerOrderProductReferenceKey = (String) request.getParameter("sellerOrderProductReferenceKey"); // 외부가맹점에서
        // 관리하는
        // 주문상품키
        String orderProductStatus = (String) request.getParameter("orderProductStatus"); // 변경할 주문상태
        String returnStr = "";

        try {
            // json object 생성
            Map<String, Object> jsonMap = new HashMap<String, Object>();
            jsonMap.put("sellerKey", sellerKey); // [필수]가맹점코드
            jsonMap.put("orderNo", orderNo); // [필수]payco에서 발급받은 주문번호
            jsonMap.put("sellerOrderProductReferenceKey", sellerOrderProductReferenceKey); // [필수]외부가맹점에서 관리하는 주문상품연동 키
            jsonMap.put("orderProductStatus", orderProductStatus); // [필수]변경할 주문상품 상태

            // 주문 상품 상태 변경 API 호출
            returnStr = util.payco_upstatus(jsonMap, "Y");

        } catch (Exception e) {
            e.printStackTrace();
            returnStr = "{\"code\":\"9999\", \"message\":\"상품상태변경중 알수없는 오류가 발생했습니다.\"}";
        }
        Map<String, Object> map = new HashMap<String, Object>();
        map = stringToJSON(returnStr);
        logger.debug("complete:  " + returnStr);
        model.addAttribute(map);
    }

    // 결제대기 화면으로 이동
    @RequestMapping(value = "return_ok")
    public String payco_return_ok(@RequestHeader(required = false) HttpHeaders headers, HttpServletRequest request) {

        String userAgent = headers.get("user-agent").toString();
        logger.debug(userAgent);
        logger.debug("return_ok");

        return domainName + "/payco_return";
    }

    @RequestMapping(value = "payco_update_returnUrl")
    public void payco_update_returnUrl(@RequestParam(required = false) String returnUrl, HttpServletRequest request) {
        logger.debug("payco_update_returnUrl");

        HttpSession session = request.getSession(false);
        String userUid = (String) session.getAttribute("userUid");

        //returnUrl을 받아서 주문번호 추출 후 주문번호로 디비 생성 뒤 주문 완료 처리
        String target = "sellerOrderReferenceKey="; // 24글자
        int target_num = returnUrl.lastIndexOf(target) + 24;
        String orderKey = returnUrl.substring(target_num, (returnUrl.substring(target_num).indexOf("&") + target_num));


        payService.setOrder(userUid, orderKey, returnUrl);

        logger.debug(orderKey);
        logger.debug(returnUrl);

    }

    @RequestMapping(value = "payco_cancel")
    public void payco_cancel(HttpServletRequest request, HttpServletResponse response, Model model) {

        logger.debug("payco_cancel");
        ObjectMapper mapper = new ObjectMapper(); // jackson json object
        String strResult = ""; // 반환값

        String cancelType = (String) request.getParameter("cancelType"); // 취소 Type 받기 - ALL 또는 PART
        String orderNo = (String) request.getParameter("orderNo"); // PAYCO에서 발급받은 주문번호
        String orderCertifyKey = (String) request.getParameter("orderCertifyKey"); // PAYCO에서 발급받은 주문인증 key
        String cancelTotalAmt = (String) request.getParameter("cancelTotalAmt"); // 총 취소 금액
        String totalCancelTaxfreeAmt = (String) request.getParameter("totalCancelTaxfreeAmt"); // 주문 총 면세금액
        String totalCancelTaxableAmt = (String) request.getParameter("totalCancelTaxableAmt"); // 주문 총 과세 공급가액
        String totalCancelVatAmt = (String) request.getParameter("totalCancelVatAmt"); // 주문 총 과세 부가세액
        String totalCancelPossibleAmt = (String) request.getParameter("totalCancelPossibleAmt"); // 총 취소가능금액
        String sellerOrderProductReferenceKey = (String) request.getParameter("sellerOrderProductReferenceKey"); // 가맹점 주문 상품 연동 키(PART 취소시)

        String cancelDetailContent = (String) request.getParameter("cancelDetailContent"); // 취소 상세 사유
        String cancelAmt = (String) request.getParameter("cancelAmt"); // 취소 상품 금액(PART 취소 시)
        String requestMemo = (String) request.getParameter("requestMemo"); // 취소처리 요청메모
        String sellerOrderReferenceKey = (String) request.getParameter("sellerOrderReferenceKey"); // 가맹점키

        /* orderNo 값이 없으면 로그를 기록한 뒤 JSON 형태로 오류를 돌려주고 API를 종료합니다. */
        if (orderNo == null || orderNo.equals("")) {

            Map<String, Object> noKeyMap = new HashMap<String, Object>();
            noKeyMap.put("result", "주문번호 값이 전달되지 않았습니다.");
            noKeyMap.put("message", "orderNo is Nothing.");
            noKeyMap.put("code", 9999);

            PrintWriter pw;
            try {
                pw = response.getWriter();
                response.setContentType("application/json; charset=utf-8");
                pw.print(mapper.writeValueAsString(noKeyMap));
                pw.flush();
                pw.close();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

            /* cancelTotalAmt 값이 없으면 로그를 기록한 뒤 JSON 형태로 오류를 돌려주고 API를 종료합니다. */
        } else if (cancelTotalAmt == null || cancelTotalAmt.equals("")) {

            Map<String, Object> noAmtMap = new HashMap<String, Object>();
            noAmtMap.put("result", "총 취소 금액이 전달되지 않았습니다.");
            noAmtMap.put("message", "cancelTotalAmt is Nothing.");
            noAmtMap.put("code", 9999);

            try {
                PrintWriter pw;
                pw = response.getWriter();
                response.setContentType("application/json; charset=utf-8");
                pw.print(mapper.writeValueAsString(noAmtMap));
                pw.flush();
                pw.close();
            } catch (Exception e) {
                // TODO: handle exception
                e.printStackTrace();
            }

        } else if (orderCertifyKey == null || orderCertifyKey.equals("")) {

            Map<String, Object> noCertifyKeyMap = new HashMap<String, Object>();
            noCertifyKeyMap.put("result", "주문인증 key가 전달되지 않았습니다.");
            noCertifyKeyMap.put("message", "CertifyKey is Nothing.");
            noCertifyKeyMap.put("code", 9999);

            try {
                PrintWriter pw;
                pw = response.getWriter();
                response.setContentType("application/json; charset=utf-8");
                pw.print(mapper.writeValueAsString(noCertifyKeyMap));
                pw.flush();
                pw.close();
            } catch (Exception e) {
                // TODO: handle exception
                e.printStackTrace();
            }

        }

        List<Map<String, Object>> orderProducts = new ArrayList<Map<String, Object>>();

        /* 전체 취소 = "ALL", 부분취소 = "PART" */
        if (cancelType.equals("ALL")) {
            /*
             * 주문상품 데이터 불러오기 파라메터로 값을 받을 경우 받은 값으로만 작업을 하면 됩니다. 주문 키값으로만 DB에서 취소 상품 데이터를
             * 불러와야 한다면 이 부분에서 작업하세요.
             */

        } else if (cancelType.equals("PART")) {
            /*
             * 주문상품 데이터 불러오기 파라메터로 값을 받을 경우 받은 값으로만 작업을 하면 됩니다. 주문 키값으로만 DB에서 취소 상품 데이터를
             * 불러와야 한다면 이 부분에서 작업하세요.
             */

            if (sellerOrderProductReferenceKey == null || sellerOrderProductReferenceKey.equals("")) {
                Map<String, Object> noProductReferenceKey = new HashMap<String, Object>();
                noProductReferenceKey.put("result", "주문상품 연동키가 전달되지 않았습니다.");
                noProductReferenceKey.put("message", "sellerOrderProductReferenceKey is Nothing.");
                noProductReferenceKey.put("code", 9999);

                try {
                    PrintWriter pw;
                    pw = response.getWriter();
                    response.setContentType("application/json; charset=utf-8");
                    pw.print(mapper.writeValueAsString(noProductReferenceKey));
                    pw.flush();
                    pw.close();
                } catch (Exception e) {
                    // TODO: handle exception
                    e.printStackTrace();
                }

            } else if (cancelAmt == null || cancelAmt.equals("")) {
                Map<String, Object> noCancelAmt = new HashMap<String, Object>();
                noCancelAmt.put("result", "취소상품 금액이 전달되지 않았습니다.");
                noCancelAmt.put("message", "cancelAmt is Nothing.");
                noCancelAmt.put("code", 9999);

                try {
                    PrintWriter pw;
                    pw = response.getWriter();
                    response.setContentType("application/json; charset=utf-8");
                    pw.print(mapper.writeValueAsString(noCancelAmt));
                    pw.flush();
                    pw.close();
                } catch (Exception e) {
                    // TODO: handle exception
                    e.printStackTrace();
                }

            }

            /* 부분 취소 할 상품정보 */
            Map<String, Object> orderProductsInfo = new HashMap<String, Object>();
            orderProductsInfo = payService.getOrderProductPrice(orderNo, sellerOrderProductReferenceKey);

            orderProductsInfo.put("sellerOrderProductReferenceKey", sellerOrderProductReferenceKey); // [필수]취소상품 연동키(파라메터로 넘겨 받은값 - 필요시 DB에서 불러와 대입)

            int dBProductAmt = (int) orderProductsInfo.get("productAmt");

            if (dBProductAmt < Integer.parseInt(cancelAmt)) {
                Map<String, Object> noCancelTypeMap = new HashMap<String, Object>();
                noCancelTypeMap.put("result", "CANCEL_TYPE_ERROR");
                noCancelTypeMap.put("message", "취소 요청 금액이 구매금액보다 큽니다.");
                noCancelTypeMap.put("code", 9999);

                try {
                    PrintWriter pw;
                    pw = response.getWriter();
                    response.setContentType("application/json; charset=utf-8");
                    pw.print(mapper.writeValueAsString(noCancelTypeMap));
                    pw.flush();
                    pw.close();
                } catch (Exception e) {
                    // TODO: handle exception
                    e.printStackTrace();
                }
            } else {
                orderProductsInfo.put("productAmt", cancelAmt); // [필수]취소상품 금액( 파라메터로 넘겨 받은 금액 - 필요시 DB에서 불러와 대입)
            }
            orderProductsInfo.put("cancelDetailContent", cancelDetailContent); // [선택]취소 상세 사유
            orderProducts.add(orderProductsInfo);

            /* 취소타입이 잘못되었음. ( ALL과 PART 가 아닐경우 ) */
        } else {
            Map<String, Object> noCancelTypeMap = new HashMap<String, Object>();
            noCancelTypeMap.put("result", "CANCEL_TYPE_ERROR");
            noCancelTypeMap.put("message", "취소 요청 타입이 잘못되었습니다.");
            noCancelTypeMap.put("code", 9999);

            try {
                PrintWriter pw;
                pw = response.getWriter();
                response.setContentType("application/json; charset=utf-8");
                pw.print(mapper.writeValueAsString(noCancelTypeMap));
                pw.flush();
                pw.close();
            } catch (Exception e) {
                // TODO: handle exception
                e.printStackTrace();
            }

        }

        /* 설정한 주문취소 정보로 Json String 을 작성합니다. */
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("sellerKey", sellerKey); // [필수]가맹점 코드
        param.put("sellerOrderReferenceKey", sellerOrderReferenceKey); // [선택]가맹점 코드
        param.put("orderNo", orderNo); // [필수]주문번호
        param.put("orderCertifyKey", orderCertifyKey); // [필수]주문인증 key
        param.put("cancelTotalAmt", Integer.parseInt(cancelTotalAmt)); // [필수]취소할 총 금액(전체취소, 부분취소 전부다)

        if (orderProducts.size() != 0) {
            param.put("orderProducts", orderProducts); // [선택]취소할 상품 List(부분취소인 경우 사용, 입력하지 않는 경우 전체 취소)
        }

        param.put("totalCancelTaxfreeAmt", totalCancelTaxfreeAmt); // [선택]총 취소할 면세금액
        param.put("totalCancelTaxableAmt", totalCancelTaxableAmt); // [선택]총 취소할 과세금액
        param.put("totalCancelVatAmt", totalCancelVatAmt); // [선택]총 취소할 부가세
        param.put("requestMemo", requestMemo); // [선택]취소처리 요청메모

        /*
         * 부분취소 중복을 막기위해 totalCancelPossibleAmt 컬럼을 사용하는 예 예를들어 고객이 10만원 주문을 하고 2만원을
         * 부분취소 하고 싶은데 두번눌러서 4만원이 취소 되는 케이스 또는 어떠한 이유로 PAYCO 에서는 2만원 부분취소가 되었지만 가맹점 에서는
         * 취소가 발생하지 않았을때 등의 예외상황이 발생했을때를 대비하여 totalCancelPossibleAmt 컬럼의 값을 설정하여 보내주시면
         * 중복취소를 막을 수 있습니다. 고객이 10만원 결제금액 중 2만원 부분취소시도 -> PAYCO에는 2만원 취소성공, 그러나 어떠한 이유로
         * 고객 화면에는 취소가 안되었음 -> 고객이 다시 2만원 취소 -> 이때 가맹점 에서는 취소된상품이 하나도 없으므로
         * totalCancelPossibleAmt 값을 10만원으로 보냄 -> 가맹점은 totalCancelPossibleAmt 값이 10만원이고
         * PAYCO 는 2만원을 제외한 8만원이 취소가능금액 이므로 취소가능금액이 일치하지않아 부분취소 불가.
         */
        param.put("totalCancelPossibleAmt", totalCancelPossibleAmt); // [선택]총 취소가능금액(현재기준) : 취소가능금액 검증

        /* 주문 결제 취소 API 호출 */
        strResult = util.payco_cancel(param, "Y", "N");
        Map<String, Object> map = new HashMap<String, Object>();
        map = stringToJSON(strResult);


        int cancelOk = (int) map.get("code");
        logger.debug("cancelOk:   " + cancelOk);

        if (cancelOk == 0) {
            logger.debug("cancelOk:   " + cancelOk);
            payService.updateCancel(orderNo, totalCancelPossibleAmt, cancelTotalAmt, requestMemo);
        }

        model.addAttribute(map);


        try {

            PrintWriter pw;
            pw = response.getWriter();
            response.setContentType("application/json; charset=utf-8");
            pw.print(strResult);
            pw.flush();
            pw.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @RequestMapping(value = "payco_verifyPayment")
    public void payco_verifyPayment(HttpServletRequest request, HttpServletResponse response) {
        logger.debug("payco_verifyPayment");

        String reserveOrderNo = request.getParameter("reserveOrderNo"); // PAYCO 주문예약번호
        String sellerOrderReferenceKey = request.getParameter("sellerOrderReferenceKey"); // 외부가맹점에서 발급하는 주문연동키

        ObjectMapper mapper = new ObjectMapper(); // jackson json object

        // 결제상세 조회 필수값 셋팅
        Map<String, Object> sendMap = new HashMap<String, Object>();
        sendMap.put("sellerKey", sellerKey);
        sendMap.put("reserveOrderNo", reserveOrderNo);
        sendMap.put("sellerOrderReferenceKey", sellerOrderReferenceKey);

        // 결제상세 조회 API 호출
        String result = util.payco_verifyPayment(sendMap, "Y");

        Object obj;

        try {
            obj = mapper.readValue(result, new TypeReference<HashMap<String, Object>>() {
            });
            String resultValue = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(obj);

            PrintWriter pw;
            pw = response.getWriter();
            response.setContentType("application/json; charset=utf-8");
            pw.print(resultValue);
            pw.flush();
            pw.close();

        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    @RequestMapping(value = "payco_mileage_cancel")
    public void payco_mileage_cancel(HttpServletRequest request, HttpServletResponse response, Model model) {
        logger.debug("payco_mileage_cancel");

        /* 마일리지 취소를 위한 값을 설정합니다 */
        String orderNo = request.getParameter("orderNo"); // 주문번호
        String cancelPaymentAmount = request.getParameter("cancelPaymentAmount"); // 마일리지 취소할 주문서의 원 금액
        String outStr = "";

        ObjectMapper mapper = new ObjectMapper(); // jackson json object

        try {
            /* 설정한 주문정보 변수들로 Json String 을 작성합니다. */
            Map<String, Object> jsonObject = new HashMap<String, Object>();
            jsonObject.put("sellerKey", sellerKey); // [필수]가맹점 코드
            jsonObject.put("orderNo", orderNo); // [필수]주문번호
            jsonObject.put("cancelPaymentAmount", cancelPaymentAmount); // [필수]마일리지 취소할 주문서의 원 금액

            /* 주문 상품 상태 변경 API 호출 */
            outStr = util.payco_cancelmileage(jsonObject, "Y");

        } catch (Exception e) {
            outStr = "{ \"message\" : \"마일리지 취소중 에러가 발생했습니다.\", \"code\" : 9999 }";
        }

        try {
            /* 결과반환 */
            PrintWriter pw;
            pw = response.getWriter();
            response.setContentType("application/json; charset=utf-8");
            pw.print(outStr);
            pw.flush();
            pw.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        Map<String, Object> map = new HashMap<String, Object>();
        map = stringToJSON(outStr);

        model.addAttribute(map);
    }

    @RequestMapping(value = "payco_popup")
    public String payco_popup(@RequestParam(required = false) String customerOrderNumber, HttpServletRequest request) {
        logger.debug("payco_popup");

        return domainName + "/payco_popup";
    }

    @RequestMapping(value = "payco_without_bankbook")
    public String payco_without_bankbook(HttpServletRequest request) {
        logger.debug("payco payco_without_bankbook");

        return domainName + "/payco_without_bankbook";
    }


    // 상품 목록이 나오는 페이지로 이동시 DB에서 상품목록을 가져옴
    @RequestMapping(value = "index")
    public String openPayco(HttpServletRequest request, Model model) {
        logger.debug("payco index");


        SellerInfoVO seller = payService.getSellerInfo(sellerUid);
        // 가맹점 ID 가져오기
        String cpId = seller.getCpId();

        // 가맹점 물건 목록 가져오기
        ArrayList<SellerProductInfoVO> productInfo = payService.getProductInfo(cpId);
        model.addAttribute("productInfo", productInfo);

        return domainName + "/index";
    }

    @RequestMapping(value = "payco_reserve_test")
    // public void opnePaycoReserve(@RequestParam Map<String, Object> param, HttpServletRequest request, Model model) {
    public void payco_reserve_test(@RequestParam String[] productKey,
                                   @RequestParam String[] orderQuantity,
                                   @RequestParam String customerOrderNumber, HttpServletRequest request, Model model) {
        // logger.debug("Payco Reseve KeySet = " + param.keySet());

        SellerInfoVO seller = payService.getSellerInfo(sellerUid); // 가맹점 정보 가져오기

        ObjectMapper mapper = new ObjectMapper(); // jackson json object

        String userUid = "1";
        logger.debug("userUid : " + userUid);

        /*
         * //totalTaxfreeAmt(면세상품 총액) / totalTaxableAmt(과세상품 총액) / totalVatAmt(부가세 총액)
         * => 일부 필요한 가맹점을위한 예제입니다. //과세상품일 경우 if(taxationType.equals("TAXATION")){
         * unitTaxfreeAmt = 0; unitTaxableAmt = Math.round((float)(productPaymentAmt /
         * 1.1)); unitVatAmt = Math.round((float)((productPaymentAmt / 1.1) * 0.1));
         *
         * if(unitTaxableAmt + unitVatAmt != productPaymentAmt){ unitTaxableAmt =
         * productPaymentAmt - unitVatAmt; }
         *
         * //면세상품일 경우 }else if(taxationType.equals("DUTYFREE")){ unitTaxfreeAmt =
         * productPaymentAmt; unitTaxableAmt = 0; unitVatAmt = 0;
         *
         * //복합상품일 경우 }else if(taxationType.equals("COMBINE")){ unitTaxfreeAmt = 1000;
         * unitTaxableAmt = Math.round((float)((productPaymentAmt - unitTaxfreeAmt) /
         * 1.1)); unitVatAmt = Math.round((float)(((productPaymentAmt - unitTaxfreeAmt)
         * / 1.1) * 0.1));
         *
         * if(unitTaxableAmt + unitVatAmt != productPaymentAmt - unitTaxfreeAmt){
         * unitTaxableAmt = (productPaymentAmt - unitTaxfreeAmt) - unitVatAmt; }
         *
         * }
         *
         * totalTaxfreeAmt = totalTaxfreeAmt + unitTaxfreeAmt; totalTaxableAmt =
         * totalTaxableAmt + unitTaxableAmt; totalVatAmt = totalVatAmt + unitVatAmt;
         *
         */

        // 상품값으로 읽은 변수들로 Json String 을 작성합니다.
        int totalPaymentAmt = 0;

//         String customerOrderNumber = (String) param.get("customerOrderNumber");
//         String[] productKey = (String[]) param.get("productKey");
//         String[] orderQuantity = (String[]) param.get("orderQuantity");

        // 상품정보 불러오는 map List
        List<Map<String, Object>> orderProducts = new ArrayList<Map<String, Object>>();
        // 상품정보 불러오는 map
        Map<String, Object> productInfo = new HashMap<String, Object>();
        // 주문정보 저장
        SellerProductOrderVO userOrderInfo = new SellerProductOrderVO();

//        List<String> productKey = info.getProductKey();
//        List<String> orderQuantity = info.getOrderQuantity();
//        String customerOrderNumber = info.getCustomerOrderNumber();

        // productKey = new String[1];
        // productKey[0] = "2960903800";

        for (int i = 0; i < productKey.length; i++) {
            productInfo = payService.getProductInfo_Selected(productKey[i], orderQuantity[i]);

            totalPaymentAmt += (int) productInfo.get("productPaymentAmt");
            orderProducts.add(productInfo);

            // DB에 주문정보 입력 INSERT
            payService.setUserOrder(productInfo, userUid, customerOrderNumber, orderQuantity[i]);
        }

        // 설정한 주문정보로 Json String 을 작성합니다.
        // 가맹점 코드를 받아와 바뀌지 않는 정보들을 DB에서 가져오고 바뀌는 정보는 map에 추가로 입력
        Map<String, Object> orderInfo = new HashMap<String, Object>();
        orderInfo = payService.getOrderInfo(sellerKey);
        String returnUrl = request.getParameter("pathUrl");
        returnUrl += "/user/pay/payco_return_test";
        logger.debug("returnUrlreturnUrl : " + returnUrl);
        orderInfo.put("returnUrl", returnUrl);
        orderInfo.put("sellerOrderReferenceKey", customerOrderNumber); // [필수]외부가맹점 주문번호
        orderInfo.put("totalPaymentAmt", totalPaymentAmt); // [필수]총 결제금액(면세금액,과세금액,부가세의 합) totalTaxfreeAmt +
        // totalTaxableAmt + totalVatAmt
        orderInfo.put("orderProducts", orderProducts); // [필수]주문상품 리스트

        /* 부가정보(extraData) - Json 형태의 String */
        Map<String, Object> extraData = new HashMap<String, Object>();
        // 해당주문예약건 만료처리일자(해당일 이후에는 결제불가)
        Date time = new Date();
        // 현재시간
        Calendar cal = Calendar.getInstance();
        cal.setTime(time);
        cal.add(Calendar.HOUR, 2);
        String currentTime = dateformat.format(time);
        String terminateTime = dateformat.format(cal.getTime());

        extraData.put("payExpiryYmdt", terminateTime); // [선택]해당주문예약건 만료처리일자(14자리로 맞춰주세요)
        // 가맹점 상황에따라 필요한경우가 아니라면 해당 파라미터는 삭제하여 주세요.
        // 가상계좌만료일시(YYYYMMDD or YYYYMMDDHHmmss형태로 넣는다)
        // extraData.put("virtualAccountExpiryYmd", "20191231180000");
        // //[선택]가상계좌만료일시(Default 3일, YYYYMMDD일경우 그날 24시까지)
        // 가맹점 에서 무통장입금을 사용하지 않으시면 해당 파라미터는 삭제하여 주세요.
        // appUrl
        //extraData.put("appUrl", "testapp://open"); // [IOS필수]IOS 인앱 결제시 ISP 모바일 등의 앱에서 결제를 처리한 뒤 복귀할 앱 URL
        // AOS(안드로이드) 에서는 필수사항이 아니므로 삭제하여 주세요.

        // 모바일 결제페이지에서 취소 버튼 클릭시 이동할 URL (결제창 이전 URL 등)
        // 1순위 : 주문예약 > extraData > cancelMobileUrl 값이 있을시 => cancelMobileUrl 이동
        // 2순위 : 주문예약시 전달받은 returnUrl 이동 + 실패코드(오류코드:2222)
        // 3순위 : 가맹점 URL로 이동(가맹점등록시 받은 사이트URL)
        // 4순위 : 이전 페이지로 이동 => history.Back();
        extraData.put("cancelMobileUrl", "http://sharelogi.smartgimhae.kr/user/warehouse/paycoTest"); // [선택][모바일 일경우 필수]모바일 결제페이지에서 취소 버튼 클릭시 이동할 URL

        Map<String, Object> viewOptions = new HashMap<String, Object>();
        viewOptions.put("showMobileTopGnbYn", "N"); // [선택]모바일 상단 GNB 노출여부
        viewOptions.put("languageCode", "KR"); // [선택]주문서 언어 코드 (default KR) - EN/KR
        viewOptions.put("iframeYn", "N"); // [선택]Iframe 호출(모바일에서 접근하는경우 iframe 사용시 이값을 "Y"로 보내주셔야 합니다.)
        // Iframe 사용시 연동가이드 내용중 [Iframe 적용가이드]를 참고하시길 바랍니다.
        extraData.put("viewOptions", viewOptions); // [선택]화면 UI 옵션

        try {
            orderInfo.put("extraData", mapper.writeValueAsString(extraData));
        } catch (JsonProcessingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } // [선택]부가정보 - Json 형태의 String

        // 주문예약 API 호출 함수
        String result = util.payco_reserve(orderInfo, "Y");
        Map<String, Object> map = new HashMap<String, Object>();
        map = stringToJSON(result);

        model.addAttribute(map);
        /*
         * try { PrintWriter pw; pw = response.getWriter();
         * response.setContentType("application/json; charset=utf-8"); pw.print(result);
         * pw.flush(); pw.close();
         *
         * } catch (IOException e) { e.printStackTrace(); }
         */
    }

    @RequestMapping(value = "payco_reserve")
    // public void opnePaycoReserve(@RequestParam Map<String, Object> param, HttpServletRequest request, Model model) {
    public void opnePaycoReserve(@RequestParam String[] productKey,
                                 @RequestParam String[] orderQuantity,
                                 @RequestParam String customerOrderNumber, HttpServletRequest request, Model model) {

        // logger.debug("Payco Reseve KeySet = " + param.keySet());
        logger.debug("productKey = " + productKey);

        SellerInfoVO seller = payService.getSellerInfo(sellerUid); // 가맹점 정보 가져오기

        ObjectMapper mapper = new ObjectMapper(); // jackson json object

        HttpSession session = request.getSession(false);
        String userUid = (String) session.getAttribute("userUid");
        logger.debug("userUid : " + userUid);

        /*
         * //totalTaxfreeAmt(면세상품 총액) / totalTaxableAmt(과세상품 총액) / totalVatAmt(부가세 총액)
         * => 일부 필요한 가맹점을위한 예제입니다. //과세상품일 경우 if(taxationType.equals("TAXATION")){
         * unitTaxfreeAmt = 0; unitTaxableAmt = Math.round((float)(productPaymentAmt /
         * 1.1)); unitVatAmt = Math.round((float)((productPaymentAmt / 1.1) * 0.1));
         *
         * if(unitTaxableAmt + unitVatAmt != productPaymentAmt){ unitTaxableAmt =
         * productPaymentAmt - unitVatAmt; }
         *
         * //면세상품일 경우 }else if(taxationType.equals("DUTYFREE")){ unitTaxfreeAmt =
         * productPaymentAmt; unitTaxableAmt = 0; unitVatAmt = 0;
         *
         * //복합상품일 경우 }else if(taxationType.equals("COMBINE")){ unitTaxfreeAmt = 1000;
         * unitTaxableAmt = Math.round((float)((productPaymentAmt - unitTaxfreeAmt) /
         * 1.1)); unitVatAmt = Math.round((float)(((productPaymentAmt - unitTaxfreeAmt)
         * / 1.1) * 0.1));
         *
         * if(unitTaxableAmt + unitVatAmt != productPaymentAmt - unitTaxfreeAmt){
         * unitTaxableAmt = (productPaymentAmt - unitTaxfreeAmt) - unitVatAmt; }
         *
         * }
         *
         * totalTaxfreeAmt = totalTaxfreeAmt + unitTaxfreeAmt; totalTaxableAmt =
         * totalTaxableAmt + unitTaxableAmt; totalVatAmt = totalVatAmt + unitVatAmt;
         *
         */

        // 상품값으로 읽은 변수들로 Json String 을 작성합니다.
        int totalPaymentAmt = 0;

//         String customerOrderNumber = (String) param.get("customerOrderNumber");
//         String[] productKey = (String[]) param.get("productKey");
//         String[] orderQuantity = (String[]) param.get("orderQuantity");

        // 상품정보 불러오는 map List
        List<Map<String, Object>> orderProducts = new ArrayList<Map<String, Object>>();
        // 상품정보 불러오는 map
        Map<String, Object> productInfo = new HashMap<String, Object>();
        // 주문정보 저장
        SellerProductOrderVO userOrderInfo = new SellerProductOrderVO();

//        List<String> productKey = info.getProductKey();
//        List<String> orderQuantity = info.getOrderQuantity();
//        String customerOrderNumber = info.getCustomerOrderNumber();

        // productKey = new String[1];
        // productKey[0] = "2960903800";

        for (int i = 0; i < productKey.length; i++) {
            productInfo = payService.getProductInfo_Selected(productKey[i], orderQuantity[i]);

            totalPaymentAmt += (int) productInfo.get("productPaymentAmt");
            orderProducts.add(productInfo);

            // DB에 주문정보 입력 INSERT
            payService.setUserOrder(productInfo, userUid, customerOrderNumber, orderQuantity[i]);
        }

        // 설정한 주문정보로 Json String 을 작성합니다.
        // 가맹점 코드를 받아와 바뀌지 않는 정보들을 DB에서 가져오고 바뀌는 정보는 map에 추가로 입력
        Map<String, Object> orderInfo = new HashMap<String, Object>();
        orderInfo = payService.getOrderInfo(sellerKey);
        String returnUrl = request.getParameter("pathUrl");
        returnUrl += (String) orderInfo.get("returnUrl");
        logger.debug("returnUrlreturnUrl : " + returnUrl);
        orderInfo.put("returnUrl", returnUrl);
        orderInfo.put("sellerOrderReferenceKey", customerOrderNumber); // [필수]외부가맹점 주문번호
        orderInfo.put("totalPaymentAmt", totalPaymentAmt); // [필수]총 결제금액(면세금액,과세금액,부가세의 합) totalTaxfreeAmt +
        // totalTaxableAmt + totalVatAmt
        orderInfo.put("orderProducts", orderProducts); // [필수]주문상품 리스트

        /* 부가정보(extraData) - Json 형태의 String */
        Map<String, Object> extraData = new HashMap<String, Object>();
        // 해당주문예약건 만료처리일자(해당일 이후에는 결제불가)
        Date time = new Date();
        // 현재시간
        Calendar cal = Calendar.getInstance();
        cal.setTime(time);
        cal.add(Calendar.HOUR, 2);
        String currentTime = dateformat.format(time);
        String terminateTime = dateformat.format(cal.getTime());

        extraData.put("payExpiryYmdt", terminateTime); // [선택]해당주문예약건 만료처리일자(14자리로 맞춰주세요)
        // 가맹점 상황에따라 필요한경우가 아니라면 해당 파라미터는 삭제하여 주세요.
        // 가상계좌만료일시(YYYYMMDD or YYYYMMDDHHmmss형태로 넣는다)
        // extraData.put("virtualAccountExpiryYmd", "20191231180000");
        // //[선택]가상계좌만료일시(Default 3일, YYYYMMDD일경우 그날 24시까지)
        // 가맹점 에서 무통장입금을 사용하지 않으시면 해당 파라미터는 삭제하여 주세요.
        // appUrl
        //extraData.put("appUrl", "testapp://open"); // [IOS필수]IOS 인앱 결제시 ISP 모바일 등의 앱에서 결제를 처리한 뒤 복귀할 앱 URL
        // AOS(안드로이드) 에서는 필수사항이 아니므로 삭제하여 주세요.

        // 모바일 결제페이지에서 취소 버튼 클릭시 이동할 URL (결제창 이전 URL 등)
        // 1순위 : 주문예약 > extraData > cancelMobileUrl 값이 있을시 => cancelMobileUrl 이동
        // 2순위 : 주문예약시 전달받은 returnUrl 이동 + 실패코드(오류코드:2222)
        // 3순위 : 가맹점 URL로 이동(가맹점등록시 받은 사이트URL)
        // 4순위 : 이전 페이지로 이동 => history.Back();
        extraData.put("cancelMobileUrl", "http://logi.smartgimhae.kr"); // [선택][모바일 일경우 필수]모바일 결제페이지에서 취소 버튼 클릭시 이동할 URL

        Map<String, Object> viewOptions = new HashMap<String, Object>();
        viewOptions.put("showMobileTopGnbYn", "N"); // [선택]모바일 상단 GNB 노출여부
        viewOptions.put("languageCode", "KR"); // [선택]주문서 언어 코드 (default KR) - EN/KR
        viewOptions.put("iframeYn", "N"); // [선택]Iframe 호출(모바일에서 접근하는경우 iframe 사용시 이값을 "Y"로 보내주셔야 합니다.)
        // Iframe 사용시 연동가이드 내용중 [Iframe 적용가이드]를 참고하시길 바랍니다.
        extraData.put("viewOptions", viewOptions); // [선택]화면 UI 옵션

        try {
            orderInfo.put("extraData", mapper.writeValueAsString(extraData));
        } catch (JsonProcessingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } // [선택]부가정보 - Json 형태의 String

        // 주문예약 API 호출 함수
        String result = util.payco_reserve(orderInfo, "Y");
        Map<String, Object> map = new HashMap<String, Object>();
        map = stringToJSON(result);

        model.addAttribute(map);
        /*
         * try { PrintWriter pw; pw = response.getWriter();
         * response.setContentType("application/json; charset=utf-8"); pw.print(result);
         * pw.flush(); pw.close();
         *
         * } catch (IOException e) { e.printStackTrace(); }
         */
    }

    @RequestMapping(value = "type")
    public void type(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession();

        // 결제를 하기 전에 type이 logis인지 warehouse인지 세션에 저장함
        String type = (String) session.getAttribute("type");

        // 다시 요청했을 때, 변경 할 수 없도록 값 변경
        session.setAttribute("type", "");

        if (type != null && !type.equals("")) {
            model.addAttribute("type", type);
        } else {
            model.addAttribute("type", "");
        }
    }

    public Map<String, Object> stringToJSON(String result) {
        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            map = mapper.readValue(result, new TypeReference<Map<Object, Object>>() {
            });
        } catch (JsonParseException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (JsonMappingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return map;
    }

}
