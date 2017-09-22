package cn.lgq.mm.filter;

import cn.lgq.mm.Constants;
import cn.lgq.mm.model.Admin;
import org.apache.commons.lang3.ArrayUtils;
import org.springframework.http.HttpStatus;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by Ligq on 2017/9/15.
 */
public class AdminInterceptor extends HandlerInterceptorAdapter {

    /**
     * 超级管理员权限访问路径
     */
    private String[] superAdminPaths;

    public AdminInterceptor() {
    }

    public AdminInterceptor(String[] superAdminPaths) {
        this.superAdminPaths = superAdminPaths;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        HttpSession session = request.getSession();
        Admin user = (Admin) session.getAttribute(Constants.ADMIN_SESSION_KEY);
        if (user == null) {
            request.setAttribute(Constants.ERROR_MSG_REQUEST_KEY, "会话超时，请重新登陆!");
            request.getRequestDispatcher("/admin/login").forward(request, response);
            return false;
        }

        if (ArrayUtils.isNotEmpty(superAdminPaths)) {
            String requestUri = request.getRequestURI().replaceFirst(request.getContextPath(), "");
            for (String path : superAdminPaths) {
                if (requestUri.startsWith(path) && !Constants.ADMIN_SUPER.equals(user.getType())) {
                    request.setAttribute(Constants.STATUS_CODE_REQUEST_KEY, HttpStatus.FORBIDDEN);
                    request.setAttribute(Constants.ERROR_MSG_REQUEST_KEY, "您没有权限访问该URL");
                    request.getRequestDispatcher("/error").forward(request, response);
                    return false;
                }
            }
        }

        return true;
    }
}
