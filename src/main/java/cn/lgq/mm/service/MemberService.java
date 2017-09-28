package cn.lgq.mm.service;

import cn.lgq.mm.dao.MemberMapper;
import cn.lgq.mm.model.Member;
import cn.lgq.mm.vo.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Ligq on 2017/9/15.
 */
@Service
public class MemberService {

    @Autowired
    private MemberMapper mapper;

    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public Member getMember(Long id) {
        return mapper.getMember(id);
    }

    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public Member getMemberByIdCardNo(String idCardNo) {
        return mapper.getMemberByIdCardNo(idCardNo);
    }

    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public Page<Member> findMembers(String name, String mobile, String idCardNo, int pageNo, int pageSize) {
        Page<Member> page = new Page<>();
        page.setPageNo(pageNo);
        page.setLimit(pageSize);
        List<Member> list = mapper.findMembers(name, mobile, idCardNo, page.getOffset(), page.getLimit());
        int count = mapper.countMembers(name, mobile, idCardNo);
        page.setTotalRows(count);
        page.setResultList(list);
        return page;
    }

    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public List<Member> findAllMembers() {
        return mapper.findMembers(null, null, null, null, null);
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void addMember(Member member) {
        mapper.addMember(member);
        //推荐人不为空则更新推荐人recommendNum属性+1
        if (member.getReferrerId() != null) {
            mapper.incrementMemberRecommendNum(member.getReferrerId());
        }
    }

    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Throwable.class)
    public void updateMember(Member member) {
        mapper.updateMember(member);
    }
}
