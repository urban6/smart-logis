package kr.co.shovvel.dm.domain.logis.apply;

/**
 * 물류 배송을 신청할 때, 회원가입 시 입력한 회원 정보를 가져온다.
 */
public class LogisUserInfo {

    private String managerName; // 관리자명(=사용자)
    private String phoneNumber; // 연락처
    private String postcode; // 우편번호
    private String address; // 주소
    private String detailAddress; // 상세주소

    public String getManagerName() {
        return managerName;
    }

    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getPostcode() {
        return postcode;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDetailAddress() {
        return detailAddress;
    }

    public void setDetailAddress(String detailAddress) {
        this.detailAddress = detailAddress;
    }
}
