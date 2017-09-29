package cn.lgq.mm.controller;

import cn.lgq.mm.Constants;
import cn.lgq.mm.model.Bill;
import cn.lgq.mm.model.Member;
import cn.lgq.mm.service.BillService;
import cn.lgq.mm.service.MemberService;
import cn.lgq.mm.util.SHA1Util;
import cn.lgq.mm.vo.Page;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import javax.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by Ligq on 2017/9/15.
 */
@Slf4j
@Controller
@RequestMapping("/member")
public class MemberDashboardController extends AbstractController {

    private final String memberMainPage = "/member/dashboard";

    @Autowired
    private MemberService memberService;
    @Autowired
    private BillService billService;

    /**
     * 跳转至member主页面
     */
    @RequestMapping(value = "/dashboard", method = RequestMethod.GET)
    public ModelAndView forwardToMember(@RequestParam(name = "pageNo", defaultValue = "1") int pageNo,
        @RequestParam(name = "pageSize", defaultValue = "10") int pageSize, HttpSession session) {
        Member member = (Member) session.getAttribute(Constants.MEMBER_SESSION_KEY);
        Page<Bill> page = billService.findBills(null, member.getId(), null, null, null, pageNo, pageSize);
        ModelAndView mav = new ModelAndView(memberMainPage);
        mav.addObject("page", page);
        mav.addObject("member", member);
        return mav;
    }

    /**
     * 修改member个人基本信息
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String updateMemberInfo(Member member, HttpSession session) {
        Member old = (Member) session.getAttribute(Constants.MEMBER_SESSION_KEY);
        old.setName(member.getName());
        old.setMobile(member.getMobile());
        if (StringUtils.isNotBlank(member.getPassword())) {
            old.setPassword(SHA1Util.encrypt(member.getPassword()));
        }
        old.setSex(member.getSex());
        old.setBirthday(member.getBirthday());
        old.setUpdaterId(old.getId() * -1);
        memberService.updateMember(old);
        return "redirect:" + memberMainPage;
    }

}
