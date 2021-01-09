package kr.co.shovvel.dm.domain.logis.apply;

import kr.co.shovvel.dm.domain.logis.RFIDItem;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

/**
 * 택배를 신청할 때, 필요한 데이터
 */

public class LogisOrderInfo {

	private String logisOrderUid;
    private String userUid;

    // 보내는 분 정보
    private String senderName;
    private String senderPhone;
    private String senderPostcode;
    private String senderAddress;

    // 받는 분 정보
    private String receiverName;
    private String receiverPhone;
    private String receiverPostcode;
    private String receiverAddress;

    private String wishDeliveryDatetime;
    private String startTime;
    private String endTime;

    private int boxCount;
    private int paletteCount;
    private String requestTime;

    private int status;

    private int price; // 가격

    private String isPay;
    private String payType;
    private int logisType;

    private String itemInfo;

    private List<RFIDItem> rfidItemList;

    private String warehouseOrderUid;

	public String getLogisOrderUid() {
		return logisOrderUid;
	}

	public void setLogisOrderUid(String logisOrderUid) {
		this.logisOrderUid = logisOrderUid;
	}

	public String getUserUid() {
		return userUid;
	}

	public void setUserUid(String userUid) {
		this.userUid = userUid;
	}

	public String getSenderName() {
		return senderName;
	}

	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}

	public String getSenderPhone() {
		return senderPhone;
	}

	public void setSenderPhone(String senderPhone) {
		this.senderPhone = senderPhone;
	}

	public String getSenderPostcode() {
		return senderPostcode;
	}

	public void setSenderPostcode(String senderPostcode) {
		this.senderPostcode = senderPostcode;
	}

	public String getSenderAddress() {
		return senderAddress;
	}

	public void setSenderAddress(String senderAddress) {
		this.senderAddress = senderAddress;
	}

	public String getReceiverName() {
		return receiverName;
	}

	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}

	public String getReceiverPhone() {
		return receiverPhone;
	}

	public void setReceiverPhone(String receiverPhone) {
		this.receiverPhone = receiverPhone;
	}

	public String getReceiverPostcode() {
		return receiverPostcode;
	}

	public void setReceiverPostcode(String receiverPostcode) {
		this.receiverPostcode = receiverPostcode;
	}

	public String getReceiverAddress() {
		return receiverAddress;
	}

	public void setReceiverAddress(String receiverAddress) {
		this.receiverAddress = receiverAddress;
	}

	public String getWishDeliveryDatetime() {
		return wishDeliveryDatetime;
	}

	public void setWishDeliveryDatetime(String wishDeliveryDatetime) {
		this.wishDeliveryDatetime = wishDeliveryDatetime;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public int getBoxCount() {
		return boxCount;
	}

	public void setBoxCount(int boxCount) {
		this.boxCount = boxCount;
	}

	public int getPaletteCount() {
		return paletteCount;
	}

	public void setPaletteCount(int paletteCount) {
		this.paletteCount = paletteCount;
	}

	public String getRequestTime() {
		return requestTime;
	}

	public void setRequestTime(String requestTime) {
		this.requestTime = requestTime;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getIsPay() {
		return isPay;
	}

	public void setIsPay(String isPay) {
		this.isPay = isPay;
	}

	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

	public int getLogisType() {
		return logisType;
	}

	public void setLogisType(int logisType) {
		this.logisType = logisType;
	}

	public String getItemInfo() {
		return itemInfo;
	}

	public void setItemInfo(String itemInfo) {
		this.itemInfo = itemInfo;
	}

	public List<RFIDItem> getRfidItemList() {
		return rfidItemList;
	}

	public void setRfidItemList(List<RFIDItem> rfidItemList) {
		this.rfidItemList = rfidItemList;
	}

	public String getWarehouseOrderUid() {
		return warehouseOrderUid;
	}

	public void setWarehouseOrderUid(String warehouseOrderUid) {
		this.warehouseOrderUid = warehouseOrderUid;
	}
}
