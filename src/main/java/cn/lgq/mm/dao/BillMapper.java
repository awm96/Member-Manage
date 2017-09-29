package cn.lgq.mm.dao;

import cn.lgq.mm.model.Bill;
import java.sql.Timestamp;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * Created by Ligq on 2017/9/15.
 */
@Mapper
public interface BillMapper {

    Bill getBill(Long id);

    List<Bill> findBills(@Param("masterId") Long masterId, @Param("memberId") Long memberId,
                         @Param("transType") Integer transType,
                         @Param("createTimeStart") Timestamp createTimeStart,
                         @Param("createTimeEnd") Timestamp createTimeEnd,
                         @Param("offset") Integer offset, @Param("limit") Integer limit);

    int countBills(@Param("masterId") Long masterId, @Param("memberId") Long memberId,
                   @Param("transType") Integer transType,
                   @Param("createTimeStart") Timestamp createTimeStart,
                   @Param("createTimeEnd") Timestamp createTimeEnd);

    void addBill(Bill bill);

    List<Bill> findNeedProcessConsumeAmount(@Param("createTimeStart") Timestamp createTimeStart,
                                            @Param("createTimeEnd") Timestamp createTimeEnd);

    void updateConsumePayBillProcessFinish(@Param("createTimeStart") Timestamp createTimeStart,
                                           @Param("createTimeEnd") Timestamp createTimeEnd);
}
