package kr.co.shovvel.dm.domain.management.pay;

import java.sql.Date;

public class SellerApprovalVO {
	private String sellerOrderReferenceKey;
	private int approval_uid;
	private String userUid;
	private String orderReturnUrl;
	private String orderNo;
	private String orderChannel;
	private int totalOrderAmt;
	private int totalPaymentAmt;
	private String paymentCompletionYn;
	private String orderCertifyKey;
	private String paymentTradeNo;
	private String paymentMethodCode;
	private String paymentMethodName;
	private String tradeYmdt;
	private String pgAdmissionNo;
	private String pgAdmissionYmdt;
	private int isCancel;
	private int totalCancelPossibleAmt;
	private String cancelMemo;
	private int approvalCode;
	private Date approvalStartTime;
	private String reserveOrderNo;
	
	
	public int getIsCancel() {
		return isCancel;
	}
	public void setIsCancel(int isCancel) {
		this.isCancel = isCancel;
	}
	public String getCancelMemo() {
		return cancelMemo;
	}
	public void setCancelMemo(String cancelMemo) {
		this.cancelMemo = cancelMemo;
	}
	public int getApprovalCode() {
		return approvalCode;
	}
	public void setApprovalCode(int approvalCode) {
		this.approvalCode = approvalCode;
	}
	public Date getApprovalStartTime() {
		return approvalStartTime;
	}
	public void setApprovalStartTime(Date approvalStartTime) {
		this.approvalStartTime = approvalStartTime;
	}
	public String getReserveOrderNo() {
		return reserveOrderNo;
	}
	public void setReserveOrderNo(String reserveOrderNo) {
		this.reserveOrderNo = reserveOrderNo;
	}
	public String getSellerOrderReferenceKey() {
		return sellerOrderReferenceKey;
	}
	public void setSellerOrderReferenceKey(String sellerOrderReferenceKey) {
		this.sellerOrderReferenceKey = sellerOrderReferenceKey;
	}
	public int getApproval_uid() {
		return approval_uid;
	}
	public void setApproval_uid(int approval_uid) {
		this.approval_uid = approval_uid;
	}
	public String getUserUid() {
		return userUid;
	}
	public void setUserUid(String userUid) {
		this.userUid = userUid;
	}
	public String getOrderReturnUrl() {
		return orderReturnUrl;
	}
	public void setOrderReturnUrl(String orderReturnUrl) {
		this.orderReturnUrl = orderReturnUrl;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getOrderChannel() {
		return orderChannel;
	}
	public void setOrderChannel(String orderChannel) {
		this.orderChannel = orderChannel;
	}
	public int getTotalOrderAmt() {
		return totalOrderAmt;
	}
	public void setTotalOrderAmt(int totalOrderAmt) {
		this.totalOrderAmt = totalOrderAmt;
	}
	public int getTotalPaymentAmt() {
		return totalPaymentAmt;
	}
	public void setTotalPaymentAmt(int totalPaymentAmt) {
		this.totalPaymentAmt = totalPaymentAmt;
	}
	public String getPaymentCompletionYn() {
		return paymentCompletionYn;
	}
	public void setPaymentCompletionYn(String paymentCompletionYn) {
		this.paymentCompletionYn = paymentCompletionYn;
	}
	public String getOrderCertifyKey() {
		return orderCertifyKey;
	}
	public void setOrderCertifyKey(String orderCertifyKey) {
		this.orderCertifyKey = orderCertifyKey;
	}
	public String getPaymentTradeNo() {
		return paymentTradeNo;
	}
	public void setPaymentTradeNo(String paymentTradeNo) {
		this.paymentTradeNo = paymentTradeNo;
	}
	public String getPaymentMethodCode() {
		return paymentMethodCode;
	}
	public void setPaymentMethodCode(String paymentMethodCode) {
		this.paymentMethodCode = paymentMethodCode;
	}
	public String getPaymentMethodName() {
		return paymentMethodName;
	}
	public void setPaymentMethodName(String paymentMethodName) {
		this.paymentMethodName = paymentMethodName;
	}
	public String getTradeYmdt() {
		return tradeYmdt;
	}
	public void setTradeYmdt(String tradeYmdt) {
		this.tradeYmdt = tradeYmdt;
	}
	public String getPgAdmissionNo() {
		return pgAdmissionNo;
	}
	public void setPgAdmissionNo(String pgAdmissionNo) {
		this.pgAdmissionNo = pgAdmissionNo;
	}
	public String getPgAdmissionYmdt() {
		return pgAdmissionYmdt;
	}
	public void setPgAdmissionYmdt(String pgAdmissionYmdt) {
		this.pgAdmissionYmdt = pgAdmissionYmdt;
	}
	public int getTotalCancelPossibleAmt() {
		return totalCancelPossibleAmt;
	}
	public void setTotalCancelPossibleAmt(int totalCancelPossibleAmt) {
		this.totalCancelPossibleAmt = totalCancelPossibleAmt;
	}
	
	
	
}

