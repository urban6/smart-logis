package kr.co.shovvel.dm.domain.logis;

public class RFIDItem {

    private int itemUid;
    private String rfidUid;
    private String itemInfo;

    public int getItemUid() {
        return itemUid;
    }

    public void setItemUid(int itemUid) {
        this.itemUid = itemUid;
    }

    public String getRfidUid() {
        return rfidUid;
    }

    public void setRfidUid(String rfidUid) {
        this.rfidUid = rfidUid;
    }

    public String getItemInfo() {
        return itemInfo;
    }

    public void setItemInfo(String itemInfo) {
        this.itemInfo = itemInfo;
    }
}
