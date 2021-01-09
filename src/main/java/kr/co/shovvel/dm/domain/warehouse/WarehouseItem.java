package kr.co.shovvel.dm.domain.warehouse;

public class WarehouseItem {

    private String itemUid;
    private String spaceUid;
    private String orderInfoUid;
    private String inDate;
    private String outDate;
    private int state;
    private String itemInfo;
    private String spaceName;
    private String rfidUid;
    
    
    public String getSpaceName() {
		return spaceName;
	}

	public void setSpaceName(String spaceName) {
		this.spaceName = spaceName;
	}

	public String getRfidUid() {
		return rfidUid;
	}

	public void setRfidUid(String rfidUid) {
		this.rfidUid = rfidUid;
	}

    public String getItemUid() {
        return itemUid;
    }

    public void setItemUid(String itemUid) {
        this.itemUid = itemUid;
    }

    public String getSpaceUid() {
        return spaceUid;
    }

    public void setSpaceUid(String spaceUid) {
        this.spaceUid = spaceUid;
    }

    public String getOrderInfoUid() {
        return orderInfoUid;
    }

    public void setOrderInfoUid(String orderInfoUid) {
        this.orderInfoUid = orderInfoUid;
    }

    public String getInDate() {
        return inDate;
    }

    public void setInDate(String inDate) {
        this.inDate = inDate;
    }

    public String getOutDate() {
        return outDate;
    }

    public void setOutDate(String outDate) {
        this.outDate = outDate;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public String getItemInfo() {
        return itemInfo;
    }

    public void setItemInfo(String itemInfo) {
        this.itemInfo = itemInfo;
    }
}
