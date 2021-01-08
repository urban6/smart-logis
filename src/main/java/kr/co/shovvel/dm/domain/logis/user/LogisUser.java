package kr.co.shovvel.dm.domain.logis.user;

public class LogisUser {

    private String userUid; // 회원 고유번호
    private String loginId; // 아이디
    private String passwd; // 비밀번호
    // 삭제 예정
    /*
    private String companyName; // 회사명
    private String postcode; // 우편번호
    private String address; // 회사 주소
    private String managerName; // 관라자명
    private String phoneNumber; // 연락처
     */
    private String companyUid; // 회사 고유번호

    private String status; // 상태
    private String lastLoginIp; // 마지막 로그인 아이피
    private String lastLoginDate; // 마지막 로그인 날짜
    private String signUpDate; // 회원가입 날짜

    public String getUserUid() {
        return userUid;
    }

    public void setUserUid(String userUid) {
        this.userUid = userUid;
    }

    public String getLoginId() {
        return loginId;
    }

    public void setLoginId(String loginId) {
        this.loginId = loginId;
    }

    public String getPasswd() {
        return passwd;
    }

    public String getCompanyUid() {
        return companyUid;
    }

    public void setCompanyUid(String companyUid) {
        this.companyUid = companyUid;
    }

    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getLastLoginIp() {
        return lastLoginIp;
    }

    public void setLastLoginIp(String lastLoginIp) {
        this.lastLoginIp = lastLoginIp;
    }

    public String getLastLoginDate() {
        return lastLoginDate;
    }

    public void setLastLoginDate(String lastLoginDate) {
        this.lastLoginDate = lastLoginDate;
    }

    public String getSignUpDate() {
        return signUpDate;
    }

    public void setSignUpDate(String signUpDate) {
        this.signUpDate = signUpDate;
    }
}
