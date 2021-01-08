package kr.co.shovvel.dm.domain.warehouse;

import lombok.Data;

/**
 * http://localhost:8080/user/warehouse/apply 에서 창고를 조회한 결과를 보내줄 때 사용한다.
 */
@Data
public class WarehouseInfo {

    private String warehouseUid; // 창고 고유번호
    private String warehouseName; // 창고 명
    private String warehouseAddress; // 창고 주소
    private String warehousePostcode; // 우펴번호

    // 창고 위경도
    private float lat;
    private float lng;

    private int price; // 공간 1개당 가격
    private int days; // 빌리는 일 수
    private int spaceSize; // 사용자가 빌리는 공간 수
    private int availableSpace; // 이용 가능한 공간의 수

    // 사용자가 선택한 예약 기간
    private String startDatetime;
    private String endDatetime;

    private boolean isCanUse;

	public String getWarehouseUid() {
		return warehouseUid;
	}

	public void setWarehouseUid(String warehouseUid) {
		this.warehouseUid = warehouseUid;
	}

	public String getWarehouseName() {
		return warehouseName;
	}

	public void setWarehouseName(String warehouseName) {
		this.warehouseName = warehouseName;
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

	public float getLat() {
		return lat;
	}

	public void setLat(float lat) {
		this.lat = lat;
	}

	public float getLng() {
		return lng;
	}

	public void setLng(float lng) {
		this.lng = lng;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getDays() {
		return days;
	}

	public void setDays(int days) {
		this.days = days;
	}

	public int getSpaceSize() {
		return spaceSize;
	}

	public void setSpaceSize(int spaceSize) {
		this.spaceSize = spaceSize;
	}

	public int getAvailableSpace() {
		return availableSpace;
	}

	public void setAvailableSpace(int availableSpace) {
		this.availableSpace = availableSpace;
	}

	public String getStartDatetime() {
		return startDatetime;
	}

	public void setStartDatetime(String startDatetime) {
		this.startDatetime = startDatetime;
	}

	public String getEndDatetime() {
		return endDatetime;
	}

	public void setEndDatetime(String endDatetime) {
		this.endDatetime = endDatetime;
	}

	public boolean isCanUse() {
		return isCanUse;
	}

	public void setCanUse(boolean isCanUse) {
		this.isCanUse = isCanUse;
	}
    
    
}
