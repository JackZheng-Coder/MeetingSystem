package com.yanzhen.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class    LoginInterceptor  implements HandlerInterceptor {

    /**
     * 对于controller层进行预处理，如判断是否登录，session过期检测，返回是一个boolean
     * 如果是true 放行  否则重新登陆
     * @param request
     * @param response
     * @param handler
     * @return
     * @throws Exception
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        if(session.getAttribute("user")!=null){
           return true;
        }else{
            response.sendRedirect(request.getContextPath()+"/login");
            return false;
        }
    }

    /**
     * 后处理回调函数，在controller方法执行之后，视图被渲染之前
     * 可以对模型数据和视图进行相关处理
     * @param request
     * @param response
     * @param handler
     * @param modelAndView
     * @throws Exception
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    /**
     * 在请求处理完成之后的一个函数
     * 在视图渲染之后执行，可以进行性能检测，输出消耗时间，可以进行垃圾清理
     * @param request
     * @param response
     * @param handler
     * @param ex
     * @throws Exception
     */
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
