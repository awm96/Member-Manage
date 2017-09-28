package cn.lgq.mm.controller;

import cn.lgq.mm.Constants;
import cn.lgq.mm.model.Admin;
import cn.lgq.mm.model.Bill;
import cn.lgq.mm.service.BillService;
import cn.lgq.mm.service.MemberService;
import cn.lgq.mm.vo.Page;
import cn.lgq.mm.vo.SystemRegulation;
import com.google.common.collect.Maps;
import java.sql.Timestamp;
import java.util.Map;
import javax.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by Ligq on 2017/9/15.
 */
@Slf4j
@Controller
@RequestMapping("/manage/bill")
public class BillManageController extends AbstractController {

    private final String listPage = "/manage/bill_list";
    private final String redirectListPage = "redirect:/manage/bill/list";
    private final String addPage = "/manage/bill_add";

    @Autowired
    private BillService billService;
    @Autowired
    private MemberService memberService;
    @Autowired
    private SystemRegulation regulation;

    /**
     * 跳转至交易列表页面
     */
    @RequestMapping(value = "/list")
    public ModelAndView list(Long masterId, Long memberId, Integer transType,
          Timestamp createTimeStart, Timestamp createTimeEnd,
          @RequestParam(defaultValue = "1") int pageNo, @RequestParam(defaultValue = "10") int pageSize) {
        ModelAndView mav = new ModelAndView(listPage);
        Page<Bill> page = billService
            .findBills(masterId, memberId, transType, createTimeStart, createTimeEnd, pageNo, pageSize);
        mav.addObject(page);
        mav.addObject("memberList", memberService.findAllMembers());
        return mav;
    }

    /**
     * 跳转至新增交易页面
     */
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String forwardToSave(Model model) {
        model.addAttribute("memberList", memberService.findAllMembers());
        Map<String, String>convertMap = Maps.newLinkedHashMapWithExpectedSize(regulation.getStorePresentRule().size());
        for (Map.Entry<Integer, Integer> entry : regulation.getStorePresentRule().entrySet()) {
            convertMap.put(entry.getKey().toString(), entry.getValue().toString());
        }
        model.addAttribute("storePresentRule", convertMap);
        return addPage;
    }

    /**
     * 新增交易
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String save(@RequestParam Long memberId, @RequestParam Integer transType,
        @RequestParam Integer amount, HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute(Constants.ADMIN_SESSION_KEY);
        try {
            billService.addBill(memberId, transType, amount, admin.getCreatorId());
        } catch (Exception e) {
            log.error("交易异常！", e);
            model.addAttribute(Constants.ERROR_MSG_REQUEST_KEY, e.getMessage());
            return this.forwardToSave(model);
        }
        return redirectListPage;
    }

    /**
     * 冲正交易
     */
    @RequestMapping(value = "/repeal", method = RequestMethod.POST)
    public String repeal(@RequestParam Long masterId, HttpSession session) {
        Admin admin = (Admin) session.getAttribute(Constants.ADMIN_SESSION_KEY);
        return redirectListPage;
    }
}
