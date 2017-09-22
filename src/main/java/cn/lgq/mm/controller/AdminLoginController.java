package cn.lgq.mm.controller;

import cn.lgq.mm.Constants;
import cn.lgq.mm.model.Admin;
import cn.lgq.mm.service.AdminService;
import cn.lgq.mm.util.SHA1Util;
import javax.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by Ligq on 2017/9/15.
 */
@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminLoginController extends AbstractController {

    private final String loginPage = "/admin/login";
    private final String dashboardPage = "redirect:/admin/dashboard";

    @Autowired
    private AdminService service;

    /**
     * 跳转至admin登陆页面
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String forwardTo() {
        return loginPage;
    }

    /**
     * 处理admin登陆
     *
     * @param name 管理员名称
     * @param password 密码
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public ModelAndView login(@RequestParam String name, @RequestParam String password, HttpSession session) {

        Admin admin = service.getAdminByName(name);
        if (admin == null || !admin.getPassword().equals(SHA1Util.encrypt(password))) {
            ModelAndView mav = new ModelAndView(loginPage);
            mav.addObject(Constants.ERROR_MSG_REQUEST_KEY, "管理员名称或密码错误!");
            return mav;
        } else {
            session.setAttribute(Constants.ADMIN_SESSION_KEY, admin);
            return new ModelAndView(dashboardPage);
        }
    }

    /**
     * 处理admin登出
     */
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpSession session) {
        session.invalidate();
        return "/";
    }
}
