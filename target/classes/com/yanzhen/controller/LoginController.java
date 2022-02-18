package com.yanzhen.controller;

import com.yanzhen.codeutil.IVerifyCodeGen;
import com.yanzhen.codeutil.SimpleCharVerifyCodeGenImpl;
import com.yanzhen.codeutil.VerifyCode;
import com.yanzhen.model.User;
import com.yanzhen.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    /**
     * 获取验证码方法
     * @param request
     * @param response
     */
    @RequestMapping("/verifyCode")
    public void verifyCode(HttpServletRequest request, HttpServletResponse response) {
        IVerifyCodeGen iVerifyCodeGen = new SimpleCharVerifyCodeGenImpl();
        try {
            //设置长宽
            VerifyCode verifyCode = iVerifyCodeGen.generate(80, 28);
            String code = verifyCode.getCode();
//            LOGGER.info(code);
            //将VerifyCode绑定session
            request.getSession().setAttribute("VerifyCode", code);
            //设置响应头
            response.setHeader("Pragma", "no-cache");
            //设置响应头
            response.setHeader("Cache-Control", "no-cache");
            //在代理服务器端防止缓冲
            response.setDateHeader("Expires", 0);
            //设置响应内容类型
            response.setContentType("image/jpeg");
            response.getOutputStream().write(verifyCode.getImgBytes());
            response.getOutputStream().flush();
        } catch (IOException e) {
//            LOGGER.info("", e);
            System.out.println("异常处理");
        }
    }

    /**
     * 登录验证方法
     */
//    @ResponseBody
    @RequestMapping("/loginIn")
    public String loginIn(HttpServletRequest request,Model model){
        /*
          1、接收前端传值信息
          2、判断用户登录信息是否过时，如果过时，重新登录
          3、判断验证码是否正确，如果不正确，重新登录
          4、根据用户名 密码 以及用户类型查询用户对象是否存在，不存在重新登录
             存在，放入到session中 跳转到主页
         */
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String type = request.getParameter("type");
        String captcha = request.getParameter("captcha");
        //判断用户登录信息是否过时，如果过时，重新登录
        HttpSession session = request.getSession();
        if(session==null){
            model.addAttribute("msg","登录超时了");
            return "login";
        }

        //判断验证码是否正确，如果不正确，重新登录
        String verifyCode = (String) session.getAttribute("VerifyCode");
        if(!verifyCode.toLowerCase().equals(captcha.toLowerCase())){
            model.addAttribute("msg","验证码不正确....");
            return "login";
        }

        User u=new User();
        u.setUsername(username);
        u.setPassword(password);
        u.setRoleName(type);
        User user=userService.queryUserInfoByNameAndPwdAndType(u);
        if(user==null){
            model.addAttribute("msg","用户名或密码不正确....");
            return "login";
        }
        session.setAttribute("user",user);
        session.setAttribute("type",type);
        return "../index";
    }

/**
 * 退出功能
 */
 @RequestMapping("/loginOut")
 public String loginOut(HttpServletRequest request){
     HttpSession session = request.getSession();
     session.invalidate();
     return "redirect:/login";
 }


    /**
     * 登录页面映射路径
     */
    @RequestMapping("login")
    public String login(){
        return "login";
    }


    /**
     * 默认的欢迎页
     */
    @RequestMapping("/welcome")
    public String welcome(){
        return "welcome";
    }

}
