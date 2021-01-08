package kr.co.shovvel.dm.domain.logis.management;

public class DriverLogin {
    
    private String driverLoginUid;
    private String logisNumber;
    private String driverName;
    private String driverHpNo;
    private String loginDate;

    public String getDriverLoginUid() {
        return driverLoginUid;
    }

    public void setDriverLoginUid(String driverLoginUid) {
        this.driverLoginUid = driverLoginUid;
    }

    public String getLogisNumber() {
        return logisNumber;
    }

    public void setLogisNumber(String logisNumber) {
        this.logisNumber = logisNumber;
    }

    public String getDriverName() {
        return driverName;
    }

    public void setDriverName(String driverName) {
        this.driverName = driverName;
    }

    public String getDriverHpNo() {
        return driverHpNo;
    }

    public void setDriverHpNo(String driverHpNo) {
        this.driverHpNo = driverHpNo;
    }

    public String getLoginDate() {
        return loginDate;
    }

    public void setLoginDate(String loginDate) {
        this.loginDate = loginDate;
    }
}
