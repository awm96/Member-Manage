package cn.lgq.mm.controller;

import cn.lgq.mm.Constants;
import cn.lgq.mm.model.Admin;
import cn.lgq.mm.model.Member;
import cn.lgq.mm.service.AdminService;
import cn.lgq.mm.util.SHA1Util;
import cn.lgq.mm.vo.Page;
import javax.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by Ligq on 2017/9/15.
 */
/**
 * Created by Ligq on 2017/9/15.
 */
@Slf4j
@Controller
@RequestMapping("/manage/admin")
public class AdminManageController extends AbstractController {

    private final String listPage = "/manage/admin_list";
    private final String redirectListPage = "redirect:/manage/admin/list";

    @Autowired
    private AdminService service;

    /**
     * 跳转至管理员列表页面
     */
    @RequestMapping(value = "/list")
    public ModelAndView list(String name, Integer type, @RequestParam(defaultValue = "1") int pageNo,
        @RequestParam(defaultValue = "10") int pageSize) {
        ModelAndView mav = new ModelAndView(listPage);
        Page<Admin> page = service.findAdmins(name, type, pageNo, pageSize);
        mav.addObject(page);
        return mav;
    }

    /**
     * 新增修改管理员
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public ModelAndView save(Admin admin, HttpSession session) {
        Admin operater = (Admin) session.getAttribute(Constants.ADMIN_SESSION_KEY);
        ModelAndView mav = new ModelAndView(redirectListPage);
        if (admin.getId() == null) {
            admin.setPassword(SHA1Util.encrypt(admin.getPassword()));
            admin.setCreatorId(operater.getId());
            admin.setUpdaterId(operater.getId());
            service.addAdmin(admin);
        } else {
            if (StringUtils.isNotBlank(admin.getPassword())) {
                admin.setPassword(SHA1Util.encrypt(admin.getPassword()));
            }
            admin.setUpdaterId(operater.getId());
            service.updateAdmin(admin);
        }
        return mav;
    }

    /**
     *删除管理员
     */
    @RequestMapping(value = "/delete")
    public String delete(@RequestParam Long adminId) {
        service.deleteAdmin(adminId);
        return redirectListPage;
    }
}
