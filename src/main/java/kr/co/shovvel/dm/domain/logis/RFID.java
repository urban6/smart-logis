package kr.co.shovvel.dm.domain.logis;

public class RFID {
    
    private String rfidNo;
    private String rfidUid;
    private String logisOrderUid;
    private String itemUid;

    public String getRfidNo() {
        return rfidNo;
    }

    public void setRfidNo(String rfidNo) {
        this.rfidNo = rfidNo;
    }

    public String getRfidUid() {
        return rfidUid;
    }

    public void setRfidUid(String rfidUid) {
        this.rfidUid = rfidUid;
    }

    public String getLogisOrderUid() {
        return logisOrderUid;
    }

    public void setLogisOrderUid(String logisOrderUid) {
        this.logisOrderUid = logisOrderUid;
    }

    public String getItemUid() {
        return itemUid;
    }

    public void setItemUid(String itemUid) {
        this.itemUid = itemUid;
    }
}
