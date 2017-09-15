package cn.lgq.mm.dao;

import cn.lgq.mm.model.Member;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Ligq on 2017/9/15.
 */
public interface MemberMapper {

    Member getMember(Long id);

    Member getMemberByIdCardNo(String idCardNo);

    List<Member> findMembers(@Param("") String name, @Param("") String mobile, @Param("") String idCardNo);

    void addMember(Member member);

    void updateMember(Member member);
}
