package kr.co.shovvel.dm.domain.warehouse;

public class WarehouseSpace {

    private int spaceUid;
    private int warehouseUid;
    private String spaceName;
    private String startDatetime;
    private String endDatetime;
    private int userUid;

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
