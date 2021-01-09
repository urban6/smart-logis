package kr.co.shovvel.dm.domain.warehouse;

public class WarehouseSpace {

    private int spaceUid;
    private int warehouseUid;
    private String spaceName;
    private String startDatetime;
    private String endDatetime;
    private int userUid;
    private String rfidUid;
    private String startTime;
    private String endTime;
    private String companyName;
    

    
    public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
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

	public String getRfidUid() {
		return rfidUid;
	}

	public void setRfidUid(String rfidUid) {
		this.rfidUid = rfidUid;
	}

	public int getSpaceUid() {
        return spaceUid;
    }

    public void setSpaceUid(int spaceUid) {
        this.spaceUid = spaceUid;
    }

    public int getWarehouseUid() {
        return warehouseUid;
    }

    public void setWarehouseUid(int warehouseUid) {
        this.warehouseUid = warehouseUid;
    }

    public String getSpaceName() {
        return spaceName;
    }

    public void setSpaceName(String spaceName) {
        this.spaceName = spaceName;
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

    public int getUserUid() {
        return userUid;
    }

    public void setUserUid(int userUid) {
        this.userUid = userUid;
    }
}
