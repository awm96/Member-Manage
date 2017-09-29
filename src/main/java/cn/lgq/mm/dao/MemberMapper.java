package cn.lgq.mm.dao;

import cn.lgq.mm.model.Member;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by Ligq on 2017/9/15.
 */
@Mapper
public interface MemberMapper {

    Member getMember(Long id);

    Member getMemberForUpdate(Long id);

    Member getMemberByIdCardNo(String idCardNo);

    List<Member> getMemberBaseInfo(Long... id);

    List<Member> findMembers(@Param("name") String name, @Param("mobile") String mobile, @Param("idCardNo") String idCardNo,
                             @Param("offset") Integer offset, @Param("limit") Integer limit);

    int countMembers(@Param("name") String name, @Param("mobile") String mobile, @Param("idCardNo") String idCardNo);

    void addMember(Member member);

    void updateMember(Member member);

    void incrementMemberRecommendNum(Long memberId);

    void updateMemberAmountAndLevel(@Param("memberId") Long memberId, @Param("level") Integer level,
        @Param("storedAmount") Integer storedAmount, @Param("consumeAmount") Integer consumeAmount,
        @Param("integralAmount") Integer integralAmount);
}
