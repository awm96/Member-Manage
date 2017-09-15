package cn.lgq.mm.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Created by Ligq on 2017/9/15.
 */
@Slf4j
@Controller
@RequestMapping("/login")
public class LoginController extends AbstractController {

    /** 跳转至member登陆页面 */
    @RequestMapping(value = "/member", method = RequestMethod.GET)
    public String forwardToMember() {
        log.info("gggg");
        return "login_member";
    }

    /**
     * 处理member登陆
     * @param idCardNo 身份证号
     * @param password 密码
     */
    @RequestMapping(value = "/member", method = RequestMethod.POST)
    public String memberLogin(@RequestParam String idCardNo, @RequestParam String password) {
        return "member_dashboard";
    }
}
