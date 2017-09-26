package cn.lgq.mm.controller;

import cn.lgq.mm.Constants;
import cn.lgq.mm.model.Admin;
import cn.lgq.mm.model.Member;
import cn.lgq.mm.service.MemberService;
import cn.lgq.mm.util.SHA1Util;
import cn.lgq.mm.vo.Page;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
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
@RequestMapping("/manage/member")
public class MemberManageController extends AbstractController {

    private final String listPage = "/manage/member_list";

    @Autowired
    private MemberService service;

    /**
     * 跳转至会员列表页面
     */
    @RequestMapping(value = "/list")
    public ModelAndView list(String name, String mobile, String idCardNo, @RequestParam(defaultValue = "1") int pageNo,
                       @RequestParam(defaultValue = "10") int pageSize) {
        ModelAndView mav = new ModelAndView(listPage);
        Page<Member> page = service.findMembers(name, mobile, idCardNo, pageNo, pageSize);
        mav.addObject(page);
        return mav;
    }

    /**
     * 新增修改会员
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public ModelAndView save(Member member, HttpSession session) {
        Admin admin = (Admin) session.getAttribute(Constants.ADMIN_SESSION_KEY);
        ModelAndView mav = new ModelAndView("redirect:/manage/member/list");
        if (member.getId() == null) {
            member.setPassword(SHA1Util.encrypt(member.getPassword()));
            member.setCreatorId(admin.getId());
            member.setUpdaterId(admin.getId());
            service.addMember(member);
        } else {
            if (StringUtils.isNotBlank(member.getPassword())) {
                member.setPassword(SHA1Util.encrypt(member.getPassword()));
            }
            member.setUpdaterId(admin.getId());
            service.updateMember(member);
        }
        return mav;
    }
}
