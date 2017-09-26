package cn.lgq.mm.service;

import cn.lgq.mm.dao.AdminMapper;
import cn.lgq.mm.dao.BillMapper;
import cn.lgq.mm.model.Admin;
import cn.lgq.mm.model.Bill;
import cn.lgq.mm.vo.Page;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by Ligq on 2017/9/15.
 */
@Service
public class BillService {

    @Autowired
    private BillMapper billMapper;
    @Autowired
    private AdminMapper adminMapper;

    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public Bill getBill(Long id) {
        return billMapper.getBill(id);
    }

    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public Page<Bill> findBills(Long masterId, Long memberId, Timestamp createTimeStart,
        Timestamp createTimeEnd, Integer pageNo, Integer pageSize) {
        Page<Bill> page = new Page<>();
        page.setPageNo(pageNo);
        page.setLimit(pageSize);
        List<Bill> billList = billMapper.findBills(masterId, memberId, createTimeStart, createTimeEnd, page.getOffset(), page.getLimit());
        List<Long> creatorIdList = Lists.transform(billList, (bill) -> bill.getCreatorId());
        List<Admin> adminList = adminMapper.getAdminNames(Sets.newHashSet(creatorIdList).toArray(new Long[1]));
        Map<Long, Admin> adminMap = Maps.uniqueIndex(adminList, (admin) -> admin.getId());
        billList.forEach(bill -> bill.setCreatorName(adminMap.get(bill.getCreatorId()).getName()));
        int count = billMapper.countBills(masterId, masterId, createTimeStart, createTimeEnd);
        page.setTotalRows(count);
        page.setResultList(billList);
        return page;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void addBill(Bill bill) {
        billMapper.addBill(bill);
    }
}
