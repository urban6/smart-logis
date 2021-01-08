package kr.co.shovvel.dm.domain.logis.user;

import lombok.Data;

import java.util.ArrayList;

@Data
public class PayOrderInfo {
    private String customerOrderNumber;
    private String pathUrl;
    private ArrayList<String> productKey;
    private ArrayList<String> orderQuantity;
	public String getCustomerOrderNumber() {
		return customerOrderNumber;
	}
	public void setCustomerOrderNumber(String customerOrderNumber) {
		this.customerOrderNumber = customerOrderNumber;
	}
	public String getPathUrl() {
		return pathUrl;
	}
	public void setPathUrl(String pathUrl) {
		this.pathUrl = pathUrl;
	}
	public ArrayList<String> getProductKey() {
		return productKey;
	}
	public void setProductKey(ArrayList<String> productKey) {
		this.productKey = productKey;
	}
	public ArrayList<String> getOrderQuantity() {
		return orderQuantity;
	}
	public void setOrderQuantity(ArrayList<String> orderQuantity) {
		this.orderQuantity = orderQuantity;
	}
    
    
}
