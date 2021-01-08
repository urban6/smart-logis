package kr.co.shovvel.dm.domain.logis.management;

import lombok.Data;

@Data
public class Company {
    private int orderInfoUid; // 창고 예약 고유번호
    private String companyName; // 회사명
    private String address; // 회사 주소
    private String startTime; // 예약 시작 시간
    private String endTime; // 예약 종료 시간
}
