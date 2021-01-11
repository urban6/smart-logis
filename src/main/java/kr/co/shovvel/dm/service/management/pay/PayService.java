package kr.co.shovvel.dm.service.management.pay;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ArrayNode;

import kr.co.shovvel.dm.dao.management.pay.PayMapper;
import kr.co.shovvel.dm.domain.management.pay.SellerApprovalVO;
import kr.co.shovvel.dm.domain.management.pay.SellerInfoVO;
import kr.co.shovvel.dm.domain.management.pay.SellerProductInfoVO;
import kr.co.shovvel.dm.domain.management.pay.SellerProductOrderVO;

@Service
public class PayService {
    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private PayMapper payMapper;

    public SellerInfoVO getSellerInfo(int sellerUid) {
        SellerInfoVO seller = payMapper.getSellerInfo(sellerUid);
        return seller;
    }

    public ArrayList<SellerProductInfoVO> getProductInfo(String cpId) {
        ArrayList<SellerProductInfoVO> seller_Producct = payMapper.getProductInfo(cpId);
        return seller_Producct;
    }

    public Map<String, Object> getProductInfo_Selected(String productUid, String quantity) {
        Map<String, Object> productInfo = new HashMap<String, Object>();
        productInfo = payMapper.getProductInfo_Selected(productUid);
        productInfo.put("orderQuantity", quantity);

        int productPrice = (int) productInfo.get("productAmt");
        int productPaymentPrice = (int) productInfo.get("productPaymentAmt");
        productPrice = productPrice * Integer.parseInt(quantity);
        productPaymentPrice = productPaymentPrice * Integer.parseInt(quantity);

        productInfo.put("productAmt", productPrice);
        productInfo.put("productPaymentAmt", productPaymentPrice);

        return productInfo;
    }

    public void setUserOrder(Map<String, Object> productInfo, String userUid, String customerOrderNumber, String quantity) {

        SellerProductOrderVO userOrderInfo = new SellerProductOrderVO();

        userOrderInfo.setCpId((String) productInfo.get("cpId"));
        userOrderInfo.setOrderQuantity(Integer.parseInt(quantity));
        userOrderInfo.setProductId((String) productInfo.get("productId"));
        userOrderInfo.setSellerOrderProductReferenceKey((String) productInfo.get("sellerOrderProductReferenceKey"));
        userOrderInfo.setSellerOrderReferenceKey(customerOrderNumber);
        userOrderInfo.setUserUid(userUid);
        userOrderInfo.setSortOrdering((int) productInfo.get("sortOrdering"));

        payMapper.setUserOrder(userOrderInfo);
    }

    public Map<String, Object> getOrderInfo(String sellerKey) {
        Map<String, Object> map = new HashMap<String, Object>();
        map = payMapper.getOrderInfo(sellerKey);
        return map;
    }

    public int getOrderTotalPrice(String sellerOrderReferenceKey) {
        ArrayList<Map<String, Object>> totalPriceList = new ArrayList<Map<String, Object>>();
        totalPriceList = payMapper.getOrderTotalPrice(sellerOrderReferenceKey);
        int totalPayment = 0;
        for (Map<String, Object> list : totalPriceList) {
            int price = (int) list.get("productPaymentAmt");
            int quantity = (int) list.get("orderQuantity");
            int payment = price * quantity;
            totalPayment += payment;
        }
        return totalPayment;
    }

    public void updateUserOrder(String sellerOrderReferenceKey, ArrayNode orderProducts_arr) {
        for (int i = 0; i < orderProducts_arr.size(); i++) {
            SellerProductOrderVO userOrderInfo = new SellerProductOrderVO();
            String orderProductNo = orderProducts_arr.get(i).get("orderProductNo").textValue();
            String orderProductStatusCode = orderProducts_arr.get(i).get("orderProductStatusCode").textValue();
            String orderProductStatusName = orderProducts_arr.get(i).get("orderProductStatusName").textValue();
            String sellerOrderProductReferenceKey = orderProducts_arr.get(i).get("sellerOrderProductReferenceKey").textValue();

            userOrderInfo.setOrderProductNo(orderProductNo);
            userOrderInfo.setOrderProductStatusCode(orderProductStatusCode);
            userOrderInfo.setOrderProductStatusName(orderProductStatusName);
            userOrderInfo.setSellerOrderProductReferenceKey(sellerOrderProductReferenceKey);
            userOrderInfo.setSellerOrderReferenceKey(sellerOrderReferenceKey);

            payMapper.updateUserOrder(userOrderInfo);
        }
    }

    public void setOrderApproval(JsonNode node, String userUid) {
        SellerApprovalVO orderApproval = new SellerApprovalVO();

        orderApproval.setSellerOrderReferenceKey(node.path("result").get("sellerOrderReferenceKey").textValue());
        orderApproval.setUserUid(userUid);
        orderApproval.setOrderNo(node.path("result").get("orderNo").textValue());
        orderApproval.setOrderChannel(node.path("result").get("orderChannel").textValue());
        orderApproval.setTotalOrderAmt((int) Float.parseFloat(node.path("result").get("totalOrderAmt").toString()));
        orderApproval.setTotalPaymentAmt((int) Float.parseFloat(node.path("result").get("totalPaymentAmt").toString()));
        orderApproval.setPaymentCompletionYn(node.path("result").get("paymentCompletionYn").textValue());
        orderApproval.setOrderCertifyKey(node.path("result").get("orderCertifyKey").textValue());
        orderApproval.setReserveOrderNo(node.path("result").get("reserveOrderNo").textValue());

        ArrayNode paymentDetails_arr = (ArrayNode) node.path("result").get("paymentDetails");
        for (int j = 0; j < paymentDetails_arr.size(); j++) {
            orderApproval.setPaymentTradeNo(paymentDetails_arr.get(j).get("paymentTradeNo").textValue());
            orderApproval.setPaymentMethodCode(paymentDetails_arr.get(j).get("paymentMethodCode").textValue());
            orderApproval.setPaymentMethodName(paymentDetails_arr.get(j).get("paymentMethodName").textValue());
            orderApproval.setTradeYmdt(paymentDetails_arr.get(j).get("tradeYmdt").textValue());
            orderApproval.setPgAdmissionNo(paymentDetails_arr.get(j).get("pgAdmissionNo").textValue());
            orderApproval.setPgAdmissionYmdt(paymentDetails_arr.get(j).get("pgAdmissionYmdt").textValue());
            payMapper.setOrderApproval(orderApproval);
        }


    }

    public void setOrder(String userUid, String sellerOrderReferenceKey, String returnUrl) {
        SellerApprovalVO newOrder = new SellerApprovalVO();
        newOrder.setUserUid(userUid);
        newOrder.setSellerOrderReferenceKey(sellerOrderReferenceKey);
        newOrder.setOrderReturnUrl(returnUrl);
        payMapper.setOrder(newOrder);
    }

    public Map<String, Object> getOrderProductPrice(String orderNo, String sellerOrderProductReferenceKey) {
        Map<String, Object> orderProductPrice = new HashMap<String, Object>();
        orderProductPrice = payMapper.getOrderProductPrice(orderNo, sellerOrderProductReferenceKey);
        int productAmt = 0;
        int price = (int) orderProductPrice.get("productPaymentAmt");
        int quantity = (int) orderProductPrice.get("orderQuantity");
        productAmt = price * quantity;

        orderProductPrice.put("productAmt", productAmt);
        return orderProductPrice;
    }

    public void updateCancel(String orderNo, String totalCancelPossibleAmt, String cancelAmt, String requestMemo) {
        SellerApprovalVO cancelOrder = new SellerApprovalVO();
        int totalCancelAmt = Integer.parseInt(totalCancelPossibleAmt);
        int requestCancelAmt = Integer.parseInt(cancelAmt);
        totalCancelAmt -= requestCancelAmt;

        cancelOrder.setOrderNo(orderNo);
        cancelOrder.setTotalCancelPossibleAmt(totalCancelAmt);
        if (requestMemo != null) {
            cancelOrder.setCancelMemo(requestMemo);
        } else {
            cancelOrder.setCancelMemo("결제가 취소되었습니다");
        }


        payMapper.updateCancel(cancelOrder);
    }

    public String searchSellerKey(int productUid) {
        return payMapper.searchSellerKey(productUid);
    }

    public int searchLogisPrice(int productUid) {
        return payMapper.searchLogisPrice(productUid);
    }

    public void updateOrderCode(String code, String userUid) {
        payMapper.updateOrderCode(code, userUid);
    }

    public void updateApprovalCode(String approvalCode, String sellerOrderReferenceKey) {
        payMapper.updateApprovalCode(approvalCode, sellerOrderReferenceKey);
    }

    public SellerApprovalVO getArrovalDetail(String userUid) {
        return payMapper.getArrovalDetail(userUid);
    }

    public SellerApprovalVO getArroval(String orderInfoUid) {
        return payMapper.getArroval(orderInfoUid);
    }

    /**
     * 물류 환불 관련 조회
     *
     * @param logisOrderUid - 물류 신청 고유번호
     */
    public SellerApprovalVO getArrovalLogis(String logisOrderUid) {
        return payMapper.getArrovalLogis(logisOrderUid);
    }
}
