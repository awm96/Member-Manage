package cn.lgq.mm.filter;

import cn.lgq.mm.Constants;
import cn.lgq.mm.model.Member;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * Created by Ligq on 2017/9/15.
 */
public class MemberInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        Member user = (Member) session.getAttribute(Constants.MEMBER_SESSION_KEY);
        if (user == null) {
            request.setAttribute(Constants.ERROR_MSG_REQUEST_KEY, "会话超时，请重新登陆!");
            request.getRequestDispatcher("/member/login").forward(request, response);
            return false;
        }
        return true;
    }
}
