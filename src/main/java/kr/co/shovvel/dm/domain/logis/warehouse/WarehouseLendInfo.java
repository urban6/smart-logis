package kr.co.shovvel.dm.domain.logis.warehouse;

import lombok.Data;

/**
 * 창고를 신청할 때, 사용자에게 받는 데이터
 * [창고명, 회사명, 연락처, 주소, 창고 크기, 공간 당 가격]
 */
@Data
public class WarehouseLendInfo {
    private String lendOrderUid;
    private String userUid;
    private String warehouseName;
    private String companyName;
    private String phoneNumber;
    private String warehouseAddress;
    private String warehousePostcode;
    private int warehouseSize;
    private int spacePrice;
	public String getLendOrderUid() {
		return lendOrderUid;
	}
	public void setLendOrderUid(String lendOrderUid) {
		this.lendOrderUid = lendOrderUid;
	}
	public String getUserUid() {
		return userUid;
	}
	public void setUserUid(String userUid) {
		this.userUid = userUid;
	}
	public String getWarehouseName() {
		return warehouseName;
	}
	public void setWarehouseName(String warehouseName) {
		this.warehouseName = warehouseName;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getWarehouseAddress() {
		return warehouseAddress;
	}
	public void setWarehouseAddress(String warehouseAddress) {
		this.warehouseAddress = warehouseAddress;
	}
	public String getWarehousePostcode() {
		return warehousePostcode;
	}
	public void setWarehousePostcode(String warehousePostcode) {
		this.warehousePostcode = warehousePostcode;
	}
	public int getWarehouseSize() {
		return warehouseSize;
	}
	public void setWarehouseSize(int warehouseSize) {
		this.warehouseSize = warehouseSize;
	}
	public int getSpacePrice() {
		return spacePrice;
	}
	public void setSpacePrice(int spacePrice) {
		this.spacePrice = spacePrice;
	}
    
    
}
