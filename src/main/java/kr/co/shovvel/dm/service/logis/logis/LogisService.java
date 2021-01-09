package kr.co.shovvel.dm.service.logis.logis;

import kr.co.shovvel.dm.common.Consts;
import kr.co.shovvel.dm.dao.logis.logis.LogisMapper;
import kr.co.shovvel.dm.domain.logis.apply.LogisOrderInfo;
import kr.co.shovvel.dm.domain.logis.apply.LogisUserInfo;
import kr.co.shovvel.dm.domain.logis.search.LogisSearchInfo;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LogisService {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private LogisMapper logisMapper;

    /**
     * 물류 신청
     *
     * @param logisOrderInfo - 물류 신청 정보
     */
    public String applyAction(LogisOrderInfo logisOrderInfo) {
        logisMapper.insertLogisApply(logisOrderInfo);

        // 데이터가 들어 갔을 경우
        if (logisOrderInfo.getLogisOrderUid() != null) {
            return Consts.LOGIS_APPLY_RESULT.SUCCESS;
        } else {
            // 데이터가 제대로 안들어 갔을 경우
            return Consts.LOGIS_APPLY_RESULT.FAIL;
        }
    }

    /**
     * 물류 신청
     *
     * @param logisOrderInfo - 물류 신청 정보
     */
    public String applyActionToWarehouse(LogisOrderInfo logisOrderInfo) {
        logisMapper.insertToWhseLogisApply(logisOrderInfo);

        // 데이터가 들어 갔을 경우
        if (logisOrderInfo.getLogisOrderUid() != null) {
            return Consts.LOGIS_APPLY_RESULT.SUCCESS;
        } else {
            // 데이터가 제대로 안들어 갔을 경우
            return Consts.LOGIS_APPLY_RESULT.FAIL;
        }
    }

    /**
     * 물류 신청 리스트를 조회한다.
     *
     * @param userUid - 회원 고유번호
     */
    public List<LogisSearchInfo> searchLogisOrderInfo(String userUid) {
        return logisMapper.searchLogisOrderInfo(userUid);
    }

    /**
     * 사용자가 선택한 물류에 대해서 상세조회를 한다.
     *
     * @param logisOrderUid - 물류 고유번호
     */
    public LogisSearchInfo searchLogisDetail(String logisOrderUid) {
        return logisMapper.searchLogisDetail(logisOrderUid);
    }

    /**
     * 결제를 하기 전에
     *
     * @param productName
     * @return
     */
    public String searchProductKey(String productName) {
        return logisMapper.searchProductKey(productName);
    }


    /**
     * 결제가 성공적으로 되었을 경우, 기존에 추가했던 신청 데이터의 결제 상태를 변경한다.
     * [ IS_PAY = 'Y, STATUS = 1 ]
     *
     * @param salesUid      - 결제 고유번호
     * @param logisOrderUid - 주문 고유번호
     */
    public void updatePayStateInOrderInfo(String salesUid, int logisOrderUid) {
        logisMapper.updatePayStateInOrderInfo(salesUid, logisOrderUid);
    }

    /**
     * 물류 배송을 할 때, 회원가입 시 입력한 정보를 가져온다.
     *
     * @param userUid - 회원 고유번호
     */
    public LogisUserInfo searchUserAddress(String userUid) {
        return logisMapper.searchUserAddress(userUid);
    }
}
