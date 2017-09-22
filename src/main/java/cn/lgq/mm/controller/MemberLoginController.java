package cn.lgq.mm.controller;

import cn.lgq.mm.Constants;
import cn.lgq.mm.model.Member;
import cn.lgq.mm.service.MemberService;
import cn.lgq.mm.util.SHA1Util;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

/**
 * Created by Ligq on 2017/9/15.
 */
@Slf4j
@Controller
@RequestMapping("/member")
public class MemberLoginController extends AbstractController {

    private final String memberLoginPage = "/member/login";
    private final String memberDashboardPage = "redirect:/member/dashboard";

    @Autowired
    private MemberService service;

    /**
     * 跳转至member登陆页面
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String forwardToMember() {
        return memberLoginPage;
    }

    /**
     * 处理member登陆
     *
     * @param idCardNo 身份证号
     * @param password 密码
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public ModelAndView memberLogin(@RequestParam String idCardNo, @RequestParam String password, HttpSession session) {

        Member member = service.getMemberByIdCardNo(idCardNo);
        if (member == null || !member.getPassword().equals(SHA1Util.encrypt(password))) {
            ModelAndView mav = new ModelAndView(memberLoginPage);
            mav.addObject(Constants.ERROR_MSG_REQUEST_KEY, "身份证号或密码错误!");
            return mav;
        } else {
            session.setAttribute(Constants.MEMBER_SESSION_KEY, member);
            return new ModelAndView(memberDashboardPage);
        }
    }
}
