package cn.lgq.mm.controller;

import cn.lgq.mm.Constants;
import cn.lgq.mm.model.Bill;
import cn.lgq.mm.model.Member;
import cn.lgq.mm.service.BillService;
import cn.lgq.mm.service.MemberService;
import cn.lgq.mm.vo.Page;
import lombok.extern.slf4j.Slf4j;
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
        @RequestParam(name = "pageSize", defaultValue = "10") int pageSize, HttpSession session, Model model) {
        Member member = (Member) session.getAttribute(Constants.MEMBER_SESSION_KEY);
        model.addAttribute("member", member);
        Page<Bill> page = billService.findBills(null, member.getId(), null, null, pageNo, pageSize);
        ModelAndView mav = new ModelAndView(memberMainPage);
        mav.addObject("page", page);
        return mav;
    }
}
