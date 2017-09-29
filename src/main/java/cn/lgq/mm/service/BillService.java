package cn.lgq.mm.service;

import cn.lgq.mm.Constants;
import cn.lgq.mm.dao.AdminMapper;
import cn.lgq.mm.dao.BillMapper;
import cn.lgq.mm.dao.MemberMapper;
import cn.lgq.mm.exception.BillException;
import cn.lgq.mm.model.Admin;
import cn.lgq.mm.model.Bill;
import cn.lgq.mm.model.Member;
import cn.lgq.mm.vo.Page;
import cn.lgq.mm.vo.SystemRegulation;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;
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
    @Autowired
    private MemberMapper memberMapper;
    @Autowired
    private SystemRegulation regulation;

    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public Bill getBill(Long id) {
        return billMapper.getBill(id);
    }

    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public Page<Bill> findBills(Long masterId, Long memberId, Integer transType, Timestamp createTimeStart,
        Timestamp createTimeEnd, Integer pageNo, Integer pageSize) {
        Page<Bill> page = new Page<>();
        page.setPageNo(pageNo);
        page.setLimit(pageSize);
        //查询订单列表
        int count = billMapper.countBills(masterId, masterId, transType, createTimeStart, createTimeEnd);
        List<Bill> billList = billMapper.findBills(masterId, memberId, transType, createTimeStart, createTimeEnd, page.getOffset(), page.getLimit());
        //填充creator
        List<Long> creatorIdList = Lists.transform(billList, (bill) -> bill.getCreatorId());
        List<Admin> adminList = adminMapper.getAdminNames(Sets.newHashSet(creatorIdList).toArray(new Long[1]));
        Map<Long, Admin> adminMap = Maps.uniqueIndex(adminList, (admin) -> admin.getId());
        billList.forEach(bill -> bill.setCreatorName(adminMap.get(bill.getCreatorId()).getName()));
        //填充member
        List<Long> memberIdList = Lists.transform(billList, (bill) -> bill.getMemberId());
        List<Member> memberList = memberMapper.getMemberBaseInfo(Sets.newHashSet(memberIdList).toArray(new Long[1]));
        Map<Long, Member> memberMap = Maps.uniqueIndex(memberList, (member) -> member.getId());
        billList.forEach(bill -> {
            Member member = memberMap.get(bill.getMemberId());
            bill.setMemberName(member.getName());
            bill.setMemberIdCardNo(member.getIdCardNo());
            bill.setMemberMobile(member.getMobile());
        });
        page.setTotalRows(count);
        page.setResultList(billList);
        return page;
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void addBill(long memberId, int transType, int amount, long creatorId) {
        Member member = memberMapper.getMemberForUpdate(memberId);
        Integer storedAmount = null, consumeAmount = null, integralAmount = null, level = null;
        if (transType == Constants.TRANS_TYPE_STORED_RECHARGE) {
            Integer presentAmount = regulation.getStorePresentRule().floorKey(amount);
            storedAmount = amount;
            consumeAmount = presentAmount == null ? amount : presentAmount;
            level = Constants.MEMBER_LEVEL_THRESHOLD_MAP.floorKey(member.getStoredAmount() + amount);
            Bill master = new Bill(memberId, Constants.TRANS_TYPE_STORED_RECHARGE, storedAmount, creatorId);
            billMapper.addBill(master);
            Bill child = new Bill(memberId, Constants.TRANS_TYPE_CONSUME_RECHARGE, consumeAmount, creatorId);
            child.setMasterId(master.getId());
            billMapper.addBill(child);
        } else if (transType == Constants.TRANS_TYPE_CONSUME_PAY) {
            if (member.getConsumeAmount() < amount) {
                throw new BillException("会员消费余额小于请求的消费金额!");
            }
            boolean presentNow = member.getRecommendNum() >= Constants.MEMBER_RECOMMEND_NUM_THRESHOLD;
            consumeAmount = amount;
            Bill master = new Bill(memberId, Constants.TRANS_TYPE_CONSUME_PAY, consumeAmount, creatorId);
            if (presentNow) {
                master.setProcessFlag(1);
            }
            billMapper.addBill(master);
            if (presentNow) {
                integralAmount = Double.valueOf(Math.floor(consumeAmount * regulation.getConsumeReturnRatio())).intValue();
                Bill child = new Bill(memberId, Constants.TRANS_TYPE_INTEGRAL_RECHARGE, consumeAmount, creatorId);
                child.setMasterId(master.getId());
                billMapper.addBill(child);
            }
            consumeAmount = consumeAmount * -1;
        } else if (transType == Constants.TRANS_TYPE_INTEGRAL_PAY) {
            if (member.getIntegralAmount() < amount) {
                throw new BillException("会员积分余额小于请求的积分金额!");
            }
            integralAmount = amount;
            Bill master = new Bill(memberId, Constants.TRANS_TYPE_CONSUME_PAY, integralAmount, creatorId);
            billMapper.addBill(master);
            integralAmount = integralAmount * -1;
        } else {
            throw new BillException("错误的交易类型! transType=" + transType);
        }
        memberMapper.updateMemberAmountAndLevel(memberId, level, storedAmount, consumeAmount, integralAmount);
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void repealBill(long masterId) {
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void execIntegralPresent(Timestamp startTime, Timestamp endTime) {
        List<Bill> billList = billMapper.findNeedProcessConsumeAmount(startTime, endTime);
        for (Bill bill : billList) {
            if (bill.getAmount() <= 0)
                continue;
            int integralAmount = Double.valueOf(Math.floor(bill.getAmount() * regulation.getConsumeReturnRatio())).intValue();
            Bill child = new Bill(bill.getMemberId(), Constants.TRANS_TYPE_INTEGRAL_RECHARGE, integralAmount, 0L);
            billMapper.addBill(child);
            memberMapper.updateMemberAmountAndLevel(bill.getMemberId(), null,null, null, integralAmount);
        }
        if (!billList.isEmpty()) {
            billMapper.updateConsumePayBillProcessFinish(startTime, endTime);
        }
    }
}
