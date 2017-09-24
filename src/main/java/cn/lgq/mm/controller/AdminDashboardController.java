package cn.lgq.mm.controller;

import cn.lgq.mm.Constants;
import cn.lgq.mm.model.Admin;
import cn.lgq.mm.service.AdminService;
import cn.lgq.mm.util.SHA1Util;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

/**
 * Created by Ligq on 2017/9/15.
 */
@Slf4j
@Controller
@RequestMapping("/manage")
public class AdminDashboardController extends AbstractController {

    private final String mainPage = "/manage/dashboard";

    @Autowired
    private AdminService service;

    /**
     * 跳转至admin主页面
     */
    @RequestMapping(value = "/dashboard", method = RequestMethod.GET)
    public ModelAndView forwardTo(HttpSession session) {
        ModelAndView mav = new ModelAndView(mainPage);
        Admin admin = (Admin) session.getAttribute(Constants.ADMIN_SESSION_KEY);
        mav.addObject("manage", admin);
        return mav;
    }

    /**
     * 修改admin个人基本信息
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String updateAdminInfo(Admin admin, HttpSession session) {
        Admin old = (Admin) session.getAttribute(Constants.ADMIN_SESSION_KEY);
        old.setName(admin.getName());
        old.setType(admin.getType());
        if (StringUtils.isNotBlank(admin.getPassword())) {
            old.setPassword(SHA1Util.encrypt(admin.getPassword()));
        }
        old.setUpdaterId(old.getId());
        service.updateAdmin(old);
        return "redirect:" + mainPage;
    }

}
