package com.yanzhen.controller;

import com.github.pagehelper.PageInfo;
import com.yanzhen.model.User;
import com.yanzhen.service.MeetingInfoService;
import com.yanzhen.service.UserService;
import com.yanzhen.util.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
public class UserCotroller {

    @Autowired
    private UserService userService;
    @Autowired
    private MeetingInfoService meetingInfoService;

    @RequestMapping("user/queryAll")
    @ResponseBody
    public R queryUserAllList(User user,
                              @RequestParam(defaultValue = "1") Integer page,
                              @RequestParam(defaultValue = "15") Integer limit){
        PageInfo<User> pageInfo=userService.queryUserList(page,limit,user);
        return R.ok("ok",pageInfo.getTotal(),pageInfo.getList());
    }


    //普通职员查询自己的个人信息
    @RequestMapping("user/queryAll3")
    @ResponseBody
    public R queryUserAllList3(HttpServletRequest request){
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");//获取用户
        PageInfo<User> pageInfo=userService.queryUserList(1,1,user);//根据当前用户查询用户信息
        return R.ok("ok",pageInfo.getTotal(),pageInfo.getList());
    }



    @RequestMapping("user/queryUserListByMeetId")
    @ResponseBody
    public R queryUserListByMeetId(User user,Integer mid,
                              @RequestParam(defaultValue = "1") Integer page,
                              @RequestParam(defaultValue = "15") Integer limit){
        PageInfo<User> pageInfo=userService.queryUserList(page,limit,user);
        //获取所有的用户列表
        List<User> list=pageInfo.getList();
        //根据遍历的用户id 看下是否参与了mid的会议 如果参与了，默认选择
        List  ulist=new ArrayList<>();
        for(User u:list){
            Map m=new HashMap<>();
            m.put("id",u.getId());
            m.put("username",u.getUsername());
            m.put("tel",u.getTel());
            m.put("dname",u.getDept().getName());
            m.put("email",u.getEmail());
            //根据会议id和用户id判断是否参与会议
            boolean bs=meetingInfoService.queryMeeingInfoByMeetIdAndUserId(mid,u.getId());
            if(bs){
                m.put("LAY_CHECKED",true);
            }else{
                m.put("LAY_CHECKED",false);
            }
            ulist.add(m);
        }
        return R.ok("ok",pageInfo.getTotal(),ulist);
    }

    /**
     * 添加用户信息
     */
    @RequestMapping("user/addInfo")
    @ResponseBody
    public R add(@RequestBody User user){
          //调用service层方法
          int num=userService.insertUserInfo(user);
          if(num>0){
              return R.ok();
          }
          return R.fail("用户添加失败");
    }


    /**
     * 修改用户信息
     */
    @RequestMapping("user/updateInfo")
    @ResponseBody
    public R update(@RequestBody User user){
        //调用service层方法
        int num=userService.updateUserInfo(user);
        if(num>0){
            return R.ok();
        }
        return R.fail("用户修改失败");
    }


    /**
     * 用户删除功能 支持批量删除和单个删除
     *  1,2,3,4
     */
    @ResponseBody
    @RequestMapping("user/deleteByIds")
    public R deleteUserByIds(String ids){
        //把字符串转成集合对象
        List<String> list= Arrays.asList(ids.split(","));
        int num=0;
        for(String id:list){
           num+= userService.deleteUserInfoByUserId(Integer.parseInt(id));
        }
        if(num>0){
            return R.ok();
        }
        return R.fail("删除失败");
    }

    /**
     * 修改密码方法
     */
    @RequestMapping("user/updatePwd2")
    @ResponseBody
    public R updatePwd2(String pwd,HttpServletRequest request){
        HttpSession session = request.getSession();
        User u= (User) session.getAttribute("user");//获取当前用户
        u.setPassword(pwd);//s设置新密码
        int num=userService.updateUserInfo(u);//调用service层，更新数据库
        if(num>0){
            return R.ok();
        }
        return R.fail("失败");
    }

    //页面映射
    @RequestMapping("user")
    public String userIndex(){
        return "user/index";
    }

    @RequestMapping("user/add")
    public String userAdd(){
        return "user/add";
    }

    @RequestMapping("user/update")
    public String userUpdate(Integer id,Model model){
        //根据id查询用户对象
        User user= userService.queryUserByID(id);
        model.addAttribute("user",user);
        return "user/update";
    }

//    @RequestMapping("/userList")
//    public String getUserIndex(Model model){
//     /*  List list= userService.queryList();
//       System.out.println(list);
//       model.addAttribute("user",list);*/
//      return "ShowUser";
//    }


    /**
     * 个人信息
     */
    @RequestMapping("user/emp/index")
    public String index2(){
       return "other/myindex";
    }


    @RequestMapping("user/my_update")
    public String my_update(Integer id,Model model){
        //根据id查询用户对象
        User user= userService.queryUserByID(id);
        model.addAttribute("user",user);
        return "other/my_update";
    }

    @RequestMapping("user/updatePwd")
    public String updatePwd(){
        return "other/update_pwd";
    }


}
