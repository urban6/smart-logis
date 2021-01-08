package kr.co.shovvel.dm.domain.logis.warehouse;

import lombok.Data;

@Data
public class WarehouseOrderInfo {
    private int orderInfoUid;
    private int userUid;
    private int companyUid;
    private int warehouseUid;
    private String startTime;
    private String endTime;
    private int size;
    private String requestTime;
    private int status;
    private int price;
    private String payType;
    private String isPay;
	public int getOrderInfoUid() {
		return orderInfoUid;
	}
	public void setOrderInfoUid(int orderInfoUid) {
		this.orderInfoUid = orderInfoUid;
	}
	public int getUserUid() {
		return userUid;
	}
	public void setUserUid(int userUid) {
		this.userUid = userUid;
	}
	public int getCompanyUid() {
		return companyUid;
	}
	public void setCompanyUid(int companyUid) {
		this.companyUid = companyUid;
	}
	public int getWarehouseUid() {
		return warehouseUid;
	}
	public void setWarehouseUid(int warehouseUid) {
		this.warehouseUid = warehouseUid;
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
	public int getSize() {
		return size;
	}
	public void setSize(int size) {
		this.size = size;
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
	public String getPayType() {
		return payType;
	}
	public void setPayType(String payType) {
		this.payType = payType;
	}
	public String getIsPay() {
		return isPay;
	}
	public void setIsPay(String isPay) {
		this.isPay = isPay;
	}
    
    
}

