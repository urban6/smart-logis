package kr.co.shovvel.dm.dao.logis.logis;

import kr.co.shovvel.dm.domain.logis.apply.LogisOrderInfo;
import kr.co.shovvel.dm.domain.logis.search.LogisSearchInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface LogisMapper {

    void insertLogisApply(LogisOrderInfo logisOrderInfo);

    List<LogisSearchInfo> searchLogisOrderInfo(@Param(value = "userUid") String userUid);

    LogisSearchInfo searchLogisDetail(@Param(value = "logisOrderUid") String logisOrderUid);

    String searchProductKey(@Param(value = "productName") String productName);

    void updatePayStateInOrderInfo(@Param(value = "salesUid") String salesUid, @Param(value = "logisOrderUid") int logisOrderUid);
}
