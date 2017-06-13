package com.lppz.back.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/back/*")
public class Filtervip implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        String allpath = request.getRequestURI();
        String path = allpath.substring(allpath.lastIndexOf("/"));
        HttpSession session = request.getSession();
        if (!("/login.jsp".equals(path))&&allpath.endsWith(".jsp")) {
            //判断当前页面是否是陆页面，如果是就不做session的判断，防止死循环
            if (session == null || null == (session.getAttribute("account"))){
                //如果session为空表示用户没有登陆就重定向到login.jsp页面
                response.sendRedirect("/back/login.jsp");
                return;
            }
        }
        chain.doFilter(req, resp);
    }
    @Override
    public void destroy() {

    }
}
